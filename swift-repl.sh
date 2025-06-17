#!/bin/bash
swift build && \
swift repl -I .build/debug -L .build/debug -lCalculoKit
