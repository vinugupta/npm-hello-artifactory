#!/bin/sh

if [ "$#" -eq "0" -o "$1" == "--build" -o "$1" == "-b" ]
then
	if [ -f package.json ]
	then
		name=$(grep name package.json| cut -f2 -d ":" | tr -d "\", ")
		#creates the tar file after creating relevant files
		mkdir ../package
		cp -rf * ../package/
		rm ../package/*.sh
		cd ..
		tar -zcvf $name.tgz package/
		rm -rf package/
		cd -
		mv ../$name.tgz .
		printf "$name.tgz has been created!\n"
	else
		echo "package.json doesn't exist in build source!"
	fi
elif [ "$1" == "--clean" -o "$1" == "-c" ]
then
	if [ -f package.json ]
	then
		name=$(grep name package.json| cut -f2 -d ":" | tr -d "\", ")
		if [ -f $name.tgz ]
		then
			rm rf $name.tgz
		else
			echo "$name.tgz doesn't exists in the directory!"
		fi
	else
		echo "package.json doesn't exist in build source!"
	fi
elif [ "$1" == "--help" ]
then
        printf "Usage: bash npm-packer.sh [option]\n"
        printf "Possible options:\n"
        printf " --build \tIt builds the package this is the default option\n"
        printf "\t\tAlternatively -b can be used\n"

        printf " --clean \tIt cleans the latest tar file that was built using this packer\n"
        printf "\t\tAlternatively -c can be used\n"
else
	printf "Usage: bash npm-packer.sh [option]\n"
	printf "Possible options:\n"
	printf " --build \tIt builds the package this is the default option\n"
	printf "\t\tAlternatively -b can be used\n"

	printf " --clean \tItcleans the latest tar file that was built using this packer\n"
        printf "\t\tAlternatively -c can be used\n"
fi
