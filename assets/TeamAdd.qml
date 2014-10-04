import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {

    property string detailName
    property string detailDescription
    property string detailArea
    property int detailMemberCount
    property int detailLeaderId

    property int customerId
    property int teamId
    property NavigationPane navigate
    property bool needFocus
    
    onNeedFocusChanged: {
        nameTF.requestFocus()
    }

    titleBar: TitleBar {
        title: qsTr("New Team")
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("Save")
            ActionBar.placement: ActionBarPlacement.OnBar

            attachedObjects: [
                DataSource {
                    id: insertSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "insert into team (name, description, area, membercount, customerid) values ('" + detailName + "', '" + detailDescription + "', '" + detailArea + "' , " + detailMemberCount +  " , " + customerId + ")"

                    onDataLoaded: {
                        alertToast.body = "New team record created."
                        alertToast.show()
                        navigate.needRefresh = true
                        navigate.pop()
                    }
                },
                SystemToast {
                    id: alertToast
                    button.enabled: false
                }
            ]

            onTriggered: {
                insertSource.load();
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
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Team Name")
                    minWidth: 180
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Right
                }
                TextField {
                    id: nameTF
                    onTextChanged: {
                        detailName = text
                    }
                }

            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Area")
                    textStyle.textAlign: TextAlign.Right
                    minWidth: 180
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: areaTF
                    onTextChanged: {
                        detailArea = text
                    }
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Members")
                    textStyle.textAlign: TextAlign.Right
                    minWidth: 180
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: membercountTF
                    onTextChanged: {
                        detailMemberCount = text
                    }
                }
            
            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Description")
                    minWidth: 180
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Right
                }
                TextArea {
                    id: descriptionTA
                    minHeight: 200
                    onTextChanged: {
                        detailDescription = text
                    }
                }

            } //line end

            Divider {
            }

        }
    }
}