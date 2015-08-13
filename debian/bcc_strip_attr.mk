include /usr/include/android/arch/android_includes.mk
include ../../../slang/rs_version.mk
include ../../../debian/use_llvm.mk

NAME = bcc_strip_attr
SOURCES = bcc_strip_attr.cpp
CXXFLAGS += $(RS_VERSION_DEFINE)
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include
LDFLAGS += -fPIC -ldl -lm -lpthread -lbcc -lbcinfo

build: $(SOURCES)
	c++ $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	rm -f $(NAME)