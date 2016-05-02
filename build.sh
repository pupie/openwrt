#!/bin/bash
git checkout cc4530
git stash
git checkout chaos_calmer
git pull origin chaos_calmer
git checkout cc4530
git merge chaos_calmer
./scripts/feeds update -a
rm -rf ./feeds/packages/libs/libsodium
rm -rf ./feeds/packages/net/dnscrypt-proxy
./scripts/feeds install -a
#read -n1 -p "Press any key to update custom packages..."

#update git submodule packages
git submodule foreach git pull origin master
#read -n1 -p "Press any key to continue..."
git stash pop

make defconfig

echo "Make clean? Please answer yes or no."
read YES_OR_NO
case "$YES_OR_NO" in
	yes|y|Yes|YES)
		make clean
		make V=99 -j 5
	;;
	
	[nN]*)
		echo "DO NOT make clean!"
		make V=99 -j 5
	;;

	*)
		echo "Sorry, $YES_OR_NO not recognized. Enter yes or no."
		exit 1
	;;
esac




