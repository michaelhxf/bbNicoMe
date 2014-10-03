import bb.cascades 1.2
import bb.data 1.0
import bb.cascades.datamanager 1.2

NavigationPane {
    id: navigate

    property string jpWord
    property string engWord
    property string cnWord
    property string queryMemo
    property string queryTask
    property string queryAttendance
    property string randomWord
    property bool needRefresh
    property TabbedPane tabPanel

    property LearningDetail detailPage
    
    function reload() {
        //
        var jpwordstr = "SELECT id from learning WHERE langtypeid=1"
        jpWord = jpwordstr
        
        var engwordstr = "SELECT id from learning WHERE langtypeid=2"
        engWord = engwordstr
        
        var cnwordstr = "SELECT id from learning WHERE langtypeid=3"
        cnWord = cnwordstr
        
        var querymemostr = "SELECT id from memo"
        queryMemo = querymemostr
        
        var queryattendancestr = "SELECT id from attendance" //where month
        queryAttendance = queryattendancestr
        
        var randomwordstr = "SELECT * FROM learning ORDER BY RANDOM() LIMIT 1"
        randomWord = randomwordstr

        //
        countSource.query = jpWord
        countSource.load();
        //
        countSource.query = engWord
        countSource.load();
        //
        countSource.query = cnWord
        countSource.load();
        //
        countSource.query = queryMemo
        countSource.load();
        //
        //countSource.query = queryAttendance
        //countSource.load();
        
        countSource.query=randomWord
        countSource.load()
    }

    onPopTransitionEnded: {
        if (needRefresh) {
            needRefresh = false
            //countSource.load()
            reload()
        }
       // page.destroy()
    }

    onCreationCompleted: {
        tabPanel = navigate.parent.parent
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
            AttendanceAdd {

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
                console.log("#load report")
                if (query == jpWord) {
                    jplWordLA.text = data.length
                }
                
                if (query == engWord) {
                    engWordLA.text =  data.length
                }
                
                if (query == cnWord) {
                    cnWordLA.text =  data.length
                }

                if (query == queryMemo) {
                    totalMemos.text = data.length
                }

                if (query == queryAttendance) {
                    totalAttendance.text =  data.length
                }
                
                if (query==randomWord){
                    randomWordButton.text = data[0].subject
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

        titleBar: TitleBar {
            title: qsTr("Home")

        }
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
                        imageSource: "asset:///images/star.png"
                        text: qsTr("Attendance")
                        minWidth: 240

                        onClicked: {
                            tabPanel.activeTab = tabPanel.tabs[3]
                        }
                    }
                }

                Container {
                    minHeight: 40
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight

                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight

                        }
                        Label {
                            text: "Japanese:"
                            //minWidth: 180
                            textStyle.textAlign: TextAlign.Right
                        }
                        Container {
                            minWidth: 10
                        }

                        Label {
                            id: jplWordLA
                            text: "0"
                        }
                    }

                    Container {
                        minWidth: 80
                    }

                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight

                        }
                        Label {
                            text: "English:"
                            //minWidth: 180
                            textStyle.textAlign: TextAlign.Right
                        }

                        Container {
                            minWidth: 10
                        }

                        Label {
                            id: engWordLA
                            text: "0"
                        }
                    }
                }

                Divider {

                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    
                    }
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        
                        }
                        Label {
                            text: "Memo:"
                            //minWidth: 180
                            textStyle.textAlign: TextAlign.Right
                        }
                        Container {
                            minWidth: 10
                        }
                        
                        Label {
                            id: totalMemo
                            text: "0"
                        }
                    }
                    
                    Container {
                        minWidth: 80
                    }
                    
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        
                        }
                        Label {
                            text: "Attendance:"
                            //minWidth: 180
                            textStyle.textAlign: TextAlign.Right
                        }
                        
                        Container {
                            minWidth: 10
                        }
                        
                        Label {
                            id: totalAttendance
                            text: "0"
                        }
                    }
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
                    Button {
                        id: randomWordButton
                        text: "none"
                        layoutProperties: StackLayoutProperties {

                        }
                        minHeight: 100
                        minWidth: 600
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
    }
}
