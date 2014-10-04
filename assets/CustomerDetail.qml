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
    
    property string memoId
    property int customerId
    property NavigationPane navigate
    
    
    //////
    
    onDetailNameChanged: {
        customerNameTF.text = detailName
    }
    
    onDetailCompanyChanged: {
        customerCompanyTF.text = detailCompany
    }
    
    onDetailCTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailCTime))
        ctimeLA.text = Qt.formatDateTime(_date,"ddd yyyy.MM.dd hh:mmAP")
    }
    
    onDetailMTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailMTime))
        mtimeLA.text = Qt.formatDateTime(_date,"ddd yyyy.MM.dd hh:mmAP")
    }
    
    onDetailDescriptionChanged: {
        descriptionTF.text = detailDescription
    }
    
    onDetailEmailChanged: {
        emailTF.text = detailEmail
    }
    
    onDetailFaxChanged: {
        faxTF.text = detailFax
    }
    
    onDetailLocationChanged: {
        locationTF.text = detailLocation
    }
    
    onDetailPhoneChanged: {
        phoneTF.text = detailPhone
    }
    

    ////////////

    titleBar: TitleBar {
        title: qsTr("Customer Detail")
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("Update")
            ActionBar.placement: ActionBarPlacement.OnBar

            attachedObjects: [
                DataSource {
                    id: insertSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "UPDATE customer"
                    //fixme

                    onDataLoaded: {
                        alertToast.body = "update success."
                        alertToast.show()
                        navigate.needRefresh=true
                    }
                },
                SystemToast {
                    id: alertToast
                    button.enabled: false
                },
                
                ComponentDefinition {
                    id: teamList
                    source: "TeamList.qml"
                }
            ]

            onTriggered: {
                insertSource.load();
            }
            imageSource: "asset:///images/box.png"
        },
        ActionItem {
            id: teamListAction
            title: qsTr("Team")
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                var addPage = teamList.createObject()
                addPage.navigate = navigate
                addPage.customerId = customerId
                navigate.push(addPage)
            }
            imageSource: "asset:///images/1412395077_config-users.png"
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
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Location")
                    textStyle.textAlign: TextAlign.Right
                    minWidth: 200
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }
                
                TextField {
                    id: locationTF
                    
                    onTextChanged: {
                        detailLocation = text
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
                    text: qsTr("Create Time:")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                Label {
                    id: ctimeLA
                }
            
            } //line end
            
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Modify Time:")
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 180
                    textStyle.textAlign: TextAlign.Right
                }
                Label {
                    id: mtimeLA
                }
            
            } //line end
        }
    }

}
