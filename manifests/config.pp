# @summary node_exporter options
#
# Create a configuration file for the unit file to use
#
# @param options
#   options to pass to the execution of the binary by the system
#
# @example
#   include node_exporter::config
class node_exporter::config (
  String $options,
){
  file { '/etc/default/node_exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => epp('node_exporter/node_exporter.epp', {
      'options' => $options,
    }),
  }
}
