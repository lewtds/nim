require 'dbus'

class Broker < DBus::Object

  def initialize(path, bus)
    super(path)
    @bus = bus
    @input_contexts = {}
    @input_methods = {}
  end

  dbus_interface "nim.server.InputMethod" do
    dbus_method :register, "in im_id:s" do |im_id|
      puts "IM: #{im_id} registered"

      im = @bus.service(im_id).object("/im")
      im.introspect
      im.default_iface = "nim.im.InputMethod"

      @input_methods[im_id] = im
      @active_im_id = im_id
    end
  end

  dbus_interface "nim.server.InputContext" do
    dbus_method :register, "in ic_id:s" do |ic_id|
      puts "IC: #{ic_id} registered"

      ic = @bus.service(ic_id).object("/ic")
      ic.introspect
      ic.default_iface = "nim.ic.InputContext"

      @input_contexts[ic_id] = ic
    end

    dbus_method :focus_in, "in ic_id:s" do |ic_id|
      # When an input context is focused in, it should be selected as the active
      # input context and be routed to the active input method.
      puts "#{ic_id} is focused in"
      @active_ic = @input_contexts[ic_id]

      # Notify both the calling input context and the active input method of the
      # change. Probably, in the future, the notified input method might not be
      # the active input method but one chosen by a policy (e.g. always use a
      # dummy input method for new input contexts...)
      @active_ic.set_input_method(@active_im_id)
      @input_methods[@active_im_id].change_input_context(ic_id)
    end

    dbus_method :preprocess_key_press, "in key:s, out ret:b" do |key|
      [false]
    end
  end
end


session_bus = DBus::SessionBus.instance
service = session_bus.request_service('org.nim.Broker')
service.export Broker.new('/broker', session_bus)

main = DBus::Main.new
main << session_bus
main.run

