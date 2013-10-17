using Gtk;

class NimContext : IMContext {

}

[CCode (cname = "G_MODULE_EXPORT im_module_init", instance_pos = -1)]
public void im_module_init(TypeModule type_module) {
    type_module.register_type(NimContext);
}

[CCode (cname = "G_MODULE_EXPORT im_module_exit", instance_pos = -1)]
public void im_module_exit() {
    message("init");
}

[CCode (cname = "G_MODULE_EXPORT im_module_create", instance_pos = -1)]
public IMContext im_module_create(string context_id) {
    message("create");
    return null;
}

[CCode (cname = "G_MODULE_EXPORT im_module_list", instance_pos = -1)]
public void im_module_list(IMContextInfo*** contexts, int *length) {
    message("list");
    IMContextInfo nim = IMContextInfo() {
        context_id = "nim",
        context_name = "nim (Intelligent Input Bus)",
        domain = "nim",
        default_locales = "ja:ko:zh:*"
    };

    unowned IMContextInfo** im_list = new IMContextInfo*[1];
    im_list[0] = &nim;

    *contexts = im_list;
    *length = 1;
}
