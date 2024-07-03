

resource "azurerm_public_ip" "fw" {
  name                = "pip-fw"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  name                = "fw-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags = merge(
    local.common_tags,
    {
      composant = "fw"
    }
  )
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fw.id
    public_ip_address_id = azurerm_public_ip.fw.id
  }

}
# Network rule collections
resource "azurerm_firewall_network_rule_collection" "fw_net_rule" {
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = azurerm_firewall.fw.resource_group_name
  action              = "Allow"
  name                = "spoke-to-internet"
  priority            = 100
  rule {
    name = "allow-web"

    source_addresses = [
      "",
    ]

    destination_ports = [
      "80", "443"
    ]

    destination_addresses = ["*"]

    protocols = [
      "TCP",
    ]
  }
}
