class docker {

	$pacotesRemover = ["docker", "docker-engine" ,"docker.io"]
	$pacotesGenericos = ["apt-transport-https","ca-certificates","software-properties-common"]
	$distroCode = $facts['os']['distro']['codename']

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
                command => 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $distroCode stable ; apt update"',
		path => '/usr/local/bin:/usr/bin'
        }	

	package { docker-ce:
		ensure => present
	}

	service {'docker':
		ensure => running,
		enable => true
	}			
}
