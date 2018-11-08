import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import VPlayApps 1.0

App{
    id: _main
    visible: true
    licenseKey: Constants.vplaylicenseKey

    FruitModel {
        id: _xmlItemModel

    }

    CppInterface {
        id: _cppInterface
        Component.onCompleted: {
            console.log("_cppInterface create!" )
        }
        onElementAdded: {
            console.log("hello" + element)
            _xmlItemModel.append(element)
        }
    }

    Component {
        id: _fruitPage
        FruitPage {
            model: _xmlItemModel
            assetsPath: _cppInterface.assetsPath
            onFruitClicked: {
                _cppInterface.speechObj.speak(fruitName);
            }
            Component.onCompleted: {
                console.log("_fruitPage create! path: " + assetsPath)
            }
        }
    }

    AdBanner {
        id: _adBanner
        z: 100
        height: 50
    }
    Page {
        id: _naviWnd
        anchors.bottom: _adBanner.top
        clip: true
        visible: true
        Navigation {
             z: -1
             id: navigation
             navigationMode: navigationModeDrawer
             Component.onCompleted: {
                 //drawer width change
                 navigation.drawer.width = navigation.width * 0.4
             }

             NavigationItem {
               title: "과일"
               icon: IconType.heart
                Loader {
                    sourceComponent: _fruitPage
                    anchors.fill: parent
                }
             }
             NavigationItem {
               title: "설정"
               icon: IconType.cog

               Rectangle{
                   anchors.fill: parent
                   color: "black"
                   opacity: 0.5
               }
             }
        }
    }
    FloatingActionButton {
        id: _bntConnect
        icon: IconType.terminal
        visible: true
        z:1
        onClicked: {
            console.log("test clicked");
            _cppInterface.speechObj.printModel();
        }
        
    }
    // 가로 보기시 status bar 제거 필요
    onPortraitChanged: {
        console.log("Portrait changed" )
        if( _main.potrait )
            ThemeColors.statusBarStyle = ThemeColors.statusBarStyleHidden
        else 
            ThemeColors.statusBarStyle =  ThemeColors.statusBarStyleBlack
        
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
