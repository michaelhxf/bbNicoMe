import bb.cascades 1.2

Page {
    id: loginPage

    function getToken() {
        
        var getString = "http://nico-michaelhxf.rhcloud.com/api/loguser/get_token/name=" + usrname.text + "&password=" + usrpasswd.text;
        var request = new XMLHttpRequest();
        
        request.onreadystatechange = function() {

            if (request.readyState === XMLHttpRequest.DONE) {
                
               // if (request.status === 200) {
                    console.log("request:"+getString);
                    console.log("response:"+request.responseText.toMap["data"].toMap["token"]);
                    console.log("login:"+request.responseText);
                   Application.setScene(testPage.createObject());
                //}
            }
        }
        
        request.open("GET", getString, true); // only async supported 
        request.send()
    }
    
    
    titleBar: TitleBar {
        title: "Welcome to NicoMe"
        appearance: TitleBarAppearance.Branded
        scrollBehavior: TitleBarScrollBehavior.Sticky

    }
    accessibility.name: "login"

    Container {
        layoutProperties: FlowListLayoutProperties {

        }
        Label {
            text: " "
        }
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
                verticalAlignment: VerticalAlignment.Center
            }
            TextField {
                id: usrname
                input.masking: TextInputMasking.Masked
                maximumLength: 16
                accessibility.name: "TODO: Add property content"
                verticalAlignment: VerticalAlignment.Center
                textFormat: TextFormat.Plain

            }
            Label {
                text: " "
            }
        }
        Divider {
            accessibility.name: "TODO: Add property content"

        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }
            Label {
                text: "     Password:"
                verticalAlignment: VerticalAlignment.Center
            }
            TextField {
                id: usrpasswd
                inputMode: TextFieldInputMode.Password
                input.masking: TextInputMasking.Masked
                maximumLength: 16
                accessibility.name: "TODO: Add property content"
                verticalAlignment: VerticalAlignment.Center
                textFormat: TextFormat.Plain

            }
            Label {
                text: " "
            }

        }
        Label {
            text: " "
        }
        Container {
            layoutProperties: FlowListLayoutProperties {

            }
            horizontalAlignment: HorizontalAlignment.Right

            Label {
                text: "Remember Password"
            }
            ToggleButton {
                accessibility.name: "TODO: Add property content"
                checked: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right

            }
        }

    }

    actions: [
        ActionItem {
            id: loginButton
            title: "Login"
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                getToken();
            }
            imageSource: "asset:///images/login.png"

        }
    ]

    attachedObjects: [
        ComponentDefinition {
            id: mainPage
            source: "main.qml"
        },
        
        ComponentDefinition {
            id: testPage
            source: "testPage.qml"
        }
    ]

}