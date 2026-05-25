# Quick README: Copy `license.txt` to CHPC and Set `FS_LICENSE`

This guide shows how to copy your local FreeSurfer `license.txt` file to CHPC and set the `FS_LICENSE` variable permanently on CHPC.

## Step 1: Copy `license.txt` to CHPC

From your local terminal, run this command from the workshop repository folder:

```sh
scp license.txt <yourusername>@scp.chpc.ac.za:~/license.txt
```

Replace `<yourusername>` with your CHPC username.

This copies:

```text
license.txt
```

to this location on CHPC:

```text
~/license.txt
```

## Step 2: Log In to CHPC

Log in to CHPC:

```sh
ssh <yourusername>@lengau.chpc.ac.za
```

## Step 3: Add `FS_LICENSE` to `.bash_profile`

On CHPC, add this line to your `~/.bash_profile`:

```sh
export FS_LICENSE="$HOME/license.txt"
```

One simple way to do that is:

```sh
printf '\nexport FS_LICENSE="$HOME/license.txt"\n' >> ~/.bash_profile
```

## Step 4: Load the Updated `.bash_profile`

Still on CHPC, run:

```sh
source ~/.bash_profile
```

## Step 5: Check That It Worked

Check that `FS_LICENSE` points to the copied license file:

```sh
echo "$FS_LICENSE"
```

You should see:

```text
/home/<yourusername>/license.txt
```

Check that the file exists:

```sh
ls -l "$FS_LICENSE"
```

## Notes

- Run the `scp` command from your local machine, not from CHPC.
- Run the `.bash_profile` and `source` commands after logging in to CHPC.
- If `FS_LICENSE` is already set in `~/.bash_profile`, edit the existing line instead of adding a duplicate.
