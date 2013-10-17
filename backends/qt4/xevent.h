#ifndef XEVENT_H
#define XEVENT_H

#include <QInputContext>

bool
parseXKeyEvent (XEvent *xevent, uint *keyval, uint *keycode, uint *state);

#endif // XEVENT_H
