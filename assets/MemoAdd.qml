import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    id: addPage
    ///properties

    property string detailSubject
    property string detailContent
    property string detailCTime
    property string detailMTime
    property string detailTagList
    property int detailType
    property NavigationPane navigate

    ////////////

    titleBar: TitleBar {
        title: qsTr("Memo Add")
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
                    source: "asset:///nicome.s3db"
                    query: "insert into memo (subject, content, memotypeid, taglist, ctime) values ('" + detailSubject + "', '" + detailContent + "', " + detailType + " , '" + detailTagList + "' , "+ Date.now() +")"

                    onDataLoaded: {
                        alertToast.body = "Memo created"
                        alertToast.show()
                        navigate.needRefresh=true
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

    onCreationCompleted: {
        typeSource.load()
    }

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
                                }

                                if (typeDD.count() > 0) {
                                    typeDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        detailType = selectedOption.value
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Tag")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                TextArea {
                    id: taglistTA
                    onTextChanged: {
                        detailTagList = text
                    }
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
                    text: qsTr("Create Time")
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
                    text: qsTr("Modify Time")
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
