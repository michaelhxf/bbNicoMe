import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {

    property NavigationPane navigate
    property bool needFocus

    onNeedFocusChanged: {
        keywordTF.requestFocus()
    }

    ScrollView {
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
                        spaceQuota: -1.0

                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    selectedOption: jp2cn
                }
                TextField {
                    id: keywordTF
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: -1.0

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

                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            CustomListItem {
                                id: resultItem
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
        },
        SystemToast {
            id: myQmlToast
            body: "Loading ..."
            position: SystemUiPosition.MiddleCenter
            button.enabled: false
            //button.label: "Undo"
            //button.enabled: true
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
