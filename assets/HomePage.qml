import bb.cascades 1.2

NavigationPane {

    Page {

        titleBar: TitleBar {
            title: qsTr("Home")
        }

        Container {
            ListView {
                dataModel: XmlDataModel {
                    source: "data.xml"
                }
                layout: GridListLayout {
                }

                onTriggered: {
                    var itemdata = dataModel.data(indexPath);
                    console.log(itemdata.title)
                }
            }
        }
    }

}
