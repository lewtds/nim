# This is a sample input method.

require 'dbus'
require 'thread'

class InputContextProxy < DBus::Object

  def initialize(path, session_bus)
    super(path)
    @bus = session_bus
    @broker = @bus.service('org.nim.Broker').object('/broker')
    @broker.introspect
    @broker.default_iface = 'nim.server.InputContext'
    @im = nil
  end

  def register
    @broker.register(@service.name)
  end

  def focus_in
    @broker.focus_in(@service.name)
  end

  def send_key(key)
    # DBus methods can have many output arguments. In this
    unless @broker.preprocess_key_press(key)[0]
      @im.key_press(key)
    end
  end

  dbus_interface "nim.ic.InputContext" do
    dbus_method :commit_string, "in str:s" do |str|
      puts "String committed: #{str}"
    end

    dbus_method :set_input_method, "in im_id:s" do |im_id|
      puts "Active IM set: #{im_id}"
      @im = @bus.service(im_id).object("/im")
      @im.introspect
      @im.default_iface = "nim.im.InputMethod"
      puts @im
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
