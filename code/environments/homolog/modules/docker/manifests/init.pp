class docker {

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

	$pacotesRemover = ["docker", "docker-engine" ,"docker.io"]
	$pacotesGenericos = ["apt-transport-https","ca-certificates","software-properties-common"]


	package { $pacotesRemover:
		ensure => absent
	}

	package { $pacotesGenericos:
        	ensure => present
        }

	exec { 'add_docker_gpg_key':
		command => "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",		
		path => '/usr/local/bin:/usr/bin'
	}

        exec { 'add_docker_repo':
                command => 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"',
		path => '/usr/local/bin:/usr/bin'
        }	

	package { docker-ce:
		ensure => present
	}
}
