# SPDX-License-Identifier: Apache-2.0
TARGETS = \
	Thingy91 \

DIST = dist
DEPS = \
	zdv/CMakeLists.txt \
	zdv/aliases.cmake \
	zdv/build.mk \
	zdv/prj.conf \
	zdv/src/main.c \
	$(wildcard zdv/boards/*.conf)

OBJCOPY = arm-none-eabi-objcopy
BUILD_OPTIONS = -p auto

.PHONY:
all: $(patsubst %, $(DIST)/%.hex, $(TARGETS))

.SECONDARY:
$(DIST)/%.hex: builds/%/zephyr/zephyr.hex $(DEPS)
	@mkdir -p $(DIST)
	cp $< $@
	$(OBJCOPY) -O binary --gap-fill=0xff builds/$*/zephyr/zephyr.elf $(DIST)/$*.bin
	if [ -f builds/$*/zephyr/zephyr.uf2 ] ; then \
		cp builds/$*/zephyr/zephyr.uf2 $(DIST)/$*.uf2 ; \
	fi

.SECONDARY:
builds/%/zephyr/zephyr.hex: $(DEPS)
	ZEPHYR_BOARD_ALIASES=$(abspath zdv/aliases.cmake) \
		west build -b $* -d builds/$* $(BUILD_OPTIONS) zdv
	@touch $@
