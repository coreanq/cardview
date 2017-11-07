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
    Image {
        source: assetsPath + "background.jpg"
        anchors.fill: parent
        clip: false
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
        delegate: Rectangle {
            property bool maximized : false
            id: _item
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            height: (_listView.height - _ad.height) * 0.615
            color: "white"
        
            radius: 30
            onMaximizedChanged: {
            }

            Image{
                anchors.fill: parent
                source: Qt.resolvedUrl(assetsPath + front_img_name)
                fillMode: Image.PreserveAspectFit
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    _item.maximized = !_item.maximized
//                    _listView.currentIndex = _listView.indexAt(mouseX, mouseY)

                }
            }
            states: [
                State {
                    name: "maximized"
                    when: _item.maximized
                    PropertyChanges {
                        target: _item
                        height: _mainWnd.height - _ad.height
                        radius: 0 
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                    }
                    PropertyChanges {
                        target: _listView
                        interactive: false
                    }
                },
                State {
                    name: "nomalized"
                    when: !_itemWnd.maximized
                    PropertyChanges {
                        target: _item
                        height: undefined 
                        radius: undefined 
                        anchors.leftMargin: undefined 
                        anchors.rightMargin: undefined
                    }
                    PropertyChanges {
                        target: _item.ListView.view
                        interactive: undefined
                    }
                    // Move the list so that this item is at the top.
                    PropertyChanges { target: _item.ListView.view; explicit: true; contentY: _item.y }
                }
            ]

            transitions: Transition {
                NumberAnimation { target: _item; property: "x,contentY,radius,width,height"; duration: 500; easing.type: Easing.OutQuad  }
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

    }

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
