import bb.cascades 1.2
import bb.data 1.0

Container {

    Container {
        layout: StackLayout {

        }
        background: Color.Black

        //ImageView {
        // imageSource: "asset:///images/application-cover.png"
        //scalingMethod: ScalingMethod.AspectFit
        // }

        Container {
            bottomPadding: 31
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom

            layout: StackLayout {

            }
            Container {
                preferredWidth: 330
                preferredHeight: 30
                background: Color.create("#121212")
                layout: DockLayout {
                }

                Label {
                    objectName: "TheLabel"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "NicoMe for BB"
                    textStyle.color: Color.create("#ebebeb")
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                    layoutProperties: StackLayoutProperties {

                    }
                }
            }
        }

        
    }
    
    Container {
        Label {
            id: langCount
            text: "Word:"
            layoutProperties: StackLayoutProperties {
            
            }
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    
    }


    attachedObjects: [
        DataSource {
            id: countSource
            remote: false
            source: "file://" + nicomeApp.getDatabasePath() //"asset:///nicome.s3db" //nicomeApp.getValueFor("dbFilePath", undefined)
            type: DataSourceType.Sql
            query: "SELECT count() as langcount from (select id from learning)"
            
            onDataLoaded: {
                langCount.text = "Word:" + data[0].langcount
            }
        }
    ]

    onCreationCompleted: {
        Application.thumbnail.connect(onThumbnail)
    }
    
    function onThumbnail() {
        countSource.load()
    }
}