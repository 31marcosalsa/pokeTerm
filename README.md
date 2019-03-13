# pokeTerm
Just for fun and to remember the good old days.

![Minion](https://raw.githubusercontent.com/31marcobarbosa/pokeTerm/master/desktop.png?token=AR0VTE0eOmLpQ6SlAe_0oD3rKswFgC1Nks5ckkm6wA%3D%3D)

### Description
Shell script that shows a random pokémon everytime a new terminal window is opened.

Currently with 7 Gens, meaning 800+ pokémons. Just run the script from time to time to check if there are new updates. 

### Installation
Tested on a *Linux* environment using *zsh* as the Unix shell.
+ Run the python script `getPokes.py`.
  + You will be prompt to enter a path to download some images.
+ Place `pokeTerm.sh` where you want in your computer.
+ Add this line to your `.zshrc` :
  + `/path_to_pokeTerm.sh/ /path_to_downloaded_images/`

  + for example: `/usr/bin/pokeTerm.sh /usr/share/pokemons` 

### Dependencies
Besides the modules in python that need to be installed to run the script, it should also be installed:
+ `img2xterm`
+ `lolcat`

### Notice
Pokémon is property of [The Pokémon Company](https://en.wikipedia.org/wiki/The_Pok%C3%A9mon_Company).
