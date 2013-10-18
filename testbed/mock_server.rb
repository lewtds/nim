#### Prerequisites

# Obviously, we need the 'dbus' library.
require 'dbus'

#### Public API

# At any moment, there is only one active input context and one active input
# method.

# When an input method starts, it registers itself with Nim then wait for the
# **input-context-changed** signal from Nim. This signal carries the path for
# the newly focused input context. The input method is supposed to talk to this
# input context object. When the conversation ends, **input-context-changed**
# is raised again, either because the user has disabled Nim temporarily or
# permanently, in which case the **path** argument will be blank; or because the
# current focus has been changed, in which case the **path** argument will contain
# the path to the new input context.

# When an input context starts, it registers itself with Nim and wait for the
# focus signal from its toolkit. Then it forwards the signal to Nim.

# A conversation starts with an input context getting the input focus, it calls
# a method from Nim to signify it of the new focus. Nim makes it the current
# input context and puts the previous input context back in the store. According
# to a user-overridable rule, the current input method could be used or be replaced
# by a default input method for the newly focused input context.

# An example
# Assuming we have an input context called IC and an input method called IM. We
# also have a dummy input context that emits no signal and replies to no messages
# call dummyIC. A similar dummy input method called dummyIM also exists. It simply
# echo the
class Nim < DBus::Object
  dbus_interface "org.nim.Router" do

    dbus_method :register_input_context do
      # A new input context proxy object should be created, exported and given
      # to the requesting input context
    end

    dbus_method :register_input_method do
      # A new input method proxy object should be created, exported and given
      # to the requesting input method
    end
  end

  def preprocess_key_press(key)
    # This method should be the first to receive the new key press after the
    # input context proxy. We could use this to implement control key sequences
    # like Ctrl-Space to toggle Nim.
  end
end

class InputMethodProxy < DBus::Object
  # This interface is used by input methods.
  dbus_interface "org.nim.InputMethodProxy" do
    # Input methods use this method to send the final string to input contexts.
    dbus_method :commit_string, "in str:s" do |str|
      self.on_string_committed "From IM: #{str}"
    end

    # And listen on this signal for new keypresses.
    #
    # QUESTION: normally, input contexts anticipate a boolean answer to this
    # signal: TRUE if the key has been consumed by the input method (the key won't
    # be echoed onscreen by the input context) or FALSE if the input method shows
    # no interest in the key. How can we implement this synchronized behaviour
    # with DBus signal?
    dbus_signal :key_pressed, "key:s"

    # This signal is raised when the user changes focus and a new input context
    # is selected. An input method only needs to know that the current input
    # context has been reset.
    dbus_signal :reset
  end
end

class InputContextProxy < DBus::Object
  dbus_interface "org.nim.InputContextProxy" do
    dbus_method :key_press, "in key:s" do
    end

    dbus_method :focus_in do
      # The previous input context should be kicked out now
    end

    dbus_method :focus_out do
      # The dummy input context should be focused in now
    end

    dbus_method :reset do
    end

    dbus_signal :string_committed, "in str:s"
  end
end

# At request of an input context, it will receive a DBus object representing
# an input method called inputMethodProxy. On the other side, an input method
# is requested to create a worker object and Nim will connect it with a new
# input context proxy it created.

#### Initialization

# Export Nim at `org.nim/server` on the current session bus.
bus = DBus::SessionBus.instance
service = bus.request_service("org.nim")
service.export Nim.new('/server')

# Run the main loop and wait for connections
main = DBus::Main.new
main << bus
main.run
