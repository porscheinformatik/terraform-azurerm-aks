# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## 0.13.0 (2021-03-11)

### ⚠ BREAKING CHANGES

* If you have used the Kubernetes namespace creation please move this
feature to your own module.
* This changes the default network plugin/policy form azure/azure
to kubenet/calico. Please add the parameters to the module if you
do not want to change the networking (recreates the cluster).

### Features

* Make network plugin/policy configurable ([1f55e9a](https://github.com/porscheinformatik/terraform-azurerm-aks/commit/1f55e9ab7d581717eb62b13ea76d1d46b09d2bb0))
* Remote Kubernetes namespace creation from module ([187f94c](https://github.com/porscheinformatik/terraform-azurerm-aks/commit/187f94cdad8f5708d1c708af92a443257383e762))


## 0.12.0 (2021-03-11)

### Other Changes

* Loosen version constraints to azurerm
* **deps:** update terraform kubernetes to v2 ([#20](https://github.com/porscheinformatik/terraform-azurerm-aks/issues/20)) ([1466834](https://github.com/porscheinformatik/terraform-azurerm-aks/commit/1466834ec0ec1461e841612256dc8b41ad2e50cc))

