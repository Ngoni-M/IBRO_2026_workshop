# Basic Emacs

Emacs is very useful when working on CHPC because it is a fully featured code
editor that runs directly in the terminal.

There are, of course, other editors such as `vim` and `neovim`, but Emacs is the
one I know. You can also use VS Code directly on CHPC in various ways, but that
falls outside the scope of this tutorial. It is always nice to know at least one
terminal-based editor.

## Starting Emacs

Open a file with:

```sh
emacs filename.txt
```

If the file does not exist yet, Emacs will create it when you save.

## Key Notation

Emacs commands often use key combinations:

- `C` means `Ctrl`
- `M` means `Alt` or `Meta`
- `RET` means `Enter`

The dash means "hold the first key while pressing the second key". For example,
`C-x` means hold `Ctrl` and press `x`.

For example, `C-x C-s` means:

1. Hold `Ctrl` and press `x`
2. Release the keys
3. Hold `Ctrl` and press `s`

## Files

| Keys | Action |
| --- | --- |
| `C-x C-f` | Open a file |
| `C-x C-s` | Save |
| `C-x C-w` | Save as |
| `C-x C-c` | Quit Emacs |

## Moving Around

| Keys | Action |
| --- | --- |
| `C-f` | Move forward one character |
| `C-b` | Move backward one character |
| `C-n` | Move to the next line |
| `C-p` | Move to the previous line |
| `M-f` | Move forward one word |
| `M-b` | Move backward one word |
| `C-a` | Move to the start of the line |
| `C-e` | Move to the end of the line |

Arrow keys also work.

## Basic Editing

| Keys | Action |
| --- | --- |
| `C-space` | Start selecting text |
| `C-w` | Cut selected text |
| `M-w` | Copy selected text |
| `C-y` | Paste text |
| `C-k` | Cut from the cursor to the end of the line |
| `C-d` | Delete the character under the cursor |
| `C-/` | Undo |

## Search

| Keys | Action |
| --- | --- |
| `C-s` | Search forward |
| `C-r` | Search backward |

Press `RET` to stop searching and keep the cursor where it is.

## If You Get Stuck

Use:

| Keys | Action |
| --- | --- |
| `C-g` | Cancel the current command |
| `C-h t` | Open the built-in Emacs tutorial |

`C-g` is the most important rescue command. If Emacs is waiting for input and you
are not sure what to do, press `C-g`.

## Minimal Survival Workflow

1. Open a file: `emacs filename.txt`
2. Edit the text
3. Save: `C-x C-s`
4. Quit: `C-x C-c`
