import bb.cascades 1.2
import bb.data 1.0
import bb.cascades.datamanager 1.2

NavigationPane {
    id: navigate

    property string queryJpWord
    //property string queryEngWord
    //property string queryCnWord
    property string queryMemo
    //property string queryTask
    property string queryAttendance
    property string querySentence
    property string queryJX

    property int jpcount
    property int memocount
    property int attendancecount
    property int sentencecount
    property int jxcount

    property string randomWord
    property bool needRefresh
    property TabbedPane tabPanel

    property LearningDetail detailPage

    function reloadCount() {
        //
        queryJpWord = "SELECT id from learning WHERE langtypeid=1"
        //queryEngWord = "SELECT id from learning WHERE langtypeid=2"
        //queryCnWord = "SELECT id from learning WHERE langtypeid=3"
        //queryMemo = "SELECT id from memo"
        //queryAttendance = "SELECT id from attendance" //where month
        querySentence = "SELECT id FROM learning WHERE taglist LIKE \"%句子%\""
        queryJX = "SELECT id FROM learning WHERE taglist LIKE \"%句型%\""

        randomWord = "SELECT * FROM learning ORDER BY RANDOM() LIMIT 1"

        //
        countSource.query = queryJpWord
        countSource.load();
        //
        //countSource.query = queryEngWord
        //countSource.load();
        //
        //countSource.query = cnWord
        //countSource.load();
        //
        //countSource.query = queryMemo
        //countSource.load();
        //
        //countSource.query = queryAttendance
        //countSource.load();
        //
        countSource.query = querySentence
        countSource.load();
        //
        countSource.query = queryJX
        countSource.load();

        //countSource.query=randomWord
        //countSource.load()

        //finally show the chart
        var datastr = "chart.series[0].setData([['Other' ," + (jpcount - jxcount -sentencecount) + "],[ 'Sentence', " + sentencecount + " ] , [ 'Jx', "+jxcount+"]], true)"
        chartView.evaluateJavaScript(datastr)
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            //countSource.load()
            reloadCount()
        }
        // page.destroy()
    }

    onCreationCompleted: {
        tabPanel = navigate.parent.parent
        chartView.loadFile(nicomeApp.getChartHTML())
        reloadCount()
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
            AttendanceAdd {

            }
        },
        ComponentDefinition {
            id: searchWord
            SearchWord {

            }
        },

        ComponentDefinition {
            id: learningDetail
            source: "LearningDetail.qml"
        },

        DataSource {
            id: countSource
            remote: false
            source: "file://" + nicomeApp.getDatabasePath() //"asset:///nicome.s3db" //nicomeApp.getValueFor("dbFilePath", undefined)
            type: DataSourceType.Sql

            onDataLoaded: {
                //console.log("#load report")
                if (query == queryJpWord) {
                    jpcount = data.length
                }

                if (query == queryMemo) {
                    memocount = data.length
                }

                if (query == queryAttendance) {
                    attendancecount = data.length
                }
                if (query == querySentence) {
                    sentencecount = data.length
                }
                if (query == queryJX) {
                    jxcount = data.length
                }
                if (query == randomWord) {
                    randomWordLA.text = data[0].subject
                    var chosenItem = data[0]
                    detailPage = learningDetail.createObject()

                    detailPage.detailSubject = chosenItem.subject
                    detailPage.detailMeaning = chosenItem.meaning
                    detailPage.detailQIndex = chosenItem.qindex
                    detailPage.detailDescription = chosenItem.description
                    detailPage.detailCTime = chosenItem.ctime
                    detailPage.detailMTime = chosenItem.mtime
                    detailPage.detailTagList = chosenItem.taglist
                    detailPage.detailMemoId = chosenItem.memoid
                    detailPage.detailSymbol = chosenItem.symbol
                    detailPage.detailTagList = chosenItem.taglist
                    detailPage.detailLangTypeId = chosenItem.langtypeid
                    detailPage.detailPictureId = chosenItem.pictureid
                    detailPage.detailVoiceLink = chosenItem.voicelink
                    detailPage.learningId = chosenItem.id
                    detailPage.navigate = navigate
                }
            }

        }
    ]

    Page {

        //        titleBar: TitleBar {
        //            title: qsTr("Home")
        //
        //        }
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
                    addPage.needFocus = true
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
                    addPage.needFocus = true
                }
                imageSource: "asset:///images/book.png"

            },
            ActionItem {
                id: newAttendanceAction
                title: qsTr("New Attendance")
                imageSource: "asset:///images/1412394983_preferences-system-time.png"
                ActionBar.placement: ActionBarPlacement.OnBar

                onTriggered: {
                    var addPage = newAttendance.createObject()
                    addPage.navigate = navigate
                    navigate.push(addPage)
                }

            },
            ActionItem {
                id: searchwordAction
                title: qsTr("Search Word Online")
                imageSource: "asset:///images/1412395069_gnome-fs-loading-icon.png"
                ActionBar.placement: ActionBarPlacement.InOverflow

                shortcuts: Shortcut {
                    key: "s"

                }

                onTriggered: {
                    var swoPage = searchWord.createObject()
                    swoPage.navigate = navigate
                    navigate.push(swoPage)
                    swoPage.needFocus = true
                }

            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                imageSource: "asset:///images/refresh.png"
                ActionBar.placement: ActionBarPlacement.InOverflow

                onTriggered: {
                    reloadCount()
                }

                shortcuts: Shortcut {
                    key: "r"
                }

            }
        ]

        ///content
        Container {
            Container {
                layout: StackLayout {

                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    Button {
                        imageSource: "asset:///images/language.png"
                        text: qsTr("Learning")
                        minWidth: 240
                        onClicked: {

                            tabPanel.activeTab = tabPanel.tabs[1]
                        }
                    }

                    Button {
                        imageSource: "asset:///images/book.png"
                        text: qsTr("Memo")
                        minWidth: 240

                        onClicked: {
                            tabPanel.activeTab = tabPanel.tabs[2]
                        }
                    }

                    Button {
                        imageSource: "asset:///images/1412394983_preferences-system-time.png"
                        text: qsTr("Attendance")
                        minWidth: 240

                        onClicked: {
                            tabPanel.activeTab = tabPanel.tabs[3]
                        }
                    }
                }

                Divider {

                }

                WebView {
                    id: chartView
                    minHeight: 400
                    html: "loading chart..."

                }

                Divider {

                }

                Container {
                    minHeight: 80
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    Label {
                        id: randomWordLA
                        textStyle.fontSize: FontSize.Large
                        textStyle.textAlign: TextAlign.Right
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        layoutProperties: StackLayoutProperties {

                        }
                    }
                    Button {
                        id: randomWordButton
                        text: ">"
                        layoutProperties: StackLayoutProperties {

                        }
                        minHeight: 100
                        maxWidth: 100
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center

                        onClicked: {
                            navigate.push(detailPage)
                        }
                    }

                }

                Divider {

                }

            }
        }

        shortcuts: [
            Shortcut {
                key: "q"
                onTriggered: {
                    countSource.query = randomWord
                    countSource.load()
                }
            }
        ]
    }
}
