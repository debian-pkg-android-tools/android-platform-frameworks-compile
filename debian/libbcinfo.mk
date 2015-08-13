include /usr/include/android/arch/android_includes.mk
include ../../slang/rs_version.mk
include ../../debian/use_llvm.mk

NAME = libbcinfo
SOURCES = BitcodeTranslator.cpp \
          BitcodeWrapper.cpp \
          MetadataExtractor.cpp
OBJECTS = $(SOURCES:.cpp=.o) \
          Wrap/libLLVMWrap.a \
          BitReader_2_7/libLLVMBitReader_2_7.a \
          BitReader_3_0/libLLVMBitReader_3_0.a \
          ../../slang/BitWriter_3_2/libLLVMBitWriter_3_2.a \
          /usr/lib/llvm-$(LLVM_VERSION)/lib/libLLVMCore.a
CXXFLAGS += -fPIC -c $(RS_VERSION_DEFINE)
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -I../include -I../../slang
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android -Wl,-soname,$(NAME).so.5 \
           -ldl -lpthread -L/usr/lib/android -lcutils -llog

build: $(OBJECTS)
	c++ $^ -o $(NAME).so.$(UPSTREAM_LIBVERSION) $(LDFLAGS)
	ar rs $(NAME).a $(OBJECTS)
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)