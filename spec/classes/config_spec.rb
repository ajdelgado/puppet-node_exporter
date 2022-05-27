# frozen_string_literal: true

require 'spec_helper'

describe 'node_exporter::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          options: '--web.listen=:9100'
        }
      end

      it { is_expected.to contain_file('/etc/default/node_exporter') }
    end
  end
end
