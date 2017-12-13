import QtQuick 2.8
import QtQuick.Window 2.2
import QtSensors 5.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import QtWebSockets 1.0 
import QtWebChannel 1.0
import VPlayApps 1.0
import VPlayPlugins 1.0

import "qwebchannel.js"  as WebChannel

App{

    id: _mainWnd
    visible: true
    licenseKey: "2295246592E1DC90A8F79AC5C38BC3FED4B97543419BB1E3F73B6799BE66308C1342E93AC3D85279A4F049BEEBC6217C6B56570617E15FA177454DCA65DFF992A12176D7494055F91762C62E20F6BF70685169CA49C90663AD242E70346AB5153CDA66D095A64CD9552DA8F24F6E6AC7357D23490329021B00CAACFAFFA1882F4F430EC1548A2FE131E8CD63EA732410D4D0085988C2845DB9E02382E23F03FAAF7142B91F7330499333921D7F3183173FCC0EE20590CAD6910A96B01214D163B70F037BC941818BE58ACC7AB9FD04C58BF0DB7C0C348154177DD4E697F605194F9EBF4C456A0A756F29846E24B763B58A22270D9A6DBB1BFCE63E6C6BBFFE729FF04F4948A5F1DEB0902F0E6B1394725F392B3BCC6B5C1AC599496C14A92C00D2FF4507E4D114F3931D485134090522D720BEE50570F557BB46E71B4BECDD94"
    readonly property string assetsPath: "../assets/"
    property var cppSpeech

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
    XmlListModel {
      id: _xmlItemModel
      
      query: "/root/item"
      XmlRole { name: "name"; query: "name/string()" }
      XmlRole { name: "front_img_name"; query: "front_img_name/string()" }
      XmlRole { name: "back_img_name"; query: "back_img_name/string()" }
    }

    WebSocket {
        id: socket

        // the following three properties/functions are required to align the QML WebSocket API
        // with the HTML5 WebSocket API.
        property var send: function(arg) {
            sendTextMessage(arg);
        }

        onTextMessageReceived: {
            onmessage({data: message});
        }

        property var onmessage

        active: true
        url: "ws://127.0.0.1:12345"

        onStatusChanged: {
            switch (socket.status) {
            case WebSocket.Error:
                console.log("Error: " + socket.errorString);
                break;
            case WebSocket.Closed:
                console.log("Error: Socket at " + url + " closed.");
                break;
            case WebSocket.Open:
                //open the webchannel with the socket as transport
                new WebChannel.QWebChannel(socket, function(ch) {
                    console.log( url + " opened.");
                    _mainWnd.cppSpeech  = ch.objects.speech
                    _xmlItemModel.xml = ch.objects.speech.itemModel
                    console.log(_xmlItemModel.xml)
                });

                break;
            }
        }
    }

    Rectangle {
//        source: assetsPath + "background.jpg"
        anchors.fill: parent
        color: "lightgrey"
        z: -1
    }
    Button {
        id: _bntConnect
        text: "test"
        width: parent.width
        height: 30
        z:1
        onClicked: {
            console.log("active clicked " + socket.active)
            _mainWnd.cppSpeech.printModel();
            socket.active = !socket.active
        }
        
    }
    ListView {
        id: _listView
        clip: true
        anchors.left: parent.left
        anchors.bottom: _ad.top
        width: parent.width
        height: parent.height  - _ad.height
//        anchors.fill: parent
        spacing: 20
        model: _xmlItemModel
        
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
                    anchors.centerIn: parent
                    width: parent.width * 0.815
                    height: parent.height * 0.815

                    clip: true
                    source: Qt.resolvedUrl(assetsPath + front_img_name)
                    fillMode: Image.PreserveAspectFit
                    Button { text: "click"
                        visible: false
                        anchors.centerIn: parent
                        width: 100
                        height: 100
                        onClicked: {
                            console.log("requesetGet clicked")
                        }
                    }
                    MouseArea {
                        id: _item_mouse_area
                        visible: false
                        anchors.fill: parent
                        Rectangle{
                            anchors.fill: parent
                            visible : false
                            color: "black"
                            opacity: 0.5
                            z: 1
                        }

                        onClicked:{
                            console.log("clicked " + name)
                            _mainWnd.cppSpeech.speak(name)
                        }
                    }

                }
                Text{
                        id: _item_text
                        text: name
                        visible: false
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.margins: 30
                        font.pointSize: 25
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
