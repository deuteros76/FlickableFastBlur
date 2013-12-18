import QtQuick 2.0

Item {
    id: root
    property real maxBoxOpacity: 0.2
    property int boxContentMargin: 15
    property int contentVerticalSpacing: 40
    property alias text: txtContent.text

    height: txtContent.height+boxContentMargin
    anchors.topMargin: contentVerticalSpacing
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle{
        color: "black"
        opacity: maxBoxOpacity
        anchors.centerIn: txtContent
        width: txtContent.width+boxContentMargin
        height: txtContent.height+boxContentMargin
    }

    Text {
        id: txtContent
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 24
        color: "white"
        wrapMode: Text.WordWrap
        opacity:1
    }
}
