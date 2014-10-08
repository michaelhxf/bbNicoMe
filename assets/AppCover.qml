import bb.cascades 1.2

Container {
    Container {        
        layout: DockLayout {}
        background: Color.Black
        
        //ImageView {
           // imageSource: "asset:///images/application-cover.png"
           //scalingMethod: ScalingMethod.AspectFit
      // }
        
        Container {
            bottomPadding: 31
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            
            Container {
                preferredWidth: 330
                preferredHeight: 30
                background: Color.create("#121212")
                layout: DockLayout {}
                
                Label {
                    objectName: "TheLabel"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "Nicolas Han"
                    textStyle.color: Color.create("#ebebeb")
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                    layoutProperties: StackLayoutProperties {

                    }
                }
            }
        }
    }
}