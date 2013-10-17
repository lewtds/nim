SRC=nim.vala
BINARY=nim
CFLAGS=`pkg-config --cflags glib-2.0 gmodule-2.0 gtk+-3.0` --shared -fPIC

all: nim.so immodules.cache

# nim.so:
# 	gcc ${SRC} ${CFLAGS} -o ${OUTPUT}
nim.so:
	valac ${SRC} --library=${BINARY} --pkg gtk+-3.0 -X --shared -X -fPIC -o ${BINARY}.so

immodules.cache: nim.so
	/usr/lib/x86_64-linux-gnu/libgtk-3-0/gtk-query-immodules-3.0 ${BINARY}.so > immodules.cache

clean:
	@rm nim.so immodules.cache
