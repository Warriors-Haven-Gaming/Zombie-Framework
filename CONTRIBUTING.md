# Contributing Guide

## Table of Contents

- [Contributing Guide](#contributing-guide)
  - [Table of Contents](#table-of-contents)
  - [Recommended Setup](#recommended-setup)
  - [Resources](#resources)
  - [SQF/CPP Style Guide](#sqfcpp-style-guide)

## Recommended Setup

Mission contributors are recommended to [fork this repository], clone it locally,
then create a [Directory Junction] inside your `<Arma 3 profile>/mpmissions/` folder
pointing to `SHZombiesFramework.Tanoa/` so your script edits can be previewed
from the [Eden Editor] in real-time (see also [Link Shell Extension]).
Once set up, you can follow the [GitHub Flow] to make a new branch, commit your changes,
and start a pull request on this repository for the owner to review and merge.

Contributors making changes that don't affect gameplay, such as documentation,
can skip cloning this repository and instead use the [web-based editor]
with [GitHub Flow] to contribute instead.

[fork this repository]: https://docs.github.com/en/get-started/quickstart/fork-a-repo
[Directory Junction]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mklink
[Eden Editor]: https://community.bistudio.com/wiki/Eden_Editor:_Introduction
[Link Shell Extension]: https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html
[GitHub Flow]: https://docs.github.com/en/get-started/quickstart/github-flow
[web-based editor]: https://docs.github.com/en/codespaces/the-githubdev-web-based-editor

## Resources

- Community Wiki: https://community.bistudio.com/wiki/Main_Page

## SQF/CPP Style Guide

- All indentation should use tabs
- Lines should not contain any trailing whitespace
- Lines should avoid exceeding 80 characters unless its readability would
  be worsened by line breaks
- SQF functions should be documented ([example](/SHZombiesFramework.Tanoa/Functions/Zombies/fn_hordeSpawn.sqf))
