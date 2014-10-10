require 'spec_helper'
describe D7sysinfo::Ohai do
  before(:all) do
    module ::Ohai
      class System
        def initialize
        end
        def all_plugins
          @data = {
            languages: {
              ruby: { version: '1.8.2' },
              php: { version: '4.5.1' },
            },
            kernel: { release: '2.27.3-200.test5.x86_64' },
            lsb: {
              id: 'test',
              release: '5'
            },
            fqdn: 'example.com',
            memory: { total: '8356036kB' },
            network: {
              interfaces: {
                lo: { addresses: { '127.0.0.1' => { family: 'inet' } } },
                eth0: { addresses: { '192.205.0.1' => { family: 'inet' } } },
                eth1: { addresses: { '10.10.0.5' => { family: 'inet' } } }
              }
            }
          }
        end
      end
    end
  end

  subject { D7sysinfo::Ohai.new.node }
  it { expect(subject[:ruby_version]).to eq '1.8.2' }
  it { expect(subject[:php_version]).to eq '4.5.1' }
  it { expect(subject[:kernel_version]).to eq '2.27.3-200.test5.x86_64' }
  it { expect(subject[:linux_type]).to eq 'test' }
  it { expect(subject[:linux_version]).to eq '5' }
  it { expect(subject[:fqdn]).to eq 'example.com' }
  it { expect(subject[:memory]).to eq '8356036kB' }
  it { expect(subject[:ips]).to eq ["127.0.0.1", "192.205.0.1", "10.10.0.5"] }
end
