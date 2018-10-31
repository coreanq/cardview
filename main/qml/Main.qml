import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import VPlayApps 1.0

App{
    id: _main
    visible: true
    licenseKey: "6577159175B1ABEF378D1A677808B8B8E034A940CAADCF9EBAD57B5ECF602EE5337F62CD8732736716ECD594301EB6FC1277718B88D84D6DE3ABFB25F0C08DE9CC6B9A6D7B4B6A16BF3FCE1B1A86EB619E2F3DB0CDCB229A682DE73108DFBC2F4F16747470EB2594CE4116B8CAE65353A2933424C72190AF77000E1C0161B6315CCCE2B2D51C10E1DABBE7BE00AD2A005B4115A2BB374FA02FD072E504E1A731C5796F37FDEA34BB16C501FA240C545F0BA1D9E2C36B5074A724159671AB509CB8AAFD08BC6EE67E1D115A5EF3CE381C2D1A76726C32CDC90759E9C96ABC3A55AD21580853E14721E866E9EB885A431DB696FA4A07479883F4671EDADACF1A7785FC4BF294FF5965DE8C2E6D55DA411AC33CAE8AC004AD44858CEE0BCAF41324F33D7FA91F1C7B4C98AB3466D57DC3C492FD62F0A728F268BE782217C20FB059"

    FruitModel {
        id: _xmlItemModel
        xml: _cppInterface.fruitModel
    }

    CppInterface {
        id: _cppInterface
        Component.onCompleted: {
            console.log("_cppInterface create!" )
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
    }
    
    
    
  
    Navigation {
        id: _naviWnd
        visible: true
        y: Theme.statusBarHeight
        
         NavigationItem {
           id: widgetsItem
           title: "Main"
         
           icon: IconType.calculator
           Loader {
                sourceComponent: _fruitPage
           }
         }
    
         NavigationItem {
           title: "Simple List"
           icon: IconType.list
    
           NavigationStack { //this tab/navigation item uses stack-based sub-navigation
             splitView: tablet
             Page { }
           }
         }
    
   }
    Button {
        id: _bntConnect
        text: "test"
        width: parent.width
        visible: false
        height: 30
        z:1
        onClicked: {
            _cppInterface.speechObj.printModel();
        }
        
    }
    // 가로 보기시 status bar 제거 
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
