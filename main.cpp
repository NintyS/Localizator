#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <networkmanager.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    NetworkManager nM;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("nM", &nM);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Localizator", "Main");

    return app.exec();
}
