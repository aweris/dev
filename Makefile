# Project directories
ROOT_DIR      := $(CURDIR)
SCRIPTS_DIR   := $(ROOT_DIR)/scripts
RESOURCES_DIR := $(ROOT_DIR)/resources
TMP_DIR       := $(ROOT_DIR)/tmp
GOBIN         := $(ROOT_DIR)/.gobin

# Helper variables
V = 0
Q = $(if $(filter 1,$V),,@)
M = $(shell printf "\033[34;1m▶\033[0m")

# External targets
include .bingo/Variables.mk
include scripts/make/help.mk

#  Non phony targets
$(TMP_DIR): ; $(info $(M) creating tmp directory ...)
	$(Q) mkdir -p $@
