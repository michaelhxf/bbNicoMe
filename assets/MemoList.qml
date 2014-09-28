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
            id: listview
            dataModel: memoDataModel

            listItemComponents: ListItemComponent {
                type: "item"
                StandardListItem {
                    title: ListItemData.subject
                    description: ListItemData.content
                }
            }
            
            onTriggered: {
                //if (indexPath.length > 1) {
                var chosenItem = dataModel.data(indexPath);
                var detailPage = memoDetail.createObject()

                detailPage.detailSubject = chosenItem.subject
                detailPage.detailContent = chosenItem.content
                detailPage.detailCTime = chosenItem.ctime
                detailPage.detailMTime = chosenItem.mtime
                detailPage.detailTagList = chosenItem.taglist
                detailPage.detailType = chosenItem.memotypeid
                detailPage.memoId = chosenItem.id
                detailPage.navigate = naviPanel

                naviPanel.push(detailPage)
                // }
            }
            bufferedScrollingEnabled: true
            multiSelectAction: MultiSelectActionItem {
                title: qsTr("aaa")
                onTriggered: {
                }
                multiSelectHandler: MultiSelectHandler {
                    id: defaultSelectHandler

                }

            }

        }

        attachedObjects: [
            GroupDataModel {
                id: memoDataModel
                sortingKeys: [ "mtime", "ctime" ]
                sortedAscending: false
                grouping: ItemGrouping.None
            },

            DataSource {
                id: memoDataSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "select * from memo"

                onDataLoaded: {
                    memoDataModel.clear()
                    memoDataModel.insertList(data)
                }
            },

            DataSource {
                id: searchDataSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "SELECT * FROM memo WHERE subject LIKE '%" + searchBar.text + "%' OR content LIKE '%" + searchBar.text + "%' OR taglist LIKE '%" + searchBar.text + "%'"

                onDataLoaded: {
                    memoDataModel.clear()
                    memoDataModel.insertList(data)
                }
            },

            ComponentDefinition {
                id: memoDetail
                source: "MemoDetail.qml"
            },

            ComponentDefinition {
                id: memoAdd
                source: "MemoAdd.qml"
            }

        ]

        actions: [
            ActionItem {
                id: addMemoAction
                title: qsTr("New Memo")
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = memoAdd.createObject()
                    addPage.navigate = naviPanel
                    naviPanel.push(addPage)
                }
                imageSource: "asset:///images/add.png"
                shortcuts: [
                    Shortcut {
                        key: "a"
                        onTriggered: {
                            var addPage = memoAdd.createObject()
                            addPage.navigate = naviPanel
                            naviPanel.push(addPage)
                        }
                    }
                ]
            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    memoDataSource.load()
                }
                imageSource: "asset:///images/refresh.png"
                
                shortcuts: [
                    Shortcut {
                        key: "r"
                        onTriggered: {
                            memoDataSource.load()
                        }
                    }
                ]
            },
            ActionItem {
                id: selectAction
                title: qsTr("Select")
                ActionBar.placement: ActionBarPlacement.InOverflow
                
                onTriggered: {
                    listview.multiSelectHandler.active=true
                }
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
                        text: qsTr(" Memo")
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.color: Color.White
                        textStyle.textAlign: TextAlign.Center
                        textStyle.fontSize: FontSize.Large

                    }
                    
                    TextField {
                        id: searchBar
                        verticalAlignment: VerticalAlignment.Center
                        hintText: qsTr("Search keyword")
                        
                        onTextChanged: {
                            if (text.length == 0) {
                                memoDataSource.load()
                            } else {
                                searchDataSource.load()
                            }
                        }
                        
                        textFormat: TextFormat.Plain
                        inputMode: TextFieldInputMode.Text
                        maximumLength: 36
                    }
                }
            }
            scrollBehavior: TitleBarScrollBehavior.Sticky
            
        }
    }

    onCreationCompleted: {
        memoDataSource.load()
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh=false
            memoDataSource.load()
        }
    }
}
