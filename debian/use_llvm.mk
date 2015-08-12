# Use libc++
CXXFLAGS += -D_USING_LIBCXX -nostdinc++ -std=c++11
CPPFLAGS += -I/usr/include/c++/v1
LDFLAGS += -nodefaultlibs -lm -lc -lc++

# Use llvm
CXXFLAGS += -D_GNU_SOURCE \
            -D__STDC_LIMIT_MACROS \
            -fomit-frame-pointer \
            -Dsprintf=sprintf
CPPFLAGS += -I/usr/include/llvm-$(LLVM_VERSION) -I/usr/include/llvm-c-$(LLVM_VERSION)
LDFLAGS += -L/usr/lib/llvm-$(LLVM_VERSION)/lib -lLLVM-$(LLVM_VERSION)