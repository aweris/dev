# Auto generated binary variables helper managed by https://github.com/bwplotka/bingo v0.2.3. DO NOT EDIT.
# All tools are designed to be build inside $GOBIN.
GOPATH ?= $(shell go env GOPATH)
GOBIN  ?= $(firstword $(subst :, ,${GOPATH}))/bin
GO     ?= $(shell which go)

# Bellow generated variables ensure that every time a tool under each variable is invoked, the correct version
# will be used; reinstalling only if needed.
# For example for helm variable:
#
# In your main Makefile (for non array binaries):
#
#include .bingo/Variables.mk # Assuming -dir was set to .bingo .
#
#command: $(HELM)
#	@echo "Running helm"
#	@$(HELM) <flags/args..>
#
HELM := $(GOBIN)/helm-v3.5.0
$(HELM): .bingo/helm.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/helm-v3.5.0"
	@cd .bingo && $(GO) build -mod=mod -modfile=helm.mod -o=$(GOBIN)/helm-v3.5.0 "helm.sh/helm/v3/cmd/helm"

K3D := $(GOBIN)/k3d-v4.0.0
$(K3D): .bingo/k3d.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/k3d-v4.0.0"
	@cd .bingo && $(GO) build -mod=mod -modfile=k3d.mod -o=$(GOBIN)/k3d-v4.0.0 "github.com/rancher/k3d/v4"

