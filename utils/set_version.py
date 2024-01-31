"""Updates the mission version across relevant files."""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ENCODING = "utf-8"
VERSION_PATTERN = re.compile(r"(\d\S+?)")
BRIEFING_NAME_PATTERN = re.compile(
    r'(?<=briefingName=")(.+?)( v\d\S+?)?(?=";$)',
    re.MULTILINE,
)
FN_VERSION_PATTERN = re.compile(
    r'(?<=^")(\d\S+?)(?="$)',
    re.MULTILINE,
)


def subn_briefing_name(content: str, new_version: str):
    def repl(m: re.Match):
        return f"{m[1]} v{new_version}"

    return BRIEFING_NAME_PATTERN.subn(repl, content)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--commit",
        action="store_true",
        help="Stage and commit changes to git",
    )
    parser.add_argument("version", help="The new version string to use")
    args = parser.parse_args()

    new_version = args.version.lstrip(" v").rstrip()
    if VERSION_PATTERN.fullmatch(new_version) is None:
        sys.exit(
            f"Invalid version specifier: {new_version}\n"
            f"Expected format: 1.2.3"
        )

    for path in Path().glob("SHZombiesFramework.*"):
        if path.is_dir():
            mission_dir = path
            break
    else:
        sys.exit(
            "Could not find the mission directory; "
            "is your CWD in the project root?"
        )

    mission_sqm = mission_dir / "mission.sqm"
    version_function = mission_dir / "Functions" / "Helpers" / "fn_version.sqf"

    sqm_content = mission_sqm.read_text(ENCODING)
    version_content = version_function.read_text(ENCODING)

    sqm_content, n = subn_briefing_name(sqm_content, new_version)
    if n != 1:
        sys.exit(
            f"Expected exactly 1 briefingName declaration in {mission_sqm}, "
            f"found {n} instead"
        )

    version_content, n = FN_VERSION_PATTERN.subn(new_version, version_content)
    if n != 1:
        sys.exit(
            f"Expected exactly 1 version string in {version_function}, "
            f"found {n} instead"
        )

    mission_sqm.write_text(sqm_content, ENCODING)
    version_function.write_text(version_content, ENCODING)
    print(f"Version updated to v{new_version}")

    if args.commit:
        subprocess.check_call(["git", "restore", "--staged", "."])
        subprocess.check_call(["git", "add", mission_sqm, version_function])
        subprocess.check_call(["git", "commit", "-m", f"build: bump version to v{new_version}"])


if __name__ == "__main__":
    main()
