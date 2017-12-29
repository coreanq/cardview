import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import VPlayApps 1.0

App{
    id: _main
    visible: true
    licenseKey: "2295246592E1DC90A8F79AC5C38BC3FED4B97543419BB1E3F73B6799BE66308C1342E93AC3D85279A4F049BEEBC6217C6B56570617E15FA177454DCA65DFF992A12176D7494055F91762C62E20F6BF70685169CA49C90663AD242E70346AB5153CDA66D095A64CD9552DA8F24F6E6AC7357D23490329021B00CAACFAFFA1882F4F430EC1548A2FE131E8CD63EA732410D4D0085988C2845DB9E02382E23F03FAAF7142B91F7330499333921D7F3183173FCC0EE20590CAD6910A96B01214D163B70F037BC941818BE58ACC7AB9FD04C58BF0DB7C0C348154177DD4E697F605194F9EBF4C456A0A756F29846E24B763B58A22270D9A6DBB1BFCE63E6C6BBFFE729FF04F4948A5F1DEB0902F0E6B1394725F392B3BCC6B5C1AC599496C14A92C00D2FF4507E4D114F3931D485134090522D720BEE50570F557BB46E71B4BECDD94"

    Component{
        id: _cppInterface
        CppInterface { 
            onConnected: {
                _xmlItemModel.xml = Qt.binding(function() { return cppInterface.fruitModel } )
            }
        }
    }
    
    Component {
        id: _fruitPage 
        FruitPage {
            model: _xmlItemModel
            onFruitClicked: {
                _cppInterface.speechObj.speak(fruitName);
            }
        }
    }
    
    Component {
        id: _adBanner
        AdBanner {} 
    }
    
    Component {
        id: _xmlItemModel
        FruitModel {} 
    }
    
    Loader { sourceComponent: _adBanner }
    Loader { sourceComponent: _xmlItemModel }
    Loader { sourceComponent: _cppInterface }
    
    
  
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
    
         NavigationItem {
           title: "Dialogs"
           icon: IconType.square
    
           Page { }
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
