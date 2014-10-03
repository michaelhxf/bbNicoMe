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
    property string detailQIndex
    property string detailSymbol
    property string detailDescription
    property string detailVoiceLink
    property int detailLangTypeId
    property string detailPictureId
    property string detailMemoId
    property int learningId
    property NavigationPane navigate

    onDetailMeaningChanged: {
        meaningTF.text = detailMeaning
    }

    onDetailSubjectChanged: {
        subjectTF.text = detailSubject
    }

    onDetailSymbolChanged: {
        symbolTF.text = detailSymbol
    }
    onDetailCTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailCTime))
        ctimeLA.text = Qt.formatDateTime(_date, "ddd yyyy-MM-dd  hh:mmAP")
    }

    onDetailMTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailMTime))
        mtimeLA.text = Qt.formatDateTime(_date, "ddd yyyy-MM-dd  hh:mmAP")
    }

    onDetailTagListChanged: {
        taglistTA.text = detailTagList
    }

    onDetailDescriptionChanged: {
        descriptionTA.text = detailDescription
    }

    onDetailLangTypeIdChanged: {
        langTypeSource.load()
    }

    onDetailVoiceLinkChanged: {

    }

    onDetailPictureIdChanged: {

    }

    onDetailQIndexChanged: {
        qindexTF.text = detailQIndex
    }

    ////////////

    titleBar: TitleBar {
        title: qsTr("Word Detail")
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
                    query: "UPDATE learning  SET subject = '" + detailSubject + "', meaning = '" + detailMeaning + "', symbol = '" + detailSymbol + "', description = '" + detailDescription + "', qindex = '" + detailQIndex + "', taglist='" + detailTagList + "', voicelink = '" + detailVoiceLink + "', langtypeid = " + detailLangTypeId + ", mtime = " + Date.now() + " WHERE id =" + learningId
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
                    body: "Will delete this record... "
                    confirmButton.label: "Yes"
                    cancelButton.label: "No"
                    onFinished: {
                        if (myQmlDialog.result == SystemUiResult.ConfirmButtonSelection) {
                            deleteSource.load()
                        }
                    }
                },
                DataSource {
                    id: deleteSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "DELETE FROM learning  WHERE id =" + learningId
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
                    //minHeight:120
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
                    //minHeight: 120
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
                            source: "file://" + nicomeApp.getDatabasePath()
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
                                    if (data[i].id == detailLangTypeId) {
                                        langTypeDD.selectedOption = option
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
                        detailTagList = text
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

            Divider {
                minHeight: 100

            }

        }
    }

}
