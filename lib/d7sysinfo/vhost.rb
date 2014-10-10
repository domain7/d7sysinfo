module D7sysinfo
  class Vhost
    attr_accessor :lines
    attr_accessor :docroot
    attr_accessor :node
    attr_accessor :linux_type
    def initialize(platform)
      @linux_type = platform.downcase
      @node = {}
      Dir[vhost_path].each do |f|
        file = Pathname.new(f).basename.to_s
        @lines = []
        File.open(f, 'r') { |conf| conf.each_line { |l| @lines << l } }
        @node[file] = {
          ssl:       ssl,
          names:     names,
          docroot:   find_docroot,
          rails:     rails,
          drupal:    drupal,
          wordpress: wordpress,
          ee: ee
        }
      end
      @node
    end

    def names
      @lines.
        grep(/(ServerAlias|ServerName)/).join.
        gsub(/(ServerAlias|ServerName)/,'').
        split.sort.uniq.compact.join(',')
    end

    def ssl
      @lines.grep(/SSLCertificateFile/).size > 0
    end

    def find_docroot
      @docroot = @lines.grep(/DocumentRoot/).first.gsub(/DocumentRoot/,'').strip
    end

    def rails
      gemfile = @docroot.gsub(/public/,'').strip + "Gemfile.lock"
      File.file?(gemfile) && File.open(gemfile).grep(/^\s*rails .[0-9]/).first.strip
    end

    def drupal
      bootstrap = @docroot + "/includes/bootstrap.inc"
      system = @docroot + "/modules/system/system.info"
      if (File.file?(system))
        File.open(system).grep(/version = "[0-9\.]+"/).first.gsub(/[^0-9\.]/,'')
      elsif (File.file?(bootstrap))
        File.open(bootstrap).grep(/VERSION/).first.gsub(/[^0-9\.]/,'')
      else
        false
      end
    end

    def wordpress
      verfile = @docroot + "/wp-includes/version.php"
      File.file?(verfile) && File.open(verfile).grep(/^\$wp_version/).first.gsub(/[^0-9\.]/,'')
    end

    def ee
      verfile = @docroot + "/system/expressionengine/config/config.php"
      File.file?(verfile) && File.open(verfile).grep(/app_version/).first.gsub(/[^0-9]/,'')
    end

    def vhost_path
      case @linux_type
      when 'ubuntu'
        '/etc/apache2/sites-enabled/*.conf'
      when 'fedora'
        '/etc/httpd/conf.d/sites-enabled/*.conf'
      else
        'spec/fixtures/*.conf'
      end
    end
  end
end
