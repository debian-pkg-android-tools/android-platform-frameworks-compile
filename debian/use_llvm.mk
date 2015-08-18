CXXFLAGS += -std=c++11 \
            -D_GNU_SOURCE \
            -D__STDC_LIMIT_MACROS \
            -D__STDC_CONSTANT_MACROS \
            -fomit-frame-pointer \
            -Dsprintf=sprintf
CPPFLAGS += -I/usr/include/llvm-$(LLVM_VERSION) -I/usr/include/llvm-c-$(LLVM_VERSION)
LDFLAGS += -L/usr/lib/llvm-$(LLVM_VERSION)/lib -lLLVM-$(LLVM_VERSION)