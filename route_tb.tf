resource "azurerm_route_table" "rt" {
  name                          = "rt-spoke-to-hub"
  location                      = azurerm_resource_group.spoke.location
  resource_group_name           = azurerm_resource_group.spoke.name
  disable_bgp_route_propagation = false

  route {
    name                   = "route-to-hub"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
  tags = merge(
    local.common_tags,
    {
      composant = "rt"
    }
  )
}