// SDL_haptic.h
SDL_Haptic :: struct {}; // just a marker/pointer, I guess

SDL_HapticCondition :: struct {
    // Header 
    type: u16; // SDL_HAPTIC_SPRING, SDL_HAPTIC_DAMPER, SDL_HAPTIC_INERTIA or SDL_HAPTIC_FRICTION
    direction: SDL_HapticDirection; // Direction of the effect - Not used ATM

    // Replay 
    length: u32;          // Duration of the effect
    delay: u16;           // Delay before starting the effect

    // Trigger 
    button: u16;          // Button that triggers the effect
    interval: u16;        // How soon it can be triggered again after button

    // Condition 
    right_sat: [3] u16;   // Level when joystick is to the positive side; max 0xFFFF
    left_sat: [3] u16;    // Level when joystick is to the negative side; max 0xFFFF
    right_coeff: [3] s16; // How fast to increase the force towards the positive side
    left_coeff: [3] s16;  // How fast to increase the force towards the negative side
    deadband: [3] u16;    // Size of the dead zone; max 0xFFFF: whole axis-range when 0-centered
    center: [3] s16;      // Position of the dead zone
}

SDL_HapticConstant :: struct {
    // Header
    type: u16;          // SDL_HAPTIC_CONSTANT 
    direction: SDL_HapticDirection; // Direction of the effect

    // Replay
    length: u32;        // Duration of the effect
    delay: u16;         // Delay before starting the effect

    // Trigger
    button: u16;        // Button that triggers the effect
    interval: u16;      // How soon it can be triggered again after button

    // Constant
    level: s16;         // Strength of the constant effect

    // Envelope
    attack_length: u16; // Duration of the attack
    attack_level: u16;  // Level at the start of the attack
    fade_length: u16;   // Duration of the fade
    fade_level: u16;    // Level at the end of the fade
} 

SDL_HapticCustom :: struct {
    // Header
    type: u16;            // SDL_HAPTIC_CUSTOM
    direction: SDL_HapticDirection;  // Direction of the effect

    // Replay
    length: u32;          // Duration of the effect.
    delay: u16;           // Delay before starting the effect

    // Trigger
    button: u16;          // Button that triggers the effect
    interval: u16;        // How soon it can be triggered again after button

    // Custom
    channels: u8;         // Axes to use, minimum of one
    period: u16;          // Sample periods
    samples: u16;         // Amount of samples
    data: *u16;           // Should contain channels*samples items

    // Envelope
    attack_length: u16;   // Duration of the attack
    attack_level: u16;    // Level at the start of the attack
    fade_length: u16;     // Duration of the fade
    fade_level: u16;      // Level at the end of the fade
}

SDL_HapticDirection :: struct {
    type: u8;     // The type of encoding
    dir: [3] s32; // The encoded direction
}

SDL_HapticEffect :: union {
    type: u16;                      // Effect type
    constant: SDL_HapticConstant;   // Constant effect
    periodic: SDL_HapticPeriodic;   // Periodic effect
    condition: SDL_HapticCondition; // Condition effect
    ramp: SDL_HapticRamp;           // Ramp effect
    leftright: SDL_HapticLeftRight; // Left/Right effect
    custom: SDL_HapticCustom;       // Custom effect
}

SDL_HapticLeftRight :: struct {
    // Header
    type: u16;            // SDL_HAPTIC_LEFTRIGHT

    // Replay
    length: u32;          // Duration of the effect in milliseconds

    // Rumble
    large_magnitude: u16; // Control of the large controller motor
    small_magnitude: u16; // Control of the small controller motor
}

SDL_HapticPeriodic :: struct {
    // Header
    type: u16;          // SDL_HAPTIC_SINE, SDL_HAPTIC_LEFTRIGHT, SDL_HAPTIC_TRIANGLE, 
    // SDL_HAPTIC_SAWTOOTHUP or SDL_HAPTIC_SAWTOOTHDOWN
    direction: SDL_HapticDirection;  // Direction of the effect

    // Replay
    length: u32;        // Duration of the effect
    delay: u16;         // Delay before starting the effect

    // Trigger
    button: u16;        // Button that triggers the effect
    interval: u16;      // How soon it can be triggered again after button

    // Periodic
    period: u16;        // Period of the wave
    magnitude: s16;     // Peak value; if negative, equivalent to 180 degrees extra phase shift
    offset: s16;        // Mean value of the wave
    phase: u16;         // Positive phase shift given by hundredth of a degree

    // Envelope
    attack_length: u16; // Duration of the attack
    attack_level: u16;  // Level at the start of the attack
    fade_length: u16;   // Duration of the fade
    fade_level: u16;    // Level at the end of the fade
}

SDL_HapticRamp :: struct {
    // Header
    type: u16;          // SDL_HAPTIC_RAMP
    direction: SDL_HapticDirection; // Direction of the effect

    // Replay
    length: u32;        // Duration of the effect
    delay: u16;         // Delay before starting the effect

    // Trigger
    button: u16;        // Button that triggers the effect
    interval: u16;      // How soon it can be triggered again after button

    // Ramp
    start: s16;         // Beginning strength level
    end: s16;           // Ending strength level

    // Envelope
    attack_length: u16; // Duration of the attack
    attack_level: u16;  // Level at the start of the attack
    fade_length: u16;   // Duration of the fade
    fade_level: u16;    // Level at the end of the fade
}

SDL_JoystickIsHaptic :: (joystick: *SDL_Joystick) -> s32 #foreign SDL2;
SDL_HapticOpenFromJoystick :: (joystick: *SDL_Joystick) -> *SDL_Haptic #foreign SDL2;
SDL_HapticRumbleInit :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticClose :: (haptic: *SDL_Haptic) #foreign SDL2;
SDL_HapticRumblePlay :: (haptic: *SDL_Haptic, strength: float, length: u32 ) -> s32 #foreign SDL2;
SDL_HapticDestroyEffect :: (haptic: *SDL_Haptic, effect: s32) #foreign SDL2;
SDL_HapticEffectSupported :: (haptic: *SDL_Haptic, effect: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_HapticGetEffectStatus :: (haptic: *SDL_Haptic, effect: s32) -> s32 #foreign SDL2;
SDL_HapticIndex :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticName :: (device_index: s32) -> *u8 #foreign SDL2;
SDL_HapticNewEffect :: (haptic: *SDL_Haptic, effect: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_HapticNumAxes :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticNumEffects :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticNumEffectsPlaying :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticOpen :: (device_index: s32) -> *SDL_Haptic #foreign SDL2;
SDL_HapticOpened :: (device_index: s32) -> s32 #foreign SDL2;
SDL_HapticOpenFromMouse :: () -> *SDL_Haptic #foreign SDL2;
SDL_HapticPause :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticQuery :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticRumbleStop :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticRumbleSupported :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticRunEffect :: (haptic: *SDL_Haptic, effect: s32, iterations: u32) -> s32 #foreign SDL2;
SDL_HapticSetAutocenter :: (haptic: *SDL_Haptic, autocenter: s32) -> s32 #foreign SDL2;
SDL_HapticSetGain :: (haptic: *SDL_Haptic, gain: s32) -> s32 #foreign SDL2;
SDL_HapticStopAll :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticStopEffect :: (haptic: *SDL_Haptic, effect: s32) -> s32 #foreign SDL2;
SDL_HapticUnpause :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticUpdateEffect :: (haptic: *SDL_Haptic, effect: s32, data: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_MouseIsHaptic :: () -> s32 #foreign SDL2;
SDL_NumHaptics :: () -> s32 #foreign SDL2;

