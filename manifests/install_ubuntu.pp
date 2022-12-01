# @summary Install node_exporter in Ubuntu
#
# Install and manage node_exporter package and its pertinent permissions
#
#
# @example
#   include node_exporter::install_ubuntu
class node_exporter::install_ubuntu () {
  package {'prometheus-node-exporter':
    ensure => present,
  }
}
