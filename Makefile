# Compiler
CC := gcc

# Compiler flags
CFLAGS := -Wall -Wextra -fPIC

# Directories
SRC_DIR := ./src
INCLUDE_DIR := ./include
BIN_DIR := ./bin
OBJ_DIR := $(BIN_DIR)/objs

# Source files
SRCS := $(wildcard $(SRC_DIR)/*.s)

# Object files
OBJS := $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS))

# Library name
LIBRARY := $(BIN_DIR)/libIOLibrary.so

# Executable name and path
EXECUTABLE := $(BIN_DIR)/driver

# Default target
# Build shared library and delete temp objs folder
all: $(LIBRARY) 
	@echo "Build completed"
	@$(MAKE) clean

# Rule to create temp objs folder if it doesn't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Rule to assemble assembly files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to link object files into shared library
$(LIBRARY): $(OBJS) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -shared $^ -o $@

# Delete temp objs folder
clean:
	rm -rf $(OBJ_DIR)
	@echo "Cleaned up"

# Run target (build library if necessary, compile driver.c, and run executable)
run: $(EXECUTABLE)
	@$(MAKE) clean
	@echo "Running $(EXECUTABLE)"
	LD_LIBRARY_PATH=$(BIN_DIR) ./$(EXECUTABLE)

# Compile driver.c and link with shared library
$(EXECUTABLE): $(LIBRARY) driver.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -L$(BIN_DIR) -I$(INCLUDE_DIR) driver.c -o $(EXECUTABLE) -lIOLibrary 

.PHONY: all clean run

