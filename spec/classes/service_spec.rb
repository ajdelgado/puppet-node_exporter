# frozen_string_literal: true

require 'spec_helper'

describe 'node_exporter::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          node_exporter_install_path: '/opt',
          node_exporter_version: '1.3.1',
          node_exporter_flavor: 'linux-amd64',
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
