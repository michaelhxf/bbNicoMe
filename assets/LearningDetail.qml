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
        meaningTA.text = detailMeaning
    }

    onDetailSubjectChanged: {
        subjectTA.text = detailSubject
    }

    onDetailSymbolChanged: {
        symbolTA.text = detailSymbol
    }
    onDetailCTimeChanged: {
        ctimeLA.text = Date(detailCTime)
    }

    onDetailMTimeChanged: {
        mtimeLA.text = Date(detailMTime)
    }

    onDetailTagListChanged: {
        taglistTA.text = detailTagList
    }

    onDetailDescriptionChanged: {
        descriptionTA = detailDescription
    }

    onDetailLangTypeIdChanged: {
        langTypeSource.load()
    }

    onDetailVoiceLinkChanged: {

    }

    onDetailPictureIdChanged: {

    }

    onDetailQIndexChanged: {
        qindexTA.text = detailQIndex
    }

    ////////////

    titleBar: TitleBar {
        title: qsTr("单词内容")
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
                    query: "UPDATE learning  SET subject = '" + detailSubject + "', meaning = '" + detailMeaning + "', symbol = '" + detailSymbol + "', description = '" + detailDescription + "', qindex = '" + detailQIndex + "', voicelink = '" + detailVoiceLink + "', langtypeid = " + detailLangTypeId + ", mtime = " + Date.now() + " WHERE id =" + learningId
                }
            ]

            onTriggered: {
                navigate.needRefresh = true
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
                    title: "提醒"
                    body: "是否删除此单词记录... "
                    confirmButton.label: "确定"
                    cancelButton.label: "取消"
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
                    source: "asset:///nicome.s3db"
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
                    text: qsTr("音标")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
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
                    text: qsTr("快速索引")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
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
                    text: qsTr("含义")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                }
                TextArea {
                    id: meaningTA
                    //minHeight:120
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
                    text: qsTr("备注")
                    textStyle.fontWeight: FontWeight.Bold
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
                    text: qsTr("语言")
                    textStyle.fontWeight: FontWeight.Bold
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
                    text: qsTr("标签")
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
                    text: qsTr("创建时间")
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