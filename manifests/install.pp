# @summary Install node_exporter
#
# Install and manage node_exporter binary and its pertinent permissions
#
# @param install_path
#   path to where the package will be extracted
#
# @param package_name
#   name of the extracted package
#
# @param package_flavor
#   architecture of the binary
#
# @param package_version
#   version of the binary to download
#
# @param checksum
#   archive file checksum (match checksum_type)
#
# @param checksum_type
#   archive file checksum type (none|md5|sha1|sha2|sha256|sha384| sha512)
#
# @param repo_url_base
#   base to build the final url
#
# @param manage_user
#   should a especial user be created for node_exporter to run as
#
# @param username
#   username to be created
#
# @param package_ensure
#   full name of the final package
#
# @param repo_url
#   URL prefix for the tarballed package
#
# @param archive_name
#   name of the tarball after download
#
# @param package_source
#   source of the package to be downloaded
#
# @param from_package
#   install from operating system package manager
#
# @example
#   include node_exporter::install
class node_exporter::install (
  Stdlib::Absolutepath $install_path,
  String $package_name,
  String $package_flavor,
  String $package_version,
  String $package_checksum,
  String $checksum_type,
  String $repo_url_base,
  Boolean $manage_user,
  String $username = 'prometheus',
  String $package_ensure             = "${package_version}.${package_flavor}",
  String $repo_url                   = "${repo_url_base}${package_version}",
  String $archive_name               = "${package_name}-${package_ensure}.tar.gz",
  String $package_source             = "${repo_url}/${archive_name}",
  Boolean $from_package              = false,
){
  if ($from_package) {
    include node_exporter::install_ubuntu
  } else {
    include 'archive'

    archive { $archive_name:
      path          => "/tmp/${archive_name}",
      source        => $package_source,
      extract       => true,
      extract_path  => $install_path,
      checksum      => $package_checksum,
      checksum_type => $checksum_type,
      creates       => "${install_path}/${package_name}-${package_ensure}",
      cleanup       => true,
    }

    if $manage_user {
      user { $username:
        ensure     => present,
        shell      => '/sbin/nologin',
        home       => "${install_path}/${package_name}-${package_ensure}",
        managehome => false,
        require    => Archive[$archive_name],
      }
    }

    file { "${install_path}/${package_name}-${package_ensure}":
      ensure  => directory,
      recurse => true,
      owner   => $username,
      group   => $username,
      require => Archive[$archive_name],
    }

    class { 'node_exporter::service':
      node_exporter_install_path => $install_path,
      node_exporter_version      => $package_version,
      node_exporter_flavor       => $package_flavor,
    }

  }
}
