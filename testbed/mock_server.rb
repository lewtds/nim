require 'dbus'

class Broker < DBus::Object
  dbus_interface "nim.server.InputMethod" do
    dbus_method :register, "in str:s" do |str|
      
    end
  end

  dbus_interface "nim.server.InputContext" do
    dbus_method :register, "in str:s" do |str|
      puts "IC registered: #{str}"
    end

    dbus_method :focus_in, "in ic_id:s" do |ic_id|
      
    end

    dbus_method :preprocess_key_press, "in key:s" do |key|
      
    end
  end
end


session_bus = DBus::SessionBus.instance
service = session_bus.request_service('org.nim.Broker')
service.export Broker.new('/broker')

main = DBus::Main.new
main << session_bus
main.run

