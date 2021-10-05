# JAI Language Bindings for Simple DirectMedia Layer (SDL) Version 2.0 libraries

The JAI compiler is shipped with some SDL2 bindings, but at this point in time (beta 085) they are pretty basic. This project is an attempt to bridge that gap, and I hope in the future the compiler maintainers will incorporate them into the main package.

I heaven't use SDL before, so I'm adding the missing procedures as I'm learning new topics. This way I can test most of the bindings right away, but there's too many of them for a single developer, so your feedback is very important. 

I also added the initial version of a few SDL addon libraries:
- `SDL_image`
- `SDL_mixer`
- `SDL_ttf`

Please, keep in mind, that I didn't test any of them yet.

The current version of SDL2 is 2.0.16, but JAI compiler is shipped with fairly old version 2.0.7. To avoid compilation issues, replace files in the folder(s) `jai/modules/SDL/(win/linux/mac)` with the latest ones.


