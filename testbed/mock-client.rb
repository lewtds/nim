# This is a sample input context. In real-life, an input context could be a text
# field or text area in any program.
require 'dbus'

# Open a connection to Nim
session_bus = DBus::SessionBus.instance
server = session_bus.service('org.nim').object('/server')

# The object at `org.nim/server` has two interfaces, we only use the interface
# for input contexts.
server.default_iface = 'nim.server.InputContext'

# Wait for the **string-committed** signal and print the received string out
# for debugging purpose.
server.on_signal("on_string_committed") do |str|
  puts "String committed: #{str}"
end

# Send a test key to Nim. We expect that Nim will forward
# this key press to the current input method and that the input method
# will reply appropriately using the **string-committed** signal.
server.send_key '9'

# Start the main loop.
main = DBus::Main.new
main << session_bus
main.run
