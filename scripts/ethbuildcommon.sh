#!/bin/bash
# author: Lefteris Karapetsas <lefteris@refu.co>
#
# Some common functionality to be used by ethupdate and ethbuild

PROJECTS_HELP="    --project NAME            Will only clone/update/build repos for the requested project. Valid values are: [\"all\", \"cpp-ethereum\", \"webthree\", \"solidity\", \"alethzero\", \"mix\"]."
CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree solidity alethzero mix)
BUILD_REPOSITORIES=(cpp-ethereum webthree solidity alethzero mix)

function set_repositories() {
	if [[ $1 == "" || $2 == "" ]]; then
		echo "ETHBUILD - ERROR: get_repositories() function called without the 2 needed arguments."
		exit 1
	fi
	REQUESTER_SCRIPT=$1
	REQUESTED_PROJECT=$2
	case $REQUESTED_PROJECT in
		"all")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree solidity alethzero mix)
			BUILD_REPOSITORIES=(cpp-ethereum webthree solidity alethzero mix)
			;;
		"cpp-ethereum")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests)
			BUILD_REPOSITORIES=(cpp-ethereum)
			;;
		"webthree")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree)
			BUILD_REPOSITORIES=(cpp-ethereum webthree)
			;;
		"solidity")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree solidity)
			BUILD_REPOSITORIES=(cpp-ethereum webthree solidity)
			;;
		"alethzero")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree solidity alethzero)
			BUILD_REPOSITORIES=(cpp-ethereum webthree solidity alethzero)
			;;
		"mix")
			CLONE_REPOSITORIES=(cpp-ethereum cpp-ethereum-cmake tests webthree solidity mix)
			BUILD_REPOSITORIES=(cpp-ethereum webthree solidity mix)
			;;
		*)
			echo "${REQUESTER_SCRIPT} - ERROR: Unrecognized value \"${REQUESTED_PROJECT}\" for the --project argument."
			exit 1
			;;
	esac
}
