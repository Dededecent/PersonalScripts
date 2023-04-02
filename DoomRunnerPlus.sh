#!/usr/bin/env bash
#an updated version of crispy doom runner that allows for choosing between multiple source ports as well as using a json file


# paths
declare DoomWadsPath=$HOME/DoomWads
declare SourcePortsToml=$DoomWadsPath/SourcePorts.toml
declare WadsToml=$DoomWadsPath/Wads.toml
num=1
declare -a LaunchOptionsArray=(
)


# Actual Code
WadChoice=$(tomlq 'keys' $WadsToml | tr -d '[]", ' | sed -r '/^\s*$/d' | dmenu -sb "#775577")
SourcePortChoice=$(tomlq ".$WadChoice[1]" $WadsToml | sed '/false/d' | tr -d '{}",: ' | sed -r '/^\s*$/d' | sed 's/true//' | dmenu -sb "#775577")
WadType=$(tomlq ".$WadChoice[0].Type" $WadsToml | tr -d '"')
WadPath=$(tomlq ".$WadChoice[0].Path" $WadsToml | tr -d '"')
#temporary fix
LaunchOptions=$(dmenu -sb "#775577" < /dev/null)

case $SourcePortChoice in
	"CrispyDoom")
		crispy-doom -iwad $DoomWadsPath/$WadPath $LaunchOptions
	;;
	"PrBoomPlus")
		prboom-plus -iwad $DoomWadsPath/$WadPath $LaunchOptions
	;;
	"GZDoom")
		if [ "$WadType" == "PK3" ]; then
			gzdoom -iwad $DoomWadsPath/DOOM2.WAD -file $DoomWadsPath/$WadPath $LaunchOptions
		else
			gzdoom -iwad $DoomWadsPath/$WadPath $LaunchOptions
		fi
	;;
	"CrispyHexen")
		crispy-hexen -iwad $DoomWadsPath/$WadPath $LaunchOptions
	;;
	"CrispyHeretic")
		crispy-heretic -iwad $DoomWadsPath/$WadPath $LaunchOptions
	;;
esac
