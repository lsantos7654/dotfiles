# Quick overview:
# - dls: lists active & stopped containers
# - dils: list images
# - dsh <container>: starts a session to a container
# - dkill <container>: stops a container
# - drm <container>: removes a container
# - dcommit <container>: wraps 'docker commit'; Create a new image from a container’s changes
# - drunning <container>: checks if a container is running
#
# note: <container> could be either the container ID or the container's name.
# It is usually more convenient to just type the first few characters of the
# container's ID hash.

#### General utilities
function color_echo {
	echo -e "${1}${2}${NC}"
}

# colors for echo
export YELLOW='\033[0;33m'
export RED='\033[0;31m'
export BROWN='\033[0;33m'
export BLUE='\033[0;34m'
export GREEN='\033[0;32m'
export GRAY='\033[0;37m'
export CYAN='\033[0;36m'
export LYELLOW='\033[1;33m'
export LRED='\033[1;31m'
export LBLUE='\033[1;34m'
export LGREEN='\033[1;32m'
export LGRAY='\033[1;37m'
export LCYAN='\033[1;36m'
export NC='\033[0m' # No Color
export BOLD='\033[1;0m'
export NORMAL='\033[0;0m'

#### Docker utilities ####
function dls {
	# Function to colorize output, assuming 'color_echo' is defined elsewhere
	color_echo "$LBLUE" "Active docker containers:"
	docker container ls
	echo -e ""

	color_echo "$LYELLOW" "Stopped docker containers:"
	docker ps --filter "status=exited"
	echo -e ""

	color_echo "$RED" "Other docker containers:"
	docker ps --filter "status=created" --filter "status=paused" --filter "status=restarting"
}

function dzsh {
	if [ "$#" -ne 1 ]; then
		echo -e "Usage: dsh <container>"
	else
		# Starts a session to a container
		if ! drunning $1; then
			docker restart $1
		fi
		# docker exec -it $1 /usr/bin/zsh
		docker exec -it -u $(whoami) $1 /usr/bin/zsh
	fi
}

function drunning {
	# check if a container is running
	if [[ "$(docker container inspect -f '{{.State.Status}}' $1)" == "running" ]]; then
		return 0
	else
		return 1
	fi
}

function dim {
	# List images
	color_echo "$LGRAY" "List of docker images:"
	docker images
}

function dkill {
	# stop a container
	if [ "$#" -ne 1 ]; then
		echo -e "Usage: dkill <container>"
	else
		if drunning $1; then
			docker kill $1
		else
			echo -e "Container $1 is not running."
		fi
	fi
}

function drm {
	# remove a container
	if [ "$#" -ne 1 ]; then
		echo -e "Usage: drm <container>"
	else
		docker rm $1
	fi
}

function dcommit {
	# creates a new image from a container’s changes
	if [ "$#" -ne 2 ]; then
		echo -e "Usage: dcommit <container> <image_name>"
	else
		if ! drunning $1; then
			docker commit $1 $2
		else
			echo -e "Unable to commit. The container $1 is still running. Stop it first."
		fi
	fi
}
