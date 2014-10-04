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

Page {
    
    property NavigationPane navigate

    ListView {
        id: listview
        dataModel: customerDataModel

        listItemComponents: ListItemComponent {
            type: "item"
            StandardListItem {
                title: ListItemData.name
                description: ListItemData.company
            }
        }

        onTriggered: {
            //if (indexPath.length > 1) {
            var chosenItem = dataModel.data(indexPath);
            var detailPage = customerDetail.createObject()

            detailPage.detailName = chosenItem.name
            detailPage.detailCompany = chosenItem.company
            detailPage.detailLocation = chosenItem.location
            detailPage.detailDescription = chosenItem.description
            detailPage.detailPhone = chosenItem.phone
            detailPage.detailFax = chosenItem.fax
            detailPage.detailEmail = chosenItem.email
            detailPage.detailCTime = chosenItem.ctime
            detailPage.detailMTime = chosenItem.mtime

            detailPage.memoId = chosenItem.memoid
            detailPage.customerId = chosenItem.id
            detailPage.navigate = navigate

            navigate.push(detailPage)
            // }
        }

    }

    attachedObjects: [
        GroupDataModel {
            id: customerDataModel
            sortingKeys: [ "mtime", "ctime" ]
            sortedAscending: false
            grouping: ItemGrouping.None
        },

        DataSource {
            id: customerDataSource
            type: DataSourceType.Sql
            remote: false
            source: "file://" + nicomeApp.getDatabasePath()
            query: "select * from customer"

            onDataLoaded: {
                customerDataModel.clear()
                customerDataModel.insertList(data)
            }
        },

        ComponentDefinition {
            id: customerDetail
            source: "CustomerDetail.qml"
        },

        ComponentDefinition {
            id: customerAdd
            source: "CustomerAdd.qml"
        }

    ]

    actions: [
        ActionItem {
            id: addCustomerAction
            title: qsTr("New Customer")
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                var addPage = customerAdd.createObject()
                addPage.navigate = navigate
                navigate.push(addPage)
            }
            imageSource: "asset:///images/add.png"
            shortcuts: [
                Shortcut {
                    key: "a"
                    onTriggered: {
                        var addPage = customerAdd.createObject()
                        addPage.navigate = navigate
                        navigate.push(addPage)
                    }
                }
            ]
        },
        ActionItem {
            id: refreshAction
            title: qsTr("Refresh")
            ActionBar.placement: ActionBarPlacement.InOverflow

            onTriggered: {
                customerDataSource.load()
            }
            imageSource: "asset:///images/refresh.png"

            shortcuts: [
                Shortcut {
                    key: "r"
                    onTriggered: {
                        customerDataSource.load()
                    }
                }
            ]
        }
    ]

    titleBar: TitleBar {
        scrollBehavior: TitleBarScrollBehavior.Sticky
        title: qsTr("Customer")

    }

    onCreationCompleted: {
        customerDataSource.load()
    }

}
