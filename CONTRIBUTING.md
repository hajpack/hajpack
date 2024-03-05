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

#### Running a server
To run a packwiz server, you will need to run the following command:
```bash
packwiz serve
```
<!-- yes i really stretched this single command into a entire section -->

### Contribution guidelines
> 💡 This section is a WIP!
> Some information may be missing or incomplete.

#### Mod suggestions
If you have a mod suggestion, please open an pull request or issue with the mod suggestion.

#### Commits
When making commits that are not hotfixes, please open a pull request and wait for it to be reviewed before merging it.
