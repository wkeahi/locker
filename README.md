# locker

Locker (l[ichess in d]ocker) is a Docker development setup for [lila](https://github.com/ornicar/lila). Particularly, locker is focused on developing lila using Visual Studio Code. Locker will gladly run without it but extra files are present (in this repo, not in the containers) for this setup.

# Requirements

* Git
* Docker

Optional:
* Visual Studio Code
* [Visual Studio Code Remote - Containers extension](https://code.visualstudio.com/docs/remote/containers)

# Installation

Clone this repository.

    git clone https://github.com/wkeahi/locker.git
    
After this, there are a few more steps. You can run `setup.sh`in this directory to run the remaining steps in this section.
  
Inside your local folder for this repo, clone lila.

    git clone --recursive https://github.com/ornicar/lila.git
  
Inside your local folder for this repo, clone lila-ws.

    git clone https://github.com/ornicar/lila-ws.git

Unfortunately, Metals requires `build.sbt` to be in the root. This will mean a few manual steps will be necessary. 

Create a `.vscode` directory in `lila`.

    mkdir lila/.vscode

Copy `settings.json` to this new folder.

    cp settings.json lila/.vscode/
    
Copy the configuration file to point lila to the redis and mongo containers.

    cp conf/application.conf lila/conf/

Copy the configuration file to point lila-ws to the redis and mongo containers.

    cp conf/custom_ws.conf lila-ws/

# Usage

## Without VS Code


## VS Code

Open the Command Palette (Ctrl+Shift+P/Cmd+Shift+P) and search `Open Container in Folder`. Then select your local `locker` folder. VS Code will automatically 


