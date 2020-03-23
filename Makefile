#thanks to @potatonomicon for the guidance with this Makefile

define search #(1 path, 2 pattern) -> list
	$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call search,$d/,$2))
endef

SHELL := /bin/zsh
SOURCE := src
APPDATA = ~/.local/share/love/goinghomerevisit
FILENAME_LOG_OUTPUT = log_output.txt
FILENAME_LOG_INFO = info.txt
OUTPUT_DIRECTORY := output
EXCLUDES := modules

DIR_ECS_W := worlds
DIR_ECS_C := components
DIR_ECS_S := systems
SOURCE_PATH := ./${SOURCE}
SOURCE_FILES := $(strip $(call search,$(SOURCE_PATH),*.lua2p))
SOURCE_FILES += $(strip $(call search,$(SOURCE_PATH)/*.lua2p))
SOURCE_OBJECTS := $(SOURCE_FILES:$(SOURCE_PATH)/%.lua2p=./$(OUTPUT_DIRECTORY)/%.lua)

DIRECTORIES_TO_COPY := shaders #folders inside the "${SOURCE}"
DIR_ASSETS = assets
DIR_MODULES = modules

LPP_PATH := ./luapreprocess/preprocess-cl.lua

.PHONY: ltags

process: init $(SOURCE_OBJECTS) ltags
	@echo preprocessing finished
	love $(OUTPUT_DIRECTORY)

./$(OUTPUT_DIRECTORY)/%.lua: ./${SOURCE}/%.lua2p
	@echo processing input: $<
	@echo processing output: $@
	lua $(LPP_PATH) --handler=handler.lua --outputpaths $< $@

init:
	@if [ ! -d $(OUTPUT_DIRECTORY) ]; then mkdir -p $(OUTPUT_DIRECTORY); else echo "$(OUTPUT_DIRECTORY) directory already exists"; fi
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_ECS_W) ]; then mkdir -p $(OUTPUT_DIRECTORY)/$(DIR_ECS_W); else echo "$(OUTPUT_DIRECTORY)/$(DIR_ECS_W) directory already exists"; fi
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_ECS_C) ]; then mkdir -p $(OUTPUT_DIRECTORY)/$(DIR_ECS_C); else echo "$(OUTPUT_DIRECTORY)/$(DIR_ECS_C) directory already exists"; fi
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_ECS_S) ]; then mkdir -p $(OUTPUT_DIRECTORY)/$(DIR_ECS_S); else echo "$(OUTPUT_DIRECTORY)/$(DIR_ECS_S) directory already exists"; fi
	@for x ($(DIRECTORIES_TO_COPY)); do \
		cp -rf $(SOURCE)/$$x $(OUTPUT_DIRECTORY)/; \
	done
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_MODULES) ]; then \
		cp -rf $(DIR_MODULES) $(OUTPUT_DIRECTORY)/; \
	else \
		echo "$(DIR_MODULES) already exists in $(OUTPUT_DIRECTORY)"; \
	fi
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_ASSETS) ]; then \
		cp -rf $(DIR_ASSETS) $(OUTPUT_DIRECTORY)/; \
	else \
		echo "$(DIR_ASSETS) already exists in $(OUTPUT_DIRECTORY)"; \
	fi

clean:
	@if [ -d $(OUTPUT_DIRECTORY) ]; then rm -rf $(OUTPUT_DIRECTORY); else echo "$(OUTPUT_DIRECTORY) directory does not exist"; fi
	@echo "Clean finished"

clean_logs:
	@if [ -f $(APPDATA)/$(FILENAME_LOG_OUTPUT) ]; then \
		echo "$(APPDATA)/$(FILENAME_LOG_OUTPUT) exists. Deleting..."; \
		rm $(APPDATA)/$(FILENAME_LOG_OUTPUT); \
	else \
		echo "$(APPDATA)/$(FILENAME_LOG_OUTPUT) does not exist!"; \
	fi
	@if [ -f $(APPDATA)/$(FILENAME_LOG_INFO) ]; then \
		echo "$(APPDATA)/$(FILENAME_LOG_INFO) exists. Deleting..."; \
		rm $(APPDATA)/$(FILENAME_LOG_INFO); \
	else \
		echo "$(APPDATA)/$(FILENAME_LOG_INFO) does not exist!"; \
	fi

ltags:
	@if [ -f ltags ]; then \
		./ltags -nv $(SOURCE)/**/*.(lua|lua2p); \
	else \
		echo "no ltags found"; \
	fi
	@echo "Generated tags file"

ltags_all:
	@if [ -f ltags ]; then \
		./ltags -nv $(SOURCE)/**/*.(lua|lua2p) $(DIR_MODULES)/**/*.(lua|lua2p); \
	else \
		echo "no ltags found"; \
	fi

info:
	@echo Source----------: $(SOURCE_FILES)
	@echo Objects---------: $(SOURCE_OBJECTS)
	@echo AppData---------: $(APPDATA)
