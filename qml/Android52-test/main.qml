import QtQuick 2.0
import QtGraphicalEffects 1.0
import "components"

Rectangle {
    id: root

    property int pictureVerticalMargin: 100

    width: 540
    height: 960

    Flickable{ //Flickable element for the background image
        id: flickableImage
        width: root.width; height: root.height
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        interactive: false

        contentWidth: image.width; contentHeight: image.height

        Image{ //Background image
            id: image
            height: root.height+pictureVerticalMargin // use device's hegiht as reference
            width: sourceSize.width*height/sourceSize.height//Keep aspect ratio based on height
            source: "qrc:/backgrounds/img1"
            fillMode: Image.PreserveAspectCrop
        }

        FastBlur { //Fast blur effect to perform while flicking
            id: blurEffect
            anchors.fill: image
            source: image
            radius: 0
        }

        Connections{
            target: flickableContent
            onYPositionChanged:{ //We want to apply the effect as the image reaches its bottom limit
                if (flickableContent.yPosition>=pictureVerticalMargin)
                    blurEffect.radius=32
                else{
                    flickableImage.contentY=flickableContent.yPosition
                    blurEffect.radius=flickableContent.yPosition*32/pictureVerticalMargin
                }
            }
        }

    }

    Flickable {//Flickable element for the content
        id:flickableContent
        property alias yPosition: flickableContent.contentY

        width: root.width; height: root.height
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        contentWidth: root.width; contentHeight: root.height*2

        Column{ //We define two places for content. Each one has the same size as the screen
            anchors.fill: parent
            Item{ //First place for the title aligned bottom
                id:placeHolder1
                height: root.height
                width: parent.width
                Text {
                    text: qsTr("Hello World. Flick me up!")
                    font.pixelSize: 60
                    color: "white"
                    width: parent.width-40
                    wrapMode: Text.WordWrap
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            Item{ //Second place for the main content
                id:placeHolder2
                height: root.height
                width: parent.width

                TextBox{
                    id: summary
                    width: parent.width-40
                    anchors.top: parent.top
                    text: qsTr("I'm supposed to be something similar to Yahoo Weather, but I'm a dummy app with no content so... Let's include a lorem ipsum!")
                }

                TextBox{
                    id: lorem
                    anchors.top: summary.bottom
                    width: parent.width-40
                    text: qsTr("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                }

            }
        }

    }
}
