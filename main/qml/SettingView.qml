import QtQuick 2.0
import VPlayApps 1.0

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
                console.log("Clicked Item #" + index + ": "+ JSON.stringify(item));
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
                text: language
                style.showDisclosure: false   // disble right arrow in ios
            }
            onItemSelected: {
                console.log("Clicked Item #" + index + ": "+ JSON.stringify(item));
            }
      }

      property Component audioTypePage: ListPage {
            title: "Audio type"
            model: voiceTypeViewModel
            delegate: SimpleRow{
                text: voiceType
                style.showDisclosure: false // disble right arrow in ios

            }
            onItemSelected: {
                console.log("Clicked Item #" + index + ": "+ JSON.stringify(item));
            }
      }

}
