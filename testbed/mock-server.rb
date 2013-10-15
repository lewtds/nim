# server
require 'dbus'

class Nim < DBus::Object
  dbus_interface "nim.server.InputContext" do
    dbus_method :send_key, "in key:s" do |key|
      puts "This key got pressed: #{key}"
      self.on_keypressed key
    end
    dbus_signal :on_string_committed, "str:s"
  end

  dbus_interface "nim.server.InputMethod" do
    dbus_method :commit_string, "in str:s" do |str|
      self.on_string_committed "From IM: #{str}"
    end
    dbus_signal :on_keypressed, "key:s"
  end
end

bus = DBus::SessionBus.instance

service = bus.request_service("org.nim")

service.export Nim.new('/server')

main = DBus::Main.new

main << bus

main.run
