#include "xevent.h"
#include <X11/Xlib.h>
#include <X11/Xutil.h>

bool
parseXKeyEvent (XEvent *xevent, uint *keyval, uint *keycode, uint *state)
{

    if (xevent->type != KeyPress && xevent->type != KeyRelease)
        return false;

    *keycode = xevent->xkey.keycode;
    *state = xevent->xkey.state;
    if (xevent->type == KeyRelease)
        *state |= 1 << 30;

    char key_str[64];
    if (XLookupString (&xevent->xkey, key_str, sizeof (key_str), (KeySym *)keyval, 0) <= 0) {
        *keyval = (quint32) XLookupKeysym (&xevent->xkey, 0);
    }

    return true;

}
