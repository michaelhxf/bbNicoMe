import bb.cascades 1.2
import bb.data 1.0

NavigationPane {
    id: memoNavPanel

    property string userId
    property string secToken
    property string memoListUrl

    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                memoNavPanel.pop()
            }
        }
    }

    Page {

        actions: [
            ActionItem {
                title: qsTr("Refresh")
                onTriggered: {
                    dataSource.load()
                }
            },
            ActionItem {
                title: qsTr("New Memo")
                onTriggered: {
                }
                ActionBar.placement: ActionBarPlacement.OnBar
            },
            ActionItem {
                title: qsTr("Search")
                ActionBar.placement: ActionBarPlacement.OnBar

            },
            ActionItem {
                title: qsTr("Recent")
                onTriggered: {
                }
                ActionBar.placement: ActionBarPlacement.OnBar
            }
        ]

        Container {
            ListView {
                dataModel: dataModel

                listItemComponents: [
                    ListItemComponent {
                        type: "item"

                        StandardListItem {
                            title: ListItemData.title
                            description: ListItemData.text
                            imageSpaceReserved: false
                            
                        }

                    }
                ]
                accessibility.name: "TODO: Add property content"
            }
        }
        titleBar: TitleBar {
            title: "Memo"
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {

                    }
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Label {
                        text: "Memo"
                        textStyle.fontSize: FontSize.XLarge
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.color: Color.White
                    }
                    TextField {
                        verticalAlignment: VerticalAlignment.Center
                        text: ""
                        hintText: "Search Keyword"

                    }
                }
            }
        }

    }

    attachedObjects: [
        GroupDataModel {
            id: dataModel
            sortingKeys: [ "mtime", "ctime" ]
            sortedAscending: false
            grouping: ItemGrouping.None
            
        },
        DataSource {
            id: dataSource
            source: memoNavPanel.memoListUrl
            type: DataSourceType.Json
            remote: true

            onDataLoaded: {
                dataModel.clear()
                //dataModel.insertList(data)
                console.log(""+data.err_code+":"+data.err_msg);
            }
            onError: {
                console.log("JSON Load Error: [" + errorType + "]: " + errorMessage);
            }
        }
    ]

    function loadData(uid, token) {

        memoNavPanel.userId = uid;
        memoNavPanel.secToken = token;
        memoNavPanel.memoListUrl= "http://nico-michaelhxf.rhcloud.com/api/memo/list/token=" + memoNavPanel.secToken.toString()
        dataSource.source = memoNavPanel.memoListUrl
        console.log("loading data: " + memoNavPanel.memoListUrl);
        
        dataSource.load();
    }
}
