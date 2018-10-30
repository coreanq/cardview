import QtQuick 2.0
import QtWebSockets 1.0 
import "qwebchannel.js"  as WebChannel
WebSocket {
    id: _root
    property var onmessage
    property var speechObj
    property string assetsPath 
    property string fruitModel
    property bool isDebug : true
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
    url: "ws://192.168.0.8:12345"

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
                _root.speechObj = ch.objects.speech;
                _root.fruitModel = ch.objects.speech.itemModel;
                _root.isDebug = ch.objects.speech.isDebug;

                if( _root.isDebug === true )
                    _root.assetsPath = "../assets/"
                else
                    _root.assetsPath = "qrc:/assets/"
                console.log("asset path: " +  _root.assetsPath )
                console.log("Debug: " + _root.isDebug )
                console.log("xml: " + _root.fruitModel)
                connected();
            });

        }
    }
}
