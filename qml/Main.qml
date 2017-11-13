import QtQuick 2.8
import QtQuick.Window 2.2
import QtSensors 5.9
import QtQuick.Controls 2.2
import VPlayApps 1.0
import VPlayPlugins 1.0 


App{

    id: _mainWnd
    visible: true
    licenseKey: "F4CE7E95FB0F41685E70FBAAD2E9121A39BB4D925E690B28A487EB4827385C264AA0179F456E20450A369513EFCA62196438091D5C28DB7051CAADBFE15548E1871CC064104993D5DFAABC4124C8E423234821A42DA370C0EBB9F8654C4A02687C9D396AEBA6F04B2E5732444AE61204DDECA7D5EA445BDC8E4FDAA161716423EDD5938793E39CDE5A50E856739618189A37EA478058DD9E1D6C67CFFE44DCD61644C230722F524D490AB771DFB8B255A2BAA8BA194EA7F4246CB5361F074CE820A38AF3A404AC374A1C4ACC13261219B7524EA4846BE22463287B54CDC2E7D1CE8FB57E0BECDD61A3CB2F7B56729BA1FB9F962EAA7CE1325F1C750BC2E22F449F8629CE9D32413952F1163AA734BF782CF2B6F76319F57DF9BC5995F833556E72703559654808C39E8E853C5319961EE36A9CE3D205DA23770D75BCACC833EA"
    readonly property string assetsPath: "../assets/"
    
    AdMobBanner{
        id: _ad
        visible: true
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

    ListModel {
        id: _itemModel
        ListElement {
            name: "사과"
            front_img_name: "apple.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "토마토"
            front_img_name: "tomato.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "파인애플"
            front_img_name: "pineapple.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name:"포도"
            front_img_name: "grape.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "오렌지"
            front_img_name: "orange.jpg"
            back_img_name : "card_back.jpg"
        }
    }
    Rectangle {
//        source: assetsPath + "background.jpg"
        anchors.fill: parent
        color: "lightgrey"
        z: -1
    }
    ListView {
        id: _listView
        clip: true
        anchors.left: parent.left
        anchors.bottom: _ad.top
        width: parent.width
        height: parent.height  - _ad.height
//        anchors.fill: parent
        model: _itemModel
        spacing: 20
        
        delegate: Flickable {
            id: _item_container
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 20
            height: _listView.height * 0.615
            interactive: false

            Rectangle {
                id: _item
                anchors.fill: parent
                color: "white"
                radius: 30

                Image{
                    id: _item_image
                    height: parent.height
                    anchors.centerIn: parent
                    clip: true
                    source: Qt.resolvedUrl(assetsPath + front_img_name)
                    fillMode: Image.PreserveAspectFit
                    Button {
                        text: "click"
                        visible: false
                        anchors.centerIn: parent
                        width: 100
                        height: 100
                        onClicked: {
                            console.log("requesetGet clicked")
                            cppSpeech.requestGet()
                        }
                    }
                    MouseArea {
                        id: _item_mouse_area
                        visible: false
                        anchors.fill: parent
                        onClicked:{
                            console.log("clicked " + name)
                            cppSpeech.speak(name)
                        }
                    }
                    Text{
                        id: _item_text
                        text: name
                        visible: false
                        anchors.bottom: parent.bottom
                        anchors.margins: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pointSize: 30
                    }
                }

                Button {
                    id: _item_close_btn
                    text: "X"
                    width: 30
                    height: 30
                    visible: false
                    anchors.margins: 10
                    anchors.right: parent.right
                    anchors.top: parent.top
                    onClicked: {
                        _item_container.state = "normalized"
                    }
                }
                MouseArea {
                    id: _normalized_mouse_area
                    anchors.fill: parent
                    onClicked: {
                        console.log("maxi")
                        _item_container.state = "maximized"
                    }
                }
                MouseArea {
                    id: _maximized_mouse_area
                    visible: false
                    anchors.fill: parent
                    z: -1
                }
            }

            states: [
                State {
                    name: "maximized"
                    PropertyChanges { target: _item_container; explicit: true; height: _item_container.ListView.view.height }
                    PropertyChanges { target: _item_container; explicit: true; anchors.leftMargin: 0; anchors.rightMargin: 0 }
                    PropertyChanges { target: _item_container; explicit: true; interactive: true }
                    PropertyChanges { target: _item; explicit: true; radius: 0}
                    PropertyChanges { target: _item_mouse_area; explicit: true; visible: true }
                    PropertyChanges { target: _item_text; explicit: true; visible: true }
                    // Move the list so that this item is at the top.
                    PropertyChanges { target: _item_container.ListView.view; explicit: true; contentY: _item_container.y }
                    PropertyChanges { target: _listView; explicit: true; interactive: false }
                    PropertyChanges { target: _normalized_mouse_area ; explicit: true; visible: false }
                    PropertyChanges { target: _maximized_mouse_area ; explicit: true; visible: true }
                    PropertyChanges { target: _item_close_btn; explicit: true; visible: true }
                },
                State {
                    name: "normalized"
                }
            ]

            transitions: Transition {
                ParallelAnimation{
                    NumberAnimation { 
                        target: _item_container
                        properties:"radius,height,anchors.leftMargin,anchors.rightMargin"
                        duration: 500
                        easing.type: Easing.InOutBack
                    }
                    NumberAnimation {
                        target: _item
                        properties:"radius"
                        duration: 500
                        easing.type: Easing.InOutBack
                    }
                    NumberAnimation {
                        target: _item_text
                        properties:"visible"
                        duration: 1000
                    }
                    NumberAnimation {
                        target: _item.ListView.view
                        properties:"contentY"
                        duration: 500
                        easing.type: Easing.InOutBack
                    }
                }
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
}
