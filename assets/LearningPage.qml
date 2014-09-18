import bb.cascades 1.2
import bb.data 1.0

NavigationPane {
    id: navigationPane

    Page {
        id: pgDetail
        
        actions: [
            ActionItem {
                title: qsTr("Refresh")
                onTriggered: {
                    dataSource.load()
                }
            }
        ]
        paneProperties: NavigationPaneProperties {
            backButton: ActionItem {
                onTriggered: {
                    navigationPane.pop()
                }
            }
        }
        Container {
            ListView {
                dataModel: dataModel
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        
                        StandardListItem {
                            title: convertDate(ListItemData.someDateField) // call a function
                            description: ListItemData.someField
                            imageSpaceReserved: false
                            
                            function convertDate(toBeConvertedDate) {
                                console.debug("registration date: " + toBeConvertedDate);
                                console.debug("type of registration date: " + typeof toBeConvertedDate);
                                var workingDate = new Date();
                                workingDate.setFullYear(toBeConvertedDate.substring(0,4));
                                console.debug("year: " + toBeConvertedDate.substring(0,4));
                                workingDate.setMonth(toBeConvertedDate.substring(5,7) - 1);
                                console.debug("month: " + toBeConvertedDate.substring(5,7));
                                workingDate.setDate(toBeConvertedDate.substring(8,10));
                                console.debug("date: " + toBeConvertedDate.substring(8,10));
                                
                                workingDate.setHours(toBeConvertedDate.substring(11, 13));
                                console.debug("hours: " + toBeConvertedDate.substring(11, 13));
                                workingDate.setMinutes(toBeConvertedDate.substring(14,16));
                                console.debug("minutes: " + toBeConvertedDate.substring(14,16));
                                workingDate.setSeconds(toBeConvertedDate.substring(17,19));
                                console.debug("seconds: " + toBeConvertedDate.substring(17,19));
                                
                                //var toBeReturnedDate = Qt.formatDateTime(workingDate, "yyyy/MM/dd HH:mm:ss");
                                var toBeReturnedDate = Qt.formatDateTime(workingDate, "ddd dd MMM yyyy");
                                
                                console.debug("toBeReturnedDate: " + toBeReturnedDate);
                                return toBeReturnedDate;
                            }
                        }
                    
                    }
                ]
                accessibility.name: "TODO: Add property content"
            }
        }
        
        attachedObjects: [
            GroupDataModel {
                id: dataModel
                sortingKeys: ["someImportantFieldName"]
                sortedAscending: false
                grouping: ItemGrouping.None
            },
            DataSource {
                id: dataSource
                source: "http://some.url.that.returns.json"
                type: DataSourceType.Json
                
                onDataLoaded: {
                    dataModel.clear()
                    dataModel.insertList(data)
                }
            }
        ]
        
        onCreationCompleted: {
            dataSource.load()
        }
    }
}
