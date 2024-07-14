#include "positionmanager.h"

PositionManager::PositionManager(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager();
}

void PositionManager::sendPos(double latitude, double longitude) {
    qDebug() << "Pozycja: " << latitude << ":" << longitude;
    // QUrl url("http://192.168.1.216:8090/setLocalization");
    // QUrlQuery query;
    // query.addQueryItem("name", QHostInfo::localHostName());
    // query.addQueryItem("latitude", latitude);
    // query.addQueryItem("longitude", longitude);
    // query.addQueryItem("time", QDateTime::currentDateTime().toString());
    // url.setQuery(query);

    // QNetworkRequest request(url);
    // request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    // // Wysłanie żądania POST
    // QNetworkReply *reply = manager->post(request, QByteArray());

}

void PositionManager::getPos() {

}

void PositionManager::getUUID() {

}
