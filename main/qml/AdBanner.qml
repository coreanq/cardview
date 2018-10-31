import QtQuick 2.0
import VPlayPlugins 1.0

AdMobBanner{
    id: _root
    visible: true
    adUnitId: "ca-app-pub-1343411537040925/6004482526"
    testDeviceIds: [""]
    banner: AdMobBanner.Smart
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom : parent.bottom
//    anchors.top: parent.top
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.5
    }
}
