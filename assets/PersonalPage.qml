import bb.cascades 1.2
import bb.system 1.2
import bb.platform 1.2

NavigationPane {
    id: navigationPane

    Page {
        
        
        titleBar: TitleBar {
            title: "Personal Page"
            appearance: TitleBarAppearance.Branded

        }
        Container {
            background: Color.White

            Container {
                id: personalInfo
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                ImageView {
                    id: userpic
                    imageSource: "asset:///images/user.png"
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    accessibility.name: "TODO: Add property content"
                }
                Label {
                    id: username
                    text: "username"
                    textStyle.color: Color.Black
                }

            }
            
            Divider {
                accessibility.name: "TODO: Add property content"

            }
            
            Container {
                Label {
                    text: "Learning Report"
                }
            }
            
            Divider {
                accessibility.name: "TODO: Add property content"

            }
            
            Container {
                Label {
                    text: "Attendance Report"
                }
            }
            
            Divider {
                accessibility.name: "TODO: Add property content"

            }
            
            Container {
                Label {
                    text: "Memo Recent"
                }
            }
        }

        actions: [
            ActionItem {
                title: qsTr("New Word")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/laboratory-128.png"
            },
            ActionItem {
                title: qsTr("New Attendance")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/wristwatch-128.png"
                
            },
            ActionItem {
                title: qsTr("New Memo")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/notepad_pencil-128.png"
            },
            ActionItem {
                title: qsTr("Search All")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/search-128.png"
            },
            ActionItem {
                title: qsTr("Personal Information")
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/id-128.png"
            },
            ActionItem {
                title: qsTr("Sign Out")
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: {
                    notification.notify();
                    console.log("sign out");
                }
                imageSource: "asset:///images/plug-128.png"
            }
        ]

    }

    attachedObjects: [
        Notification {
            id: notification
            title: "title"
            body: "body"
        }
    ]

    onPopTransitionEnded: {
        page.deleteLater();
    }
}
