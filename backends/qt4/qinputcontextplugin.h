#ifndef BOGO
#define BOGO

#include <QtGui/QInputContextPlugin>
#include <QString>
#include <QInputContext>
#include <QStringList>


class Nim : public QInputContextPlugin {
    Q_OBJECT
public:
//    BoGo (QObject *parent);
    QInputContext * create ( const QString & key );
    QString description ( const QString & key );
    QString displayName ( const QString & key );
    QStringList keys () const;
    QStringList languages ( const QString & key );
};

#endif // QT4BRIDGE
