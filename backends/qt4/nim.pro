#-------------------------------------------------
#
# Project created by QtCreator 2013-02-17T22:59:56
#
#-------------------------------------------------

QT       += core gui

TARGET = niminputcontextplugin
TEMPLATE = lib
CONFIG += plugin

#DESTDIR = $$[QT_INSTALL_PLUGINS]/inputmethods
DESTDIR = inputmethods

SOURCES += qinputcontextplugin.cpp \
    context.cpp \
    xevent.cpp

HEADERS += qinputcontextplugin.h \
    context.h \
    xevent.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}
