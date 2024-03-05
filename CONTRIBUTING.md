<h1 align="center">
    <img src="assets/hajpacktransparent.png" alt="hajpack logo" width="200"><br>
	hajpack
</h3>
<div align="center">
    contributing
</div>

## How to contribute
> 💡 This section is a WIP!
> Some information may be missing or incomplete.

To manage this pack [packwiz](https://github.com/packwiz/packwiz) is used in order to make it easier to manage the mods and other files. If you want information on how to use packwiz, please refer to the [packwiz documentation](https://packwiz.infra.link/).

### Installing packwiz
> 💡 This section is specific to Linux! For other operating systems please check the official packwiz docs!

To install packwiz, you will need to install [Go](https://golang.org/doc/install) and then run the following command:
```bash
go install github.com/packwiz/packwiz@latest
```

It is also recommended to add the `go/bin` directory to your PATH.
```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

### Running the pack
In order to run the pack (for testing purposes), it is recommended to use [packwiz-installer](https://github.com/packwiz/packwiz-installer) to install it, this will allow you to auto-update the pack.

#### Installing packwiz-installer
> 💡 This section is specific to PrismLauncher! Information for MultiMC and ATLauncher is on the official packwiz docs!

To install packwiz-installer, you will need to download [packwiz-installer-bootstrap](https://github.com/packwiz/packwiz-installer-bootstrap/releases) and add it to your instance folder (e.g. `~/.local/share/PrismLauncher/instances/hajpack`).

> 💡 This assumes that your packwiz server is hosted on http://localhost:8080 (the default for packwiz serve), please change it if it is hosted somewhere else!

Then, you will need to add the following command to your Pre-launch command (Edit -> Settings -> Custom commands -> Pre-launch command):
```bash
$INST_JAVA -jar "$INST_DIR"/packwiz-installer-bootstrap.jar http://localhost:8080/pack.toml
```

#### Running the pack
After installing packwiz-installer, you can run the pack by clicking the play button in the PrismLauncher. You will also have to have the packwiz server running in order to run the pack. (use `packwiz serve` to start the server, this will start a server on http://localhost:8080)

#### Server-side testing
In order to test the pack server-side, in order to make this easier, we provide a script that will automatically build the pack and start the server. To use this script, you will need to have a packwiz server running (use `packwiz serve` to start the server, this will start a server on http://localhost:8080).

> 💡 This assumes that your packwiz server is hosted on http://localhost:8080 (the default for packwiz serve), please change it if it is hosted somewhere else!
> To clean up, change ram amount, or enable gui check the other arguments by just running `./hajpackserver.sh`!

To use the script you will first need to create a directory with only the scripts folder, from there you can run the following commands in order to do initial setup:
```bash
./hajpackserver.sh -s
./hajpackserver.sh -p http://localhost:8080/pack.toml
```

After the initial setup, you can run the following command to start the server:
```bash
./hajpackserver.sh -p http://localhost:8080/pack.toml
```

### Contribution guidelines
> 💡 This section is a WIP!
> Some information may be missing or incomplete.

#### Mod suggestions
If you have a mod suggestion, please open an pull request or issue with the mod suggestion.

#### Commits
> 💡 This section is out of date! Please check the [Branches](#branches) section for more information!
When making commits that are not hotfixes, please open a pull request and wait for it to be reviewed before merging it.

#### Branches
Commits should be made to the `dev` branch, and then merged into `main` when they are ready to be released. This is so it doesnt take ages to add a new mod to the pack.
