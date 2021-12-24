# SPDX-License-Identifier: Apache-2.0
TARGETS = \
	Microbit \
	Microbitv2 \

DIST = dist
DEPS = zdv/src/main.c \
	zdv/CMakeLists.txt \
	zdv/aliases.cmake \
	zdv/prj.conf

all: $(patsubst %, $(DIST)/%.hex, $(TARGETS))

$(DIST)/%.hex: builds/%/zephyr/zephyr.hex
	@mkdir -p $(DIST)
	cp $< $@
	cp builds/$*/zephyr/zephyr.bin $(DIST)/$*.bin

.PRECIOUS: builds/%/zephyr/zephyr.hex
builds/%/zephyr/zephyr.hex: $(DEPS)
	ZEPHYR_BOARD_ALIASES=$(abspath zdv/aliases.cmake) \
		west build -b $* zdv --pristine -d builds/$*
