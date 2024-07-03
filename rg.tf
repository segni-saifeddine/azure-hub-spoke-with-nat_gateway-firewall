resource "azurerm_resource_group" "hub" {
  name     = "rg-hub-network"
  location = var.location
  tags = merge(
    local.common_tags,
    {
      composant = "rg"
    }
  )

  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = true
  }
}

resource "azurerm_resource_group" "spoke" {
  name     = "rg-spoke-network"
  location = var.location
  tags = merge(
    local.common_tags,
    {
      composant = "rg"
    }
  )

  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = true
  }
}
