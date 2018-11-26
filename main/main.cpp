#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <VPApplication>
#include <VPLiveClient>

#include "webchannel_interface/websocketclientwrapper.h"
#include "webchannel_interface/websockettransport.h"
#include "speech.h"
#include <QWebChannel>
#include <QWebSocketServer>
#include <QTextCodec>

int main(int argc, char *argv[])
{
    // using QApplication classs for QWidget class using in AdMobs lib 
    QApplication app(argc, argv);

#if 1

    QWebSocketServer server(QStringLiteral("QWebChannel server"), QWebSocketServer::NonSecureMode );
    if( server.listen(QHostAddress::AnyIPv4, 12345) != true ){
        qFatal("Failed to open web socket server"); 
        return 1;
    } 
    qDebug() << server.serverAddress();
     // wrap WebSocket clients in QWebChannelAbstractTransport objects
    WebSocketClientWrapper clientWrapper(&server);

    // setup the channel
    QWebChannel channel;
    QObject::connect(&clientWrapper, &WebSocketClientWrapper::clientConnected,
                     &channel, &QWebChannel::connectTo);

    // publish it to the QWebChannel
    Speech* speech = new Speech(&app);
    channel.registerObject(QStringLiteral("speech"), speech);

    // application state changed
    // when application active, server listen again
    QObject::connect(&app, &QGuiApplication::applicationStateChanged,
                     [&](Qt::ApplicationState state) {
                        qDebug() << state;
                        if( state == Qt::ApplicationActive ){

                            if( server.isListening() == false ) {
                                if( server.listen(QHostAddress::AnyIPv4, 12345) != true ){
                                    qFatal("Failed to open web socket server");
                                    return 1;
                                }
                                else {
                                    qDebug() << "SERVER listen again";
                                }
                            }

                        }
                    } );
#endif

/////////////////////////////////////////////////////////////////////////////
    VPApplication vplay;

    // Use platform-specific fonts instead of V-Play's default font
    vplay.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

#ifndef VPLAY_LIVE_SERVER
    // use this during development
    // for PUBLISHING, use the entry point below
#ifdef QT_DEBUG
    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
#endif

    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
#ifndef QT_DEBUG
    vplay.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));
#endif

    engine.load(QUrl(vplay.mainQmlFileName()));
#else // V_PLAY_LIVER_SERVER
    // only support debug mode
    VPlayLiveClient liveClient(&engine);
#endif
    return app.exec();
}
