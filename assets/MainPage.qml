/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb.data 1.0

TabbedPane {
    id: tabPanel
    property string userId

    function closeLogin() {
        console.log("data:"+loginDataModel.size());
        //userId = uid;
        loginSheet.close();
        tabPanel.activeTab = personalTab;
        tabPanel.remove(maskTab);

    }

    ///////////////////////////////login function
    //    function login() {
    //        //disable it, will not touch again
    //        loginButton.enabled = false
    //
    //        var request = new XMLHttpRequest()
    //        request.onreadystatechange = function() {
    //            if (request.readyState == 4) {
    //                var response = request.responseText
    //                var jsontxt = JSON.parse(response)
    //
    //                console.log("debug:" + request.responseText);
    //                var token = jsontxt.data.token;
    //                var uid = jsontxt.data.uid;
    //
    //                if (jsontxt.err_code == 0) {
    //                    //console.log("token:"+token);
    //                    //console.log("uid:"+uid);
    //                    loginSheet.close();
    //                    setUserToken(uid, token);
    //                }
    //            } else {
    //                //make it happend
    //                loginButton.enabled = true
    //            }
    //        }
    //
    //        request.open("GET", "http://nico-michaelhxf.rhcloud.com/api/loguser/get_token/name=" + usrname.text + "&password=" + usrpasswd.text, true)
    //        request.send()
    //    }

    function loginAction() {
        loginDataSource.load()
    }

    attachedObjects: [
        DataSource {
            id: loginDataSource
            source: "asset:///data/nicome.db"
            query: "select id from loguser where name='"+usrname.text+"' and password='"+usrpasswd.text+"'";
            remote: false
            type: DataSourceType.Sql
            
            onDataLoaded: {            
                if (data.length > 0) {
                    loginDataModel.clear();
                    loginDataModel.insertList(data);
                    closeLogin()
                }
            }

        },
        GroupDataModel {
            id: loginDataModel
            sortingKeys: ["id"]
            sortedAscending: false
            grouping: ItemGrouping.None
        },
        
        //login sheet
        Sheet {
            id: loginSheet
            content: Page {
                titleBar: TitleBar {
                    title: "NicoMe"
                    scrollBehavior: TitleBarScrollBehavior.NonSticky
                    appearance: TitleBarAppearance.Branded

                }

                actions: [
                    ActionItem {
                        id: loginButton
                        title: "Sign In"
                        ActionBar.placement: ActionBarPlacement.OnBar
                        onTriggered: {
                            loginAction();
                        }

                    }
                ]

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
                        verticalAlignment: VerticalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight

                        }
                        horizontalAlignment: HorizontalAlignment.Right
                        Label {
                            text: qsTr("Auto")
                            verticalAlignment: VerticalAlignment.Center
                        }
                        ToggleButton {
                            accessibility.name: "TODO: Add property content"
                            checked: true
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Right

                        }
                    }
                }
            }
        },

        //////////////////////////help sheet
        Sheet {
            id: helpSheet
            content: Page {
                titleBar: TitleBar {
                    title: "Help"
                }

                Container {
                    Button {
                        text: "close"
                        onClicked: {
                            helpSheet.close();
                        }
                    }
                }
            }
        },

        /////////////////////////settings
        Sheet {
            id: settingSheet
            content: Page {
                titleBar: TitleBar {
                    title: "Setting"
                }

                Container {
                    Button {
                        text: "close"
                        onClicked: {
                            settingSheet.close();
                        }
                    }
                }
            }
        }
    ]

    onCreationCompleted: {
        console.log("============show login");
        loginSheet.open();
    }

    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            title: "Settings"
            onTriggered: {
                settingSheet.open();
                console.log("settings click");
            }
        }
        helpAction: HelpActionItem {
            title: "Help"
            onTriggered: {
                helpSheet.open();
            }
        }
    }

    //////////////////////////////////tabs
    //showTabsOnActionBar: true
    Tab {
        id: maskTab
    }
    Tab {
        id: personalTab
        title: qsTr("Personal Page") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/id-128.png"
        PersonalPage {
            id: personalPage

        }

    }
    Tab {
        id: learningTab
        title: qsTr("Learning") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/laboratory-128.png"
        LearningPage {
            id: learningPage
        }
    }
    Tab {
        title: qsTr("Attendance") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/wristwatch-128.png"
        NavigationPane {
            id: nav
            Page {
                Container {
                    ListView {
                        dataModel: XmlDataModel {
                            source: "data.xml"
                        }
                        onTriggered: {

                            if (indexPath.length > 1) {
                                var chosenItem = dataModel.data(indexPath);
                                var contentpage = itemPageDefinition.createObject();

                                contentpage.itemPageTitle = chosenItem.name
                                nav.push(contentpage);
                            }
                        }
                        accessibility.name: "Listing"
                    }
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: itemPageDefinition
                        source: "ItemPage.qml"
                    }
                ]
            }
        }
    }
    Tab {
        id: memoTab
        title: qsTr("Memo")
        imageSource: "asset:///images/notepad_pencil-128.png"
        MemoPage {
            id: memoPage
        }
    }
    Tab {
        title: qsTr("Todo") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/clipboard-128.png"
        Page {
            Container {
                Label {
                    text: qsTr("Todo") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    }
    Tab {
        title: qsTr("Project") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/graph-128.png"
        Page {
            Container {
                Label {
                    text: qsTr("Proejct") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    } //End of second tab
    Tab { //Second tab
        title: qsTr("Favorite") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/trophy-128.png"
        Page {
            Container {
                Label {
                    text: qsTr("Favorite") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    } //End of second tab
    Tab { //Second tab
        title: qsTr("SysInfo") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/speed-128.png"
        Page {
            Container {
                Label {
                    text: qsTr("System Information") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    } //End of second tab
    Tab { //Second tab
        title: qsTr("Management") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/direction-128.png"
        Page {
            Container {
                Label {
                    text: qsTr("Management") + Retranslate.onLocaleOrLanguageChanged
                }
            }
        }
    } //End of second tab

    onActivePaneChanged: {
        if (tabPanel.activeTab == learningTab) {
            console.log("##change to learning tab:" + tabPanel.secToken)
            learningPage.loadData(tabPanel.userId, tabPanel.secToken);
        } else if (tabPanel.activeTab == memoTab) {
            console.log("##change to memo tab:" + tabPanel.secToken)
            memoPage.loadData(tabPanel.userId, tabPanel.secToken);
        }
    }

}
