import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

NavigationPane {
    id: navigationPane

    Page {
        Container {
            ListView {
                dataModel: monthModel
                
                listItemComponents: ListItemComponent {
                    StandardListItem {
                        title: ListItemData.title
                        //description: attendance count
                        
                    }
                }
                
                onTriggered: {
                    
                }
            }
        }

        actions: ActionItem {
            title: qsTr("Add month to list")
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                navigationPane.push(secondPageDefinition.createObject());
            }
        }
    }

    attachedObjects: [
        ComponentDefinition {
            id: secondPageDefinition
            Page {
                Container {

                }
            }
        },
        GroupDataModel {
            id: monthModel
            sortedAscending: false
            grouping: ItemGrouping.None
        },
        DataSource {
            id: monthSource
            type: DataSourceType.Sql
            remote: false
            source: "file://" + nicomeApp.getDatabasePath()
            query: "SELECT id,title,no FROM month LIMIT 10"

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

    onCreationCompleted: {
        monthSource.load()
    }

    onPopTransitionEnded: {
        page.deleteLater();
    }
}
