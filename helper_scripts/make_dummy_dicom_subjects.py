#!/usr/bin/env python3
"""Create dummy DICOM subject folders for the workshop.

The script copies the bundled example scanfolder into 10 subject folders and
updates a few DICOM header fields so each copy looks like a separate subject.
By default, the output is written to ``dummy_data`` in the repository root.
Use ``--lustre`` to write to ``/mnt/lustre/users/$USER/dummy_data`` instead.

The output folder must not already exist.
"""

from pathlib import Path
import argparse
import shutil
import sys
import os

try:
    import pydicom
except ImportError:
    print("This script needs pydicom: python3 -m pip install pydicom", file=sys.stderr)
    raise

REPO_ROOT = Path(__file__).resolve().parents[1]
USER_NAME = os.environ.get("USER")
LUSTER_FOLDER = Path("/mnt/lustre/users")
SOURCE_PARENT = REPO_ROOT / "example_data"
OUTPUT_REPO = REPO_ROOT / "dummy_data"
OUTPUT_LUSTRE = LUSTER_FOLDER / USER_NAME / "dummy_data"
SUBJECT_COUNT = 10


def find_source_scanfolder():
    scanfolders = sorted(SOURCE_PARENT.glob("**/*RMS*"))
    scanfolders = [path for path in scanfolders if path.is_dir()]

    if len(scanfolders) != 1:
        raise SystemExit(
            f"Expected exactly one *RMS* scanfolder in {SOURCE_PARENT}, found {len(scanfolders)}"
        )

    return scanfolders[0]


def update_dicom_headers(scanfolder, subject_number):
    patient_name = f"subject{subject_number}"
    study_date = f"202601{subject_number:02d}"
    study_time = f"09{subject_number:02d}00"

    for dicom_file in sorted(scanfolder.rglob("*")):
        if not dicom_file.is_file():
            continue

        try:
            dataset = pydicom.dcmread(dicom_file)
        except Exception:
            continue

        dataset.PatientName = patient_name
        dataset.StudyDate = study_date
        dataset.StudyTime = study_time
        dataset.save_as(dicom_file)


def main():
    parser = argparse.ArgumentParser(
        description="Create 10 dummy DICOM subject folders from the bundled example scan."
    )
    parser.add_argument(
        "--lustre",
        action="store_true",
        help="create dummy_data under /mnt/lustre/users/$USER instead of the repository root",
    )
    args = parser.parse_args()

    output_parent = OUTPUT_LUSTRE if args.lustre else OUTPUT_REPO
    source_scanfolder = find_source_scanfolder()

    if output_parent.exists():
        raise SystemExit(f"Output folder already exists: {output_parent}")

    for subject_number in range(1, SUBJECT_COUNT + 1):
        subject_name = f"subject{subject_number}"
        target_subject_dir = output_parent / subject_name
        target_scanfolder = target_subject_dir / source_scanfolder.name

        shutil.copytree(source_scanfolder, target_scanfolder)
        update_dicom_headers(target_scanfolder, subject_number)

        print(f"Created {target_scanfolder}")

    print()
    print("Use this folder with CHPC_WORKSHOP_DAY2_prepareReconAllJobs:")
    print(f"  {output_parent}")


if __name__ == "__main__":
    main()
