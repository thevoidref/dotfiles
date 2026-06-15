#!/usr/bin/env fish

set SCRIPT_DIR "$HOME/.dotfiles/scripts"

if not test -d "$SCRIPT_DIR"
    echo "Error: Directory $SCRIPT_DIR does not exist"
    exit 1
end

set script_list ""

for script in (find "$SCRIPT_DIR" -maxdepth 1 -type f -executable | sort)
    set name (basename "$script")
    
    # Skip .fish files
    if string match -q "*.fish" "$name"
        continue
    end
    
    # Add icon based on file type
    set icon "📜"
    if string match -q "*.py" "$name"
        set icon "🐍"
    else if string match -q "*.sh" "$name"
        set icon "🐚"
    else if string match -q "*.lua" "$name"
        set icon "🌙"
    end
    
    # Get description
    set desc (grep -m 1 '^#' "$script" | grep -v '^#!/' | sed 's/^# //')
    
    if test -n "$desc"
        set script_list "$script_list$icon $name - $desc\n"
    else
        set script_list "$script_list$icon $name\n"
    end
end

if test -z "$script_list"
    echo "No non-fish executable scripts found in $SCRIPT_DIR"
    exit 1
end

set selected (echo -e "$script_list" | fuzzel --dmenu --prompt="Run script: " --lines 15 | awk '{print $2}')

if test -n "$selected"
    "$SCRIPT_DIR/$selected" &
end