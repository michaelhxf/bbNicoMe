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
        ctimeLA.text = Date(detailCTime)
    }

    onDetailMTimeChanged: {
        mtimeLA.text = Date(detailMTime)
    }

    onDetailTypeChanged: {
        typeSource.load()
    }
    
    onDetailTagListChanged: {
        taglistTA.text = detailTagList
    }

    ////////////

    titleBar: TitleBar {
        title: qsTr("记事内容")
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("保存")
            ActionBar.placement: ActionBarPlacement.OnBar
            
            attachedObjects: [
                DataSource {
                    id: updateSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "asset:///nicome.s3db"
                    query: "UPDATE memo  SET subject = '"+ detailSubject +"', content = '"+ detailContent +"', memotypeid = "+ detailType + ", mtime="+ Date.now() +" WHERE id ="+ memoId
                }
            ]
            
            onTriggered: {
                navigate.needRefresh=true
                updateSource.load();
            }
            imageSource: "asset:///images/box.png"
        },
        ActionItem {
            id: deleteAction
            title: qsTr("删除")
            ActionBar.placement: ActionBarPlacement.InOverflow
            attachedObjects: [
                SystemDialog {
                    id: myQmlDialog
                    title: "提示"
                    body: "是否删除本记录... "
                    onFinished: {
                        if (myQmlDialog.result == SystemUiResult.ConfirmButtonSelection){
                            deleteSource.load()
                        }
                    }
                    confirmButton.label: "确定"
                    cancelButton.label: "取消"
                },
                DataSource {
                    id: deleteSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "asset:///nicome.s3db"
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

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("主题")
                    textStyle.fontWeight: FontWeight.Bold
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
                    text: qsTr("内容")
                    textStyle.fontWeight: FontWeight.Bold
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
                
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Type")
                    textStyle.fontWeight: FontWeight.Bold
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
                            source: "asset:///nicome.s3db"
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
                    text: qsTr("标签")
                    textStyle.fontWeight: FontWeight.Bold
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
                    text: qsTr("创建时间")
                    textStyle.fontWeight: FontWeight.Bold
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
                    text: qsTr("修改时间")
                    textStyle.fontWeight: FontWeight.Bold
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
