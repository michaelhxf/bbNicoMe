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

                    }

                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight

                        }
                        Button {
                            text: "Import"
                            onClicked: {
                                importPicker.open()
                            }
                        }

                        Button {
                            text: "Export"
                            onClicked: {
                                if (nicomeApp.exportDbFile("" + Date.now())) {
                                    alertToast.body = "backup to [documents] success"
                                    alertToast.show()
                                } else {
                                    alertToast.body = "backup failed"
                                    alertToast.show()
                                }

                            }
                        }
                    }
                    Button {
                        text: "Force Init Database"
                        onClicked: {
                           if( nicomeApp.initDatabase(true)){
                               alertToast.body = "Force Init Data success"
                               alertToast.show()
                           }
                        }
                    }
                }

            }
        },
        FilePicker {
            id: importPicker
            title: "Select Folder"
            type: FileType.Other
            defaultType: FileType.Other
            filter: {
                "*.s3db"
            }
            sourceRestriction: FilePickerSourceRestriction.PathOnly
            directories: [ "/accounts/1000/shared/" ]
            viewMode: FilePickerViewMode.Default

            onFileSelected: {
                if (nicomeApp.importDbFile(selectedFiles[0])) {
                    alertToast.body = "import success"
                    alertToast.show()
                } else {
                    alertToast.body = "import failed"
                    alertToast.show()
                }
            }
        },
        SystemToast {
            id: alertToast
        }

    ]

    Menu.definition: [
        MenuDefinition {
            helpAction: HelpActionItem {
                id: helpAction

                onTriggered: {
                    helpSheet.open()
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
        if (nicomeApp.initDatabase(false)) {
            console.log("#init database success.\n#change database to data directory")
        } else {
            console.log("#init database failed.")
        }
        homeTab.tabPanel = tabPanel
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

        content: AttendanceList {

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
