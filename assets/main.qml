import bb.cascades 1.2

TabbedPane {

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

}
