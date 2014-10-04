import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    
    property NavigationPane navigate
    
    property string detailTitle
    property string detailYear
    property string detailMonth
    property string monthId
    

    onDetailTitleChanged: {
        titleTF.text = detailTitle
    }
    onDetailYearChanged: {
        yearTF.text = detailYear
    }
    
    onDetailMonthChanged: {
        monthTF.text = detailMonth
    }

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
                    query: "UPDATE month  SET title = '" + detailTitle + "', no = " + detailNo + " WHERE id =" + monthId
                },
                SystemToast {
                    id: saveToast
                    body: "Update complite."
                }
            ]

            onTriggered: {
                navigate.needRefresh = true
                saveToast.show()
                updateSource.load();
                navigate.pop()
            }
            imageSource: "asset:///images/box.png"
        },
        ActionItem {
            id: deleteAction
            title: qsTr("Delete")
            ActionBar.placement: ActionBarPlacement.InOverflow
            attachedObjects: [
                SystemDialog {
                    id: myQmlDialog
                    title: "Delete"
                    body: "Will delete this Record... "
                    onFinished: {
                        if (myQmlDialog.result == SystemUiResult.ConfirmButtonSelection) {
                            deleteSource.load()
                        }
                    }
                    confirmButton.label: "Yes"
                    cancelButton.label: "No"
                },
                DataSource {
                    id: deleteSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "DELETE FROM month WHERE id =" + monthId
                    onDataLoaded: {
                        navigate.needRefresh = true
                        navigate.pop()
                    }
                }

            ]
            onTriggered: {
                myQmlDialog.show();
            }
            imageSource: "asset:///images/error.png"
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
