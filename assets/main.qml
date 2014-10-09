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
                                layoutProperties: StackLayoutProperties {

                                }
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
                                layoutProperties: StackLayoutProperties {

                                }
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
                            imageSource: "asset:///images/1412395337_new-go-bottom.png"
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
                            imageSource: "asset:///images/1412395532_old-edit-redo.png"
                        }
                    }
                    Button {
                        text: "Force Init Database"

                        attachedObjects: [
                            SystemDialog {
                                id: finitdbDialog
                                title: "Force Init Database"
                                body: "This operation will clear all data... "
                                onFinished: {
                                    if (finitdbDialog.result == SystemUiResult.ConfirmButtonSelection) {
                                        if (nicomeApp.initDatabase(true)) {
                                            alertToast.body = "Force Init Data success"
                                            alertToast.show()
                                        }
                                    }
                                }
                                confirmButton.label: "Yes"
                                cancelButton.label: "No"
                            }
                        ]

                        onClicked: {
                            finitdbDialog.show()
                        }
                        imageSource: "asset:///images/1412395152_dialog-warning.png"
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
    }

    tabs: Tab {
        id: homeTab
        title: qsTr("Home Page")
        imageSource: "asset:///images/1412395468_lincity-ng.png"
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
        imageSource: "asset:///images/1412394983_preferences-system-time.png"

        content: MonthList {

        }

    }

    Tab {
        id: taskTab
        title: qsTr("Task")

        content: TaskList {

        }
        imageSource: "asset:///images/1412395012_stock_task.png"
    }

}
