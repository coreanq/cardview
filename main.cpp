#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "speech.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qmlRegisterType<Speech>("user.Speech", 1, 0, "Speech");
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
