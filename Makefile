CC := clang++
EXE := Bin/EXE_NAME
FILE_ENDING := .cpp

OBJ_DIR := Bin/Obj/
SRC_DIR := src/

DIRS := $(shell find $(SRC_DIR) -type d)
INCLUDE_DIRS := $(addprefix -I, $(DIRS))

SRC := $(shell find $(SRC_DIR) -name '*$(FILE_ENDING)')
OBJ := $(addprefix $(OBJ_DIR), $(notdir $(SRC:$(FILE_ENDING)=.o)))

LDFLAGS :=
CXXFLAGS := -std=c++17 $(INCLUDE_DIRS)

all: dirs $(EXE)

$(EXE): $(OBJ)
	$(CC) -o $(EXE) $^ $(LDFLAGS)

define generateRules
$(OBJ_DIR)%.o: $(1)/%$(FILE_ENDING)
	$(CC) $(CXXFLAGS) -c $$< -o $$@
endef

$(foreach targetdir, $(DIRS), $(eval $(call generateRules, $(targetdir))))

dirs:
	$(shell mkdir -p $(OBJ_DIR))

clean:
	rm -rf $(OBJ) $(EXE) ./Bin