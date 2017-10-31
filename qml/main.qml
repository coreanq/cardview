import QtQuick 2.8
import QtQuick.Window 2.2
import QtSensors 5.9
import QtQuick.Controls 2.2
import VPlayApps 1.0
import VPlayPlugins 1.0 


App{
    id: mainWnd
    width: 500
    height: 500
    visible: true
    licenseKey: "A6CD1FE2AE4B0FEDC0D829AF725D27976DFA256DE94F0951572F7611CF7D84CFE607D3B2766CB378A15D49057F2A450BDBF97841140BF0A56D53C1DB6D7FE4056019E5259A9C646A1564BB87BF6D1D3ACBD831FBA7142C4C2C17C1E55C1FE41276E6C4855C3D24F1DDC9EEC72342B3858A7C009562629656AA37483521032499BCBA3B3B830A9AB8F87AB09A820BE81D740B7834B84767113797346FE4AD499665C067736FBE508841A430F8EBFD762205FC3BB48E45354772C847057C682FACAD454F494F43AD9EC205115BBA0B14AFB850FBE150753BC5041DE5211766D85DA6969B7A3B6E5ACEF8C8918D5D7E462869F2983387171BED01D11FF0D32B5723959B46D513302C87BFC680489D672886790B544E5FDC7DC98253359B9E5DC310C6D0D3267B8741CC85EE0C1FBA17F3F44463A3948FD1BF3821EFCAEEE11DBC13"
    
    AdMobBanner{
        id: _ad
        adUnitId: "ca-app-pub-1343411537040925~3583043750"
        anchors.top : parent.top
        width: parent.width
        height: 100
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
            img_name: "apple"
            back_file_name : "qrc/image/card_back.jpg"
        }
        ListElement {
       		name: "토마토" 
            img_name: "tomato"
            back_file_name : "qrc/image/card_back.jpg"
        }
        ListElement {
         	name: "파인애플"	
            img_name: "pineapple"
            back_file_name : "qrc/image/card_back.jpg"
        }
        ListElement {
        	name:"포도"
            img_name: "grape"
            back_file_name : "qrc/image/card_back.jpg"
        }
        ListElement {
        	name: "오렌지"
            img_name: "orange"
            back_file_name : "qrc/image/card_back.jpg"
        }
    }
    Image {
        source: "../image/background.jpg"
        anchors.fill: parent; clip: false
        z: -1
    }
    ListView {
        id: _listView
        clip: true
        anchors.left: parent.left
        anchors.top: _ad.bottom
        width: parent.width /2
        height: parent.height  - _ad.height
//        anchors.fill: parent
        model: _itemModel

        delegate: Flipable {
            property string front_img_path: img_name + ".jpg" 
            property bool flipped: true

            id: _cardWnd
            width: _listView.width
            height: _listView.height / 3


            front: Rectangle {
            	anchors.fill: parent
            	anchors.margins: 10
            	color: "black"
            	Image{
            	    anchors.fill: parent
            	    source: "qrc:/image/" + front_img_path
            	    fillMode: Image.PreserveAspectFit
				}
            }
            back: Rectangle {
            	anchors.fill: parent
            	anchors.margins: 10
            	color: "black"
				Image {
					anchors.fill: parent
					source: "qrc:/image/card_back.jpg"
					Text {
						anchors.centerIn: parent
						text: name
						font.pointSize: parent.width /10 
					}
				}
            } 

            MouseArea {
                anchors.fill: parent
                onClicked:{ 
                    console.log("clicked " + name)
                    cppInterface.speak(name)
                }
                onDoubleClicked: {
                    console.log("double clicked " + front_img_path)
					_cardWnd.flipped = !_cardWnd.flipped 
                }
                
            }

            transform: Rotation {
                id: _rotationProcessing
                origin.x: _cardWnd.width/2
                origin.y: _cardWnd.height/2
                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: [
                State {
                    name: "back"
                    when: _cardWnd.flipped
                    PropertyChanges { 
                      target: _rotationProcessing; angle: 180 
                    }
                },
                State {
                    name: "front"
                    when: !_cardWnd.flipped
                    PropertyChanges { 
                      target: _rotationProcessing; angle: 0 
          
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation { target: _rotationProcessing; property: "angle"; duration: 800 }
            }
        }

    }

    ListView{
    	anchors.top: _ad.bottom
    	anchors.left: _listView.right
    	width: parent.width /2
    	height: parent.height - _ad.height
        clip: true
    	
//    	model : ["banana", "apple", "coconut"]
        model: cppInterface.languageModel
        delegate: Rectangle {
			height: 25
			width: parent.width
            Row {
                Text { 
                    text: first 
                    font.pointSize: 15
                }
            }
		}
		Component.onCompleted: {
//			console.log( cppInterface.str() )	
		}
    }

}

