<h1 align="center"> Beacon Custom Event Recipes</h1>

<h2 align="center"> A set of preconfigured recipes to publish custom events on your Beacon powered robot</h2>


## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Documentation](#documentation)
    - [Made a Part](#made-a-part)
    - [Production Stoppage](#production-stoppage)

## Overview

Beacon is a powerful platform for monitoring your Universal Robot cobot.  With the new custom event API you can now send up meaningful messages and metrics directly from the robot to your Beacon instance.

Beacon Recipes aims to make creating custom events easier by providing preconfigured scripts that you can use within your Polyscope program directly on the touch screen.  Using the URScript Tools package you can now bundle all of the recipes into a single file and if connected to your robot over the network push the bundled file directly to the robot.  Then you can simply call the functions from either Polyscope using the Script feature or within other URScript files.

## Quick Start

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

## Documentation

### Made a Part
  This is a good recipe to use when you want to track part production over the course of the day.  This script has optional parameters for sending in the `Part Number`, `Cycle Time` and a custom message that you want tagged in the event.  If you do not provide those values the `Part Number` will be set to an empty string and the `Cycle Time` will be set to a value of 0.

  #### Example Usage:
  ```
  beacon_partMade(1, 12.34, "PRT-00123", "Made part from machine 1234")
  ```

![img](./docs/images/partMadePolyscope.png)

#### Example of Charting Results

![img](./docs/images/partMadeMetrics.png)


### Production Stoppage

This is a recipe to use when you want to monitor work stoppages.  It will send a notification and also pop onto the screen the information for the operator on what needs to be addressed.  It also takes an optional second message that will be displayed once the operator acknowledges the situation.  The function automatically logs the amount of time it takes from when the stoppage occurs until the operator acknowledges the situation.

#### Example Usage
```
beacon_stoppage("Out of parts, please load more then press continue", "Parts have been reloaded")
```

#### Example Polyscope Program

![img](./docs/images/stoppagePolyscope.png)