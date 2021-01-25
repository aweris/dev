# Project directories
ROOT_DIR      := $(CURDIR)
SCRIPTS_DIR   := $(ROOT_DIR)/scripts
RESOURCES_DIR := $(ROOT_DIR)/resources
TMP_DIR       := $(ROOT_DIR)/tmp
HELM_DIR      := $(ROOT_DIR)/.helm
GOBIN         := $(ROOT_DIR)/.gobin

# override helm path configurations
export XDG_CACHE_HOME  := $(HELM_DIR)/cache
export XDG_CONFIG_HOME := $(HELM_DIR)/config
export XDG_DATA_HOME   := $(HELM_DIR)/home

# Helper variables
V = 0
Q = $(if $(filter 1,$V),,@)
M = $(shell printf "\033[34;1m▶\033[0m")

# External targets
include .bingo/Variables.mk
include scripts/make/help.mk
include scripts/make/k3d.mk

#  Non phony targets
$(TMP_DIR): ; $(info $(M) creating tmp directory ...)
	$(Q) mkdir -p $@
