import QtQuick 2.0
import VPlayApps 1.0
import "../helper"

Item {
    id: _root
    property ListModel cardModel
    // use attached property when it use for ListView
    property Component cardItem: Rectangle {
        id: _item
        property var parentListView: _item.ListView.view
        property string name: korean
        property string imgName: Constants.assetsPath + front_img_name
        property bool isCurrentItem : _item.ListView.isCurrentItem

        width: parentListView.width
        height: parentListView.height * 0.65

        color: "white"
        radius: 40
//        border.color: isCurrentItem ? "gray" : "blue"
        border.color: "gray"

        //            Component.onCompleted: {
        //                console.log( Constants.assetsPath +  model.modelData.front_img_name)
        //            }
        Image {
            id: _item_image
            anchors.centerIn: parent
//            width: parent.width * 0.815
//            height: parent.height * 0.815

            clip: true
            source: Qt.resolvedUrl(_item.imgName)
            fillMode: Image.PreserveAspectFit
            Component.onCompleted:  {
                width = parent.width * 0.815
                height = parent.height * 0.815
            }
        }
        Text {
            id: _item_text
            text: _item.name
            visible: false
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 30
            font.pointSize: 25
        }
        IconButton {
            id: _item_close_btn
            visible: false
            icon: IconType.close
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            scale: 2
            onClicked: {
                console.log("normal")
                _item.state = "normalized"
            }
        }
        MouseArea {
            id: _normalized_mouse_area
            anchors.fill: parent
            onClicked: {
                console.log("maxi")
                _item.state = "maximized"
            }
        }
        SwipeArea {
            id: _maximized_mouse_area
            anchors.fill: parent
            visible: false
            onTopbottomSwipe: {
//                console.log(moveRatio)
                if (1 - moveRatio < 0.85) {
                    _item.state = "normalized"
                } else if (1 - moveRatio < 0.95)
                    // do not affect when click input captured
                    _item.scale = 1 - moveRatio
            }
            onBottomtopSwipe: {
//                console.log(moveRatio)
                if (1 - moveRatio < 0.85) {
                    _item.state = "normalized"
                } else if (1 - moveRatio < 0.95)
                    _item.scale = 1 - moveRatio
            }
            onClicked: {
                _cppInterface.speechObj.speak(_item.name)
                console.log("clicked " + _item.name)
            }
            onReleased: {
                _item.scale = 1
            }
        }
        states: [
            State {
                name: "maximized"
                PropertyChanges {
                    target: _item
                    explicit: true
                    height: parentListView.height
                    radius: 0
                    scale: 1
                }
                PropertyChanges {
                    target: _item_text
                    explicit: true
                    visible: true
                }
                // Move the list so that this item is at the top.
                PropertyChanges {
                    target: parentListView
                    explicit: true
                    contentY: _item.y
                    interactive: false
                }
                PropertyChanges {
                    target: _normalized_mouse_area
                    explicit: true
                    visible: false
                }
                PropertyChanges {
                    target: _maximized_mouse_area
                    explicit: true
                    visible: true
                }
                PropertyChanges {
                    target: _item_close_btn
                    explicit: true
                    visible: true
                }
            },
            State {
                name: "normalized"
                PropertyChanges {
                    target: _item
                    explicit: true
                    scale: 1
                }
            }
        ]


        transitions: Transition {
            ParallelAnimation {
                NumberAnimation {
                    target: _item
                    properties: "radius,height,anchors.leftMargin,anchors.rightMargin,scale"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
                //text appeared slowly
                NumberAnimation {
                    target: _item_text
                    properties: "visible"
                    duration: 1000
                }
                NumberAnimation {
                    target: parentListView
                    properties: "contentY"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
            }
        }
    }
}
