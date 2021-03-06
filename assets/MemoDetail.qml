import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    id: detailPage
    ///properties

    property string detailSubject
    property string detailContent
    property string detailCTime
    property string detailMTime
    property string detailTagList
    property int detailType
    property int memoId
    property NavigationPane navigate

    onDetailContentChanged: {
        contentTA.text = detailContent
    }

    onDetailSubjectChanged: {
        subjectTA.text = detailSubject
    }

    onDetailCTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailCTime))
        ctimeLA.text = Qt.formatDateTime(_date,"ddd yyyy.MM.dd hh:mmAP")
    }
    
    onDetailMTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailMTime))
        mtimeLA.text = Qt.formatDateTime(_date,"ddd yyyy.MM.dd hh:mmAP")
    }
    
    onDetailTypeChanged: {
        typeSource.load()
    }
    
    onDetailTagListChanged: {
        taglistTA.text = detailTagList
    }

    ////////////

    titleBar: TitleBar {
        title: qsTr("Memo Detail")
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
                    query: "UPDATE memo  SET subject = '"+ detailSubject +"', content = '"+ detailContent +"', memotypeid = "+ detailType + ", mtime="+ Date.now() +" WHERE id ="+ memoId
                },
                SystemToast {
                    id: saveToast
                    body: "Update complite."
                }
            ]
            
            onTriggered: {
                navigate.needRefresh=true
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
                        if (myQmlDialog.result == SystemUiResult.ConfirmButtonSelection){
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
                    query: "DELETE FROM memo  WHERE id ="+ memoId
                    onDataLoaded: {
                        navigate.needRefresh=true 
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
                    text: qsTr("Subject")
                    verticalAlignment: VerticalAlignment.Center
                }
                TextArea {
                    id: subjectTA
                    minHeight: 120
                    onTextChanged: {
                        detailSubject = text
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Content")
                    verticalAlignment: VerticalAlignment.Center
                }
                TextArea {
                    id: contentTA
                    minHeight: 240
                    onTextChanged: {
                        detailContent = text
                    }
                }

            } //line end

            //line
            Container {
                visible: false
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Type")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: typeDD
                    
                    attachedObjects: [
                        ComponentDefinition {
                            id: dropdownOption
                            Option {
                                
                            }
                        },
                        DataSource {
                            id: typeSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select * from memotype"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = dropdownOption.createObject();
                                    option.text = data[i].title
                                    option.value = data[i].id
                                    typeDD.add(option)
                                    //console.log("dd:" + detailType + " id:" + data[i].id)
                                    if (data[i].id == detailType) {
                                        typeDD.selectedOption = option
                                    }
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        detailType= selectedOption.value
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Tags")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                TextArea {
                    id: taglistTA
                }

            } //line end

            Divider {
            }

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Create Time:")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                Label {
                    id: ctimeLA
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Modify Time:")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                Label {
                    id: mtimeLA
                }

            } //line end
        }
    }

}
