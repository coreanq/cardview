import QtQuick 2.11
import QtQml.StateMachine 1.0 as DSM
import VPlayApps 1.0
import "../helper"

AppListView {
    id: _root
    anchors.fill: parent
    signal triggerAutomatedScroll()

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

    Card { id: _card  }
    delegate: _card.cardItem
}
