import bb.cascades 1.2

TabbedPane {
    id: tabPanel

    attachedObjects: [
        Sheet {
            id: helpSheet
            Page {
                titleBar: TitleBar {
                    kind: TitleBarKind.FreeForm
                    kindProperties: FreeFormTitleBarKindProperties {
                        content: Container {
                            Button {
                                text: qsTr("Close")
                                onClicked: {
                                    helpSheet.close()
                                }
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                    }

                }
            }
        },
        Sheet {
            id: settingSheet
            Page {
                titleBar: TitleBar {
                    kind: TitleBarKind.FreeForm
                    kindProperties: FreeFormTitleBarKindProperties {
                        content: Container {
                            Button {
                                text: qsTr("Close")
                                onClicked: {
                                    settingSheet.close()
                                }
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                    }

                }
            }
        }
    ]

    Menu.definition: [
        MenuDefinition {
            helpAction: HelpActionItem {
                id: helpAction
                
                onTriggered: {
                    //helpSheet.open()
                }
            }

            settingsAction: SettingsActionItem {
                id: settingAction
                onTriggered: {
                    settingSheet.open()
                }
            }
        }
    ]

    tabs: Tab {
        id: learningTab
        title: qsTr("Learning")
        imageSource: "asset:///images/language.png"
        LearningList {

        }
    }

    Tab {
        id: memoTab
        title: qsTr("Memo")
        content: MemoList {

        }
        imageSource: "asset:///images/book.png"

    }

//    shortcuts: [
//        Shortcut {
//            key: "w"
//            onTriggered: {
//                tabPanel.activeTab=learningTab
//            }
//        },
//        Shortcut {
//            key: "e"
//            onTriggered: {
//                tabPanel.activeTab=memoTab
//            }
//        }
//
//    ]

}
