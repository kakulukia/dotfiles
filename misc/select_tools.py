#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "InquirerPy",
#     "icecream",
#     "ipdb",
# ]
# ///

import os
import sys
import json
import shutil
import subprocess
from InquirerPy import inquirer
from InquirerPy.separator import Separator
from InquirerPy.base.control import Choice
from icecream import ic


def detect_system_package_manager():
    mgr = None
    if shutil.which("brew"):
        mgr = "brew"
    elif shutil.which("apt-get"):
        mgr = "sudo apt-get -y"
    elif shutil.which("yum"):
        mgr = "sudo yum -y"
    else:
        print("No supported system package manager found (brew, apt-get or yum). Exiting.")
        sys.exit(1)

    return mgr
def load_tool_definitions():
    tool_data = None
    script_dir = os.path.dirname(os.path.realpath(__file__))
    json_path = os.path.join(script_dir, "apps.json")
    try:
        with open(json_path) as f:
            tool_data = json.load(f)
    except FileNotFoundError:
        print(f"Apps definition file not found: {json_path}")
        sys.exit(1)

    return tool_data

# Detect system package manager early
# Load tool definitions
pkg_mgr = detect_system_package_manager()
data = load_tool_definitions()

## Load defaults and compute formatting width
default_selection = []
max_name_len = 0
for info in data.values():
    for app in info.get("apps", []):
        nm = app.get("name", "") or ""
        # track max name length
        if len(nm) > max_name_len:
            max_name_len = len(nm)
# Rebuild default_selection with correct categories
default_selection = []
for category, info in data.items():
    for app in info.get("apps", []):
        name = app.get("name", "")
        if app.get("default", False):
            default_selection.append(name)
# compute column width for name + padding
name_width = max_name_len + 5
for category, info in data.items():
    for app in info.get("apps", []):
        if app.get("default", False):
            default_selection.append((category, app.get("name")))

# Ask for default vs custom
try:
    mode = inquirer.select(
        message="Do you want to continue, installing default tools?",
        choices=[
            {"name": "YES", "value": "yes"},
            {"name": "NO - customize selection", "value": "no"},
        ],

        default="yes",
    ).execute()
except KeyboardInterrupt:
    print("\nOperation cancelled by user. Exiting.")
    sys.exit(0)

# Determine selection
# Determine selection
if mode == "yes":
    selected = default_selection
else:
    # custom selection per category
    selected = []
    for category, info in data.items():
        opts = []
        # build choices for this category with aligned names
        max_len = 0
        for app in info.get("apps", []):
            nm = app.get("name", "") or ""
            if len(nm) > max_len:
                max_len = len(nm)

        for app in info.get("apps", []):
            name = app.get("name")
            desc = app.get("desc")
            enabled = bool(app.get("default", False))
            # align name column per category
            width = max_len + 5
            label = f"{name.ljust(width)}{desc}"
            opts.append(
                Choice(
                    name,
                    name=label,
                    enabled=enabled
                )
            )
        prompt = f"Select tools to install for category {category.upper()}:"
        try:
            sel = inquirer.checkbox(
                message=prompt,
                choices=opts,
                instruction="(Space to toggle, ↵ to confirm, Esc to cancel)",
                transformer=lambda x: "",
            ).execute()
        except KeyboardInterrupt:
            print("\nOperation cancelled by user. Exiting.")
            sys.exit(0)
        selected.extend(sel)

# If no tools selected, exit
if not selected:
    print("No tools selected. Exiting.")
    sys.exit(0)


# Install selected tools
for category, info in data.items():
    cmd_template = info.get("cmd")

    for app in info.get("apps", []):

        name = app.get("name")
        if not name in selected:
            continue

        # check if tool is already installed
        cmd = app.get("cmd", name)
        if shutil.which(cmd):
            print(f"{name} is already installed ...")
            continue
        else:
            if category == "system":
                full_cmd = f"{pkg_mgr} {cmd_template} {name}"
            else:
                full_cmd = f"{category} {cmd_template} {name}"
            app_install = app.get("install", full_cmd)
            try:
                print(f"Installing {name} ...")
                subprocess.run(app_install, shell=True, check=True)
            except subprocess.CalledProcessError as e:
                print(f"Error installing {name}: {e}")
