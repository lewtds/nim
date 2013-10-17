#ifndef CONTEXT_H
#define CONTEXT_H

#include <QInputContext>

class NimInputContext : public QInputContext {
    Q_OBJECT
public:
    QString identifierName ();
    QString language();
    void reset();
    bool isComposing() const;
//    bool x11FilterEvent( QWidget * keywidget, XEvent * event );
    bool filterEvent(const QEvent *event);
    void update();
    void setFocusWidget(QWidget *w);
private:
    bool isShortCut(int keyval, int modifiers);
};

#endif // CONTEXT_H
