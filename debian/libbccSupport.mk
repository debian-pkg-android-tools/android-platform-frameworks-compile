include /usr/include/android/arch/android_includes.mk
include ../../../slang/rs_version.mk
include ../../../debian/use_llvm.mk

NAME = libbccSupport
SOURCES = CompilerConfig.cpp \
          Disassembler.cpp \
          FileBase.cpp \
          Initialization.cpp \
          InputFile.cpp \
          OutputFile.cpp \
          Sha1Util.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CFLAGS += -fPIC -c
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE) -D__HOST__ -D__DISABLE_ASSERTS
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android \
            -I../../include -I../../../linkloader/include

build: $(OBJECTS) sha1.o
	ar rs $(NAME).a $^

clean:
	rm -f *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

sha1.o: sha1.c
	cc $^ -o $@ $(CFLAGS) $(CPPFLAGS)