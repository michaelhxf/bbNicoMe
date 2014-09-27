import bb.cascades 1.2
import bb.data 1.0
import bb.cascades.datamanager 1.2

NavigationPane {
    id: navigate

    property string queryWord
    property string queryMemo
    property string queryAttendance
    property bool needRefresh

    function reload() {
        //
        var querywordstr = "SELECT id from learning"
        queryWord = querywordstr
        var querymemostr = "SELECT id from memo"
        queryMemo = querymemostr
        var queryattendancestr = "SELECT id from attendance" //where month
        queryAttendance = queryattendancestr

        //
        countSource.query = queryWord
        countSource.load();
        //
        countSource.query = queryMemo
        countSource.load();
        //
        //countSource.query = queryAttendance
        //countSource.load();
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            //countSource.load()
            reload()
        }
    }

    onCreationCompleted: {
        reload()
    }

    attachedObjects: [
        ComponentDefinition {
            id: newWord
            LearningAdd {

            }
        },
        ComponentDefinition {
            id: newMemo
            MemoAdd {

            }
        },
        ComponentDefinition {
            id: newAttendance
        },

        DataSource {
            id: countSource
            remote: false
            source: "file://" + nicomeApp.getDatabasePath() //"asset:///nicome.s3db" //nicomeApp.getValueFor("dbFilePath", undefined)
            type: DataSourceType.Sql

            onDataLoaded: {
                console.log("#load report")
                if (query == queryWord) {
                    totalWords.text = "\t" + data.length
                }

                if (query == queryMemo) {
                    totalMemos.text = "\t" + data.length
                }

                if (query == queryAttendance) {
                    totalAttendance.text = "\t" + data.length
                }
            }

        }
    ]

    Page {
        actions: [
            ActionItem {
                id: newWordAction
                title: qsTr("New Word")
                imageSource: "asset:///images/language.png"
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = newWord.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                }
            },
            ActionItem {
                id: newMemoAction
                title: qsTr("New Memo")
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = newMemo.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                }
                imageSource: "asset:///images/book.png"

            },
            ActionItem {
                id: newAttendanceAction
                title: qsTr("New Attendance")
                imageSource: "asset:///images/star.png"
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = newAttendance.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                }

            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                imageSource: "asset:///images/refresh.png"
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    reload()
                }
                
                shortcuts: Shortcut {
                    key: "r"
                    onTriggered: {
                        reload()
                    }
                }

            }
        ]

        ///content
        ScrollView {
            Container {

                layout: StackLayout {

                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Label {
                        text: "\tWords:"
                        minWidth: 120
                    }

                    Label {
                        id: totalWords
                        text: "\t0"
                    }
                }

                Divider {

                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Label {
                        text: "\tMemos:"
                        minWidth: 120
                    }

                    Label {
                        id: totalMemos
                        text: "\t0"
                    }
                }

                Divider {

                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Label {
                        text: "\tAttendace:"
                        minWidth: 120
                    }

                    Label {
                        id: totalAttendance
                        text: "\t0"
                    }
                }

            }
        }
    }
}
