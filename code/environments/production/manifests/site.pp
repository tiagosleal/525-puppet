node "default" {	
	include config
	include base
}

node "docker.dexter.com.br" {
	include docker
}
