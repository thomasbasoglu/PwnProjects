# Directories
SRC_DIR := src
OBJ_DIR := obj
EXEC_DIR := exec

# Find all .s files in src/ and define their corresponding .o and .so targets
SOURCES := $(wildcard $(SRC_DIR)/*.s)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.s=$(OBJ_DIR)/%.o)
TARGETS := $(SOURCES:$(SRC_DIR)/%.s=$(EXEC_DIR)/%.so)

# Default target
all: $(TARGETS)

# Rule to build the .so from the .o
$(EXEC_DIR)/%.so: $(OBJ_DIR)/%.o
	@mkdir -p $(EXEC_DIR)
	ld -shared -o $@ $<

# Rule to build the .o from the .s
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(OBJ_DIR)
	as -o $@ $<

# Clean up build artifacts
clean:
	rm -rf $(OBJ_DIR) $(EXEC_DIR)

.PHONY: all clean
