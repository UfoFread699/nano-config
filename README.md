# nano-config

> ⚠️ **Linux only.** macOS / Windows are not supported.

A clean, terminal-friendly [GNU nano](https://www.nano-editor.org/) configuration with a green minibar UI, line numbers, scrollbar indicator and syntax highlighting for 100+ languages.

Tested on `nano 7.2` (Ubuntu/Linux Mint).

## Features

- Compact green **minibar** instead of the title bar
- Line numbers (`set linenumbers`)
- Scrollbar **indicator** on the right side
- Green `status / title / error / prompt / key / number` colors on black
- Hidden bottom help lines (`set nohelp`)
- 119 bundled syntax definitions in `nano/`

## Install (one command)

```bash
curl -fsSL https://raw.githubusercontent.com/UfoFread699/nano-config/main/install.sh | bash
```

Then restart nano:

```bash
nano ~/.nanorc
```

Existing config is automatically backed up to `~/.nanorc.backup-<date>` and `~/.nano.backup-<date>`.

## Manual install

```bash
git clone https://github.com/UfoFread699/nano-config.git
cd nano-config
./install.sh
```

## Uninstall

Restore one of the automatic backups:

```bash
ls ~/.nanorc.backup-* ~/.nano.backup-* 2>/dev/null
cp ~/.nanorc.backup-<date> ~/.nanorc
rm -rf ~/.nano && mv ~/.nano.backup-<date> ~/.nano
```

Or just delete the config:

```bash
rm ~/.nanorc
rm -rf ~/.nano
```

## Contents

- `nanorc` – main config (goes to `~/.nanorc`)
- `nano/*.nanorc` – syntax highlighting files (go to `~/.nano/`)
- `install.sh` – Linux-only installer with backup support

## Requirements

- Linux
- `nano`
- `curl` (only for the one-line install)

## Release

`v1.0.0` – initial release.

## License

MIT – see [LICENSE](LICENSE).
