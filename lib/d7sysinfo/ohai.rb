module D7sysinfo
  require 'ohai'
  class Ohai
    attr_accessor :node
    def initialize
      sys = ::Ohai::System.new
      sys.all_plugins
      @node = {
        ruby_version:   sys[:languages][:ruby] && sys[:languages][:ruby][:version],
        php_version:    sys[:languages][:php] && sys[:languages][:php][:version],
        kernel_version: sys[:kernel][:release],
        linux_type:     sys[:lsb][:id],
        linux_version:  sys[:lsb][:release],
        fqdn:           sys[:fqdn],
        memory:         sys[:memory][:total],
        ips:            ( sys[:network][:interfaces].map { |k,v| v[:addresses].map {|key,val| key if val[:family] == 'inet' } }).flatten.compact,
      }
    end
  end
end
