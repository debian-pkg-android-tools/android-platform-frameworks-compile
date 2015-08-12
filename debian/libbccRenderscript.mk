include /usr/include/android/arch/android_includes.mk
include ../../../slang/rs_version.mk
include ../../../debian/use_llvm.mk

NAME = libbccRenderscript
SOURCES = RSCompiler.cpp \
          RSCompilerDriver.cpp \
          RSEmbedInfo.cpp \
          RSExecutable.cpp \
          RSForEachExpand.cpp \
          RSInfo.cpp \
          RSInfoExtractor.cpp \
          RSInfoReader.cpp \
          RSInfoWriter.cpp \
          RSScript.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE) -D__HOST__ -D__DISABLE_ASSERTS
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include

build: $(OBJECTS)
	ar rs $(NAME).a $^

clean:
	rm -f *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)