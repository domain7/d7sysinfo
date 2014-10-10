# D7sysinfo

Domain 7 Solutions system information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'd7sysinfo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install d7sysinfo

## Usage

```ruby
d7sysinfo --format json
```

Will output following server information:

```json
{
    "fqdn": "example.com",
    "ips": [
        "127.0.0.1",
        "10.8.8.99",
        "192.168.0.99"
    ],
    "kernel_version": "3.08",
    "linux_type": "Fedora",
    "linux_version": "18",
    "memory": "1000000kB",
    "php_version": "4.5",
    "ruby_version": "1.8.2",
    "vhosts": {
        "drupal.conf": {
            "docroot": "/var/www/drupal/",
            "drupal": "1.1.1",
            "names": "drupal.example.com",
            "rails": false,
            "ssl": false,
            "wordpress": false
        },
        "rails.conf": {
            "docroot": "/var/www/rails/public/",
            "drupal": false,
            "names": "rails.example.com",
            "rails": "rails (2.14)",
            "ssl": true,
            "wordpress": false
        },
        "wordpress.conf": {
            "docroot": "/var/www/wordpress/",
            "drupal": false,
            "names": "wordpress.example.com",
            "rails": false,
            "ssl": false,
            "wordpress": "7.7.7"
        }
    }
}
```

## Prerequisites
 * uri
 * net
 * rexml

## Contributing

1. Fork it ( https://github.com/[my-github-username]/d7sysinfo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


# References
* [Domain7](http://www.domain7.com)

Released under the GPLv3 license

Copyright (c) 2014 [Domain7](http://www.domain7.com)
