CXX = g++
CXXFLAGS = -std=c++23 -Wall -Wextra -pedantic
LDFLAGS =

# Directories
SRC_DIR = src
INCLUDE_DIR = src/include
BUILD_DIR = build
LIB_DIR = lib

# Files
SRCS = $(SRC_DIR)/config.cpp
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))
STATIC_LIB = $(LIB_DIR)/libcppconfig.a
SHARED_LIB = $(LIB_DIR)/libcppconfig.so

# Installation paths
PREFIX ?= /usr/local
INCLUDE_INSTALL_DIR = $(PREFIX)/include/cppconfig
LIB_INSTALL_DIR = $(PREFIX)/lib

# Targets
.PHONY: all clean install uninstall static shared

all: static shared

# Create build directories
$(BUILD_DIR) $(LIB_DIR):
	mkdir -p $@

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -fPIC -I$(INCLUDE_DIR) -c $< -o $@

# Create static library
static: $(STATIC_LIB)

$(STATIC_LIB): $(OBJS) | $(LIB_DIR)
	ar rcs $@ $^

# Create shared library
shared: $(SHARED_LIB)

$(SHARED_LIB): $(OBJS) | $(LIB_DIR)
	$(CXX) -shared -o $@ $^ $(LDFLAGS)

# Install the library and headers
install: all
	mkdir -p $(INCLUDE_INSTALL_DIR)
	mkdir -p $(LIB_INSTALL_DIR)
	cp $(INCLUDE_DIR)/config.h $(INCLUDE_INSTALL_DIR)/
	cp $(STATIC_LIB) $(SHARED_LIB) $(LIB_INSTALL_DIR)/
	ldconfig

# Uninstall the library and headers
uninstall:
	rm -rf $(INCLUDE_INSTALL_DIR)
	rm -f $(LIB_INSTALL_DIR)/libcppconfig.a
	rm -f $(LIB_INSTALL_DIR)/libcppconfig.so
	ldconfig

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)
