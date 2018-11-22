import QtQuick 2.0
import VPlayApps 1.0
import "../helper"

Item {
    id: _root
    property ListModel voiceLanguageViewModel
    property ListModel voiceTypeViewModel

      NavigationStack {
        splitView: tablet
        initialPage: mainPage
      }

      property Component mainPage: ListPage {
            title: "Settings"
            model: [
              { text: "Language", icon: IconType.language, group: "Audio" },
              { text: "Type", icon: IconType.thlarge, group: "Audio" }
            ]

            section.property: "group"
            onItemSelected: {
                if( index === 0 )
                    navigationStack.popAllExceptFirstAndPush(audioLanguagePage)
                else if ( index === 1)
                    navigationStack.popAllExceptFirstAndPush(audioTypePage)
            }
      }


      property Component audioLanguagePage: ListPage {
            title: "Audio language"

            model: voiceLanguageViewModel
            delegate: SimpleRow{
                id: row
                // cannot access model.modelData.language so fix to direct access
                property var currentModel : voiceLanguageViewModel.get(index)
                text: currentModel.language
                style.showDisclosure: false   // disble right arrow in ios
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
                    console.log("Clicked Item #" + index +  " " + JSON.stringify(currentModel))
                    _cppInterface.speechObj.languageSelected(index)
                }
            }
            onModelChanged: {
            }
      }

      property Component audioTypePage: ListPage {
            title: "Audio type"
            model: voiceTypeViewModel
            delegate: SimpleRow{
                // cannot access model.modelData.name so fix to direct access
                property var currentModel : voiceTypeViewModel.get(index)
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
                    console.log("Clicked Item #" + index + JSON.stringify(currentModel) ) ;
                    _cppInterface.speechObj.voiceSelected(index)
                }

            }
      }

}
