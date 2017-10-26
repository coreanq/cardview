#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "speech.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // * qml 과 c++ 인터페이스 시 주의 사항  
    // qml 내부에서 해당 객체를 직접 선언해서 사용할 경우 qmlRegisterType 방식 사용
    // qmlRegisterType<Speech>("user.Speech", 1, 0, "Speech");
    
    // c 코드에서 객체를 선언해서 사용할 경우 setContextProperty 사용 
    Speech speech; 
    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();
    // qml load 전에 c++ interface 등록되야 함  
    context->setContextProperty("cppInterface", &speech);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    
    context->setContextProperty("cppInterface", &speech);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
