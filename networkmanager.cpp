#include "networkmanager.h"

NetworkManager::NetworkManager(QObject *parent) : QObject{parent}
{
    manager = new QNetworkAccessManager();
}

void NetworkManager::sendData(double latitude, double longitude) {
    qDebug() << "Pozycja: " << latitude << ":" << longitude;
    QUrl url("http://31.178.6.12:80/receivePosition");

    // Tworzymy obiekt JSON
    QJsonObject jsonObj;
    jsonObj["latitude"] = latitude;
    jsonObj["longitude"] = longitude;

    // Przekształcamy JSON na bajty
    QJsonDocument jsonDoc(jsonObj);
    QByteArray jsonData = jsonDoc.toJson();

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Wysyłamy żądanie POST
    QNetworkReply* reply = manager->post(request, jsonData);

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, [&]{
        reply->abort();
    });

    timer->start(5000);

    connect(reply, &QNetworkReply::finished, this, [&]{
        qDebug() << reply->error();

        if ( reply->errorString() != "" ) {
            connected = false;
        } else {
            connected = true;
        }
    });

}

void NetworkManager::registerDevice() {

    QString id = "nil";

    QUrl url("http://31.178.6.12:80/registerDevice");

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    // Wysłanie żądania POST
    QNetworkReply *reply = manager->post(request, QByteArray());
    qDebug() << reply;

}

bool NetworkManager::isConnected() {
    return connected;
}

bool NetworkManager::isSSL() {
    return ssl;
}

QString NetworkManager::getUUID() {
    return UUID;
}
