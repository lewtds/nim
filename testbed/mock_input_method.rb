# This is a sample input method.

require 'dbus'

# Open a connection to Nim
session_bus = DBus::SessionBus.instance
server = session_bus.service('org.nim').object('/server')

# The object at `org.nim/server` has two interfaces, we only use the interface
# for input methods.
server.default_iface = 'nim.server.InputMethod'

# Wait for the **keypress** signal and reply with an output string.
server.on_signal("on_keypressed") do |key|
  puts "Key pressed: #{key}"
  server.commit_string "hello, you pressed #{key}"
end

# Start the main loop. We are doing event-driven programming here.
main = DBus::Main.new
main << session_bus
main.run
