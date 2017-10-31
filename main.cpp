#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <VPApplication>
#include "speech.h"

int main(int argc, char *argv[])
{
    // using QApplication classs for QWidget class using in AdMobs lib 
    QApplication app(argc, argv);
    
    VPApplication vplay;
    // Use platform-specific fonts instead of V-Play's default font
    vplay.setPreservePlatformFonts(true);
    
    // * qml 과 c++ 인터페이스 시 주의 사항  
    // qml 내부에서 해당 객체를 직접 선언해서 사용할 경우 qmlRegisterType 방식 사용
    // qmlRegisterType<Speech>("user.Speech", 1, 0, "Speech");
    
    // c 코드에서 객체를 선언해서 사용할 경우 setContextProperty 사용 
    Speech speech; 
    QQmlApplicationEngine engine;
    vplay.initialize(&engine);
    QQmlContext* context = engine.rootContext();
    // qml load 전에 c++ interface 등록되야 함  
    context->setContextProperty("cppInterface", &speech);

  //  QString qmlSource = "qrc/qml/main.qml";
    QString qmlSource = "qml/main.qml"; //NOTE: uncomment for DEPLOYMENT
    vplay.setMainQmlFileName(qmlSource);
    
    engine.load(QUrl(vplay.mainQmlFileName()));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
