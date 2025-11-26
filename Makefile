EXE := Bin/EXE_NAME
FILE_ENDINGS := .cpp .c

OBJ_DIR := Bin/Obj/
SRC_DIR := src/

DIRS := $(shell find $(SRC_DIR) -type d)
INCLUDE_DIRS := $(addprefix -I, $(DIRS))

SRC := $(foreach ext, $(FILE_ENDINGS), $(shell find $(SRC_DIR) -name '*$(ext)'))
OBJ := $(foreach file, $(SRC), $(addprefix $(OBJ_DIR), $(notdir $(addsuffix .o, $(basename $(file))))))

all: dirs $(EXE)

$(EXE): $(OBJ)
	$(CC) -o $(EXE) $^ $(LDFLAGS)

dirs:
	$(shell mkdir -p $(OBJ_DIR))

clean:
	rm -rf $(OBJ) $(EXE) ./Bin


CC := clang++
LDFLAGS  :=
CXXFLAGS := -std=c++17 $(INCLUDE_DIRS)

define generateRulesCpp
$(OBJ_DIR)%.o: $(1)%.cpp
	$(CC) $(CXXFLAGS) -c $$< -o $$@
endef

define generateRulesC
$(OBJ_DIR)%.o: $(1)%.c
	$(CC) $(CXXFLAGS) -c $$< -o $$@
endef

$(foreach targetdir, $(DIRS), $(eval $(call generateRulesCpp, $(targetdir))))
$(foreach targetdir, $(DIRS), $(eval $(call generateRulesC, $(targetdir))))