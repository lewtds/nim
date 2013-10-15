# server
require 'dbus'

class Nim < DBus::Object
  dbus_interface "nim.server" do
    dbus_method :says, "in msg:s" do |msg|
      puts "Got this message: #{msg}"
    end
  end
end

bus = DBus::SessionBus.instance

service = bus.request_service("org.nim")

service.export Nim.new('/server')

main = DBus::Main.new

main << bus

main.run
