# JAI Language Bindings for Simple DirectMedia Layer (SDL) Version 2.0 libraries

The JAI compiler is shipped with some SDL2 bindings, but at this point in time (beta 1.0.33) they are pretty basic. This project is an attempt to bridge that gap, and I hope, that in the future, compiler maintainers will incorporate them into the main package.

I heaven't use SDL before, so I'm adding the missing procedures as I'm learning new topics. This way I can test most of the bindings right away, but I'm working alone, so things can slip through the cracks. That's why your feedback will be much appreciated.

This project contains bindings for [`SDL2 v2.0.22`](/COMPLETION.md#SDL2), and few popular addon libraries:
- [`SDL2_image v2.6.0`](/COMPLETION.md#SDL2_image)
- [`SDL2_mixer v2.6.1`](/COMPLETION.md#SDL2_mixer)
- [`SDL2_ttf v2.20.0`](/COMPLETION.md#SDL2_ttf)

⚠  WARNING ⚠  
JAI compiler is shipped with fairly old version 2.0.7. To avoid compilation issues, replace files in the folder(s) `jai/modules/SDL/(win/linux/mac)` with the latest ones.


