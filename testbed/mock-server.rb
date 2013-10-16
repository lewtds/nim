#### Prerequisites

# Obviously, we need the 'dbus' library.
require 'dbus'

#### Public API

# Nim is a DBus object that exhibits two different programming interfaces. One
# is for talking to input contexts and the other is for input methods. Most of
# the work right now for Nim is to forward messages between the input context
# and the input method. We currently support a single input method and a single
# input context working at once.
class Nim < DBus::Object
  dbus_interface "nim.server.InputContext" do

    # Input contexts use this method to signal that a key has been pressed by
    # the user.
    dbus_method :send_key, "in key:s" do |key|
      puts "This key got pressed: #{key}"
      self.on_keypressed key
    end

    # Meanwhile, they listen on this signal to get the final string sent by input
    # methods.
    dbus_signal :on_string_committed, "str:s"
  end

  dbus_interface "nim.server.InputMethod" do

    # Input methods use this method to send the final string to input contexts.
    dbus_method :commit_string, "in str:s" do |str|
      self.on_string_committed "From IM: #{str}"
    end

    # And listen on this signal for new keypresses.
    dbus_signal :on_keypressed, "key:s"
  end
end

#### Initialization

# Export Nim at `org.nim/server` on the current session bus.
bus = DBus::SessionBus.instance
service = bus.request_service("org.nim")
service.export Nim.new('/server')

# Run the main loop and wait for connections
main = DBus::Main.new
main << bus
main.run
