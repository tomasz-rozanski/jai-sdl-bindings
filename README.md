# SDL bindings for the Jai programming language (Work in Progress)

Jai compiler is shipped with some SDL bindings, but at this point in time (beta 1.0.33) they are very incomplete. This project is an attempt to bridge that gap, and I hope, that in the future, compiler maintainers will incorporate them into the main package.

I heaven't use SDL before, so I'm adding the missing procedures as I'm learning new topics. This way I can test most of the bindings right away, but I'm working alone, so things can slip through the cracks. That's why your feedback will be much appreciated.

This project contains bindings for `SDL v2.0.22`, and few popular addon libraries:
- `SDL_image v2.6.0`
- `SDL_mixer v2.6.1`
- `SDL_ttf v2.20.0`

To check which procedures are implemented, and what is missing, read the [`COMPLETION.md`](/COMPLETION.md).

To learn more about the SDL project, visit [SDL Wiki](https://wiki.libsdl.org/Libraries).

⚠  WARNING ⚠  
SDL binaries shipped with Jai compiler, are fairly old (`v2.0.7`), so to avoid any issues, replace files in the folder(s) `jai/modules/SDL/(win/linux/mac)` with the most recent ones.


