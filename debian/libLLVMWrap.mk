include ../../../debian/use_libcxx.mk

NAME = libLLVMWrap
SOURCES = bitcode_wrapperer.cpp \
          file_wrapper_input.cpp \
          file_wrapper_output.cpp \
          in_memory_wrapper_input.cpp \
          wrapper_output.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE) -D__HOST__ \
            -D_GNU_SOURCE -fomit-frame-pointer -Dsprintf=sprintf -std=c++11
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include

build: $(OBJECTS)
	ar rs $(NAME).a $^

clean:
	rm -f *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)