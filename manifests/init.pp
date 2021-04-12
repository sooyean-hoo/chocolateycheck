# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include chocolateycheck
class chocolateycheck {
#   include chocolatey
#   Package { provider => chocolatey, }
#   package { '7zip.install':
#     ensure   => 'installed',
#   }

  $resources_home = 'http://puppet.ccccc.ccc.aus/resources'
  	$proxy_host = 'someproxy.ccccc.ccc.aus'  # some things want it like this
	$proxy_port = '8080'
	$proxy = "http://${proxy_host}:${proxy_port}/"
	$host_tz = 'Australia/Brisbane'

  # we don't seem to be able to configure a proxy for the installation of Chocolatey itself :-(
  class {'chocolatey':
    chocolatey_download_url => "${resources_home}/misc/chocolatey.0.10.11.nupkg",
    log_output              => true,
  }
  chocolateyconfig {'proxy':
    ensure  => 'present',
    value   => $proxy,
    require => Class['chocolatey'],
  }

  # sets default Package provider on windows to chocolatey NOT windows default (whatever that was)
  Package{
    provider => 'chocolatey',
  }
}