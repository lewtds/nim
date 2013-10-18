# This is a sample input method.

require 'dbus'

class InputContextProxy < DBus::Object

  attr_reader :service

  def initialize(path, session_bus)
    super(path)
    @broker = session_bus.service('org.nim.Broker').object('/broker')
    @broker.introspect
    @broker.default_iface = 'nim.server.InputContext'
  end

  def register
    @broker.register(@service.name)
  end

  def focus_in
    @broker.focus_in(@service.name)
  end

  dbus_interface "nim.ic.InputContext" do
    dbus_method :commit_string, "in str:s" do |str|

    end
  end
end

session_bus = DBus::SessionBus.instance
service = session_bus.request_service("org.nim.ic.Fake")

ic = InputContextProxy.new('/ic', session_bus)
service.export(ic)
ic.register
ic.focus_in

main = DBus::Main.new
main << session_bus
main.run
