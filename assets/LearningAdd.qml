import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    id: detailPage
    ///properties

    property string detailSubject
    property string detailMeaning
    property string detailCTime
    property string detailMTime
    property string detailTagList
    property string detailSymbol
    property string detailQIndex
    property string detailDescription
    property string detailVoiceLink
    property int detailLangTypeId
    property int detailPictureId
    property int detailMemoType
    property int learningId
    property NavigationPane navigate


    ////////////

    titleBar: TitleBar {
        title: qsTr("New Word")
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
                    source:  "file://"+ nicomeApp.getDatabasePath()
                    query: "INSERT INTO learning (subject, meaning, symbol, qindex, description, langtypeid, voicelink, ctime) values ('" + detailSubject + "' , '" + detailMeaning + "' , '" + detailSymbol +"' , '" + detailQIndex + "' , '" + detailDescription + "' , " + detailLangTypeId + " , '" + detailVoiceLink + "' , " + Date.now() + ")"
                    
                    onDataLoaded: {
                        alertToast.body = "New word created."
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
                navigate.needRefresh = true
                updateSource.load();
            }
            imageSource: "asset:///images/box.png"
        }
    ]
    
    onCreationCompleted: {
        langTypeSource.load()
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
                    textStyle.fontWeight: FontWeight.Bold
                }
                TextArea {
                    id: subjectTA
                    //minHeight: 120
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
                    text: qsTr("Symbol")
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Bold
                }
                TextArea {
                    id: symbolTA
                    //minHeight: 120
                    onTextChanged: {
                        detailSymbol = text
                    }
                }
            
            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Quick Index")
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Bold
                }
                TextArea {
                    id: qindexTA
                    //minHeight: 120
                    onTextChanged: {
                        detailQIndex = text
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Meaning")
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Bold
                }
                TextArea {
                    id: meaningTA
                    minHeight: 120
                    onTextChanged: {
                        detailMeaning = text
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Description")
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Bold
                }
                TextArea {
                    id: descriptionTA
                    minHeight: 120
                    onTextChanged: {
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Language")
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: langTypeDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: langDDOption
                            Option {

                            }
                        },
                        DataSource {
                            id: langTypeSource
                            source: "asset:///nicome.s3db"
                            query: "select * from langtype"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = langDDOption.createObject();
                                    option.text = data[i].title
                                    option.value = data[i].id
                                    langTypeDD.add(option)
                                    //console.log("dd:" + detailType + " id:" + data[i].id)
                                    if (langTypeDD.count() > 0) {
                                        langTypeDD.selectedIndex = 0;
                                    }
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        detailLangTypeId = selectedOption.value
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
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                TextArea {
                    id: taglistTA
                    onTextChanged: {
                        detailTagList=text
                    }
                }

            } //line end

            Divider {
            }


        }
    }

}
