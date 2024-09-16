#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QDebug>
#include <QObject>
#include <QHostInfo>
#include <QDateTime>
#include <QUrlQuery>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonDocument>
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

    // void getPos(); // get position of other devices

    // void getUUID(); // get to UUID on which is based which data is about user

private:
    QNetworkAccessManager *manager;
    QString UUID = "";
    QString name = "";
};

#endif // NETWORKMANAGER_H
