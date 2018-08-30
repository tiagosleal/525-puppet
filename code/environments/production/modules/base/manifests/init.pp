class base {

	case $::osfamily {

		"RedHat": {
			$pacotes = ["epel-release","git","vim","sl","figlet","cowsay","nmap"]
			$web = "httpd"
		}

		"Debian": {
			$pacotes = ["git","vim","sl","figlet","cowsay","htop"]
			$web = "apache2"			
		}		
	}

	package { $pacotes:
		ensure => present,
	}

	file { "/root/.bashrc":	
		source => "puppet:///modules/base/bashrc_base",
		ensure => present
	}
}
