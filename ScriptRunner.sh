choice=$(ls $HOME/Scripts | sed '/ScriptRunner.sh/d' | sed '/.sh/!d' |  sed 's/.sh//' | dmenu -sb "#775577" )
./Scripts/$choice.sh
