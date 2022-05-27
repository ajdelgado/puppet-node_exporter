#### node_exporter

1. [Overview](#overview)
1. [Requirements](#requirements)
1. [Usage](#usage)
    - [Basic usage](#basic-usage)
    - [Choosing a version](#choosing-a-version)
    - [Customization](#customization)
    - [Using Hiera](#using-hiera)
1. [Development](#development)
    - [Contributing](#contributing)

## Overview

A puppet module for setting up the [Prometheus node_exporter](https://prometheus.io/docs/guides/node-exporter/#node-exporter-metrics) service

## Requirements

Although there are no specific requiremets, it worth noting that node_explorer by itself might be useless without a [Prometheus](https://prometheus.io/docs/prometheus/latest/getting_started/) server. There are modules ready in the forge for it, therefore it is out of the scope of this one.

## Usage

### Basic usage

This example would install and configure node_exporter for you, then create a service in systemd to manage it.

```puppet
    class { 'node_exporter': }
```

### Choosing a version

To select a different version than default versions (please check `data/commons.yaml` for more information), you must provide the version number you want installed, and the correspoding checsum. 

```puppet
    class { 'node_exporter':
      version       => '1.3.1',
    }
    class { 'node_exporter::install':
      checksum      => '68f3802c2dd3980667e4ba65ea2e1fb03f4a4ba026cca375f15a0390ff850949',
      checksum_type => 'sha256',
    }
```

### Customization

Change default values, like for example the destination of the binary after extraction

```puppet
    class { 'node_exporter':
      version       => '1.3.1',
    }

    class { 'node_exporter::install':
      install_path  => '/usr/local/bin',
      checksum      => '68f3802c2dd3980667e4ba65ea2e1fb03f4a4ba026cca375f15a0390ff850949',
      checksum_type => 'sha256',
    }
```


### Using Hiera

You're encouraged to define your configuration using Hiera.

```yaml
node_exporter::version: '1.3.0'
node_exporter::install::checksum: '68f3802c2dd3980667e4ba65ea2e1fb03f4a4ba026cca375f15a0390ff850949'
node_exporter::install::checksum_type: 'sha256'
```

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.

Contributions must pass all existing tests, new features should provide additional unit/acceptance tests.


