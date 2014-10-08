import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {

    property NavigationPane navigate
    property bool needFocus

    onNeedFocusChanged: {
        keywordTF.requestFocus()
    }

    Container {
        Container {

            //tools bar
            Container {

                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight

                }
                background: Color.LightGray

                DropDown {
                    id: searchTypeDD
                    maxWidth: 100
                    minWidth: 100
                    options: [
                        Option {
                            id: jp2cn
                            value: 1
                            text: "JP2CN"
                        },
                        Option {
                            id: cn2jp
                            value: 2
                            text: "CN2JP"
                        },
                        Option {
                            id: en2cn
                            value: 3
                            text: "EN2CN"
                        }
                    ]

                    layoutProperties: StackLayoutProperties {

                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    selectedOption: jp2cn
                }
                TextField {
                    id: keywordTF
                    layoutProperties: StackLayoutProperties {

                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center

                }

            }

            Divider {

            }

            //display data area
            Container {
                ListView {
                    id: resultList
                    dataModel: searchModel

                    onTriggered: {
                        var detailPage = searchWordDetail.createObject()
                        var chosenItem = searchModel.data(indexPath)

                        if (chosenItem.Word != null && chosenItem.Word != "" && chosenItem.Word != undefined) {
                            detailPage.word = chosenItem.Word
                        }

                        if (chosenItem.Comment != null && chosenItem.Comment != "" && chosenItem.Comment != undefined) {
                            detailPage.comment = chosenItem.Comment
                        }

                        if (chosenItem.PinYin != null && chosenItem.PinYin != "" && chosenItem.PinYin != undefined) {
                            detailPage.pinyin = chosenItem.PinYin
                        }

                        if (chosenItem.Tone != null && chosenItem.Tone != "" && chosenItem.Tone != undefined) {
                            detailPage.tone = chosenItem.Tone
                        }
                        if (chosenItem.Pronounce != null && chosenItem.Pronounce != "" && chosenItem.Pronounce != undefined) {
                            detailPage.pronounce = chosenItem.Pronounce
                        }

                        if (chosenItem.TtsUrl != null && chosenItem.TtsUrl != "" && chosenItem.TtsUrl != undefined) {
                            detailPage.ttsurl = chosenItem.TtsUrl
                        }

                        if (chosenItem.PronounceJp != null && chosenItem.PronounceJp != "" && chosenItem.PronounceJp != undefined) {
                            detailPage.pronouncejp = chosenItem.PronounceJp
                        }

                        navigate.push(detailPage)
                    }

                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            CustomListItem {
                                id: resultItem
                                maxHeight: 400

                                Container {
                                    layout: StackLayout {

                                    }
                                    Label {
                                        text: ListItemData.Word
                                        textFormat: TextFormat.Html
                                        textStyle.fontWeight: FontWeight.Bold
                                        textStyle.fontSize: FontSize.Large
                                    }

                                    Label {
                                        multiline: true
                                        text: ListItemData.Comment
                                        textFormat: TextFormat.Html

                                        onCreationCompleted: {
                                            if (text.search("br") > 0) {
                                                resultItem.minHeight = (text.search("br") + 1) * 40 + 80
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    ]
                }
            }
            Divider {

            }

        }
    }

    attachedObjects: [
        GroupDataModel {
            id: searchModel
            sortedAscending: true
            grouping: ItemGrouping.None
        },
        DataSource {
            id: searchSource
            remote: true
            type: DataSourceType.Json

            onDataLoaded: {
                searchModel.clear()
                searchModel.insertList(data)
                myQmlToast.cancel()
            }
            
            onError: {
                searchModel.clear()
                myQmlToast.cancel()
            }
        },
        SystemToast {
            id: myQmlToast
            body: "Loading ..."
            position: SystemUiPosition.MiddleCenter
            button.enabled: false
            //button.label: "Undo"
            //button.enabled: true
        },
        ComponentDefinition {
            id: searchWordDetail
            SearchWordDetail {

            }
        }
    ]

    actions: [
        ActionItem {
            id: searchAction
            title: qsTr("Search")
            imageSource: "asset:///images/1412395333_gtk-zoom-100.png"
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                if (searchTypeDD.selectedValue == 1) {
                    var url = "http://m.hujiang.com/d/dict_jp_api.ashx?w=" + keywordTF.text + "&type=jc"
                    searchSource.source = url
                    searchSource.load()
                }
                if (searchTypeDD.selectedValue == 2) {
                    var url = "http://m.hujiang.com/d/dict_jp_api.ashx?w=" + keywordTF.text + "&type=cj"
                    searchSource.source = url
                    searchSource.load()
                }
                if (searchTypeDD.selectedValue == 3) {
                    var url = "http://m.hujiang.com/d/dict_en_api.ashx?w=" + keywordTF.text
                    searchSource.source = url
                    searchSource.load()
                }

                myQmlToast.show()
            }
        }
    ]

}
