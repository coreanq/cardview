import QtQuick 2.11
import QtQml.StateMachine 1.0 as DSM
import VPlayApps 1.0
import "../helper"

AppListView {
    id: _root
    spacing: 20
    signal maxFruitClicked(string fruitName)
    signal normalFruitClicked()

    signal triggerAutomatedScroll()

    function start() {
       triggerAutomatedScroll()
    }

    DSM.StateMachine {
        id: _automatedScrollDSM
        initialState: _standby
        running: true
        DSM.State{
            id: _standby
            DSM.SignalTransition {
                targetState: _running
                signal : triggerAutomatedScroll
            }

            onEntered: {
                console.log("standby")
            }
            onExited: {
                _item_container.state = "normalized"
            }
        }
        DSM.State {
            id: _running
            initialState: _currentIndexing
            DSM.SignalTransition {
                targetState: _standby
                signal : triggerAutomatedScroll

            }
            onExited: {
                console.log("_running exiting")
                _item_container.state = "normalized"

            }

            DSM.State{
                id: _currentIndexing

                DSM.TimeoutTransition {
                    targetState: _maxmized
                    timeout: 1000
                }

                onEntered: {
//                    console.log("currentIndexing")
                    incrementCurrentIndex()
                    positionViewAtIndex(currentIndex, ListView.Center)
                }
            }
            DSM.State{
                id: _maxmized

                DSM.TimeoutTransition {
                    targetState: _speaking
                    timeout: 1000
                }

                onEntered: {
//                    console.log("maxmized")
                   _item_container.state = "maximized"
                }
            }
            DSM.State{
                id: _speaking

                DSM.TimeoutTransition {
                    targetState: _normalized
                    timeout: 2000
                }

                onEntered: {
                    console.log("speaking " )
                    maxFruitClicked(_item.name)
                }
            }
            DSM.State{
                id: _normalized

                DSM.TimeoutTransition {
                    targetState: _currentIndexing
                    timeout: 1000
                }
                onEntered: {
//                    console.log("normalized")
                    _item_container.state = "normalized"
                }
            }
        }
    }

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

            Image {
                id: _item_image
                anchors.centerIn: parent
                width: parent.width * 0.815
                height: parent.height * 0.815

                clip: true
                source: Qt.resolvedUrl(
                            Constants.assetsPath + model.modelData.front_img_name)
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
                    //                    console.log(moveRatio)
                    if (1 - moveRatio < 0.8) {
                        _item_container.state = "normalized"
                    } else if (1 - moveRatio < 0.95)
                        // do not affect when click input captured
                        _item.scale = 1 - moveRatio
                }
                onBottomtopSwipe: {
                    //                    console.log(moveRatio)
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
                PropertyChanges {
                    target: _item_container
                    explicit: true
                    interactive: true
                }
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
                    target: _item_container.ListView.view
                    explicit: true
                    contentY: _item_container.y
                }
                PropertyChanges {
                    target: _root
                    explicit: true
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
                    target: _item.ListView.view
                    properties: "contentY"
                    duration: 500
                    easing.type: Easing.OutQuart
                }
            }
        }

    }
}
