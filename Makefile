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

DIR_ECS := worlds components systems assemblages
SOURCE_PATH := ./${SOURCE}
SOURCE_FILES := $(strip $(call search,$(SOURCE_PATH),*.lua2p))
SOURCE_FILES += $(strip $(call search,$(SOURCE_PATH)/*.lua2p))
SOURCE_OBJECTS := $(SOURCE_FILES:$(SOURCE_PATH)/%.lua2p=./$(OUTPUT_DIRECTORY)/%.lua)

DIRECTORIES_TO_COPY := shaders #folders inside the "${SOURCE}"
DIR_ASSETS = assets
DIR_MODULES = modules
DIR_RELEASE = release

DIR_TO_REMOVE := _images new_assets soundtracks audio media
MODULES_EXCLUDE := spec docs example test love-sdf-text-testing rockspecs main.lua .travis .git examples .travis.yml

FONTS_PATH = scripts/fonts
FONTS_OUTPUT = scripts/output
FONTS_FINAL = scripts/final
FONTS_TARGET = assets/fonts
FONTS = Jamboree DigitalDisco-Thin DigitalDisco Firefly Jamboree Luna Pixeled tiny uncle_type
TEXTURE_SIZE = 1024,1024

LPP_PATH := ./luapreprocess/preprocess-cl.lua
LPP_HANDLER := handler_dev.lua

RELEASE_VERSION :=

.PHONY: ltags release

process: init $(SOURCE_OBJECTS) minimize
	@echo preprocessing finished
	love $(OUTPUT_DIRECTORY)

./$(OUTPUT_DIRECTORY)/%.lua: ./${SOURCE}/%.lua2p
	@echo processing input: $<
	@echo processing output: $@
	@lua $(LPP_PATH) --handler=$(LPP_HANDLER) --outputpaths $< $@

release:
	@cd $(OUTPUT_DIRECTORY) && makelove --config ../makelove.toml --version-name $(RELEASE_VERSION)

generate-fonts: msdf-fonts convert-fonts copy-fonts
	@echo generating fonts finished

msdf-fonts:
	@if [ ! -d $(OUTPUT_DIRECTORY) ]; then mkdir -p $(OUTPUT_DIRECTORY); else echo "$(OUTPUT_DIRECTORY) directory already exists"; fi
	@if [ ! -d $(FONTS_OUTPUT) ]; then mkdir -p $(FONTS_OUTPUT); else echo "$(FONTS_OUTPUT) directory already exists"; fi
	@if [ ! -d $(FONTS_FINAL) ]; then mkdir -p $(FONTS_FINAL); else echo "$(FONTS_FINAL) directory already exists"; fi
	for font in $(FONTS); do \
		msdf-bmfont -o $(FONTS_OUTPUT)/$$font.png -t msdf $(FONTS_PATH)/$$font.ttf -m $(TEXTURE_SIZE); \
	done

convert-fonts:
	for font in $(FONTS); do \
		python scripts/convertfont.py $(FONTS_OUTPUT)/$$font.fnt $(FONTS_FINAL)/$$font.fnt; \
	done

copy-fonts:
	for font in $(FONTS); do \
		cp $(FONTS_OUTPUT)/$$font.png $(FONTS_TARGET); \
		cp $(FONTS_PATH)/$$font.ttf $(FONTS_TARGET); \
		cp -i $(FONTS_FINAL)/$$font.fnt $(FONTS_TARGET); \
	done

init:
	@$(foreach var,$(DIR_ECS),mkdir -p $(OUTPUT_DIRECTORY)/$(var);)
	@for x ($(DIRECTORIES_TO_COPY)); do \
		cp -rf $(SOURCE)/$$x $(OUTPUT_DIRECTORY)/; \
	done
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_MODULES) ]; then \
		rsync -av --progress $(DIR_MODULES) $(OUTPUT_DIRECTORY) $(foreach var,$(MODULES_EXCLUDE),--exclude $(var)); \
	else \
		echo "$(DIR_MODULES) already exists in $(OUTPUT_DIRECTORY)"; \
	fi
	@if [ ! -d $(OUTPUT_DIRECTORY)/$(DIR_ASSETS) ]; then \
		rsync -av --progress $(DIR_ASSETS) $(OUTPUT_DIRECTORY) $(foreach var, $(DIR_TO_REMOVE),--exclude $(var)); \
	else \
		echo "$(DIR_ASSETS) already exists in $(OUTPUT_DIRECTORY)"; \
	fi

minimize:
	@$(foreach var,$(DIR_TO_REMOVE),rm -rf $(OUTPUT_DIRECTORY)/$(DIR_ASSETS)/$(var);)

clean:
	@if [ -d $(OUTPUT_DIRECTORY) ]; then rm -rf $(OUTPUT_DIRECTORY); else echo "$(OUTPUT_DIRECTORY) directory does not exist"; fi
	@echo "Clean finished"

clean-release:
	@if [ -d $(DIR_RELEASE) ]; then rm -rf $(DIR_RELEASE); else echo "$(DIR_RELEASE) directory does not exist"; fi

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

clean-fonts:
	@if [ -d $(FONTS_OUTPUT) ]; then rm -rf $(FONTS_OUTPUT); else echo "$(FONTS_OUTPUT) directory does not exist"; fi
	@if [ -d $(FONTS_FINAL) ]; then rm -rf $(FONTS_FINAL); else echo "$(FONTS_FINAL) directory does not exist"; fi

info:
	@echo Source----------: $(SOURCE_FILES)
	@echo Objects---------: $(SOURCE_OBJECTS)
	@echo AppData---------: $(APPDATA)

test:
