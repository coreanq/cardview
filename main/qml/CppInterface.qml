import QtQuick 2.0
import QtWebSockets 1.0
import QtQml.Models 2.11
import "qwebchannel.js"  as WebChannel
WebSocket {
    id: _root
    property var onmessage
    property var speechObj
    property string assetsPath 
    signal connected()
    signal elementAdded(string element)
    
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

                //signal to signal connection
                speechObj.elementAdded.connect(_root.elementAdded)

                // model update
                speechObj.updateModels()

                if( ch.objects.speech.isDebug === true ){
                    _root.assetsPath = "../assets/"
                    Constants.isDebugMode = true
                }
                else{
                    _root.assetsPath = "qrc:/assets/"
                    Constants.isDebugMode = false
                }

                console.log("asset path: " +  _root.assetsPath )
                console.log("Debug: " + Constants.isDebugMode )
//                console.log("xml: " + _root.fruitModel)
                connected();
            });

        }
    }
}
