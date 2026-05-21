#!/usr/bin/env python3
"""Create 10 dummy DICOM subject folders from the bundled example scan."""

from pathlib import Path
import shutil
import sys

try:
    import pydicom
except ImportError:
    print("This script needs pydicom: python3 -m pip install pydicom", file=sys.stderr)
    raise

REPO_ROOT = Path(__file__).resolve().parents[1]
SOURCE_PARENT = REPO_ROOT / "example_data"
OUTPUT_PARENT = REPO_ROOT / "dummy_data"
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
    source_scanfolder = find_source_scanfolder()

    if OUTPUT_PARENT.exists():
        raise SystemExit(f"Output folder already exists: {OUTPUT_PARENT}")

    for subject_number in range(1, SUBJECT_COUNT + 1):
        subject_name = f"subject{subject_number}"
        target_subject_dir = OUTPUT_PARENT / subject_name
        target_scanfolder = target_subject_dir / source_scanfolder.name

        shutil.copytree(source_scanfolder, target_scanfolder)
        update_dicom_headers(target_scanfolder, subject_number)

        print(f"Created {target_scanfolder}")

    print()
    print("Use this folder with CHPC_WORKSHOP_DAY2_clustersurfManual2:")
    print(f"  {OUTPUT_PARENT}")


if __name__ == "__main__":
    main()
