import bb.cascades 1.2
import bb.cascades.pickers 1.0

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
        },
        FilePicker {
            id: settingPicker
            title: "Select App Data Folder"
            type: FileType.Document
            defaultType: FileType.Document
            sourceRestriction: FilePickerSourceRestriction.PathOnly
            directories : ["/accounts/1000/removable/sdcard/" , "/accounts/1000/shared/"]
        }
        
    ]

    Menu.definition: [
        MenuDefinition {
            helpAction: HelpActionItem {
                id: helpAction
                
                onTriggered: {
                    //helpSheet.open()
                    settingPicker.open()
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
    
    onCreationCompleted: {
        var dbFilePath = _app.getValueFor("dbFilePath", undefined)
        if(dbFilePath == undefined){
            
        }
    }

    tabs: Tab {
        id: homeTab
        title: qsTr("Home")
        HomePage {
            
        }
    } 
    
    Tab {
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
