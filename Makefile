CC = gcc
TARGET = libcustomlabels.so
SRCS = src/customlabels.c

ARCH := $(shell uname -m)

ifeq ($(ARCH),aarch64)
    TLS_DIALECT = "-mtls-dialect=desc"
else ifeq ($(ARCH),arm64)
    TLS_DIALECT = ""
else ifeq ($(ARCH),x86_64)
    TLS_DIALECT = "-mtls-dialect=gnu2"
else
    $(error only aarch64, x86-64 and Apple's arm64 are supported)
endif

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -ftls-model=global-dynamic $(TLS_DIALECT) -fPIC -shared -o $(TARGET) $(SRCS)

clean:
	rm -f $(TARGET)
