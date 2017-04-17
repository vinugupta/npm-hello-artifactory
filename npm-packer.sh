#!/bin/sh


## Not the best packer/helper script but it does the job
## It packs the the files into a tar with the right folder structure
## It also cleans any temporary files and even the tar file as long as the files haven't been moved or renamed
## It basically deletes the file which it built, so if there is any file that has the names of the files this script created, it WILL be deleted if cleaning using this scipt, so beware!


#Check if option is build or not, not using getops or getopt here
if [ "$#" -eq "0" -o "$1" == "--build" -o "$1" == "-b" ]
then
	if [ -f package.json ]  # Checking is package.json, which is essential for an npm package is present or not
	then
		name=$(grep name package.json| tr -d "\", " | cut -f2 -d ":")  #retreives name from package.json
		echo $name
		#creates the tar file after creating relevant files
		mkdir ../package
		cp -rf * ../package/
		rm ../package/*.sh
		cd ..
		tar -zcvf $name.tgz package/
		rm -rf package/  #removing the folder created while making the tar file
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
		name=$(grep name package.json| tr -d "\", " | cut -f2 -d ":")  #retreives name from package.json
		if [ -f $name.tgz ]
		then
			rm -rf $name.tgz  #Attemps to delete the tar file that this script created, deleted it only if it hasn't been renmaed or moved
			if [ "$?" -eq 0 ]
			then
				echo "$name.tar.gz has been removed"
			else
				echo "Some error occured while attempting to delete $name.tar.gz"
			fi
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
