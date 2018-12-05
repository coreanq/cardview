import QtQuick 2.0
import VPlayPlugins 1.0
import "../helper"
import Constants 1.0

AdMobBanner{
    id: _root
    visible: true
    adUnitId: Constants.admobBannerAdUnitId
    testDeviceIds: Constants.admobTestDeviceIds
    banner: AdMobBanner.Smart
    anchors.horizontalCenter: parent.horizontalCenter
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
        opacity: 0.5
    }
}
