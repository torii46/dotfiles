# cd if command is not found and is a name of directory.
setopt autocd

# Try cd with a leading '~' if the directory not found 
setopt cdablevars

# Always pushd when execute cd
setopt auto_pushd

# Ignore duplicates to add to pushd
setopt pushd_ignore_dups

# pushd $HOME when pushd no args
setopt pushd_to_home


# Move cursor to end when complete completion
setopt always_to_end

# Append '/' instead of ' ' when complete directory name
setopt auto_param_slash

# Start completion at cursor point
setopt complete_in_word

# Show file extension when complition
setopt list_types


# Enable 8bit
setopt print_eight_bit

# No Beep please
setopt no_beep
setopt no_list_beep
setopt no_hist_beep

# Expand 'command' as path of command
# e.g.) '=ls' -> '/bin/ls'
setopt equals

# Ignore case when glob
setopt no_case_glob

# Prevent overwrite prompt from output without cr.
setopt no_prompt_cr


# Share history
setopt share_history

# Record start and end
setopt extended_history

# Do not recode an event already recorded.
setopt hist_ignore_all_dups

# Ignore commands start with space to history.
setopt hist_ignore_space

# Reduce blanks of commands.
setopt hist_reduce_blanks

# Remove command of 'history' or 'fc -l' from history file
setopt hist_no_store

# Remove function declare from history file
setopt hist_no_functions

# Edit hitory file when call history before executing
setopt hist_verify
