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
    
Additionally, a few changes to the conf files for lila & lila-ws will have ot be done to point to redis/mongo.
    
Copy the configuration file to point lila to the redis and mongo containers.

    cp conf/application.conf lila/conf/

Copy the configuration file to point lila-ws to the redis and mongo containers.

    cp conf/custom_ws.conf lila-ws/

# Usage

## Without VS Code

If you would like to start lila and lila-ws (no bloop) as is, change the [entrypoint](https://github.com/wkeahi/locker/blob/main/docker-compose.yml#L17) in `docker-compose.yml` to `docker-entrypoint.sh`.

Then run the following command in the locker directory.
    
    docker-compose up
    
lila-ws will be started in the background (nothing will be output to the log). Then sbt will be ran. After it has finished, go to [http://127.0.0.1:9663/](http://127.0.0.1:9663/).

## VS Code

Open the Command Palette (Ctrl+Shift+P/Cmd+Shift+P) and search `Remote-Containers: Open Container in Folder`. Then select your local `locker` folder. VS Code will then prompt you if you would like to import the build, confirm. This will run `sbt bloopInstall`. After it is done compiling, you can use features such as "Go to Definition."


