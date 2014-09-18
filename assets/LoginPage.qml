import bb.cascades 1.2
import bb.system 1.2
NavigationPane {
    id: rootNav
    backButtonsVisible: false

    Page {

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
                    text: "test"

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
                    text: "test"
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
                    login();
                }
                imageSource: "asset:///images/login.png"

            }
        ]

        attachedObjects: [
            MainPage {
                id: mainPage
            }
        ]

    }
    
    
    function login() {
        var request = new XMLHttpRequest()
        request.onreadystatechange = function() {
            if (request.readyState == 4) {
                var response = request.responseText
                var jsontxt = JSON.parse(response)
                //var addressComponents = response.results[0].address_components
                //for (var i = 0; i < addressComponents.length; i ++) {
                //    var option = optionControlDefinition.createObject();
                //    option.text = addressComponents[i].long_name
                //    dropDown.add(option)
                //}
                
                console.log("debug:" + request.responseText);
                var token = jsontxt.data.token;
                var uid = jsontxt.data.uid;
                
                if (jsontxt.err_code == 0) {
                    //console.log("token:"+token);
                    // console.log("uid:"+uid);
                    mainPage.setUserToken(uid, token);
                    //rootNav.push(mainPage);
                    Application.setScene(mainPage);
                }
            }
        }
        
        // I have used goole's web service url, you can replace with your url
        request.open("GET", "https://nico-michaelhxf.rhcloud.com/api/loguser/get_token/name=" + usrname.text + "&password=" + usrpasswd.text, true)
        request.send()
    }
}