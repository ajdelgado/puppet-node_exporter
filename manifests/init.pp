# @summary manage node_exporter
#
# Install, configure and manage node_exporter
#
# @param version
#   version of the software to install, configure and manage
#
# @param flavor
#   architecture of the destination server where the binary will be installed
#
# @example defaults
#   class { 'node_exporter':
#     version => '1.3.1',
#     flavor  => 'linux-amd64',
#   }
class node_exporter (
  String $version,
  String $flavor,
){

  include node_exporter::config
  class { 'node_exporter::install':
    package_version => $version,
    package_flavor  => $flavor,
  }

  class { 'node_exporter::service':
    node_exporter_version => $version,
    node_exporter_flavor  => $flavor,
  }

  Class[node_exporter::install]
  -> Class[node_exporter::config]
  -> Class[node_exporter::service]
}
