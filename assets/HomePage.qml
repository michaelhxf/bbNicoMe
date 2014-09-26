import bb.cascades 1.2
import bb.data 1.0
import bb.cascades.datamanager 1.2

NavigationPane {
    id: navigate

    property string queryWord
    property string queryMemo
    property string queryAttendance

    onCreationCompleted: {
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
        countSource.query = queryAttendance
        countSource.load();
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
            source: "asset:///nicome.s3db"
            type: DataSourceType.Sql

            onDataLoaded: {
                if(query == queryWord){
                    totalWords.text = "\t"+ data.length
                }
                
                if(query == queryMemo){
                    totalMemos.text = "\t"+ data.length
                }
                
                if(query == queryAttendance){
                    totalAttendance.text = "\t"+ data.length
                }
            }

        }
    ]

    Page {

        actions: [
            ActionItem {
                id: newWordAction
                title: qsTr("新单词")
                imageSource: "asset:///images/language.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    navigate.push(newWord.createObject())
                }
            },
            ActionItem {
                id: newMemoAction
                title: qsTr("新记事")
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    navigate.push(newMemo.createObject())
                }
                imageSource: "asset:///images/book.png"

            },
            ActionItem {
                id: newAttendanceAction
                title: qsTr("新签到")
                imageSource: "asset:///images/star.png"
                onTriggered: {
                    navigate.push(newAttendance.createObject())
                }
                ActionBar.placement: ActionBarPlacement.OnBar
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
                        text: "\t全部单词:"
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
                        text: "\t全部记事:"
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
                        text: "\t本月勤务:"
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
