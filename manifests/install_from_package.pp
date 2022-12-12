# @summary Install node_exporter from package
#
# Install and manage node_exporter package and its pertinent permissions
#
#
# @example
#   include node_exporter::install_from_package
class node_exporter::install_from_package () {
  package {'prometheus-node-exporter':
    ensure => present,
  }
}
