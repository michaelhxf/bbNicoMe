import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        title: "New Memo"
    }

    Container {
        layoutProperties: FlowListLayoutProperties {

        }
        Container {
            layoutProperties: StackLayoutProperties {

            }
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom

            }
            horizontalAlignment: HorizontalAlignment.Left
            Label {
                text: "Title"
                verticalAlignment: VerticalAlignment.Center
            }
            TextField {
                id: memoTitle
                verticalAlignment: VerticalAlignment.Center
            }
        }

        ////////////
        Container {
            layoutProperties: StackLayoutProperties {

            }
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom

            }
            horizontalAlignment: HorizontalAlignment.Left
            Label {
                text: "Text"
                verticalAlignment: VerticalAlignment.Center
            }
            TextArea {
                id: memoText
                verticalAlignment: VerticalAlignment.Center

            }
        }
        ///////////
        Container {
            layoutProperties: StackLayoutProperties {

            }
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom

            }
            horizontalAlignment: HorizontalAlignment.Left
            Label {
                text: "Memo"
                verticalAlignment: VerticalAlignment.Center
            }
            TextArea {
                id: memoMemo
                verticalAlignment: VerticalAlignment.Center
            }
        }
    }

    actions: [
        ActionItem {
            id: saveAction
            title: "Save"
            ActionBar.placement: ActionBarPlacement.OnBar

        }
    ]
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
}
