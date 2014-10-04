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
    property int monthid
    property int attendanceId
    property NavigationPane navigate

    ////////////
    onDetailRecordDateChanged: {
        var _date = new Date()
        _date.setTime(detailRecordDate)
        recordDatePicker.value = _date
    }

    onDetailStartTimeChanged: {
        var _date = new Date()
        _date.setTime(detailStartTime)
        startTimePicker.value = _date
    }

    onDetailEndTimeChanged: {
        var _date = new Date()
        _date.setTime(detailEndTime)
        endTimePicker.value = _date
    }

    onDetailRestTimeChanged: {
        var _date = new Date()
        _date.setTime(detailRestTime)
        restTimePicker.value = _date
    }

    onWorktypeidChanged: {
        worktypeSource.load()
    }

    onWeektypeidChanged: {
        weektypeSource.load()
    }

    onCustomeridChanged: {
        customerSource.load()
    }

    onTeamidChanged: {
        teamSource.load()
    }

    onDetailCTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailCTime))
        ctimeLA.text = Qt.formatDateTime(_date, "ddd yyyy-MM-dd  hh:mmAP")
    }

    onDetailMTimeChanged: {
        var _date = new Date()
        _date.setTime(Number(detailMTime))
        mtimeLA.text = Qt.formatDateTime(_date, "ddd yyyy-MM-dd  hh:mmAP")
    }

    onDetailDescriptionChanged: {
        descriptionTA.text = detailDescription
    }

    //    onDetailTaskChanged: {
    //
    //    }

    titleBar: TitleBar {
        title: qsTr("Attendance Detail")
    }

    actions: [
        ActionItem {
            id: saveAction
            title: qsTr("Update")
            ActionBar.placement: ActionBarPlacement.OnBar

            attachedObjects: [
                DataSource {
                    id: updateSource
                    type: DataSourceType.Sql
                    remote: false
                    source: "file://" + nicomeApp.getDatabasePath()
                    query: "UPDATE attendance SET recorddate=" + detailRecordDate + ", starttime=" + detailStartTime + " , endtime=" + detailEndTime + " , resttime=" + detailRestTime + " , description='" + detailDescription + "' , weektypeid=" + weektypeid + " , worktypeid=" + worktypeid + " , customerid=" + customerid + " , monthid=" + monthid + ", ctime=" + Date.now() + "  WHERE id=" + attendanceId

                    onDataLoaded: {
                        alertToast.body = "Update success."
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
                updateSource.load();
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
                    minWidth: 200
                    textStyle.textAlign: TextAlign.Right

                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                }

                DateTimePicker {
                    id: recordDatePicker
                    mode: DateTimePickerMode.Date
                    onValueChanged: {
                        detailRecordDate = value.valueOf()
                    }

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
                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: startTimePicker
                    onValueChanged: {
                        detailStartTime = value.valueOf()
                    }
                    mode: DateTimePickerMode.Time

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

                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: endTimePicker
                    onValueChanged: {
                        detailEndTime = value.valueOf()
                    }
                    mode: DateTimePickerMode.Time

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

                    verticalAlignment: VerticalAlignment.Center
                }
                DateTimePicker {
                    id: restTimePicker
                    onValueChanged: {
                        detailRestTime = value.valueOf()
                    }
                    mode: DateTimePickerMode.Time

                }

            } //line end

            //line
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Work")
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

                                    if (data[i].id == worktypeid) {
                                        worktypeDD.selectedOption = option
                                    }
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

                                    if (data[i].id == weektypeid) {
                                        weektypeDD.selectedOption = option
                                    }
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

                                    if (data[i].id == customerid) {
                                        customerDD.selectedOption = option
                                    }
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

                                    if (data[i].id == teamid) {
                                        teamDD.selectedOption = option
                                    }
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
