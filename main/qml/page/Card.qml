import QtQuick 2.0
import VPlayApps 1.0
import "../helper"

Item {
    id: _root
    signal maxFruitClicked(string fruitName)


    // use attached property when it use for ListView
    property Component cardItem: Flickable {
        property var parentListView : _item_container.ListView.view
        id: _item_container

        width: parentListView.width
        height: parentListView.height * 0.65

        interactive: false

        Rectangle {
            id: _item
            property string name: model.modelData.korean
            property string imgName: Constants.assetsPath + model.modelData.front_img_name
            anchors.fill: parent
            color: "white"
            radius: 30
            border.color: "gray"
//            Component.onCompleted: {
//                console.log( Constants.assetsPath +  model.modelData.front_img_name)
//            }

            Image {
                id: _item_image
                anchors.centerIn: parent
                width: parent.width * 0.815
                height: parent.height * 0.815

                clip: true
                source: Qt.resolvedUrl( _item.imgName )
                fillMode: Image.PreserveAspectFit
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
            SwipeArea {
                id: _maximized_mouse_area
                anchors.fill: parent
                visible: false
                z: -1
                onTopbottomSwipe: {
                                        console.log(moveRatio)
                    if (1 - moveRatio < 0.8) {
                        _item_container.state = "normalized"
                    } else if (1 - moveRatio < 0.95)
                        // do not affect when click input captured
                        _item.scale = 1 - moveRatio
                }
                onBottomtopSwipe: {
                                        console.log(moveRatio)
                    if (1 - moveRatio < 0.8) {
                        _item_container.state = "normalized"
                    } else if (1 - moveRatio < 0.95)
                        _item.scale = 1 - moveRatio
                }
                onClicked: {
                    _root.maxFruitClicked(_item.name)
                    console.log("clicked " + _item.name)
                }
                onReleased: {
                    _item.scale = 1
                }
            }
        }

        states: [
            State {
                name: "maximized"
                PropertyChanges {
                    target: _item_container
                    explicit: true
                    height: _item_container.ListView.view.height
                }
                PropertyChanges {
                    target: _item_container
                    explicit: true
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }
//                PropertyChanges {
//                    target: _item_container
//                    explicit: true
//                    interactive: true
//                }
                PropertyChanges {
                    target: _item
                    explicit: true
                    radius: 0
                }
                PropertyChanges {
                    target: _item_text
                    explicit: true
                    visible: true
                }
                // Move the list so that this item is at the top.
                PropertyChanges {
                    target:parentListView
                    explicit: true
                    contentY: _item_container.y
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
                PropertyChanges {
                    target: _item
                    explicit: true
                    scale: 1
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
                    target: _item_container
                    properties: "radius,height,anchors.leftMargin,anchors.rightMargin,scale"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
                NumberAnimation {
                    target: _item
                    properties: "scale"
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
