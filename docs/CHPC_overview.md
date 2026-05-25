# CHPC Overview

This short guide gives a high-level picture of how we will use CHPC during the workshop.

## Big Picture

![CHPC overview](CHPC%20overview.png)

CHPC is a shared high-performance computing system. You usually do not run large jobs directly on the login node. Instead, you log in, prepare your files and job scripts, then submit work to the scheduler so it can run on compute nodes.

## Main Parts

- **Your local computer** is where you write files, edit scripts, and copy data from.
- **`scp.chpc.ac.za`** is used for copying files to and from CHPC.
- **`lengau.chpc.ac.za`** is used for logging in to CHPC.
- **The login node** is for light work such as checking files, editing scripts, and submitting jobs.
- **Compute nodes** are where the heavy processing should run after jobs are submitted.
- **The scheduler** decides when and where submitted jobs run.

## More Detail

![CHPC detail](CHPC%20detail.png)

A typical workflow is:

1. Copy needed files from your computer to CHPC using `scp`.
2. Log in to CHPC using `ssh`.
3. Prepare or check your job script on the login node.
4. Submit the job to the scheduler.
5. Let the job run on compute nodes.
6. Check job outputs and copy results back if needed.

## Important Rule

Do not run heavy processing directly on the login node. Use the login node to prepare and submit jobs; use compute nodes for the actual workload.

## Gotchas

- Do **not** run processing code directly on the login node.
- Use interactive jobs when you need a live compute session. See the scripts in [`../bin/`](../bin/) for workshop examples.
- Do **not** store large amounts of data in your home directory.
- Lustre SCRATCH space is large, but it is temporary and gets erased after 90 days.
- Keep local backups of important data and results. `rsync` is a good tool for copying only the files that changed.
