include /usr/include/android/arch/android_includes.mk
include ../debian/use_llvm.mk

NAME = libbcc
OBJECTS = $(shell find lib -name *.o)
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android -Wl,-soname,$(NAME).so.5 \
           -ldl -lpthread -L/usr/lib/android -lutils -lcutils -llog \
           -Lbcinfo -lbcinfo -L../linkloader -lrsloader
build: $(OBJECTS)
	c++ $^ -o $(NAME).so.$(UPSTREAM_LIBVERSION) $(LDFLAGS)
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so.5

clean:
	rm -f *.so*