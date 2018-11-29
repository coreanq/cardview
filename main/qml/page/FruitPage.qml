import QtQuick 2.11
import QtQml.StateMachine 1.0 as DSM
import VPlayApps 1.0
import "../helper"

AppListView {
    id: _root
    anchors.fill: parent
    signal triggerAutomatedScroll()

    highlightMoveVelocity: 20
    flickDeceleration: 50
    spacing: 30
//    Component {
//         id: highlight
//         Rectangle {
//             width: currentItem.width; height: currentItem.height
//             color: "lightsteelblue"; radius: 40
//             y: currentItem.y
//             Behavior on y {
//                 SpringAnimation {
//                     spring: 3
//                     damping: 0.2
//                 }
//             }
//         }
//     }

//    highlight: highlight
//     highlightFollowsCurrentItem: false
    Behavior on contentY {
                 SpringAnimation {
                     spring: 3
                     damping: 0.2
                 }
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
                currentItem.state = "normalized"
                currentIndex = 0;
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
                currentItem.state = "normalized"
            }

            DSM.State{
                id: _currentIndexing

                DSM.TimeoutTransition {
                    targetState: _maxmized
                    timeout: 1000
                }

                onEntered: {
//                    console.log("currentIndexing")
                    positionViewAtIndex(currentIndex, ListView.Center)
                }
                onExited: {

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
                   currentItem.state = "maximized"
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
                    _cppInterface.speechObj.speak(currentItem.name)
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
                    currentItem.state = "normalized"
                    incrementCurrentIndex()
                }
            }
        }
    }

    Card { id: _card  }
    delegate: _card.cardItem
}
