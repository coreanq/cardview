import QtQuick 2.0
import VPlayPlugins 1.0

AdMobBanner{
    id: _root
    visible: true
    adUnitId: Constants.admobBannerAdUnitId
    testDeviceIds: Constants.admobTestDeviceIds
    banner: AdMobBanner.Smart
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.5
    }
}
