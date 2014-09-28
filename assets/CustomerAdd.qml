import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    ///properties

    property string detailName
    property string detailCompany
    property string detailLocation
    property string detailDescription
    property string detailPhone
    property string detailFax
    property string detailEmail
    property string detailCTime
    property string detailMTime
    
    property int memoId
    property int customerId
    property NavigationPane navigate

    ////////////

    titleBar: TitleBar {
        title: qsTr("New Customer")
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("Save")
            ActionBar.placement: ActionBarPlacement.OnBar

            attachedObjects: [
                DataSource {
                    id: insertSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "insert into attendance (subject, content, memotypeid, taglist, ctime) values ('" + detailSubject + "', '" + detailContent + "', " + detailType + " , '" + detailTagList + "' , "+ Date.now() +")"

                    onDataLoaded: {
                        alertToast.body = "New Customer record created."
                        alertToast.show()
                        navigate.needRefresh=true
                        navigate.pop()
                    }
                },
                SystemToast {
                    id: alertToast
                    button.enabled: false
                }
            ]

            onTriggered: {
                insertSource.load();
            }
            imageSource: "asset:///images/box.png"
        }
    ]

    onCreationCompleted: {
        
    }

    ScrollView {
        scrollViewProperties.scrollMode: ScrollMode.Vertical

        Container {
            layout: StackLayout {

            }
            background: Color.create("#ffdddddd")
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Name")
                    textStyle.textAlign: TextAlign.Right
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 200
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }

                TextField {
                    id: customerNameTF
                    onTextChanged: {
                        detailName = text
                    }
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Company")
                    textStyle.textAlign: TextAlign.Right
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 200
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }
                
                TextField {
                    id: customerCompanyTF
                    
                    onTextChanged: {
                        detailCompany = text
                    }
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Description")
                    textStyle.fontWeight: FontWeight.Bold
                    textStyle.textAlign: TextAlign.Right
                    minWidth: 200
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }
                
                TextField {
                    id: descriptionTF
                    
                    onTextChanged: {
                        detailDescription=text
                    }
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Phone")
                    textStyle.textAlign: TextAlign.Right
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 200
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }
                
                TextField {
                    id: phoneTF
                    
                    onTextChanged: {
                        detailPhone=text
                    }
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("FAX")
                    minWidth: 200
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Right
                }
                TextField {
                    id: faxTF
                    
                    onTextChanged: {
                        detailFax = text
                    }
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("EMail")
                    minWidth: 200
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Right
                }
                TextField {
                    id: emailTF
                    
                    onTextChanged: {
                        detailEmail = text
                    }
                }
            
            } //line end
            


            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Memo")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: memoDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: memoOption
                            Option {

                            }
                        },
                        DataSource {
                            id:  memoSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select id,name from memo"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = memoOption.createObject();
                                    option.text = data[i].subject
                                    option.value = data[i].id
                                    memoDD.add(option)
                                }

                                if (memoDD.count() > 0) {
                                    memoDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        memoId = selectedOption.value
                    }
                }
                onCreationCompleted: {
                    memoSource.load()
                }

            } //line end

        }
    }

}
