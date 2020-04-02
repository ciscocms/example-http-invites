# Example HTTP server to use with CMS for custom email templates

This is a simple example of an HTTP server that can be used to serve custom email templates to a Cisco Meeting Server that uses call branding profiles invitationTemplate option.

This repository is a fork of [spujadas/lighttpd-docker](https://github.com/spujadas/lighttpd-docker) created by [Sébastien Pujadas](http://pujadas.net).

## Simple Usage

	# Build container from this repository
	docker build github.com/ciscocms/example-http-invites -t example-http-invites

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

## Disclaimer

This project is only meant as an example of how to parse CMS requests about invitation templates and it will most likely won’t fit your deployment needs in terms or security, scalability and performance.

We don’t recommend its use in production systems and we don't provide support for it.

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

