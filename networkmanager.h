#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QDebug>
#include <QTimer>
#include <QObject>
#include <QHostInfo>
#include <QDateTime>
#include <QUrlQuery>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QNetworkAccessManager>

class NetworkManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit NetworkManager(QObject *parent = nullptr);


public slots:
    void sendData(double latitude, double longitude); // send position of the user device

    void registerDevice();

    QString getUUID();

    bool isConnected();

    bool isSSL();

    // void getPos(); // get position of other devices

    // void getUUID(); // get to UUID on which is based which data is about user

private:
    QNetworkAccessManager *manager;
    QString UUID = "";
    QString name = "";

    // Connections statuses
    bool connected = false;
    bool ssl = false;
};

#endif // NETWORKMANAGER_H
