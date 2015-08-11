NAME = bcc_compat
SOURCES = Main.cpp
CXXFLAGS += $(RS_VERSION_DEFINE)
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include
LDFLAGS += -fPIC -ldl -lbcc -lbcinfo -L/usr/lib/llvm-$(LLVM_VERSION)/lib -lLLVM-$(LLVM_VERSION)

build: $(SOURCES)
	c++ $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	rm -f $(NAME)