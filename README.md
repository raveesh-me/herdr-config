# herdr-config

My personal config for the [Herdr](https://herdr.dev) desktop app: the files I own in
`~/.config/herdr-app`.

```
config/
  keys.json        shortcuts (iTerm2-style pane keys; ⌘W closes a pane, ⌘⇧W a tab)
  settings.json    zoom, fonts, theme, sounds, ...
  programs.json    (when present) program names, icons, agent launchers
  layouts/         my own layouts (clones of shipped ones go here too)
  mods/            my own panels
  themes/          my own themes
```

Herdr's shipped layouts and mods, `AGENTS.md`, the `.d.ts` files, `icons/`, `frame/`
and the state files Herdr writes itself are **not** tracked. Herdr rewrites them on
every start. To change a shipped layout or mod, clone it first
(`herdr-app do layout.clone '{"name":"main","as":"my-main"}'`) and track the clone.

## Workflow

Herdr reloads its config live, so you can try a change directly and capture it afterwards:

```sh
# 1. try it live: edit ~/.config/herdr-app/... (Herdr reloads within a second;
#    check for *.error files there, and `make check` for mods)
# 2. capture it on a branch and open a PR
git switch -c my-change
make capture        # live -> config/
git add -A && git commit -m "feat: ..." && git push -u origin my-change
gh pr create --fill
```

Or go the other way: edit `config/` on a branch, `make install` to apply it, then PR.

| Target | Does |
|---|---|
| `make status` | what differs between this repo and the live config |
| `make capture` | live → repo (mirrors deletions; refuses to run on `main`) |
| `make install` | repo → live (never deletes; backs up overwritten files to `~/.config/herdr-app/.herdr-sync-backup/<time>/`) |
| `make check` | `herdr-app check` every personal mod |

On a new machine: install Herdr, start it once, clone this repo and run `make install`.

Set `HERDR_APP_HOME` to point the scripts at a different Herdr home.
