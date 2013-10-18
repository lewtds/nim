# This is a sample input method.

require 'dbus'

class InputContextProxy < DBus::Object

  attr_reader :service
  def initialize(path, session_bus)
    super(path)
    @broker = session_bus.service('org.nim.Broker').object('/broker')
    @broker.default_iface = 'nim.server.InputContext'
  end

  def register
    @broker.register(@service.name)
  end
  
  dbus_interface "nim.server.InputContext" do
    dbus_method :commit_string, "in str:s" do |str|
      
    end
  end
end

session_bus = DBus::SessionBus.instance
service = session_bus.request_service(session_bus.unique_name)
service.export InputContextProxy.new('/ic', session_bus)

main = DBus::Main.new
main << session_bus
main.run
