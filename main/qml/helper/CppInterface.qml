import QtQuick 2.0
import QtWebSockets 1.0
import QtQml.Models 2.11
import "qwebchannel.js"  as WebChannel

WebSocket {
    id: _root
    property var onmessage
    property var speechObj
    property string cardList
    property string voiceTypeList
    property string voiceLanguageList
    signal connected()

    // the following three properties/functions are required to align the QML WebSocket API
    // with the HTML5 WebSocket API.
    property var send: function(arg) {
        sendTextMessage(arg);
    }

    onTextMessageReceived: {
        onmessage({data: message});
    }

    active: true
    url: Constants.cppInterfaceServerIpAddr

    onStatusChanged: {
        switch (_root.status) {
        case WebSocket.Error:
            console.log("Error: " + _root.errorString);
            break;
        case WebSocket.Closed :
            console.log("Error: Socket at " + url + " closed.");
            break;
        case WebSocket.Open:
            //open the webchannel with the socket as transport
            new WebChannel.QWebChannel(_root, function(ch) {
                console.log( url + " opened.");
                // cpp main object
                speechObj = ch.objects.speech
                voiceLanguageList = Qt.binding( function() { return speechObj.voiceLanguageList } )
                voiceTypeList = Qt.binding( function() { return speechObj.voiceTypeList } )
                cardList = Qt.binding( function() { return speechObj.cardList } )

                // c++ property 의 경우  client side 에서 cache 되므로 변경시 강제 업데이트 수행
                //signal to signal connection
                speechObj.voiceLanguageListChanged.connect( function() {
                    voiceLanguageList = speechObj.voiceLanguageList
//                    voiceLanguageList = Qt.binding(function() { return speechObj.voiceLanguageList } )
                })

                speechObj.voiceTypeListChanged.connect( function() {
                    voiceTypeList = speechObj.voiceTypeList
                })

                speechObj.cardListChanged.connect( function() {
                    cardList = speechObj.cardList
                })
                // Invoke a method:
//                foo.myMethod(arg1, arg2, function(returnValue) {
//                    // This callback will be invoked when myMethod has a return value. Keep in mind that
//                    // the communication is asynchronous, hence the need for this callback.
//                    console.log(returnValue);
//                });

                if( ch.objects.speech.isDebug === true ){
                    Constants.assetsPath = "../../assets/"
                    Constants.isDebugMode = true
                }
                else{
                    Constants.assetsPath = "qrc:/assets/"
                    Constants.isDebugMode = false
                }

                console.log("asset path: " +  Constants.assetsPath )
                console.log("Debug: " + Constants.isDebugMode )
//                console.log("xml: " + _root.fruitModel)
                connected();
            });

        }
    }
}
