require "d7sysinfo/version"
require "d7sysinfo/ohai"
require "d7sysinfo/vhost"

module D7sysinfo
  class Base
    attr_accessor :node

    def initialize()
      @node = D7sysinfo::Ohai.new.node
      @node[:vhosts] = D7sysinfo::Vhost.new(@node[:linux_type]).node
    end
  end
end
