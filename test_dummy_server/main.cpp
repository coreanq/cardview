#include <QGuiApplication>
#include <QWebChannel>
#include <QWebSocketServer>
#include <QDebug>

#include "../main/webchannel_interface/websocketclientwrapper.h"
#include "../main/webchannel_interface/websockettransport.h"
#include "../main/speech.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QObject::connect(&app, &QGuiApplication::applicationStateChanged, [=](Qt::ApplicationState state) { qDebug() << Q_FUNC_INFO << state; } );

    QWebSocketServer server(QStringLiteral("QWebChannel Test server"), QWebSocketServer::NonSecureMode );
    if( server.listen(QHostAddress::AnyIPv4, 12345) != true ){
        qFatal("Failed to open web socket server"); 
        return 1;
    } 
    qDebug() << server.serverAddress() ;
     // wrap WebSocket clients in QWebChannelAbstractTransport objects
    WebSocketClientWrapper clientWrapper(&server);

    // setup the channel
    QWebChannel channel;
    QObject::connect(&clientWrapper, &WebSocketClientWrapper::clientConnected,
                     &channel, &QWebChannel::connectTo);

    // publish it to the QWebChannel
    Speech* speech = new Speech(&app);
    channel.registerObject(QStringLiteral("speech"), speech);
    return app.exec();
}


