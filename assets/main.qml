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
                                text: qsTr("关闭")
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
                                text: qsTr("关闭")
                                preferredWidth: 40
                                onClicked: {
                                    settingSheet.close()
                                }
                                verticalAlignment: VerticalAlignment.Center
                            }
                        }
                    }

                }
                
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Button {
                        text: "导入"
                        onClicked: {
                        }
                    }
                    
                    Button {
                        text: "导出"
                        onClicked: {
                        }
                    }
                }
            }
        },
        FilePicker {
            id: settingPicker
            title: "选择应用程序目录"
            type: FileType.Other
            defaultType: FileType.Other
            sourceRestriction: FilePickerSourceRestriction.PathOnly
            directories : ["/accounts/1000/removable/sdcard/" , "/accounts/1000/shared/"]
            
            onFileSelected: {
                console.log(selectedFiles[0])
            }
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
        title: qsTr("主页")
        imageSource: "asset:///images/Language_Setting.png"
        HomePage {
            
        }
    } 
    
    Tab {
        id: learningTab
        title: qsTr("学习")
        imageSource: "asset:///images/language.png"
        LearningList {

        }
    }

    Tab {
        id: memoTab
        title: qsTr("记事本")
        content: MemoList {

        }
        imageSource: "asset:///images/book.png"

    }
    
    Tab {
        id: attendanceTab
        title: qsTr("勤务表")
        imageSource: "asset:///images/star.png"

        content: Page {
            
        }
    
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
