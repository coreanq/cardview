import QtQuick 2.0
import VPlayPlugins 1.0

AdMobBanner{
    id: _ad
    visible: false
//    appId: "ca-app-pub-1343411537040925~3583043750"
    adUnitId: "ca-app-pub-1343411537040925/9502612510"
    testDeviceIds: ["cf47d897bcd4218b7995db4268ed3083e0d5de1b"]
    anchors.bottom : parent.bottom
    width: parent.width
    height: 30
    banner: AdMobBanner.Smart
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.5
    }
}
