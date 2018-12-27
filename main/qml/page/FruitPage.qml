import QtQuick 2.11
import QtQml.StateMachine 1.0 as DSM
import "../helper"

ListView {
    id: _root
    anchors.fill: parent
    signal startAutomatedScroll()
    signal endAutomatedScroll()
    signal automatedScrollEnded()
    signal itemSizeChanged(bool isMaximized)

    spacing: 20

    DSM.StateMachine {
        id: _automatedScrollDSM
        initialState: _standby
        running: true
        DSM.State{
            id: _standby
            DSM.SignalTransition {
                targetState: _running
                signal : startAutomatedScroll
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
                signal : automatedScrollEnded

            }
            DSM.SignalTransition {
                targetState: _standby
                signal : endAutomatedScroll

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
                    _cppInterface.speak(currentItem.name)
                }
            }
            DSM.State{
                id: _normalized

                DSM.TimeoutTransition {
                    targetState: _currentIndexing
                    timeout: 1000
                }
                onEntered: {
                    var previousIndex = currentIndex
//                    console.log("normalized")
                    currentItem.state = "normalized"
                    incrementCurrentIndex()
                    if( previousIndex == currentIndex ) {
                        _root.automatedScrollEnded()
                    }
                }
            }
        }
    }

    delegate: Card{}
}
