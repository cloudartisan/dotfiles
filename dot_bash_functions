# View any man page as a nicely-formatted PDF in Preview.app with
# woman! :)
#
# $ woman grep
# $ woman find
# $ woman ruby
# $ woman man
function woman {
  man -t "${1}" | open -f -a /Applications/Preview.app/
}

# Pretty man pages
function pman() {
	man $1 -t | open -f -a Preview
}

# Pretty JSON
function pj() {
	python -mjson.tool
}
