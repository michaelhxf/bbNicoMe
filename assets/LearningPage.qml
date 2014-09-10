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
                        var contentpage = itemPageDefinition.createObject();

                        contentpage.itemPageTitle = chosenItem.name
                        nav.push(contentpage);
                    }
                }
                accessibility.name: "Listing"
            }
        }

        actions: [
            ActionItem {
                title: qsTr("New Word")
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
                imageSource: "asset:///images/film-128.png"
            }
        ]
        titleBar: TitleBar {
            title: "Learning"
            appearance: TitleBarAppearance.Branded
            scrollBehavior: TitleBarScrollBehavior.Sticky
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        text: " Search:"
                        verticalAlignment: VerticalAlignment.Center
                    }
                    TextField {
                        verticalAlignment: VerticalAlignment.Center

                    }
                    Label {
                        text: " "
                    }
                }

            }

        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: itemPageDefinition
            source: "ItemPage.qml"
        }
    ]

}
