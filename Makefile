EXE := Bin/EXE_NAME
FILE_ENDINGS := .cpp

OBJ_DIR := Bin/Obj/
SRC_DIR := src/

DIRS := $(shell find $(SRC_DIR) -type d)
INCLUDE_DIRS := $(addprefix -I, $(DIRS))

SRC := $(foreach ext, $(FILE_ENDINGS), $(shell find $(SRC_DIR) -name '*$(ext)'))
OBJ := $(foreach ext, $(FILE_ENDINGS), $(patsubst %$(ext), $(OBJ_DIR)%.o, $(SRC)))


LD := clang++

LIBRARIES :=
LDFLAGS := 
LDFLAGS += $(foreach library, $(LIBRARIES), $(shell pkg-config --libs $(library)))

all: dirs $(EXE)

$(EXE): $(OBJ)
	$(LD) -o $(EXE) $^ $(LDFLAGS)

dirs:
	$(shell mkdir -p $(OBJ_DIR))

clean:
	rm -rf $(OBJ) $(EXE) ./Bin


CC := clang++

CXXFLAGS := -std=c++17 $(INCLUDE_DIRS)
CXXFLAGS += $(foreach library, $(LIBRARIES), $(shell pkg-config --cflags $(library)))

$(OBJ_DIR)%.o: $(1)%.cpp
	mkdir -p $(dir $@)
	$(CC) $(CXXFLAGS) -c $< -o $@