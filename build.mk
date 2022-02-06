# SPDX-License-Identifier: Apache-2.0
TARGETS = \
	FRDM-K22F \
	FRDM-K64F \
	FRDM-K82F \
	LPCXpresso55S69 \
	Microbit \
	Microbitv2 \
	MIMXRT1020 \
	MIMXRT1050 \
	MIMXRT1060 \
	MIMXRT1170 \
	Nordic-nRF51-DK \
	Nordic-nRF52-DK \
	Nordic-nRF52840-DK \
	ST-Nucleo-F207ZG \

DIST = dist
DEPS = \
	zdv/CMakeLists.txt \
	zdv/aliases.cmake \
	zdv/build.mk \
	zdv/prj.conf \
	zdv/src/main.c \
	$(wildcard zdv/boards/*.conf)

BUILD_OPTIONS = -p auto

.PHONY:
all: $(patsubst %, $(DIST)/%.hex, $(TARGETS))

.SECONDARY:
$(DIST)/%.hex: builds/%/zephyr/zephyr.hex $(DEPS)
	@mkdir -p $(DIST)
	cp $< $@
	arm-none-eabi-objcopy -O binary --gap-fill=0xff builds/$*/zephyr/zephyr.elf $(DIST)/$*.bin

.SECONDARY:
builds/%/zephyr/zephyr.hex: $(DEPS)
	ZEPHYR_BOARD_ALIASES=$(abspath zdv/aliases.cmake) \
		west build -b $* -d builds/$* $(BUILD_OPTIONS) zdv
	@touch $@
