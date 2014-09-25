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
            
            listItemComponents: ListItemComponent {
                type: "item"
                StandardListItem {
                    title: ListItemData.subject
                    description: ListItemData.meaning
                }
            }
            
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
                sortingKeys: [ "ctime", "mtime", "id" ]
                sortedAscending: true
                grouping: ItemGrouping.None
            },
            
            DataSource {
                id: learningDataSource
                type: DataSourceType.Sql
                remote: false
                source: "asset:///nicome.s3db"
                query: "select * from learning"
                
                onDataLoaded: {
                    learningDataModel.clear()
                    learningDataModel.insertList(data)
                }
            },
            
            DataSource {
                id: searchDataSource
                type: DataSourceType.Sql
                remote: false
                source: "asset:///nicome.s3db"
                query: "SELECT * FROM learning WHERE subject LIKE '%" + searchBar.text + "%' OR content LIKE '%" + searchBar.text + "%' OR taglist LIKE '%" + searchBar.text + "%'"
                
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
                }
                imageSource: "asset:///images/add.png"
                shortcuts: [
                    Shortcut {
                        key: "a"
                        onTriggered: {
                            var addPage = learningAdd.createObject()
                            addPage.navigate = naviPanel
                            addPage.detailMemoType = 2;//learning
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
                    learningDataSource.load()
                }
                imageSource: "asset:///images/refresh.png"
                
                shortcuts: [
                    Shortcut {
                        key: "r"
                        onTriggered: {
                            learningDataSource.load()
                        }
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
                        text: qsTr(" Learning")
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
                                learningDataSource.load()
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
        learningDataSource.load()
    }
    
    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh=false
            learningDataSource.load()
        }
    }
}
