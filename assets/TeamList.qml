import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    property int customerId
    property NavigationPane  navigate
    
    ListView {
        id: listview
        dataModel: teamDataModel

        listItemComponents: ListItemComponent {
            type: "item"
            StandardListItem {
                title: ListItemData.name
                description: ListItemData.description
                status: ListItemData.membercount
            }
        }

        onTriggered: {
            //if (indexPath.length > 1) {
            //            var chosenItem = dataModel.data(indexPath);
            //            var detailPage = teamDetail.createObject()
            //
            //            detailPage.detailSubject = chosenItem.subject
            //                        detailPage.detailContent = chosenItem.content
            //                        detailPage.detailCTime = chosenItem.ctime
            //                        detailPage.detailMTime = chosenItem.mtime
            //                        detailPage.detailTagList = chosenItem.taglist
            //            detailPage.detailType = chosenItem.teamtypeid
            //            detailPage.teamId = chosenItem.id
            //            detailPage.navigate = naviPanel
            //
            //            naviPanel.push(detailPage)
            // }
        }
    }

    attachedObjects: [
        GroupDataModel {
            id: teamDataModel
            sortingKeys: [ "id" ]
            sortedAscending: false
            grouping: ItemGrouping.None
        },

        DataSource {
            id: teamDataSource
            type: DataSourceType.Sql
            remote: false
            source: "file://" + nicomeApp.getDatabasePath()
            query: "select * from team"

            onDataLoaded: {
                teamDataModel.clear()
                teamDataModel.insertList(data)
            }
        },

        ComponentDefinition {
            id: teamDetail
            //source: "teamDetail.qml"
        },

        ComponentDefinition {
            id: teamAdd
            source: "TeamAdd.qml"
        }

    ]

    actions: [
        ActionItem {
            id: addTeamAction
            title: qsTr("New team")
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                var addPage = teamAdd.createObject()
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
            id: refreshAction
            title: qsTr("Refresh")
            ActionBar.placement: ActionBarPlacement.InOverflow

            onTriggered: {
                teamDataSource.load()
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
        title: "Team List"
    }

}
