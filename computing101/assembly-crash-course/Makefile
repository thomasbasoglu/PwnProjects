SRC_DIR := src
OBJ_DIR := obj
EXEC_DIR := exec

# Find all .s files in src/ and subfolders
SRCS := $(shell find $(SRC_DIR) -name "*.s")
# Map .s files to .o files in obj/
OBJS := $(SRCS:$(SRC_DIR)/%.s=$(OBJ_DIR)/%.o)
# Map .o files to executables in exec/
BINS := $(SRCS:$(SRC_DIR)/%.s=$(EXEC_DIR)/%)

# "all" will build every executable
all: $(BINS)

# Rule 1: Link .o files into executables in exec/
$(EXEC_DIR)/%: $(OBJ_DIR)/%.o
	@mkdir -p $(dir $@)
	ld -o $@ $<

# Rule 2: Assemble .s files into .o files in obj/
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	as -o $@ $<

clean:
	rm -rf $(OBJ_DIR) $(EXEC_DIR)
