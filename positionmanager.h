#ifndef POSITIONMANAGER_H
#define POSITIONMANAGER_H

#include <QObject>
#include <QHostInfo>
#include <QDateTime>
#include <QQmlEngine>
#include <QNetworkAccessManager>

class PositionManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit PositionManager(QObject *parent = nullptr);

public slots:
    void sendPos(double latitude, double longitude); // send position of the user device

    void getPos(); // get position of other devices

    void getUUID(); // get to UUID on which is based which data is about user

private:
    QNetworkAccessManager *manager;
};

#endif // POSITIONMANAGER_H
