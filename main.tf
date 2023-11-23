locals {
  ndo              = try(local.model.ndo, {})
  schemas          = [for schema in try(local.ndo.schemas, []) : schema if var.manage_schemas && (length(var.managed_schemas) == 0 || contains(var.managed_schemas, schema.name))]
  tenants          = [for tenant in try(local.ndo.tenants, []) : tenant if var.manage_tenants && (length(var.managed_tenants) == 0 || contains(var.managed_tenants, tenant.name))]
  ndo_version_full = jsondecode(data.mso_rest.ndo_version.content).version
  ndo_version      = regex("^[0-9]+[.][0-9]+", local.ndo_version_full)
}

data "mso_rest" "ndo_version" {
  path = "api/v1/platform/version"
}


provider "mso" {
    # cisco-mso user name
    username = "admin"
    # cisco-mso password
    password =xxxxxxxxxxx
    # cisco-mso url
    url      = xxxxxxx
    insecure = true
    platform = "nd"
}
module "tenant" {
  source  = "netascode/nac-ndo/mso"
  version = ">= 0.7.0"

  yaml_files = ["data/ndo.yaml"]

  manage_sites   = false
  manage_tenants = true
  managed_tenants = ["MSO1"]
  manage_schemas   = true
  deploy_templates   = true
}
module "schema" {
  source  = "netascode/nac-ndo/mso"
  version = ">= 0.7.0"

  yaml_files = ["data/ndo.yaml"]
  manage_tenants = true
  manage_schemas   = true
  deploy_templates   = true
}
module "template" {
  source  = "netascode/nac-ndo/mso"
  version = ">= 0.7.0"

  yaml_files = ["data/ndo.yaml"]

  manage_tenants = true
  manage_schemas   = true
  deploy_templates   = true
}
module "deploy_templates" {
  source  = "netascode/nac-ndo/mso"
  version = ">= 0.7.0"

  manage_tenants = true
  manage_schemas   = true
  deploy_templates   = true
  yaml_files = ["data/ndo.yaml"]
}
module "sites" {
  source  = "netascode/nac-ndo/mso"
  version = ">= 0.7.0"

  yaml_files = ["data/ndo.yaml"]
  manage_tenants = true
  manage_schemas   = true
  deploy_templates   = true
}
