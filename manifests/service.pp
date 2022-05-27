# @summary node_exporter service
#
# Create a unit file to manage the node_exporter service
#
# @param node_exporter_version
#   Version of the application that is installed by this module
#
# @param node_exporter_flavor
#   Architecture of the binary
#
# @example
#   include node_exporter::service
class node_exporter::service (
  String $node_exporter_version,
  String $node_exporter_flavor,
){
  systemd::unit_file { 'node_exporter.service':
    content => epp('node_exporter/node_exporter.service.epp', {
      version => $node_exporter_version,
      flavor  => $node_exporter_flavor,
      }),
    enable  => true,
    active  => true,
  }
}
