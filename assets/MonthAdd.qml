import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {

    property NavigationPane navigate

    property string detailTitle
    property string detailYear
    property string detailMonth

    titleBar: TitleBar {
        title: "Month Detail"
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("Save")
            ActionBar.placement: ActionBarPlacement.OnBar

            attachedObjects: [
                DataSource {
                    id: updateSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "insert into month (title, year, month) values ('" + detailTitle + "', " + detailYear + ", " + detailMonth +  ")"

                    onDataLoaded: {
                        alertToast.body = "New Month collection record created."
                        alertToast.show()
                        navigate.needRefresh = true
                    }
                },
                SystemToast {
                    id: saveToast
                    body: "New Month collection created."
                }
            ]

            onTriggered: {
                navigate.needRefresh = true
                saveToast.show()
                updateSource.load();
                navigate.pop()
            }
            imageSource: "asset:///images/box.png"
        }

    ]

    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical

        Container {
            layout: StackLayout {

            }
            background: Color.create("#ffdddddd")
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Month Title")
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: titleTF
                    onTextChanged: {
                        detailTitle = text
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Year")
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: yearTF
                    onTextChanged: {
                        detailYear = text
                    }
                    inputMode: TextFieldInputMode.Pin
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Month")
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: monthTF
                    onTextChanged: {
                        detailMonth = text
                    }
                    inputMode: TextFieldInputMode.Pin
                }

            } //line end
        }
    }
}
