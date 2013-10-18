# This is a sample input method.

require 'dbus'

class InputMethodProxy < DBus::Object
  dbus_interface "nim.server.InputMethod" do
    dbus_method :key_press, "in str:s" do |str|

    end

    dbus_method :change_input_context, "in path:s" do |path|

    end
  end
end

session_bus = DBus::SessionBus.instance
service = session_bus.request_service("org.nim.im.Fake")
service.export InputMethodProxy.new('/im')

main = DBus::Main.new
main << session_bus
main.run
