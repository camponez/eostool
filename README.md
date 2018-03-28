## Setup

This script assume you are not running `eosiod` inside the [eos build directory](https://github.com/EOSIO/eos/tree/master#build).

### Suggestion

Run `eosid` in a separate directory like `$HOME/eos-programs`

```bash
mkdir $HOME/eos-programs/
cd $HOME/eos-programs/
git clone  https://github.com/camponez/eostool.git tools
cd $HOME/eos-programs
# pass the FULL PATH where EOS was built
./tools/eosio-tools.sh setup $HOME/eos/build
```

## Usage
* `./tools/eosio-tools.sh start` - start eosiod and redirect the log to `eosiod.log`
* `./toos/eosio-tools.sh stop` - stop eosiod
* `./toos/eosio-tools.sh restart` - restart eosiod. **NOTE**: This will overwrite the `eosiod.log.old` file. Save it before using this option

## Seeing the logs

`eosiod` will be running in the background. In order to see the log, just run:
```bash
tail -f eosiod.log
```

`CTRL+c` will stop tail but not `eosiod`.
