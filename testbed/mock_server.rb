require 'dbus'

class Broker < DBus::Object

  def initialize(path, bus)
    super(path)
    @bus = bus
    @input_contexts = {}
  end

  dbus_interface "nim.server.InputMethod" do
    dbus_method :register, "in str:s" do |str|
      puts "IM: #{str} registered"
    end
  end

  dbus_interface "nim.server.InputContext" do
    dbus_method :register, "in path:s" do |path|
      puts "IC: #{path} registered"
      ic = @bus.service(path).object("/ic")
      ic.introspect
      ic.default_iface = "nim.ic.InputContext"
      @input_contexts[path] = ic
    end

    dbus_method :focus_in, "in ic_id:s" do |ic_id|

    end

    dbus_method :preprocess_key_press, "in key:s" do |key|

    end
  end
end


session_bus = DBus::SessionBus.instance
service = session_bus.request_service('org.nim.Broker')
service.export Broker.new('/broker', session_bus)

main = DBus::Main.new
main << session_bus
main.run

