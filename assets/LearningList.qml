/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb.data 1.0

//memo list
NavigationPane {
    id: naviPanel
    property bool needRefresh

    Page {

        ListView {
            dataModel: learningDataModel

            listItemComponents: [
                ListItemComponent {
                    type: "item"

                    CustomListItem {

                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight

                            }

                            Container {
                                minHeight: 100
                                minWidth: 120

                                layout: StackLayout {

                                }
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Center
                                layoutProperties: StackLayoutProperties {

                                }

                                Container {
                                    layout: StackLayout {

                                    }
                                    minHeight: 100
                                    minWidth: 80
                                    background: (ListItemData.langtypeid == 1) ? Color.create("#200000ff") : Color.create("#2000ff00")
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Center
                                    Label {
                                        text: (ListItemData.langtypeid == 1) ? "J" : "E"
                                        minHeight: 100
                                        minWidth: 80
                                        textStyle.fontSize: FontSize.XLarge
                                        textStyle.color: Color.White
                                        textStyle.textAlign: TextAlign.Center
                                        layoutProperties: StackLayoutProperties {

                                        }
                                        verticalAlignment: VerticalAlignment.Center
                                        horizontalAlignment: HorizontalAlignment.Center
                                        textStyle.fontWeight: FontWeight.Bold
                                    }
                                }

                            }

                            Container {
                                layout: StackLayout {

                                }
                                Label {
                                    text: ListItemData.symbol
                                    maxHeight: 24
                                    textStyle.fontWeight: FontWeight.Normal
                                    textStyle.fontSize: FontSize.Small
                                    textStyle.color: Color.Gray

                                }
                                Label {
                                    text: ListItemData.subject
                                    textStyle.fontSize: FontSize.Medium
                                    textStyle.fontWeight: FontWeight.Normal
                                    textStyle.color: Color.Black

                                }
                                Label {
                                    text: ListItemData.meaning
                                    textStyle.fontWeight: FontWeight.Normal
                                    textStyle.fontSize: FontSize.Small
                                    textStyle.color: Color.Gray
                                    maxHeight: 36
                                }
                            }
                        }
                    }

                }
            ]

            onTriggered: {
                //if (indexPath.length > 1) {
                var chosenItem = dataModel.data(indexPath);
                var detailPage = learningDetail.createObject()

                detailPage.detailSubject = chosenItem.subject
                detailPage.detailMeaning = chosenItem.meaning
                detailPage.detailQIndex = chosenItem.qindex
                detailPage.detailDescription = chosenItem.description
                detailPage.detailCTime = chosenItem.ctime
                detailPage.detailMTime = chosenItem.mtime
                detailPage.detailTagList = chosenItem.taglist
                detailPage.detailMemoId = chosenItem.memoid
                detailPage.detailSymbol = chosenItem.symbol
                detailPage.detailTagList = chosenItem.taglist
                detailPage.detailLangTypeId = chosenItem.langtypeid
                detailPage.detailPictureId = chosenItem.pictureid
                detailPage.detailVoiceLink = chosenItem.voicelink
                detailPage.learningId = chosenItem.id
                detailPage.navigate = naviPanel

                naviPanel.push(detailPage)
                // }
            }

        }

        attachedObjects: [

            GroupDataModel {
                id: learningDataModel
                sortingKeys: [ "mtime", "ctime" ]
                sortedAscending: false
                grouping: ItemGrouping.None
            },

            DataSource {
                id: learningDataSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "select * from learning LIMIT 50"

                onDataLoaded: {
                    learningDataModel.clear()
                    learningDataModel.insertList(data)
                }
            },

            DataSource {
                id: searchDataSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "SELECT * FROM learning WHERE subject LIKE '%" + searchBar.text + "%' OR symbol LIKE '%" + searchBar.text + "%' OR meaning LIKE '%" + searchBar.text + "%' OR qindex LIKE '%" + searchBar.text + "%' OR taglist LIKE '%" + searchBar.text + "%' LIMIT 50"

                onDataLoaded: {
                    learningDataModel.clear()
                    learningDataModel.insertList(data)
                }
            },

            ComponentDefinition {
                id: learningDetail
                source: "LearningDetail.qml"
            },

            ComponentDefinition {
                id: learningAdd
                source: "LearningAdd.qml"
            }

        ]

        actions: [
            ActionItem {
                id: addLearningAction
                title: qsTr("New Word")
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = learningAdd.createObject()
                    addPage.navigate = naviPanel
                    naviPanel.push(addPage)
                    addPage.needFocus = true
                }
                imageSource: "asset:///images/add.png"
                shortcuts: [
                    Shortcut {
                        key: "a"
                        //                        onTriggered: {
                        //                            var addPage = learningAdd.createObject()
                        //                            addPage.navigate = naviPanel
                        //                            addPage.detailMemoType = 2; //learning
                        //                            naviPanel.push(addPage)
                        //                        }
                    }
                ]
            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    learningDataSource.load()
                }
                imageSource: "asset:///images/refresh.png"

                shortcuts: [
                    Shortcut {
                        key: "r"
                        //                        onTriggered: {
                        //                            learningDataSource.load()
                        //                        }
                    }
                ]
            }
        ]

        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }

                    Label {
                        text: qsTr(" Word")
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.color: Color.White
                        textStyle.textAlign: TextAlign.Center
                        textStyle.fontSize: FontSize.Large

                    }

                    TextField {
                        id: searchBar
                        verticalAlignment: VerticalAlignment.Center
                        hintText: qsTr("Search keyword")

                        textFormat: TextFormat.Plain
                        inputMode: TextFieldInputMode.Text
                        maximumLength: 36

                        shortcuts: Shortcut {
                            key: "Enter"
                            onTriggered: {
                                searchDataSource.query = "SELECT * FROM learning WHERE subject LIKE '%" + searchBar.text + "%' OR symbol LIKE '%" + searchBar.text + "%' OR meaning LIKE '%" + searchBar.text + "%' OR qindex LIKE '%" + searchBar.text + "%' OR taglist LIKE '%" + searchBar.text + "%'"
                                searchDataSource.load()
                            }
                        }
                    }

                    Container {
                        minWidth: 1
                    }
                }
            }
            scrollBehavior: TitleBarScrollBehavior.Sticky

        }
    }

    onCreationCompleted: {
        learningDataSource.load()
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            learningDataSource.load()
        }
        page.destroy()
    }
}
