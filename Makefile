CC := clang++
EXE := Bin/Test

OBJ_DIR := Bin/Obj/
SRC_DIR := ./src/

DIRS := $(shell find $(SRC_DIR) -type d )
INCLUDE_DIRS := $(addprefix -I, $(DIRS))
SRC := $(shell find . -name '*.cpp')
OBJ := $(addprefix $(OBJ_DIR), $(notdir $(SRC:.cpp=.o)))

LDFLAGS :=

CXXFLAGS := -std=c++17 $(INCLUDE_DIRS)

all: dirs $(EXE)

$(EXE): $(OBJ)
	$(CC) -o $(EXE) $^ $(LDFLAGS)

define generateRules
$(OBJ_DIR)%.o: $(1)%.cpp
	$(CC) $(CXXFLAGS) -c $$< -o $$@
endef

$(foreach targetdir, $(DIRS), $(eval $(call generateRules, $(targetdir))))


dirs:
	$(shell mkdir -p ./Bin)

clean:
	rm -rf $(OBJ) $(EXE) ./Bin