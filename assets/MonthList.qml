import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

NavigationPane {
    id: navigate

    property bool needRefresh

    Page {

        titleBar: TitleBar {
            title: qsTr("Month Collection")
        }

        Container {
            ListView {
                dataModel: monthModel

                listItemComponents: ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.title
                        imageSpaceReserved: true
                        imageSource: "asset:///images/1412395180_orange-folder.png"
                        // status: attendance count

                    }
                }

                onTriggered: {

                    var choseItem = monthModel.data(indexPath)
                    var detailPage = attendanceList.createObject()
                    
                    detailPage.monthId = choseItem.id
                    detailPage.detailTitle = choseItem.title
                    detailPage.detailYear = choseItem.year
                    detailPage.detailMonth = choseItem.month
                    detailPage.navigate = navigate

                    navigate.push(detailPage);
                    detailPage.needRefresh = true
                }
            }
        }

        attachedObjects: [
            ComponentDefinition {
                id: attendanceList
                AttendanceList {

                }
            },
            ComponentDefinition {
                id: monthAdd
                MonthAdd {

                }
            },
            ComponentDefinition {
                id: custList
                source: "CustomerList.qml"
            },
            GroupDataModel {
                id: monthModel
                sortingKeys: [ "no" ]
                sortedAscending: false
                grouping: ItemGrouping.None
            },
            DataSource {
                id: monthSource
                type: DataSourceType.Sql
                remote: false
                source: "file://" + nicomeApp.getDatabasePath()
                query: "SELECT * FROM month LIMIT 12"

                onDataLoaded: {
                    monthModel.clear()
                    monthModel.insertList(data)
                }
            },
            SystemToast {
                id: alertToast
                button.enabled: false
            }
        ]

        actions: [
            ActionItem {
                id: addMemoAction
                title: qsTr("New Month Collection")
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = monthAdd.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                    addPage.needFocus = true
                }
                imageSource: "asset:///images/add.png"
                shortcuts: [
                    Shortcut {
                        key: "a"
                    }
                ]
            },
            ActionItem {
                id: custListAction
                title: qsTr("Customer")
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/Customer_Male.png"
                onTriggered: {
                    var addPage = custList.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                }
                shortcuts: Shortcut {
                    key: "c"
                }
            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    monthSource.load()
                }
                imageSource: "asset:///images/refresh.png"

                shortcuts: [
                    Shortcut {
                        key: "r"
                    }
                ]
            }
        ]

    }
    onCreationCompleted: {
        monthSource.load()
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            monthSource.load()
        }
    }
}
