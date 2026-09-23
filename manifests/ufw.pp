# @summary node_exporter UFW configuration
#
# Create UFW rules to allow communication
#
# @param collector_address
#   Address of the host collecting Node Exporter data
#
# @param dns_server
#   Address of the DNS server to ask for IP of the collector
#
# @example
#   include node_exporter::ufw
class node_exporter::ufw (
  String $collector_address,
  String $dns_server = '8.8.8.8',
  Integer $port = 9100,
){
  $collector_ip = dnsquery::a($collector_address, { nameserver => $dns_server })[0]
  ufw_rule { 'allow_node_exporter_collector':
    action       => 'allow',
    from_addr    => $collector_ip,
    proto        => 'tcp',
    to_ports_app => $port,
  }
}
