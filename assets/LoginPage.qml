import bb.cascades 1.2

Page {
    id: loginPage

    titleBar: TitleBar {
        title: "NicoMe"
        appearance: TitleBarAppearance.Branded
        scrollBehavior: TitleBarScrollBehavior.Sticky

    }
    accessibility.name: "login"
    Container {
        Label {
            text: " "
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            Label {
                text: "  User Name:"
            }
            TextField {
                id: usrname
                input.masking: TextInputMasking.Masked
            }
            Label {
                text: " "
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            Label {
                text: "  Password:"
            }
            TextField {
                id: usrpasswd
                inputMode: TextFieldInputMode.Password
                input.masking: TextInputMasking.Masked

            }
            Label {
                text: " "
            }

        }
        layout: StackLayout {

        }

    }

    actions: [
        ActionItem {
            id: loginButton
            title: "Login"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                console.log("login");
                 Application.setScene(mainPage.createObject());
            }

        }
    ]
    
    attachedObjects: ComponentDefinition {
        id: mainPage
        source: "main.qml"
    }
}