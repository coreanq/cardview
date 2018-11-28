import QtQuick 2.8
import QtQml.StateMachine 1.0 as DSM
import VPlayApps 1.0
import "helper"
import "page"
import "helper/JSONListModel"

App {
    id: _main
    visible: true
    licenseKey: Constants.vplaylicenseKey

    CppInterface {
        id: _cppInterface
        Component.onCompleted: {
            console.log("_cppInterface create!")
        }
    }

    JSONListModel {
        id: _voiceTypeModel
        json: _cppInterface.voiceTypeList
        query: ""
        onJsonChanged: {
            console.log(json)
        }
    }
    JSONListModel {
        id: _voiceLanguageModel
        json: _cppInterface.voiceLanguageList
        query: ""
        onJsonChanged: {
            console.log(json)
        }
    }
    property Component fruitPage: FruitPage {
        model: JSON.parse(_cppInterface.speechObj.fruitList)
        onMaxFruitClicked: {
            _cppInterface.speechObj.speak(fruitName)
        }
    }

    AdBanner {
        id: _adBanner
        anchors.bottom: parent.bottom
    }
    Page {
        id: _naviWndContainer
        visible: true
        anchors.bottom: _adBanner.top
        clip: true
        Navigation {
            id: _naviWnd
            navigationMode: navigationModeDrawer
            NavigationItem {
                title: "과일"
                icon: IconType.heart

                Loader {
                    sourceComponent: fruitPage
                }
            }
            NavigationItem {
                title: "설정"
                icon: IconType.cog

                SettingView {
                    anchors.fill: parent
                    voiceLanguageViewModel: _voiceLanguageModel.model
                    voiceTypeViewModel: _voiceTypeModel.model
                }
            }
        }
    }
    FloatingActionButton {
        id: _btnDrawer
        icon: IconType.wrench
        visible: true
        anchors.bottom: _naviWndContainer.bottom
        onClicked: {
            _naviWnd.drawer.toggle()
        }
        Rectangle {
            anchors.fill: parent
            visible: false
            color: "black"
            opacity: 0.5
        }
    }

    // auto mated list scrolling
    FloatingActionButton {
        property bool running: false
        id: _btnAuto
        icon: IconType.font
        visible: true
        anchors.bottom: _btnDrawer.top
        onClicked: {
            if (running == false) {
                console.log("automated on")
                fruitPage.triggerAutomatedScroll()
                running = true
                icon = IconType.close
            } else {
                console.log("automated off")
                fruitPage.triggerAutomatedScroll()
                running = false
                icon = IconType.font
            }
        }
    }
    // 가로 보기시
    onPortraitChanged: {
        console.log("Portrait changed " + portrait)
    }


    Timer {
        id: _cppInterfaceReconnectTimer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if (_cppInterface.active == false) {
                _cppInterface.active = true
                console.log("try to reconnect")
            } else {
                running = false
            }
        }
    }



    onApplicationPaused: {
        console.log("paused")
        _cppInterface.active = false
    }
    onApplicationResumed: {
        console.log("resumed")
        if (_cppInterface.active == false) {
            console.log("reconnect timer on")
            _cppInterfaceReconnectTimer.running = true
        }
    }

    //        Flipable {
    //            // Image 의 source 는 url type 이 필요 하므로
    //            property bool flipped: true
    //            Component.onCompleted: {
    //            }

    //            id: _cardWnd
    //            width: _listView.width
    //            height: _listView.height / 3

    //            front: Rectangle {
    //                anchors.fill: parent
    //                anchors.margins: 10
    //                color: "black"
    //                Image{
    //                    anchors.fill: parent
    //                    source: Qt.resolvedUrl(assetsPath + front_img_name)
    //                    fillMode: Image.PreserveAspectFit
    //                }
    //            }
    //            back: Rectangle {
    //                anchors.fill: parent
    //                anchors.margins: 10
    //                color: "black"
    //                Image {
    //                    anchors.fill: parent
    //                    source: Qt.resolvedUrl(assetsPath + back_img_name)
    //                    Text {
    //                        anchors.centerIn: parent
    //                        text: name
    //                        font.pointSize: parent.width /10
    //                    }
    //                }
    //            }

    //            MouseArea {
    //                anchors.fill: parent
    //                onClicked:{
    //                    console.log("clicked " + name)
    //                    cppInterface.speak(name)
    //                }
    //                onDoubleClicked: {
    //                    console.log("double clicked " + front_img_name)
    //                    _cardWnd.flipped = !_cardWnd.flipped
    //                }

    //            }

    //            transform: Rotation {
    //                id: _rotationProcessing
    //                origin.x: _cardWnd.width/2
    //                origin.y: _cardWnd.height/2
    //                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
    //                angle: 0    // the default angle
    //            }

    //            states: [
    //                State {
    //                    name: "back"
    //                    when: _cardWnd.flipped
    //                    PropertyChanges {
    //                      target: _rotationProcessing; angle: 180
    //                    }
    //                },
    //                State {
    //                    name: "front"
    //                    when: !_cardWnd.flipped
    //                    PropertyChanges {
    //                      target: _rotationProcessing; angle: 0
    //                    }
    //                }
    //            ]

    //            transitions: Transition {
    //                NumberAnimation { target: _rotationProcessing; property: "angle"; duration: 800 }
    //            }
    //        }

    //    }

    //    ListView{
    //    	anchors.bottom: _ad.top
    //    	anchors.left: _listView.right
    //    	width: parent.width /2
    //    	height: parent.height - _ad.height
    //        clip: true

    ////    	model : ["banana", "apple", "coconut"]
    //        model: cppInterface.languageModel
    //        delegate: Rectangle {
    //            height: 25
    //            width: parent.width
    //            Row {
    //                Text {
    //                    text: first
    //                    font.pointSize: 15
    //                }
    //            }
    //        }
    //        Component.onCompleted: {
    ////            console.log( cppInterface.str() )
    //        }
    //    }
}
