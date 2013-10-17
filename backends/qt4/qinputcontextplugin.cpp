#include <QDebug>
#include <QInputContext>
#include "qinputcontextplugin.h"
#include "context.h"


QInputContext * Nim::create( const QString & key) {
    qDebug() << "created";
    return new NimInputContext;
}

QString Nim::description ( const QString & key ) {
    return "My input method";
}

QString Nim::displayName ( const QString & key ) {
    return "my input method";
}

QStringList Nim::keys () const {
    qDebug() << "keys";
    return QStringList() << "nim";
}

QStringList Nim::languages ( const QString & key ) {
    return QStringList() << "vi_VN";
}

Q_EXPORT_PLUGIN2(nim, Nim)
