import QtQuick 2.0
import VPlayApps 1.0
import "../helper"

Item {
    id: _root
    property ListModel voiceLanguageViewModel
    property ListModel voiceTypeViewModel
    property real audioPitch : _pitchSlider.position
    property real audioRate : _rateSlider.position

    NavigationStack {
        splitView: tablet
        initialPage: mainPage
    }
//    onAudioRateChanged: {
//        console.log("## "  + audioRate)
//    }
//    onAudioPitchChanged: {
//        console.log("## "  + audioPitch)
//    }

    property Component mainPage: ListPage {
        title: "설정"
        model: [{
                "text": "언어",
                "icon": IconType.language,
                "group": "음성"
            }, {
                "text": "타입",
                "icon": IconType.thlarge,
                "group": "음성"
            }, {
                "text": "특성",
                "icon": IconType.language,
                "group": "음성"
            }]

        section.property: "group"
        onItemSelected: {
            if (index === 0)
                navigationStack.popAllExceptFirstAndPush(audioLanguagePage)
            else if (index === 1)
                navigationStack.popAllExceptFirstAndPush(audioTypePage)
            else if (index === 2)
                navigationStack.popAllExceptFirstAndPush(audioSpecificPage)
        }
    }

    property Component audioLanguagePage: ListPage {
        title: "Audio language"

        model: voiceLanguageViewModel
        delegate: SimpleRow {
            id: row
            // cannot access model.modelData.language so fix to direct access
            property var currentModel: voiceLanguageViewModel.get(index)
            text: currentModel.language
            style.showDisclosure: false // disble right arrow in ios
            Icon {
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.verticalCenter: parent.verticalCenter
                icon: IconType.check
                size: dp(14)
                visible: currentModel.selected
            }
            onSelected: {
                // do not modify cpp models data
                // should do in cpp code
                console.log("Clicked Item #" + index + " " + JSON.stringify(
                                currentModel))
                _cppInterface.speechObj.languageSelected(index)
            }
        }
        onModelChanged: {

        }
    }

    property Component audioTypePage: ListPage {
        title: "Audio type"
        model: voiceTypeViewModel
        delegate: SimpleRow {
            // cannot access model.modelData.name so fix to direct access
            property var currentModel: voiceTypeViewModel.get(index)
            text: currentModel.name
            style.showDisclosure: false // disble right arrow in ios
            Icon {
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.verticalCenter: parent.verticalCenter
                icon: IconType.check
                size: dp(14)
                visible: currentModel.selected
            }
            onSelected: {
                // do not modify cpp models data
                // should do in cpp code
                console.log("Clicked Item #" + index + JSON.stringify(
                                currentModel))
                _cppInterface.speechObj.voiceSelected(index)
            }
        }
    }
    // do not confuse Qtquick's Page and V-play Page
    property Component audioSpecificPage: Page {
        title: "Audio specific"
        Column{

            anchors.horizontalCenter: parent.horizontalCenter
            Column {
                // show slider
                AppSlider {
                    id: _rateSlider
                    onPositionChanged: {
                        console.log(position)
                        _cppInterface.speechObj.setRate(Math.round(_rateSlider.position * 20) - 10)
                    }
                    from: 0
                    to: 100
                }

                // display slider position
                AppText {
                    anchors.horizontalCenter:  parent.horizontalCenter
                    text: "Rate: " + (Math.round(_rateSlider.position * 20) - 10) + "%"

                }
            } // column
            Column {
                // show slider
                AppSlider {
                    id: _pitchSlider
                    onPositionChanged: {
                        console.log(position)
                        _cppInterface.speechObj.setPitch(Math.round(_pitchSlider.position * 20) - 10)
                    }
                }

                // display slider position
                AppText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Pitch: " + (Math.round(_pitchSlider.position * 20)- 10) + "%"
                }
            } // Column
        }
        Component.onCompleted: {
            console.log("audio specific " + _cppInterface.speechObj.voiceRate +  " " + (_cppInterface.speechObj.voicePitch + 10) / 20)
            _rateSlider.value = (_cppInterface.speechObj.voiceRate + 10) / 20
            _pitchSlider.value = (_cppInterface.speechObj.voicePitch + 10) / 20

        }
    }

}
