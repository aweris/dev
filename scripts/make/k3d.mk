# configuration
K3D_CLUSTER        ?= dev
K3D_CLUSTER_CONFIG := $(RESOURCES_DIR)/k3d/$(K3D_CLUSTER).yaml

K3D_REG_CONFIG      = $(TMP_DIR)/k3d/$(K3D_CLUSTER)/registries.yaml
K3D_EXTRA_ARGS     ?= ""
K3D_ARGS           := $(K3D_EXTRA_ARGS)

# Scripts
INIT_K3D_REG_CONF  := $(SCRIPTS_DIR)/k3s/init-k3d-reg-config.sh
INIT_K3S_SERVICES  := $(SCRIPTS_DIR)/k3s/init-k3s-services.sh

.PHONY: k3d_list
k3d_list: ## list cluster(s)
k3d_list: $(K3D)
	$(Q) $(K3D) cluster list

.PHONY: k3d_create
k3d_create: ## create a new cluster
k3d_create: $(K3D) $(HELM) $(TMP_DIR) $(K3D_REG_CONFIG) ; $(info $(M) creating cluster $(K3D_CLUSTER) ...)
	$(Q) $(K3D) cluster create --config $(K3D_CLUSTER_CONFIG) --registry-config $(K3D_REG_CONFIG) $(K3D_ARGS)
	$(Q) RESOURCES_DIR=$(RESOURCES_DIR) HELM_CMD=$(HELM) $(INIT_K3S_SERVICES)

.PHONY: k3d_delete
k3d_delete: ## delete cluster
k3d_delete: $(K3D) ; $(info $(M) deleting cluster $(K3D_CLUSTER) ...)
	$(Q) $(K3D) cluster delete $(K3D_CLUSTER)
	$(Q) rm -rf $(TMP_DIR)/k3d/$(K3D_CLUSTER)

.PHONY: k3d_start
k3d_start: ## start existing k3d cluster
k3d_start: $(K3D) $(TMP_DIR); $(info $(M) starting cluster $(K3D_CLUSTER) ...)
	$(Q) $(K3D) cluster start $(K3D_CLUSTER)

.PHONY: k3d_stop
k3d_stop: ## stop existing k3d cluster
k3d_stop: $(K3D) ; $(info $(M) stoping cluster $(K3D_CLUSTER) ...)
	$(Q) $(K3D) cluster stop $(K3D_CLUSTER)

$(K3D_REG_CONFIG): ; $(info $(M) initializing $(K3D_REG_CONFIG) ...)
	$(Q) OUTPUT=$(K3D_REG_CONFIG) $(INIT_K3D_REG_CONF)
