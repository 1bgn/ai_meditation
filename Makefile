SHELL := /bin/bash

FLUTTER := flutter
BUILD_RUNNER := $(FLUTTER) pub run build_runner

.PHONY: get clean format analyze test run build_runner watch

get:
	$(FLUTTER) pub get

clean:
	$(FLUTTER) clean

format:
	$(FLUTTER) format .

analyze:
	$(FLUTTER) analyze

test:
	$(FLUTTER) test

run:
	$(FLUTTER) run

build_runner:
	$(BUILD_RUNNER) build --delete-conflicting-outputs

watch:
	$(BUILD_RUNNER) watch --delete-conflicting-outputs
