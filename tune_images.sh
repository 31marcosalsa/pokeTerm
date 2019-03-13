
# Trims the pokemon images stored on the given directory.
# Should be in the same dir as getPokes.py
for poke_image in $@
do
	convert -trim "$poke_image" "$poke_image"
done

