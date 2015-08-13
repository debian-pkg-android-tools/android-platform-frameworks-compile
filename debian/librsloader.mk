include /usr/include/android/arch/android_includes.mk
include ../debian/use_llvm.mk

NAME = librsloader
SOURCES = lib/ELFHeader.cpp \
          lib/ELFSymbol.cpp \
          lib/ELFSectionHeader.cpp \
          lib/ELFTypes.cpp \
          lib/MemChunk.cpp \
          lib/StubLayout.cpp \
          lib/GOT.cpp \
          utils/raw_ostream.cpp \
          utils/rsl_assert.cpp \
          utils/helper.cpp \
          android/librsloader.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -D__HOST__
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android -Iinclude -I.
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android -Wl,-soname,$(NAME).so.5

build: $(OBJECTS)
	c++ $^ -o $(NAME).so.$(UPSTREAM_LIBVERSION) $(LDFLAGS)
	ar rs $(NAME).a $(OBJECTS)
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so
	ln -s -f $(NAME).so.$(UPSTREAM_LIBVERSION) $(NAME).so.5

clean:
	rm -f *.so* *.a $(OBJECTS)

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)