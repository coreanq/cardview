import QtQuick 2.0
import QtQuick.Controls 2.2
import VPlayApps 1.0

ListView {
    id: _root
    spacing: 20
    signal fruitClicked(string fruitName)
    property string assetsPath : ""
    
    delegate: Flickable {
        id: _item_container
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: _root.height * 0.615
        interactive: false

        Rectangle {
            id: _item
            property string name: korean
            anchors.fill: parent
            color: "white"
            radius: 30
            Component.onCompleted: {
                console.log("path " + assetsPath)
            }

            Image{
                id: _item_image
                anchors.centerIn: parent
                width: parent.width * 0.815
                height: parent.height * 0.815

                clip: true
                source: Qt.resolvedUrl(assetsPath + front_img_name)
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
                MouseArea {
                    id: _item_mouse_area
                    visible: false
                    anchors.fill: parent
                    Rectangle{
                        anchors.fill: parent
                        visible : false
                        color: "black"
                        opacity: 0.5
                        z: 1
                    }

                    onClicked:{
                        _root.fruitClicked(_item.name);
                        console.log("clicked " + _item.name);
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
            Button {
                id: _item_close_btn
                text: "X"
                width: 30
                height: 30
                visible: false
                anchors.margins: 10
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
            MouseArea {
                id: _maximized_mouse_area
                visible: false
                anchors.fill: parent
                z: -1
            }
        }

        states: [
            State {
                name: "maximized"
                PropertyChanges { target: _item_container; explicit: true; height: _item_container.ListView.view.height }
                PropertyChanges { target: _item_container; explicit: true; anchors.leftMargin: 0; anchors.rightMargin: 0 }
                PropertyChanges { target: _item_container; explicit: true; interactive: true }
                PropertyChanges { target: _item; explicit: true; radius: 0}
                PropertyChanges { target: _item_mouse_area; explicit: true; visible: true }
                PropertyChanges { target: _item_text; explicit: true; visible: true }
                // Move the list so that this item is at the top.
                PropertyChanges { target: _item_container.ListView.view; explicit: true; contentY: _item_container.y }
                PropertyChanges { target: _root; explicit: true; interactive: false }
                PropertyChanges { target: _normalized_mouse_area ; explicit: true; visible: false }
                PropertyChanges { target: _maximized_mouse_area ; explicit: true; visible: true }
                PropertyChanges { target: _item_close_btn; explicit: true; visible: true }
            },
            State {
                name: "normalized"
            }
        ]

        transitions: Transition {
            ParallelAnimation{
                NumberAnimation { 
                    target: _item_container
                    properties:"radius,height,anchors.leftMargin,anchors.rightMargin"
                    duration: 500
                    easing.type: Easing.InOutBack
                }
                NumberAnimation {
                    target: _item
                    properties:"radius"
                    duration: 500
                    easing.type: Easing.InOutBack
                }
                NumberAnimation {
                    target: _item_text
                    properties:"visible"
                    duration: 1000
                }
                NumberAnimation {
                    target: _item.ListView.view
                    properties:"contentY"
                    duration: 500
                    easing.type: Easing.InOutBack
                }
            }
        }
    }
    
}
