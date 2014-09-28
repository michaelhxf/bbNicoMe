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

NavigationPane {
    id: naviPanel
    property bool needRefresh

    Page {

        ListView {
            id: listview
            dataModel: attendanceDataModel

            listItemComponents: ListItemComponent {
                type: "item"
                StandardListItem {
                    title: ListItemData.recorddate
                    description: ListItemData.starttime
                }
            }

            onTriggered: {
                //if (indexPath.length > 1) {
                var chosenItem = dataModel.data(indexPath);
                var detailPage = attendanceDetail.createObject()

                detailPage.detailRecordDate = chosenItem.recorddate
                detailPage.detailStartTime = chosenItem.starttime
                detailPage.detailEndTime = chosenItem.endtime
                detailPage.detailRestTime = chosenItem.resttime
                detailPage.detailTask = chosenItem.task
                detailPage.detailDescription = chosenItem.description
                detailPage.detailCTime = chosenItem.ctime
                detailPage.detailMTime = chosenItem.mtime

                detailPage.teamid = chosenItem.teamid
                detailPage.customerid = chosenItem.customerid
                detailPage.weektypeid = chosenItem.weektypeid
                detailPage.attendanceId = chosenItem.id
                detailPage.navigate = naviPanel

                naviPanel.push(detailPage)
                // }
            }

        }

        attachedObjects: [
            GroupDataModel {
                id: attendanceDataModel
                sortingKeys: [ "mtime", "ctime" ]
                sortedAscending: false
                grouping: ItemGrouping.None
            },

            DataSource {
                id: attendanceDataSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "select * from attendance"

                onDataLoaded: {
                    attendanceDataModel.clear()
                    attendanceDataModel.insertList(data)
                }
            },

            ComponentDefinition {
                id: attendanceDetail
                source: "AttendanceDetail.qml"
            },
            
            ComponentDefinition {
                id: custList
                source: "CustomerList.qml"
            },

            ComponentDefinition {
                id: attendanceAdd
                source: "AttendanceAdd.qml"
            }

            

        ]

        actions: [
            ActionItem {
                id: addAttendanceAction
                title: qsTr("New Attendance")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/add.png"
                onTriggered: {
                    var addPage = attendanceAdd.createObject()
                    addPage.navigate = naviPanel
                    naviPanel.push(addPage)
                }
               
                shortcuts: [
                    Shortcut {
                        key: "a"
                        onTriggered: {
                            var addPage = attendanceAdd.createObject()
                            addPage.navigate = naviPanel
                            naviPanel.push(addPage)
                        }
                    }
                ]
            },
            ActionItem {
                id: custListAction
                title: qsTr("Customer")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/marker.png"
                onTriggered: {
                    var addPage = custList.createObject()
                    addPage.navigate = naviPanel
                    naviPanel.push(addPage)
                }
                shortcuts: Shortcut {
                    key: "c"
                    onTriggered: {
                        var addPage = custList.createObject()
                        addPage.navigate = naviPanel
                        naviPanel.push(addPage)
                    }
                }
            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    attendanceDataSource.load()
                }
                imageSource: "asset:///images/refresh.png"

                shortcuts: [
                    Shortcut {
                        key: "r"
                        onTriggered: {
                            attendanceDataSource.load()
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
                        text: qsTr(" Attendance")
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
                    }
                }
            }
            scrollBehavior: TitleBarScrollBehavior.Sticky

        }
    }

    onCreationCompleted: {
        attendanceDataSource.load()
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            attendanceDataSource.load()
        }
    }
}
