# Example HTTP server to use with CMS for custom email templates

This is a simple example of an HTTP server that can be used to serve custom email templates to a Cisco Meeting Server that uses call branding profiles invitationTemplate option.

This repository is a fork of [spujadas/lighttpd-docker](https://github.com/spujadas/lighttpd-docker) created by [Sébastien Pujadas](http://pujadas.net).

## Simple Usage

	# Build container from this repository
	docker build github.com/ciscocms/lighttpd-docker -t example-http-invites

	# Run HTTP server in port 9999 mapping current folder for custom email template files
	docker run -d -t -v $(pwd):/invites -p 9999:80 example-http-invites

	# Create Spanish from Spain template
	echo Ejemplo > invitation_template_es_ES.txt

	# Server side script parses query string to work out which file content to return
	curl 'http://localhost:9999/invitation.sh?language=es_ES'
	Ejemplo

	# If not found and not default invitation_template.txt is provided it should return 404
	curl 'http://localhost:9999/invitation.sh?language=es_MX'
	Status: 404 (Not Found)

	# Create default generic invite that will be used for any unknown requested languages
	echo Generic Invite > invitation_template.txt
	curl 'http://localhost:9999/invitation.sh?language=es_MX'
	Generic Invite

## How it works

It runs a shell CGI script in the server side that processes the query string ?language=xx_XX and checks if the appropriate invitation_template file exists in /invites folder.

You can check and modify this script easily by forking this repository and modify [invitation.sh](/invitation.sh).

For more details on how to use the docker image check the original repository: [spujadas/lighttpd-docker](https://github.com/spujadas/lighttpd-docker)

For more information about Cisco Meeting Server check release notes and guides [here](https://www.cisco.com/c/en/us/support/conferencing/meeting-server/products-release-notes-list.html).

