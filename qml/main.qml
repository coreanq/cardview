import QtQuick 2.8
import QtQuick.Window 2.2
import QtSensors 5.9
import QtQuick.Controls 2.2
import user.Speech 1.0

Window{
    id: mainWnd
    width: 500
    height: 500
    visible: true
    Speech{
    	id: speech
    
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
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width /2
        height: parent.height
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
                    console.log("clicked " + front_img_path)
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
    	anchors.top: parent.top
    	anchors.left: _listView.right
    	width: parent.width /2
    	height: parent.height
    	
//    	model : ["banana", "apple", "coconut"]
    	model: Speech.languageModel 
			delegate: Rectangle {
			height: 25
			width: 100
			color: "black"
			Text { text: modelData }
		}
		Component.onCompleted: {
			console.log( Speech.languageModel)	
		}
    }

}

