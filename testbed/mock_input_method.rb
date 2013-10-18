# This is a sample input method.

require 'dbus'

class InputMethodProxy < DBus::Object

  def initialize(path, session_bus)
    super(path)
    @bus = session_bus
    @broker = @bus.service('org.nim.Broker').object('/broker')
    @broker.introspect
    @broker.default_iface = 'nim.server.InputMethod'
    @ic = nil
  end

  def register
    @broker.register(@service.name)
  end

  dbus_interface "nim.im.InputMethod" do
    dbus_method :key_press, "in str:s" do |str|
      puts "Key press: #{str}"
      @ic.commit_string(str)
    end

    dbus_method :change_input_context, "in ic_id:s" do |ic_id|
      puts "Input context changed to: #{ic_id}"

      @ic = @bus.service(ic_id).object('/ic')
      @ic.introspect
      @ic.default_iface = 'nim.server.InputContext'
    end

    dbus_method :reset do
      puts "Reset"
    end
  end
end

session_bus = DBus::SessionBus.instance
service = session_bus.request_service("org.nim.im.Fake")

im = InputMethodProxy.new('/im', session_bus)
service.export(im)
im.register

main = DBus::Main.new
main << session_bus
main.run
