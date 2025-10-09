# Opens a global TODO nvim file and daily TODO nvim file on i3 workspace #1

# Create dirs/files if not exists
if [ ! -d "$HOME/Documents/" ]; then 
	mkdir "$HOME/Documents/"
fi

if [ ! -d "$HOME/Documents/notes/" ]; then
	mkdir "$HOME/Documents/notes/"
fi

if [ ! -d "$HOME/Documents/notes/planning/" ]; then
	mkdir "$HOME/Documents/notes/planning/"
fi

main_todo_path="$HOME/Documents/notes/planning/todo.md"

if [ ! -f "$main_todo_path" ]; then
	echo "# TODO" > "$main_todo_path"
fi

# create date variables
year=$(date -u +%Y)
week=$(date -u +%V)
day=$(date -u +%d)
echo $year
echo $week
echo $day

year_path="$HOME/Documents/notes/planning/${year}"

if [ ! -d "$year_path" ]; then
	mkdir "$year_path"
fi

week_path="$HOME/Documents/notes/planning/${year}/${week}"

if [ ! -d $week_path ]; then
	mkdir "$week_path"
fi

daily_todo_path="$HOME/Documents/notes/planning/${year}/${week}/planning_${day}.md"

if [ ! -f "$daily_todo_path" ]; then
	printf "# TODO\n\n# Done" > "$daily_todo_path"
fi

i3-msg "workspace 1" > /dev/null 2>&1

# because nvim can open files that dont exist yet, do not have to create a file for it
i3-msg "exec i3-sensible-terminal -e nvim \"$daily_todo_path\""
i3-msg "exec i3-sensible-terminal -e nvim \"$main_todo_path\""
