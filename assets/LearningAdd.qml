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
    property int learningId
    property NavigationPane navigate
    property bool needFocus

    onDetailTagListChanged: {
        taglistTA.text = detailTagList
    }
    
    onNeedFocusChanged: {
        subjectTF.requestFocus()
    }
    

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
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "INSERT INTO learning (subject, meaning, symbol, qindex, description, taglist, langtypeid, voicelink, ctime) values ('" + detailSubject + "' , '" + detailMeaning + "' , '" + detailSymbol + "' , '" + detailQIndex + "' , '" + detailDescription + "' , '" + detailTagList + "' , " + detailLangTypeId + " , '" + detailVoiceLink + "' , " + Date.now() + ")"
                    
                    onDataLoaded: {
                        alertToast.body = "New word record created."
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
            background: Color.create("#ffdddddd")
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Subject")
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: subjectTF
                    //minHeight: 120
                    onTextChanged: {
                        detailSubject = text
                    }
                }

            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Meaning")
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: meaningTF
                    minHeight: 120
                    onTextChanged: {
                        detailMeaning = text
                    }
                }
            
            } //line end

            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Symbol")
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: symbolTF
                    //minHeight: 120
                    onTextChanged: {
                        detailSymbol = text
                    }
                }
            
            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Quick")
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                    verticalAlignment: VerticalAlignment.Center
                }
                TextField {
                    id: qindexTF
                    //minHeight: 120
                    onTextChanged: {
                        detailQIndex = text
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
                    textStyle.textAlign: TextAlign.Right
                    verticalAlignment: VerticalAlignment.Center
                }
                TextArea {
                    id: descriptionTA
                    minHeight: 120
                    onTextChanged: {
                        detailDescription = text
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
                            source:  "file://"+ nicomeApp.getDatabasePath()
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
            Container {
                maxHeight: 300
                
                ListView {
                    dataModel: langTagModel
                    
                    onCreationCompleted: {
                        langTagSource.load()
                    }
                    
                    listItemComponents: ListItemComponent {
                        Container {
                            Label {
                                text: ListItemData.title
                                verticalAlignment: VerticalAlignment.Center
                                layoutProperties: StackLayoutProperties {
                                
                                }
                                horizontalAlignment: HorizontalAlignment.Center
                            }
                        
                        }
                    
                    }
                    
                    onTriggered: {
                        var chosenItem = langTagModel.data(indexPath);
                        
                        if (detailTagList.length > 0) {
                            detailTagList = detailTagList + "," + chosenItem.title
                        
                        } else {
                            detailTagList = chosenItem.title
                        }
                    
                    }
                    
                    attachedObjects: [
                        GroupDataModel {
                            id: langTagModel
                            sortedAscending: false
                            grouping: ItemGrouping.None
                        },
                        DataSource {
                            id: langTagSource
                            type: DataSourceType.Sql
                            remote: false
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "SELECT title FROM langtag LIMIT 10"
                            onDataLoaded: {
                                langTagModel.clear()
                                langTagModel.insertList(data)
                            }
                        }
                    ]
                    layout: GridListLayout {
                        columnCount: 5
                    
                    }
                }
            }
            Divider {
                minHeight: 100
            
            }
        }
    }

}
