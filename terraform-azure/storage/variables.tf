variable "name_prefix" {
    type = string
    description = "Name prefix to use for the resources"
}

variable "azure_region" {
    type = string
    description = "The Azure region to deploy to"
}

variable "cost_allocation_tag" {
    type = string
    description = "Tag to use to identify the deployment"
}
