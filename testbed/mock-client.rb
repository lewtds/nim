# client
require 'dbus'

session_bus = DBus::SessionBus.instance

server = session_bus.service('org.nim').object('/server')

server.default_iface = 'nim.server.InputContext'

server.introspect

server.send_key 'yay'
