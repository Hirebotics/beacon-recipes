# Advanced Functionality

Advanced functionality in this repository will allow you to take more actions with the script code in this repo such as run it directly in an IDE or load the files directly to a networked robot.

To get started we need to install a few dependencies

- Install [`nodejs`](https://nodejs.org/en/download/)
- Install [`docker`](https://www.docker.com/products/docker-desktop)
- Clone [`Beacon Custom Event Recipes`](https://github.com/Hirebotics/beacon-recipes.git)


```bash
git clone https://github.com/Hirebotics/beacon-recipes.git
cd beacon-recipes
npm i
```

To deploy the scripts directly to a robot that is connected over the network you can use either:
```bash
npm run deploy --i=192.168.1.1 #Insert the actual robot address here
```

or you can run the tool directly from the command terminal which gives you more control

```bash
./tools/deploy -i 192.168.1.1
```

If you want to simply build the files to be used on the simulator or to load onto the robot using a USB stick you can run the deploy command with the `-s` or `--simulator-only` flag option. Using this you can also specify an output directory on your computer if you want the files stored somewhere other than in the repository folder using the `-o` or `--output-dir` flag.

## Testing and Script Runner

To learn more about the test suite that can be used while developing the scripts or the script runner that can be used to run scripts directly in the IDE on your computer without needing a robot you can find more information [here](https://github.com/Hirebotics/urscript-tools)