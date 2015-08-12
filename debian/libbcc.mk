include ../debian/use_llvm.mk

NAME = libbcc
OBJECTS = lib/Core/libbccCore.a \
          lib/ExecutionEngine/libbccExecutionEngine.a \
          lib/Renderscript/libbccRenderscript.a \
          lib/Support/libbccSupport.a
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android -Wl,-soname,$(NAME).so.5 \
           -L/usr/lib/android -lutils -lcutils -llog -Lbcinfo -lbcinfo \
           -ldl -lpthread

build: $(OBJECTS)
	c++ $^ -o $(NAME).so.$(UPSTREAM_LIBVERSION) $(LDFLAGS)
	ln -s $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so.5

clean:
	rm -f *.so*