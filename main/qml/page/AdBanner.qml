import QtQuick 2.12
import Felgo 3.0
import "../helper"
import Constants 1.0

AdMobBanner{
    id: _root
    visible: true
    adUnitId: Constants.admobBannerAdUnitId
    testDeviceIds: Constants.admobTestDeviceIds
    banner: AdMobBanner.Smart
    Rectangle {
        anchors.fill: parent
        color: "lightgray"
        opacity: 0.5
    }
}
