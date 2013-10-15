# server
require 'dbus'

class Nim < DBus::Object
  dbus_interface "nim.server.InputContext" do
    dbus_method :send_key, "in key:s" do |key|
      puts "This key got pressed: #{key}"
    end
  end
end

bus = DBus::SessionBus.instance

service = bus.request_service("org.nim")

service.export Nim.new('/server')

main = DBus::Main.new

main << bus

main.run
