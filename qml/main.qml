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
    licenseKey: "214C5BDA3E3807F4D183CFC06E84345ABA224FA131F7E1959B67120E64F3926005938BBBB9E95C7815F6EAF2E550BBB0756D81F5466876002FADCFCB6AF8EE75AC99759D1812AD83BD24EF5629381C601FA14B7D9E371F56DE97A15493FF26A0A23A36A4D985A1478EFE48D9ABC5AA2E7AE37CB8056E1E1CF45557B8F957BEF6CB4A3AB4BAEA75DC797E54CFCDF6707E9002CB60D99204294519381AD33995CFBFC8CED96ADA917B7ACCE0E483793A301DE7B08B2B0B0B5F9E140DBDFC993F4E58343A8F1C48E0661C58028983C0A6B6A2637A59BF58057C96B46A51AAA4FED1D9B6B23040E679EA6E7CDA4A6BE44AF996EF85CABFEDC924B857EE600F7148FA98A9656BF573ABF47E5BE7A0882245754B8FD508A44F986383FEB7184A13B76C99EB76E2C647B34C3C8E094C8BF0154441D8CA002B64A4556FE56EF1CF72E9C1"
    
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

