import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    id: addPage
    ///properties

    property string detailRecordDate
    property string detailStartTime
    property string detailEndTime
    property string detailRestTime
    property string detailTask
    property string detailDescription
    property string detailCTime
    property string detailMTime

    property int teamid
    property int customerid
    property int weektypeid
    property int worktypeid
    property int attendanceId
    property NavigationPane navigate

    ////////////

    titleBar: TitleBar {
        title: qsTr("New Attendance")
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
                    query: "insert into attendance (subject, content, memotypeid, taglist, ctime) values ('" + detailSubject + "', '" + detailContent + "', " + detailType + " , '" + detailTagList + "' , " + Date.now() + ")"

                    onDataLoaded: {
                        alertToast.body = "New Attendance record created."
                        alertToast.show()
                        navigate.needRefresh = true
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
                    text: qsTr("Date")
                    textStyle.fontWeight: FontWeight.Bold
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }

                DateTimePicker {
                    id: recordDatePicker
                    mode: DateTimePickerMode.Date
                    onValueChanged: {
                        detailRecordDate = value
                    }

                }
                Button {
                    preferredWidth: 20
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Start Time")
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: startTimePicker
                    onValueChanged: {
                        detailStartTime = value
                    }
                    mode: DateTimePickerMode.Time

                }
                Button {
                    preferredWidth: 20
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("End Time")
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: endTimePicker
                    onValueChanged: {
                        detailEndTime = value
                    }
                    mode: DateTimePickerMode.Time

                }
                Button {
                    preferredWidth: 20
                }

            } //line end
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Rest Time")
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: restTimePicker
                    onValueChanged: {
                        detailRestTime = value
                    }
                    mode: DateTimePickerMode.Time

                }
                Button {
                    preferredWidth: 20
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Work")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: worktypeDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: worktypeOption
                            Option {

                            }
                        },
                        DataSource {
                            id: worktypeSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select id,title from worktype"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = worktypeOption.createObject();
                                    option.text = data[i].title
                                    option.value = data[i].id
                                    worktypeDD.add(option)
                                }

                                if (worktypeDD.count() > 0) {
                                    worktypeDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        worktypeid = selectedOption.value
                    }
                }

                onCreationCompleted: {
                    worktypeSource.load()
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Week")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: weektypeDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: weektypeOption
                            Option {

                            }
                        },
                        DataSource {
                            id: weektypeSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select id,title from weektype"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = weektypeOption.createObject();
                                    option.text = data[i].title
                                    option.value = data[i].id
                                    weektypeDD.add(option)
                                }

                                if (weektypeDD.count() > 0) {
                                    weektypeDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        weektypeid = selectedOption.value
                    }
                }

                onCreationCompleted: {
                    weektypeSource.load()
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Customer")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: customerDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: customerOption
                            Option {

                            }
                        },
                        DataSource {
                            id: customerSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select id,name from customer"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = customerOption.createObject();
                                    option.text = data[i].name
                                    option.value = data[i].id
                                    customerDD.add(option)
                                }

                                if (customerDD.count() > 0) {
                                    customerDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        customerid = selectedOption.value
                    }
                }
                onCreationCompleted: {
                    customerSource.load()
                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Team")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                }

                DropDown {
                    id: teamDD

                    attachedObjects: [
                        ComponentDefinition {
                            id: teamOption
                            Option {

                            }
                        },
                        DataSource {
                            id: teamSource
                            source: "file://" + nicomeApp.getDatabasePath()
                            query: "select id,name from team"
                            remote: false
                            type: DataSourceType.Sql

                            onDataLoaded: {
                                for (var i = 0; i < data.length; i ++) {
                                    var option = teamOption.createObject();
                                    option.text = data[i].name
                                    option.value = data[i].id
                                    teamDD.add(option)
                                }

                                if (teamDD.count() > 0) {
                                    teamDD.selectedIndex = 0;
                                }
                            }
                        }
                    ]

                    onSelectedOptionChanged: {
                        teamid = selectedOption.value
                    }
                }

                onCreationCompleted: {
                    teamSource.load()
                }

            } //line end
            Divider {

            }
            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: qsTr("Description")
                    textStyle.fontWeight: FontWeight.Bold
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Right
                }
                TextArea {
                    id: descriptionTA
                    minHeight: 240
                    onTextChanged: {
                        detailDescription = text
                    }
                }

            } //line end
        }
    }

}
