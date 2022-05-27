# frozen_string_literal: true

require 'spec_helper'

describe 'node_exporter::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          package_version: '1.3.1',
          package_flavor: 'linux-amd64',
        }
      end

      it { is_expected.to compile }
    end
  end
end
