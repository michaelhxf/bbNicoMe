import bb.cascades 1.2

TabbedPane {

    tabs: Tab {
        id: learningTab
        title: qsTr("Learning")
        LearningList {
            
        }
    }

    Tab {
        id: memoTab
        title: qsTr("Memo")
        content: MemoList {

        }

    }

}
