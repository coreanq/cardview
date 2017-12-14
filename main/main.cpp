#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <VPApplication>

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
    
#ifdef QT_DEBUG


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

#endif

/////////////////////////////////////////////////////////////////////////////
    VPApplication vplay;
    // Use platform-specific fonts instead of V-Play's default font
    vplay.setPreservePlatformFonts(true);
    
    // * qml 과 c++ 인터페이스 
    // qml 내부에서 해당 객체를 직접 선언해서 사용할 경우 qmlRegisterType 방식 사용
//     qmlRegisterType<Speech>("cpp.Speech", 1, 0, "Speech");
    
    QQmlApplicationEngine engine;
    vplay.initialize(&engine);
    QQmlContext* context = engine.rootContext();
    
//#include "speech.h" 
//    Speech speech;
//    context->setContextProperty("cppSpeech", &speech);
    
#ifdef QT_DEBUG    
    QString qmlSource = "qml/Main.qml";
    context->setContextProperty("debug", true);
#else
    QString qmlSource = "qrc:/qml/Main.qml";  // for url type
    // to check mode in qml
    context->setContextProperty("debug", false);
#endif
    vplay.setMainQmlFileName(qmlSource);
    
    engine.load(QUrl(vplay.mainQmlFileName()));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
