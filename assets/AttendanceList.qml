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

Page {
    property bool needRefresh
    property NavigationPane navigate

    property int monthId
    property string detailTitle
    property string detailYear
    property string detailMonth

    onMonthIdChanged: {
        if (monthId != 0)
            attendanceDataSource.load()
    }

    onNeedRefreshChanged: {
        if (monthId != 0)
            attendanceDataSource.load()
    }

    ListView {
        id: listview
        dataModel: attendanceDataModel

        listItemComponents: ListItemComponent {
            type: "item"
            StandardListItem {
                // title: ListItemData.recorddate
                // description: ListItemData.starttime
                //status: ListItemData.id

                onCreationCompleted: {
                    var _date = new Date()
                    _date.setTime(Number(ListItemData.recorddate))
                    title = Qt.formatDateTime(_date, " yyyy.MM.dd\tddd")

                    _date.setTime(Number(ListItemData.starttime))
                    description = Qt.formatDateTime(_date, " hh:mm AP")

                    _date.setTime(Number(ListItemData.endtime - ListItemData.starttime))
                    status = Qt.formatDateTime(_date, " hh:mm ")
                }
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
            //detailPage.detailTask = chosenItem.task
            detailPage.detailDescription = chosenItem.description
            detailPage.detailCTime = chosenItem.ctime
            detailPage.detailMTime = chosenItem.mtime

            detailPage.teamid = chosenItem.teamid
            detailPage.customerid = chosenItem.customerid
            detailPage.weektypeid = chosenItem.weektypeid
            detailPage.monthid = monthId
            detailPage.attendanceId = chosenItem.id
            detailPage.navigate = navigate
            navigate.push(detailPage)
            // }
        }

    }

    attachedObjects: [
        GroupDataModel {
            id: attendanceDataModel
            sortingKeys: [ "recorddate" ]
            sortedAscending: false
            grouping: ItemGrouping.None
        },

        DataSource {
            id: attendanceDataSource
            type: DataSourceType.Sql
            remote: false
            source: "file://" + nicomeApp.getDatabasePath()
            query: "select * from attendance WHERE monthid=" + monthId

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
            id: monthDetail
            source: "MonthDetail.qml"
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
                addPage.monthid = monthId
                addPage.navigate = navigate
                navigate.push(addPage)
                addPage.needFocus = true
            }

            shortcuts: [
                Shortcut {
                    key: "a"
                }
            ]
        },

        ActionItem {
            id: monthAction
            title: qsTr("Month Detail")
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/calendar-month.png"
            onTriggered: {
                var mdetail = monthDetail.createObject()
                mdetail.detailTitle = detailTitle
                mdetail.detailYear = detailYear
                mdetail.detailMonth = detailMonth
                mdetail.monthId = monthId
                mdetail.navigate = navigate

                navigate.push(mdetail)
            }
        },
        ActionItem {
            id: refreshAction
            title: qsTr("Refresh")
            ActionBar.placement: ActionBarPlacement.InOverflow

            onTriggered: {
                if (monthId != 0)
                    attendanceDataSource.load()
            }
            imageSource: "asset:///images/refresh.png"

            shortcuts: [
                Shortcut {
                    key: "r"
                }
            ]
        }
    ]

    titleBar: TitleBar {
        title: detailTitle
    }

}
