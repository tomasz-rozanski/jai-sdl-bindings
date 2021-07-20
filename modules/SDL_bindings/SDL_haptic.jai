// SDL_haptic.h

SDL_HAPTIC_CONSTANT     :: 0x0001;
SDL_HAPTIC_SINE         :: 0x0002;
SDL_HAPTIC_LEFTRIGHT    :: 0x0004;
SDL_HAPTIC_TRIANGLE     :: 0x0008;
SDL_HAPTIC_SAWTOOTHUP   :: 0x0010;
SDL_HAPTIC_SAWTOOTHDOWN :: 0x0020; 
SDL_HAPTIC_RAMP         :: 0x0040; 
SDL_HAPTIC_SPRING       :: 0x0080; 
SDL_HAPTIC_DAMPER       :: 0x0100; 
SDL_HAPTIC_INERTIA      :: 0x0200; 
SDL_HAPTIC_FRICTION     :: 0x0400; 
SDL_HAPTIC_CUSTOM       :: 0x0800; 
SDL_HAPTIC_GAIN         :: 0x1000; 
SDL_HAPTIC_AUTOCENTER   :: 0x2000; 
SDL_HAPTIC_STATUS       :: 0x4000; 
SDL_HAPTIC_PAUSE        :: 0x8000; 

SDL_HAPTIC_POLAR         :: 0;
SDL_HAPTIC_CARTESIAN     :: 1;
SDL_HAPTIC_SPHERICAL     :: 2;
SDL_HAPTIC_STEERING_AXIS :: 3;

SDL_HAPTIC_INFINITY   :: 4_294_967_295;


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
    type: u16 = SDL_HAPTIC_CONSTANT; // SDL_HAPTIC_CONSTANT 
    direction: SDL_HapticDirection;  // Direction of the effect

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
    type: u16 = SDL_HAPTIC_CUSTOM;  // SDL_HAPTIC_CUSTOM
    direction: SDL_HapticDirection; // Direction of the effect

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
    type: u16 = SDL_HAPTIC_LEFTRIGHT; // SDL_HAPTIC_LEFTRIGHT

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
    type: u16 = SDL_HAPTIC_RAMP;    // SDL_HAPTIC_RAMP
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

SDL_HapticNumEffectsPlaying :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticOpenFromMouse :: () -> *SDL_Haptic #foreign SDL2;
SDL_HapticSetAutocenter :: (haptic: *SDL_Haptic, autocenter: s32) -> s32 #foreign SDL2;
SDL_HapticSetGain :: (haptic: *SDL_Haptic, gain: s32) -> s32 #foreign SDL2;
SDL_HapticUnpause :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticUpdateEffect :: (haptic: *SDL_Haptic, effect: s32, data: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_MouseIsHaptic :: () -> s32 #foreign SDL2;
SDL_NumHaptics :: () -> s32 #foreign SDL2;
// Tested
SDL_JoystickIsHaptic :: (joystick: *SDL_Joystick) -> s32 #foreign SDL2;
SDL_HapticOpenFromJoystick :: (joystick: *SDL_Joystick) -> *SDL_Haptic #foreign SDL2;
SDL_HapticRumbleInit :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticClose :: (haptic: *SDL_Haptic) #foreign SDL2;
SDL_HapticRumblePlay :: (haptic: *SDL_Haptic, strength: float, length: u32 ) -> s32 #foreign SDL2;
SDL_HapticDestroyEffect :: (haptic: *SDL_Haptic, effect: s32) #foreign SDL2;
SDL_HapticNewEffect :: (haptic: *SDL_Haptic, effect: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_HapticQuery :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticRunEffect :: (haptic: *SDL_Haptic, effect: s32, iterations: u32) -> s32 #foreign SDL2;
SDL_HapticRumbleSupported :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticStopAll :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticRumbleStop :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticStopEffect :: (haptic: *SDL_Haptic, effect: s32) -> s32 #foreign SDL2;
SDL_HapticGetEffectStatus :: (haptic: *SDL_Haptic, effect: s32) -> s32 #foreign SDL2;
SDL_HapticEffectSupported :: (haptic: *SDL_Haptic, effect: *SDL_HapticEffect) -> s32 #foreign SDL2;
SDL_HapticIndex :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticName :: (device_index: s32) -> *u8 #foreign SDL2;
SDL_HapticNumAxes :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticNumEffects :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;
SDL_HapticOpen :: (device_index: s32) -> *SDL_Haptic #foreign SDL2;
SDL_HapticOpened :: (device_index: s32) -> s32 #foreign SDL2;
// Somewhat tested
SDL_HapticPause :: (haptic: *SDL_Haptic) -> s32 #foreign SDL2;

// Test procedures
test_haptic_joyistick_is_haptic :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        haptic := SDL_JoystickIsHaptic(controller);
        log("%1SDL_JoystickIsHaptic%3 returned: %2%4%3\n", CYAN, GREEN, NORMAL, cast(SDL_bool) haptic);
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }

    // Close everything
    SDL_JoystickClose(controller);
    controller = null;

    SDL_Quit();
}

test_haptic_open_from_joystick :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;
    controller_haptic: *SDL_Haptic;

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        controller_haptic = SDL_HapticOpenFromJoystick(controller);
        log("%1SDL_HapticOpenFromJoystick%3 returned:%2 0x%4\n%3", CYAN, GREEN, NORMAL, controller_haptic);
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }

    // Close everything
    SDL_HapticClose(controller_haptic);
    SDL_JoystickClose(controller);
    controller_haptic = null;
    controller = null;

    SDL_Quit();
}

test_haptic_rumble_init :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;
    controller_haptic: *SDL_Haptic;
    rumble_init: s32;

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        controller_haptic = SDL_HapticOpenFromJoystick(controller);
        if controller_haptic {
            rumble_init = SDL_HapticRumbleInit(controller_haptic);
            if rumble_init < 0 {
                log("%1Warning: unable to initialize rumble!%2", RED, NORMAL);
            } else {
                log("Rumble initialized successfully!");
                log("%1SDL_HapticRumbleInit%3 returned: %2%4%3", CYAN, GREEN, NORMAL, rumble_init);
            }
        } else {
            log("%1Warning: controller does not support haptics!%2", RED, NORMAL);
        }
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }

    // Close everything
    SDL_HapticClose(controller_haptic);
    SDL_JoystickClose(controller);
    controller_haptic = null;
    controller = null;

    SDL_Quit();
}

test_haptic_rumble_play :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;
    controller_haptic: *SDL_Haptic;
    rumble_init: s32;

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        controller_haptic = SDL_HapticOpenFromJoystick(controller);
        if controller_haptic {
            rumble_init = SDL_HapticRumbleInit(controller_haptic);
            if rumble_init != 0 {
                log("Warning: unable to initialize rumble!");
                return;
            } 
        } else {
            log("%1Warning: controller does not support haptics!%2", RED, NORMAL);
        }
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }

    rumble_strength: float; // 0.0 -> 1.0
    rumble_length: u32; // miliseconds 
    rumble_play: s32;

    // main loop
    print("Press button 4 to exit\n");
    exit := false;
    while !exit {
        event : SDL_Event;
        while SDL_PollEvent(*event) {
            if event.type == {
                case SDL_QUIT;
                exit = true;
                case SDL_KEYUP;
                if event.key.keysym.sym == { 
                    case SDLK_ESCAPE; exit = true;
                }
                case SDL_JOYBUTTONDOWN;
                if event.jbutton.button == {
                    case 0; 
                    rumble_strength = 0.5;
                    rumble_length = 1_000;
                    rumble_play = SDL_HapticRumblePlay(controller_haptic, rumble_strength, rumble_length);
                    if rumble_play != 0 {
                        log("%1Error: SDL_HapticRumblePlay returned error %3%2", RED, NORMAL, SDL_GetError());
                    } else {
                        log("%1SDL_HapticRumblePlay%2 with strength of %3, and length of %4 ms", CYAN, NORMAL, rumble_strength, rumble_length);
                    }

                    case 1; 
                    rumble_strength = 0.1;
                    rumble_length = 1_000;
                    rumble_play = SDL_HapticRumblePlay(controller_haptic, rumble_strength, rumble_length);
                    if rumble_play != 0 {
                        log("%1Error: SDL_HapticRumblePlay returned error %3%2", RED, NORMAL, SDL_GetError());
                    } else {
                        log("%1SDL_HapticRumblePlay%2 with strength of %3, and length of %4 ms", CYAN, NORMAL, rumble_strength, rumble_length);
                    }
                    case 2; 
                    rumble_strength = 1;
                    rumble_length = 100;
                    rumble_play = SDL_HapticRumblePlay(controller_haptic, rumble_strength, rumble_length);
                    if rumble_play != 0 {
                        log("%1Error: SDL_HapticRumblePlay returned error %3%2", RED, NORMAL, SDL_GetError());
                    } else {
                        log("%1SDL_HapticRumblePlay%2 with strength of %3, and length of %4 ms", CYAN, NORMAL, rumble_strength, rumble_length);
                    }
                    case 3; exit = true;
                }
            }

            SDL_Delay(200);
           // SDL_Delay(3_000); // let the whole rumble effect play
        }
    }

    // Close everything
    SDL_HapticClose(controller_haptic);
    SDL_JoystickClose(controller);
    controller_haptic = null;
    controller = null;

    SDL_Quit();
}

test_haptic_new_effect :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;
    controller_haptic: *SDL_Haptic;
    effect: SDL_HapticEffect;
    effect_id: s32;

    Haptic_Query :: struct {
        name: string;
        value: u16;
        support: bool;
    }

    haptic_effects: [16] Haptic_Query = .[
    .{"SDL_HAPTIC_CONSTANT"     ,SDL_HAPTIC_CONSTANT,     false},
    .{"SDL_HAPTIC_SINE"         ,SDL_HAPTIC_SINE,         false},
    .{"SDL_HAPTIC_LEFTRIGHT"    ,SDL_HAPTIC_LEFTRIGHT,    false},
    .{"SDL_HAPTIC_TRIANGLE"     ,SDL_HAPTIC_TRIANGLE,     false},
    .{"SDL_HAPTIC_SAWTOOTHUP"   ,SDL_HAPTIC_SAWTOOTHUP,   false},
    .{"SDL_HAPTIC_SAWTOOTHDOWN" ,SDL_HAPTIC_SAWTOOTHDOWN, false},
    .{"SDL_HAPTIC_RAMP"         ,SDL_HAPTIC_RAMP,         false},
    .{"SDL_HAPTIC_SPRING"       ,SDL_HAPTIC_SPRING,       false},       
    .{"SDL_HAPTIC_DAMPER"       ,SDL_HAPTIC_DAMPER,       false},       
    .{"SDL_HAPTIC_INERTIA"      ,SDL_HAPTIC_INERTIA,      false},      
    .{"SDL_HAPTIC_FRICTION"     ,SDL_HAPTIC_FRICTION,     false},     
    .{"SDL_HAPTIC_CUSTOM"       ,SDL_HAPTIC_CUSTOM,       false},       
    .{"SDL_HAPTIC_GAIN"         ,SDL_HAPTIC_GAIN,         false},         
    .{"SDL_HAPTIC_AUTOCENTER"   ,SDL_HAPTIC_AUTOCENTER,   false},   
    .{"SDL_HAPTIC_STATUS"       ,SDL_HAPTIC_STATUS,       false},       
    .{"SDL_HAPTIC_PAUSE"        ,SDL_HAPTIC_PAUSE,        false}
    ];

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        controller_haptic = SDL_HapticOpenFromJoystick(controller);
        if controller_haptic {

            query := SDL_HapticQuery(controller_haptic);
            print("%1\nController haptics capabilities:%2\n", GREEN, NORMAL);
            for *haptic_effects {
                if query & it.value {
                    log("%", haptic_effects[it_index].name);
                    haptic_effects[it_index].support = true;
                }
            }

            if ((SDL_HapticQuery(controller_haptic) & SDL_HAPTIC_LEFTRIGHT) == 0) {
                log("%1Warning: No sine-wave effect%2", RED, NORMAL);
                SDL_HapticClose(controller_haptic);
                return;
            }

            effect.type = SDL_HAPTIC_LEFTRIGHT;
            effect.leftright.length = 1_000;
            effect.leftright.large_magnitude = 10_000;
            effect.leftright.small_magnitude = 20_000;

            print("\nPlaying SDL_HAPTIC_LEFTRIGHT effect\n");
            effect_id = SDL_HapticNewEffect(controller_haptic, *effect);

            SDL_HapticRunEffect(controller_haptic, effect_id, 1);

            SDL_Delay(200);

            // @todo add tests for the rest of the effects with some nice default values

        } else {
            log("%1Warning: controller does not support haptics!%2", RED, NORMAL);
        }
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }


    // Close everything
    SDL_HapticDestroyEffect(controller_haptic, effect_id);
    SDL_HapticClose(controller_haptic);
    SDL_JoystickClose(controller);
    controller_haptic = null;
    controller = null;

    SDL_Quit();
}

test_haptic_stuff :: () {
    proc_name: string = current_proc_name();
    print("\n%1=== %3 ===%2\n", YELLOW, NORMAL, proc_name); 

    controller: *SDL_Joystick;
    haptic: *SDL_Haptic;
    effect: SDL_HapticEffect;
    effect_id: s32;

    SDL_Init(SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC);

    if SDL_NumJoysticks() {
        controller = SDL_JoystickOpen(0);

        haptic = SDL_HapticOpenFromJoystick(controller);
        if haptic {
            index := SDL_HapticIndex(haptic);
            print("Controller index: %\n", index);
            print("Controller name: %\n", to_string(SDL_HapticName(index)));
            print("Controller haptic axes: %\n", SDL_HapticNumAxes(haptic));
            print("Controller haptic effects: %\n", SDL_HapticNumEffects(haptic));

            haptic = SDL_HapticOpen(index);
            if !haptic {
                log("Error: can't open haptic device with index %", index);
            } else {
                log("SDL_HapticOpen succedded. Device address: %", haptic);
            }

            opened := SDL_HapticOpened(index); // seems buggy; showed succes after SDL_HapticClose()

            if opened == 1 {
                log("Device with index % is opened", index);
            } else {
                log("Device with index % is not opened", index);
            }

            SDL_Delay(200);
        } else {
            log("%1Warning: controller does not support haptics!%2", RED, NORMAL);
        }
    } else {
        log("%1Warning: no controllers connected!%2", RED, NORMAL);
    }


    // Close everything
    SDL_HapticClose(haptic);
    if controller SDL_JoystickClose(controller);
    haptic = null;
    controller = null;

    SDL_Quit();
}

test_haptic_module :: () {
    test_haptic_joyistick_is_haptic();
    test_haptic_open_from_joystick();
    test_haptic_rumble_init();
    test_haptic_rumble_play();
    test_haptic_new_effect();
    test_haptic_stuff();
}

//#run test_haptic_module();

