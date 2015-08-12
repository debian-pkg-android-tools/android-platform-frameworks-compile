include /usr/include/android/arch/android_includes.mk
include ../../../slang/rs_version.mk
include ../../../debian/use_llvm.mk

NAME = libLLVMBitReader_3_0
SOURCES = BitcodeReader.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE) -D__HOST__ \
            -D_GNU_SOURCE -fomit-frame-pointer -Dsprintf=sprintf -std=c++11
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../../include -I/usr/include/llvm-$(LLVM_VERSION) -I/usr/include/llvm-c-$(LLVM_VERSION)

build: $(OBJECTS)
	ar rs $(NAME).a $^

clean:
	rm -f *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)