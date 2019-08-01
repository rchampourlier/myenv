# Cheatsheet

## Yadr

See [readme](https://github.com/skwp/dotfiles).

## Vim

### autocompletion

- native: `<C-n>`
- omnifunc: `<C-x> <C-o>`

### windows/splits

- split horizontally: `<C-w> s`
- split vertically: `<C-w> v`
- close: `<C-w> c`
- open new window above / beside: `:new [filename]` or `<C-w> n` / `:vnew [filename]`
- edit file in new window above / beside: `:split <filename>` / `:vsplit <filename>`
- change split size horizontally: `[count] <C-w> <` / `[count] <C-w> >`
- change split size vertically: `[count] <C-w> -` / `[count] <C-w> +`
- equalize windows: `<C-w> =`

### tabs

- open new tab: `:tabnew`
- edit file in new tab: `:tabedit <filename>`
- go to next / previous tab: `gt` / `gT`
- break current window in new tab: `<C-w> T`

### buffers

- goto next / previous: `,x` / `,z`

### copy

- current line: `yy`
- file path / name: `,cf` / `,cn`

### comment

- current line: `gcc`
- current paragraph: `gcp` #new

### navigate

- files: `,f` (using fzf)
- tags: `,t` (using ctrlp and ctags)
- toggl tagbar: `,b`

### goto

- jump to tag under cursor: `<ALT-j>`
- same in vertical split: `<ALT-J>`

### modes

- paste: `set paste` / `set nopaste`

### moves / positioning cursor

- `w`: first character of next word
- easymotion: `,<ESC>`
- `H` / `M` / `L`: move lines high / middle / low #new
- move to line with number: `<NN> G` where NN is a number
- `;` / `,`: repeat move / reverse #new

### positioning buffer in window

- center: `zz`
- top / bottom: `zt` / `zb`

### text objects

- `p`: paragraph

### surround

- surround inner word with ": `ysiw"`
- change surrounding " to ': `cs"'`

### search/replace

- `,k`: search word under cursor
- `Ag`
- `Gsearch`, then `Greplace`

### misc
  - preview Markdown: `:Mm`

## Tmux

[Cheatsheet](https://gist.github.com/henrik/1967800)
[Crash course](https://robots.thoughtbot.com/a-tmux-crash-course)

- prefix: `C-a`
- panes:
  - split horizontally: `prefix "`
  - split vertically: `prefix %`
  - close: `x`
  - resize: `prefix <H|J|K|L>`
  - move to another window:
    `join-pane -s <window-number>.<pane-number> -t <win-nb>.<pane-nb>`
- windows:
  - new: `prefix c`
  - list: `prefix w`
  - find: `prefix f`
  - name: `prefix ,`
  - kill: `&`
  - next / previous: `n` / `p`
- copy: same as Vim (`v`, moves, `y`)
- paste: `prefix ]`
- sessions:
  - new: `tmux new -s session-name`
  - attach: `tmux attach -t session-name`
  - detach: `C-d`
  - save: `prefix C-s`
  - restore: `prefix C-r`
  - switch: `prefix C-(`, `prefix C-)`
- layouts:
  - switch to next: `prefix <space>`
- plugins:
  - add: edit `~/.tmux.conf`
  - install: `prefix I`
  - see [tpm](https://github.com/tmux-plugins/tpm) for details
