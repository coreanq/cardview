import QtQuick 2.0
import QtWebSockets 1.0
import QtQml.Models 2.11
import "qwebchannel.js"  as WebChannel
//import "./JSONListModel"
WebSocket {
    id: _root
    property var onmessage
    property var speechObj
//    property alias voiceTypeModel : _voiceTypeModel.model
//    property alias voiceLanguageModel : _voiceLanguageModel.model
    signal connected()
    ListModel{
        id: test
        dynamicRoles: true

    }

//    JSONListModel{
////        id: _voiceTypeModel
////        json: speechObj.voiceTypeList
////        query: "$.[*]"
//    }
//    JSONListModel{
////        id: _voiceLanguageModel
////        json: speechObj.voiceLanguageList
////        query: "$.[*]"
//    }

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
        case WebSocket.Closed:
            console.log("Error: Socket at " + url + " closed.");
            break;
        case WebSocket.Open:
            //open the webchannel with the socket as transport
            new WebChannel.QWebChannel(_root, function(ch) {
                console.log( url + " opened.");
                // cpp main object
                speechObj = ch.objects.speech;

                // c++ property 의 경우  client side 에서  cache 되므로 변경시  main object 를 업데트 해줌
                //signal to signal connection
                speechObj.voiceTypeListChanged.connect( function() {
                    speechObj = ch.objects.speech;
                })

                speechObj.voiceLanguageListChanged.connect( function() {
                    speechObj = ch.objects.speech;
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
