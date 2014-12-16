PROG_NAME := my-calculator
LIST_OF_SRCS := calc.c main.c math.h lib.c
COLORS := red FF0000 green 00FF00 blue 0000FF purple FF00FF
ORDERS := 100 green cups 200 blue plates

#words : Given a list as input, returns the number of space-separated words
#in that list. In this example, $(NUM_FILES) evaluates to 4.
NUM_FILES := $(words $(LIST_OF_SRCS))
$(info $(NUM_FILES))

#word : Given a list, extracts the nth word from that list. The list is 1-based,
#so $(SECOND_FILE) evaluates to main.c .

SECOND_FILE := $(word 2, $(LIST_OF_SRCS))
$(info $(SECOND_FILE))

#filter : Returns the words from a list, which match a specific pattern. A
#common use is to select a subset of files that match a specific filename pat-
#tern (such as all C source files).
C_SRCS := $(filter %.c, $(LIST_OF_SRCS))
$(info $(C_SRCS))


#patsubst : For each word in a list, replaces any that match a specific pat-
#tern with a replacement pattern. The % character identifies the part of each
#word that remains unchanged (the stem). Note that the first comma must
#not be followed by a space character; otherwise, the replacement list ends
#up with two spaces between each word.
OBJECTS := $(patsubst %.c,%.o, $(LIST_OF_SRCS))
$(info ${OBJECTS})

#addprefix : For each word in a list, prepends an additional string. In
#the following example, you add the objs/ prefix to each element in the
#$(OBJECTS) list.
OBJ_LIST := $(addprefix objs/, $(OBJECTS))
$(info $(OBJ_LIST))

#foreach : Visits each word in a list and constructs a new list containing
#the “mapped” values. The mapping expression can consist of any combi-
#nation of GNU Make function calls. The following example is identical to
#the addprefix case, in that you’re constructing a new list in which all the
#filenames are mapped to the expression obj/$(file) .
# NO space after the second ","
OBJ_LIST_2 := $(foreach file, $(OBJECTS),objs/$(file))
$(info $(OBJ_LIST_2))

#dir / notdir : Given a file’s pathname, returns the directory name compo-
#nent or the filename component.
#n this case, $(DEFN_DIR) evaluates to src/headers/idl/ (including the
#final / ) and $(DEFN_BASENAME) evaluates to interface.idl .
DEFN_PATH := src/headers/idl/interface.idl
DEFN_DIR := $(dir $(DEFN_PATH))
DEFN_BASENAME := $(notdir $(DEFN_PATH))
$(info $(DEFN_DIR))
$(info $(DEFN_BASENAME))

#shell : Executes a shell command and returns the command’s output as a
#string. The following example demonstrates a nonportable way of deter-
#mining the owner of the /etc/passwd file. This assumes that the third
#word in the output of the ls –l command is the name of the file’s owner
PASSWD_OWNER := $(word 3, $(shell ls -l /etc/passwd))
$(info $(PASSWD_OWNER))

OUTPUT_LS := $(shell ls -l /)
$(info $(OUTPUT_LS))

#Define a macro
file_size = $(word 5, $(shell ls -l $(1)))
PASSWD_SIZE = $(call file_size,/etc/passwd)
$(info $(PASSWD_SIZE))


#Any rules and variables defined inside the included file are treat-
#ed as if they’re actually written inside the main file.
include include1.mk

.PHONY: all
all:
	$(info $(MAKE))
	$(start-banner)
