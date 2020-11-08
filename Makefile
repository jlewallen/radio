BUILD ?= build
SWEEPS = $(wildcard *.sweep)
RENDERED := $(SWEEPS:%=$(BUILD)/%.png)

default: channels.csv sweeps

sweeps: $(RENDERED)

$(BUILD)/%.png: NAME = ${@:${BUILD}/%.png=%}

$(BUILD)/%.png:
	time cpulimit `which python3` -f -l 50 -- tools/rtl-sdr-misc/heatmap/heatmap.py $(NAME) $@

channels.csv: channels.txt
	python3 baofeng-csv.py channels.txt > channels.csv

clean:
	rm -f channels.csv

.PHONY: sweeps
