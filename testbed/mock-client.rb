# client
require 'dbus'

session_bus = DBus::SessionBus.instance

server = session_bus.service('org.nim').object('/server')

server.default_iface = 'nim.server.InputContext'

server.introspect

server.on_signal("on_string_committed") do |str|
  puts "String committed: #{str}"
end

server.send_key 'yay'

main = DBus::Main.new

main << session_bus

main.run
