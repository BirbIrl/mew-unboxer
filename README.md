# Mewgenics unpacker for mewbox
This script translates some of mewgenic's `gon`, `swf` and `csv` data into `svg` and `json`'s for use on the web


### Required dependencies: 
- [ffdec](https://github.com/jindrapetrik/jpexs-decompiler)
- UNIX compatible environment (sorry **Windows** users, you'll need wsl. probably. you're on your own.)

### Running:
1. unpack the game using [GPAK-Extractor](https://github.com/ShootMe/GPAK-Extractor) (Works just fine through wine)
2. run the lua script

---

note that this script is only for usage in [mewbox](https://github.com/birbirl/mewbox). Data is often skipped/dropped/transformed as needed.

for now shells are generated half-manually from the assets in `static`. this is due to them needing to be tweaked to allow stacking and recoloring
