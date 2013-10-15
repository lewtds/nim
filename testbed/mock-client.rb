# client
require 'dbus'

session_bus = DBus::SessionBus.instance

foo=session_bus.service('org.nim')

server=foo.object('/server')

server.default_iface='nim.server'

server.introspect

server.says 'yay'
