# client
require 'dbus'

session_bus = DBus::SessionBus.instance

server = session_bus.service('org.nim').object('/server')

server.default_iface = 'nim.server.InputMethod'

server.introspect

server.on_signal("on_keypressed") do |key|
  puts "Key pressed: #{key}"
  server.commit_string "hello, you pressed #{key}"
end

main = DBus::Main.new

main << session_bus

main.run
