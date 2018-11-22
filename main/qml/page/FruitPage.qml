import QtQuick 2.0
import QtQuick.Controls 2.2
import VPlayApps 1.0
import "../helper"

ListView {
    id: _root
    spacing: 20
    signal fruitClicked(string fruitName)

    delegate: Flickable {
        id: _item_container
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        height: _root.height * 0.615
        interactive: false

        Rectangle {
            id: _item
            property string name: model.modelData.korean
            anchors.fill: parent
            color: "white"
            radius: 30
            border.color: "gray"

            Image{
                id: _item_image
                anchors.centerIn: parent
                width: parent.width * 0.815
                height: parent.height * 0.815

                clip: true
                source: Qt.resolvedUrl(Constants.assetsPath + model.modelData.front_img_name)
                fillMode: Image.PreserveAspectFit

                AppButton { 
                    text: "click"
                    visible: false
                    anchors.centerIn: parent
                    width: 100
                    height: 100
                    onClicked: {
                        console.log("requesetGet clicked")
                    }
                }
            }
            Text{
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
//                    console.log(moveRatio)
                    if( 1 - moveRatio < 0.8 ){
                        _item_container.state = "normalized"
                    }
                    else
                        _item.scale = 1 - moveRatio
                }
                onBottomtopSwipe: {
//                    console.log(moveRatio)
                    if( 1 - moveRatio < 0.8 ){
                        _item_container.state = "normalized"
                    }
                    else
                        _item.scale = 1 - moveRatio
                }
                onClicked:{
                        _root.fruitClicked(_item.name);
                        console.log("clicked " + _item.name);
                }
                onReleased: {
                        _item.scale = 1

                }
            }
        }

        states: [
            State {
                name: "maximized"
                PropertyChanges { target: _item_container; explicit: true; height: _item_container.ListView.view.height }
                PropertyChanges { target: _item_container; explicit: true; anchors.leftMargin: 0; anchors.rightMargin: 0 }
                PropertyChanges { target: _item_container; explicit: true; interactive: true }
                PropertyChanges { target: _item; explicit: true; radius: 0}
                PropertyChanges { target: _item_text; explicit: true; visible: true }
                // Move the list so that this item is at the top.
                PropertyChanges { target: _item_container.ListView.view; explicit: true; contentY: _item_container.y }
                PropertyChanges { target: _root; explicit: true; interactive: false }
                PropertyChanges { target: _normalized_mouse_area ; explicit: true; visible: false }
                PropertyChanges { target: _maximized_mouse_area ; explicit: true; visible: true }
                PropertyChanges { target: _item_close_btn; explicit: true; visible: true }
                PropertyChanges { target: _item; explicit: true; scale: 1 }
            },
            State {
                name: "normalized"
                PropertyChanges { target: _item; explicit: true; scale: 1 }
            }
        ]

        transitions: Transition {
            ParallelAnimation{
                NumberAnimation { 
                    target: _item_container
                    properties:"radius,height,anchors.leftMargin,anchors.rightMargin,scale"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
                NumberAnimation {
                    target: _item
                    properties:"scale"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
                //text appeared slowly
                NumberAnimation {
                    target: _item_text
                    properties:"visible"
                    duration: 1000
                }
                NumberAnimation {
                    target: _item.ListView.view
                    properties:"contentY"
                    duration: 500
                    easing.type: Easing.OutQuart

                }
            }
        }
    }
    
}
