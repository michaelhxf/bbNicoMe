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

TabbedPane {
    id: mainPage
    property string userName
    property string userId
    property string secToken
    
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            title: "Settings"
            onTriggered: {
                console.log("settings click");
            }
        }
        helpAction: HelpActionItem {
            title: "Help"
            onTriggered: {
                
            }
        }
    }
    //showTabsOnActionBar: true
    Tab { 
        title: qsTr("Personal Page") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/id-128.png"
        PersonalPage {
            id:personalPage
        }
        
    } 
    Tab { 
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
        title: qsTr("Memo") + Retranslate.onLocaleOrLanguageChanged
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
}
