import bb.cascades 1.2
import bb.cascades.pickers 1.0
import bb.system 1.2

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
                                text: qsTr("close")
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
                                text: qsTr("close")
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
                        text: "Import"
                        onClicked: {
                        }
                    }

                    Button {
                        text: "Export"
                        onClicked: {
                         if( nicomeApp.exportDbFile()){
                             alsertToast.body="backup success"
                             alsertToast.show()
                         }else {
                             alsertToast.body="backup failed"
                             alsertToast.show()
                         }
                            
                        }
                    }
                }
            }
        },
        FilePicker {
            id: settingPicker
            title: "Select Folder"
            type: FileType.Other
            defaultType: FileType.Other
            filter: {"*.s3db"}
            sourceRestriction: FilePickerSourceRestriction.PathOnly
            directories: [ "/accounts/1000/shared/" ]

            onFileSelected: {
                //nicomeApp.saveValueFor("destDBPath", selectedFiles[0])
                //var dbFilePath = nicomeApp.getValueFor("destDBPath", undefined)
                //console.log(dbFilePath)
            }
            viewMode: FilePickerViewMode.Default
        },
        SystemToast {
            id: alsertToast
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
       
    }

    tabs: Tab {
        id: homeTab
        title: qsTr("Home Page")
        imageSource: "asset:///images/Language_Setting.png"
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

    Tab {
        id: attendanceTab
        title: qsTr("Attendance")
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
