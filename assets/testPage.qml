import bb.cascades 1.2

Page {
    id: testPage
    property string userName
    property string userId
    property string secToken

    Container {
        Label {
            text: userId
        }
        Label {
            text: userName
        }
        Label {
            text: secToken
        }
    }
}
