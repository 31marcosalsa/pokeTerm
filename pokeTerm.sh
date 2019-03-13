
# Given a string, it centers it on the width of the terminal window.
function center_window_text {
     [[ $# == 0 ]] && return 1

     declare -i TERM_COLS="$(tput cols)"
     declare -i str_len="${#1}"
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}

# Reads a given directory.
DIR=$@

# Internal Field Separator set to newline, so file names with spaces do not break script.
IFS='
'

# Pick a random pokemon image.
if [[ -d "${DIR}" ]]
then
  # Runs ls on the given dir, and dumps the output into a matrix,
  # it uses the new lines character as a field delimiter, as explained above.
  file_matrix=($(ls "${DIR}"))
  num_files=${#file_matrix[*]}

  # Pick the name of a pokemon image randomly.
  poke_image=${file_matrix[$((RANDOM%num_files))]}

  # Get the name of the pokemon from its image name
  poke_name="${poke_image%.*}"

  # Get half of the terminal window width.
  bash_half_width=$(( $(tput cols) / 2 ))
  
  # Get half of the picked pokemon image width.
  poke_image_half_width=$(( $(identify -format "%w" "${DIR}/$poke_image") / 2 ))
  
  # Calculates the offset from the left of the terminal window
  # that makes the image centered on it.
  offset_center_image=$(( $bash_half_width - $poke_image_half_width ))

  # Display the desired elements.
  echo -e "\n\n\n"
  img2xterm -m $offset_center_image "${DIR}/$poke_image"
  echo -e "\n"
  center_window_text "Wild $poke_name appeared!" " " | lolcat
fi

exit 0