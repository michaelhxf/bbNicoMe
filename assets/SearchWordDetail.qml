import bb.cascades 1.2

Page {

    //PinYin
    //PronounceJp
    //Tone
    //Word
    //Comment
    //Pronounce
    //TtsUrl

    property string word
    property string comment
    property string pinyin
    property string tone
    property string pronounce
    property string ttsurl
    property string pronouncejp

    onWordChanged: {
        //        titleBar.title = word
        wordLA.text = word
    }

    onPinyinChanged: {
        pinyinLA.visible = true
        pinyinLA.text = pinyin
    }

    onToneChanged: {
        toneLA.visible = true
        toneLA.text = tone
    }

    onPronounceChanged: {
        pronounceLA.visible = true
        pronounceLA.text = pronounce
    }

    onPronouncejpChanged: {
        pronounceJpLA.visible = true
        pronounceJpLA.text = pronouncejp
    }

    onCommentChanged: {
        commentLA.text = comment
    }

    //    onTtsurlChanged: {
    //
    //    }
    ///////
    //    titleBar: TitleBar {
    //
    //    }

    ScrollView {
        Container {
            layout: StackLayout {

            }

            Label {
                id: wordLA
                textStyle.fontSize: FontSize.Large
                textStyle.fontWeight: FontWeight.Bold
                textFormat: TextFormat.Html
            }

            Label {
                visible: false
                id: pronounceJpLA
                textFormat: TextFormat.Html
            }

            Label {
                visible: false
                id: pronounceLA
                textFormat: TextFormat.Html
            }

            Label {
                visible: false
                id: pinyinLA
                textFormat: TextFormat.Html
            }

            Label {
                visible: false
                id: toneLA
                textFormat: TextFormat.Html
            }

            //            Button {
            //                visible: false
            //                id: ttsurlBTN
            //            }

            Label {
                id: commentLA
                textFormat: TextFormat.Html
                multiline: true

            }

            Divider {
                minHeight: 100
            }

        }
    }

}
