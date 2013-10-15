nim - No-brainer Input Method
=============================

**nim** is an input method manager for the Linux desktop. An input method is
a program that helps users input their own language using just the US keyboard.
With the help of an input method manager, multiple input methods can co-exist
and be switched on-the-fly.

**nim** was born out of the frustration we had with the current generation of
input method manager on Linux (namely, **ibus** and **uim**). **uim** is quite a
monolithic monster with an age-old UI and an equally unfriendly API. **iBus** used
to be doable but is quickly falling down the dictatorship path of a typical GNOME
project, they now even try (clumsily, of course) to manage both input methods
and keyboard layouts. So, say goodbye to typing Vietnamese with the Dvorak keyboard,
urgh.

## Goals

**nim** strive to:

- provide a simple yet useful API, preferably shorter than an A4 page when printed out
- support both pre-editting and direct input
- be nimble yet extensible
- spot a user-friendly UI that gets out of the way as much as possible
- support multiple backends (Gtk, Qt, XIM, Wayland,...)

## Technical decisions

**nim**'s architecture is very similar to that of iBus. **nim** acts as a
DBus server, facilitating conversations between input methods and input contexts.

The core server will be written in Ruby, the Gtk+ input context in Vala, the Qt
context in C++ to make the most out of each respective toolkit/framework.

Each input method can be lain out in any language and will communicate with the
core server directly using DBus or indirectly through our provided wrapper library
written in C or Vala.

The choice of DBus here is arbitary and out of popularity. Suggestion is
welcomed.

[DBus API](https://github.com/mvidner/ruby-dbus/blob/master/doc/Tutorial.md)

## Terms

Input method is not a familiar topic for most developers. We hope this non-exhaustive
list of terms can be of use.

- **input method, IM** - a program that helps insert non-latin, non-English text
- **input context** - a text field/area from the perspective of an IM
- **input method manager** - a program that allows multiple input methods to
    work with an input context and vice versa
- **commit** - the act of sending the final string to the input context
- **pre-editing** - a method for allowing the user to edit their input before commiting
- **candidate** - a possible output for the current raw input

    Languages that use complex writing systems like Chinese, Japanese and Korean (CJK)
    are usually typed in using sound transcription. A spoken word can have multiple written
    representations. As such, an input method supporting CJK has to allow the user
    to choose the final written word using a candidate table.

    Input methods can also take advantage of a candidate table to provide autocompletion,
    word suggestion or extra features such as dictionary lookup for non-common words.

## Contributing

**nim** is still very much an idea in infancy. You can help by offering suggestion
and/or request for clarification using the [issue tracker](https://github.com/lewtds/nim/issues)
or on IRC at [#nim@freenode.net](https://kiwiirc.com/client/irc.freenode.net/?nick=nim|?&theme=basic#nim-dev).

## License

**nim** is licensed under the terms of the GNU General Public License v3 (GPLv3).
See [LICENSE](LICENSE) for further information.

Copyright (C) 2013 Trung Ngo
