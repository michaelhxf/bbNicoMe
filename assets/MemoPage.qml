import bb.cascades 1.2

NavigationPane {
    id: navigationPane
    
    Page {
        Container {
            background: Color.White
            ListView {
                dataModel: XmlDataModel {
                    source: "data.xml"
                }
                onTriggered: {
                    
                    if (indexPath.length > 1) {
                        var chosenItem = dataModel.data(indexPath);
                        var contentpage = memoDetial.createObject();
                        
                        contentpage.detailTitle = chosenItem.name
                        navigationPane.push(contentpage);
                    }
                }
                accessibility.name: "memolist"
            }
        }
        
        actions: [
            ActionItem {
                title: qsTr("New Memo")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/laboratory-128.png"
            
            },
            ActionItem {
                title: qsTr("Search")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/search-128.png"
            
            },
            ActionItem {
                title: qsTr("Recent")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/flask-128.png"
            }
        ]
        titleBar: TitleBar {
            title: "Memo"
            appearance: TitleBarAppearance.Branded
        
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: memoDetail
            source: "MemoDetailPage.qml"
        }
    ]
    
    onPopTransitionEnded: {
        page.destroy();
    }
}
