
# Trims the pokemon images stored on the given directory.
for poke_image in $@
do
	convert -trim "$poke_image" "$poke_image"
done

