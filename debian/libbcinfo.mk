include /usr/include/android/arch/android_includes.mk
include ../../slang/rs_version.mk
include ../../debian/use_libcxx.mk

NAME = libbcinfo
SOURCES = BitcodeTranslator.cpp \
          BitcodeWrapper.cpp \
          MetadataExtractor.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE) -std=c++11
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../include -I../../slang -I/usr/include/llvm-$(LLVM_VERSION) -I/usr/include/llvm-c-$(LLVM_VERSION)
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android -Wl,-soname,$(NAME).so.5 \
           -L/usr/lib/llvm-$(LLVM_VERSION)/lib -lLLVM-$(LLVM_VERSION) \
           -L/usr/lib/android -lcutils -llog \
           -ldl -lpthread

build: $(OBJECTS) Wrap/libLLVMWrap.a BitReader_2_7/libLLVMBitReader_2_7.a BitReader_3_0/libLLVMBitReader_3_0.a ../../slang/BitWriter_3_2/libLLVMBitWriter_3_2.a
	c++ $^ -o $(NAME).so.$(UPSTREAM_LIBVERSION) $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)