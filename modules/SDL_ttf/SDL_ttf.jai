
//#include "begin_code.h"

// Printable format: "%d.%d.%d", MAJOR, MINOR, PATCHLEVEL
SDL_TTF_MAJOR_VERSION :: 2;
SDL_TTF_MINOR_VERSION :: 0;
SDL_TTF_PATCHLEVEL    :: 15;

// This macro can be used to fill a version structure with the compile-time
// version of the SDL_ttf library.
SDL_TTF_VERSION :: (X: *SDL_version) {
    X.major = SDL_TTF_MAJOR_VERSION;
    X.minor = SDL_TTF_MINOR_VERSION;
    X.patch = SDL_TTF_PATCHLEVEL;
}

// Backwards compatibility 
TTF_MAJOR_VERSION :: SDL_TTF_MAJOR_VERSION;
TTF_MINOR_VERSION :: SDL_TTF_MINOR_VERSION;
TTF_PATCHLEVEL    :: SDL_TTF_PATCHLEVEL;
TTF_VERSION       :: SDL_TTF_VERSION;

// This is the version number macro for the current SDL_ttf version.
SDL_TTF_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_TTF_MAJOR_VERSION, SDL_TTF_MINOR_VERSION, SDL_TTF_PATCHLEVEL);

 // This macro will evaluate to true if compiled with SDL_ttf at least X.Y.Z.
SDL_TTF_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
    return SDL_TTF_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
}

// Make sure this is defined (only available in newer SDL versions)
SDL_DEPRECATED :: 1;

// This function gets the version of the dynamically linked SDL_ttf library.
// it should NOT be used to fill a version structure, instead you should
// use the SDL_TTF_VERSION() macro.
TTF_Linked_Version:: () -> *SDL_version #foreign SDL2_TTF; 

// ZERO WIDTH NO-BREAKSPACE (Unicode byte order mark)
UNICODE_BOM_NATIVE  :: 0xfeff;
UNICODE_BOM_SWAPPED :: 0xfffe;

// This function tells the library whether UNICODE text is generally
// byteswapped.  A UNICODE BOM character in a string will override
// this setting for the remainder of that string.
TTF_ByteSwappedUNICODE :: (swapped: s32) #foreign SDL2_TTF; 

// The internal structure containing font information
TTF_Font :: struct {};

// Initialize the TTF engine - returns 0 if successful, -1 on error
TTF_Init :: () -> s32 #foreign SDL2_TTF; 

// Open a font file and create a font of the specified point size.
// Some .fon fonts will have several sizes embedded in the file, so the
// point size becomes the index of choosing which size.  If the value
// is too high, the last indexed size will be the default.
TTF_OpenFont :: (file: *u8, ptsize: s32) -> *TTF_Font #foreign SDL2_TTF; 
TTF_OpenFontIndex :: (file: *u8, ptsize: s32, index: s64) -> *TTF_Font #foreign SDL2_TTF;
TTF_OpenFontRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32) -> *TTF_Font #foreign SDL2_TTF; 
TTF_OpenFontIndexRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32, index: s64) -> *TTF_Font #foreign SDL2_TTF; 

// Set and retrieve the font style
TTF_STYLE_NORMAL        :: 0x00;
TTF_STYLE_BOLD          :: 0x01;
TTF_STYLE_ITALIC        :: 0x02;
TTF_STYLE_UNDERLINE     :: 0x04;
TTF_STYLE_STRIKETHROUGH :: 0x08;

TTF_GetFontStyle :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontStyle :: (font: *TTF_Font, style: s32) #foreign SDL2_TTF; 
TTF_GetFontOutline :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontOutline :: (font: *TTF_Font, outline: s32) #foreign SDL2_TTF; 

// Set and retrieve FreeType hinter settings
TTF_HINTING_NORMAL :: 0;
TTF_HINTING_LIGHT  :: 1;
TTF_HINTING_MONO   :: 2;
TTF_HINTING_NONE   :: 3;

TTF_GetFontHinting :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontHinting :: (font: *TTF_Font, hinting: s32) #foreign SDL2_TTF; 

// Get the total height of the font - usually equal to point size
TTF_FontHeight :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

// Get the offset from the baseline to the top of the font
// This is a positive value, relative to the baseline.
TTF_FontAscent :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

// Get the offset from the baseline to the bottom of the font
// This is a negative value, relative to the baseline.
TTF_FontDescent :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

// Get the recommended spacing between lines of text for this font
TTF_FontLineSkip :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

// Get/Set whether or not kerning is allowed for this font
TTF_GetFontKerning :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontKerning :: (font: *TTF_Font, allowed: s32) #foreign SDL2_TTF; 

// Get the number of faces of the font */
TTF_FontFaces :: (font: *TTF_Font) -> s64 #foreign SDL2_TTF; 

// Get the font face attributes, if any */
TTF_FontFaceIsFixedWidth :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_FontFaceFamilyName :: (font: *TTF_Font) -> *u8 #foreign SDL2_TTF; 
TTF_FontFaceStyleName :: (font: *TTF_Font) -> *u8 #foreign SDL2_TTF; 

// Check wether a glyph is provided by the font or not */
TTF_GlyphIsProvided :: (font: *TTF_Font, ch: u16) -> s32 #foreign SDL2_TTF; 

// Get the metrics (dimensions) of a glyph
// To understand what these metrics mean, here is a useful link:
// http://freetype.sourceforge.net/freetype2/docs/tutorial/step2.html
TTF_GlyphMetrics :: (font: *TTF_Font, ch: u16, minx: *s32, maxx: *s32, miny: *s32, maxy: *s32, advance: *s32) -> s32 #foreign SDL2_TTF; 

// Get the dimensions of a rendered string of text */
TTF_SizeText :: (font: *TTF_Font, text: *u8, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 
TTF_SizeUTF8 :: (font: *TTF_Font, text: *u8, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 
TTF_SizeUNICODE :: (font: *TTF_Font, text: *u16, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 

// Create an 8-bit palettized surface and render the given text at
// fast quality with the given font and color.  The 0 pixel is the
// colorkey, giving a transparent background, and the 1 pixel is set
// to the text color.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderText_Solid :: (font: *TTF_Font, text: *u8, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Solid :: (font: *TTF_Font, text: *u8, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Solid :: (font: *TTF_Font, text: *u16, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 

// Create an 8-bit palettized surface and render the given glyph at
// fast quality with the given font and color.  The 0 pixel is the
// colorkey, giving a transparent background, and the 1 pixel is set
// to the text color.  The glyph is rendered without any padding or
// centering in the X direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderGlyph_Solid :: (font: *TTF_Font, ch: u16, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 

// Create an 8-bit palettized surface and render the given text at
// high quality with the given font and colors.  The 0 pixel is background,
// while other pixels have varying degrees of the foreground color.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderText_Shaded :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Shaded :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Shaded :: (font: *TTF_Font, text: *u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

// Create an 8-bit palettized surface and render the given glyph at
// high quality with the given font and colors.  The 0 pixel is background,
// while other pixels have varying degrees of the foreground color.
// The glyph is rendered without any padding or centering in the X
// direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderGlyph_Shaded :: (font: *TTF_Font, ch: u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

// Create a 32-bit ARGB surface and render the given text at high quality,
// using alpha blending to dither the font with the given color.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderText_Blended :: (font: *TTF_Font, text: *u8, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Blended :: (font: *TTF_Font, text: *u8, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Blended :: (font: *TTF_Font, text: *u16, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

// Create a 32-bit ARGB surface and render the given text at high quality,
// using alpha blending to dither the font with the given color.
// Text is wrapped to multiple lines on line endings and on word boundaries
// if it extends beyond wrapLength in pixels.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderText_Blended_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Blended_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Blended_Wrapped :: (font: *TTF_Font, text: *u16, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 

// Create a 32-bit ARGB surface and render the given glyph at high quality,
// using alpha blending to dither the font with the given color.
// The glyph is rendered without any padding or centering in the X
// direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
TTF_RenderGlyph_Blended :: (font: *TTF_Font, ch: u16, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

// For compatibility with previous versions, here are the old functions */
TTF_RenderText :: TTF_RenderText_Shaded;
TTF_RenderUTF8 :: TTF_RenderUTF8_Shaded;
TTF_RenderUNICODE :: TTF_RenderUNICODE_Shaded;

// Close an opened font file */
TTF_CloseFont :: (font: *TTF_Font) #foreign SDL2_TTF; 

// De-initialize the TTF engine */
TTF_Quit :: () #foreign SDL2_TTF; 

// Check if the TTF engine is initialized */
TTF_WasInit :: () -> s32 #foreign SDL2_TTF; 

// Get the kerning size of two glyphs indices */
// DEPRECATED: this function requires FreeType font indexes, not glyphs,
// by accident, which we don't expose through this API, so it could give
// wildly incorrect results, especially with non-ASCII values.
// Going forward, please use TTF_GetFontKerningSizeGlyphs() instead, which
// does what you probably expected this function to do. */
TTF_GetFontKerningSize :: (font: *TTF_Font, prev_index: s32, index: s32) -> s32 #deprecated "Use TTF_GetFontKerningSizeGlyphs instead" #foreign SDL2_TTF; 

// Get the kerning size of two glyphs */
TTF_GetFontKerningSizeGlyphs :: (font: *TTF_Font, previous_ch: u16, ch: u16) -> s32 #foreign SDL2_TTF; 

// We'll use SDL for reporting errors */
// TTF_SetError :: SDL_SetError; // @todo uncomment, once SDL_SetError is implemented
TTF_GetError :: SDL_GetError;

