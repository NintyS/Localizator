#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "positionmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    PositionManager pm;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("pm", &pm);

    const QUrl url(QStringLiteral("qrc:/Localizator/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
