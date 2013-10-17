#include "context.h"
#include "xevent.h"
#include <QDebug>
#include <QEvent>
#include <QApplication>
//#include <X11/Xutil.h>

// Documentation:
// http://qt-project.org/doc/qt-4.7/qinputcontext.html#id-cc618f0c-18dd-47cc-b312-8dfa72e064d7

QString NimInputContext::identifierName () {
    return "nim";
}

QString NimInputContext::language() {
    return "vi_VN";
}

void NimInputContext::reset() {
    qDebug() << "reset";
}

bool NimInputContext::isComposing() const {
    qDebug() << "isComposing()";
    return true;
}

void NimInputContext::update() {
//    qDebug() << "update()";
}

void NimInputContext::setFocusWidget(QWidget *w) {
    qDebug() << "setFocusWidget()" << w;
}

//bool NimInputContext::x11FilterEvent( QWidget * keywidget, XEvent *event ) {
//    uint keyval;
//    uint keycode;
//    uint modifiers;

////    parseXKeyEvent(event, &keyval, &keycode, &modifiers);

////    if (keyval == int('a')) {
//////        qDebug() << XKeysymToString(keyval) << keycode << modifiers;
////        qDebug() << keywidget->inputMethodQuery(Qt::ImSurroundingText)
////            << keywidget->inputMethodQuery(Qt::ImCursorPosition)
////            << keywidget->inputMethodQuery(Qt::ImCurrentSelection)
////            << keywidget->inputMethodQuery(Qt::ImFont);
////        return true;
////    } else if (keyval == int('b') && ~(modifiers & 1<<30)) {
////        QInputMethodEvent e;
////        e.setCommitString("", -1, 1);
////        this->sendEvent(e);
////        return true;
////    }

//    QKeyEvent *e = new QKeyEvent(QEvent::KeyPress, 0, 0, QString(QChar(0x00E1)));
////    QApplication::sendEvent(keywidget, e);

//    return true;
//}

bool NimInputContext::filterEvent(const QEvent *event) {

    int eventType = event->type();
    if (eventType == QEvent::KeyPress || eventType == QEvent::KeyRelease) {
        QKeyEvent *e = (QKeyEvent*) event;

        qDebug() << e->nativeVirtualKey();
    }
    return false;
}

bool NimInputContext::isShortCut(int keyval, int modifiers) {
    if (keyval == int('a')) {
        return true;
    }
    return false;
}
