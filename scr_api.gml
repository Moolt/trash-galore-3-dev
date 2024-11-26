// API Version 1.1.0

// -- Changelog --
// 1.1.0: Adds methods for playing sounds and music

#macro API global.api

if(global[$ "launcher"] == undefined) {
	global.launcher = {};
}

enum INPUT_ACTION {
    UI_NAVIGATE_UP,
    UI_NAVIGATE_DOWN,
    UI_NAVIGATE_LEFT,
    UI_NAVIGATE_RIGHT,
    UI_SELECT,
    UI_BACK,
    UI_QUIT,
    MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    ACTION_PRIMARY,
    ACTION_SECONDARY
}

function _api_base() constructor {
	in_memory_database = ds_map_create();
	
	/**
	* Navigates back to the main menu.
	*/
	function goto_main_menu() {
		show_debug_message("[Not implemented] Navigating to main menu...");
	}
	
	/**
	* Unlocks an achievement.
	* 
	* @param {string} _identifier - The identifier defined in game.json.
	*/
	function achievement_unlock(_identifier) {
		show_debug_message("[Not implemented] Unlocked achievement " + _identifier);
	}
	
	/**
	* Checks if an achievement is unlocked.
	* 
	* @param {string} _identifier - The identifier defined in game.json.
	* @returns {boolean} True if the achievement is unlocked, false otherwise.
	*/
	function achievement_is_unlocked(_identifier) {
		return false;
	}
	
	/**
	* Gets the volume level of the music channel.
	* 
	* @returns {number} A value between 0 and 1 representing the music volume.
	*/
	function audio_get_music_volume() {
		return 1;
	}
	
	/**
	* Gets the volume level of the sound channel.
	* 
	* @returns {number} A value between 0 and 1 representing the sound volume.
	*/
	function audio_get_sound_volume() {
		return 1;
	}
	
	/**
	* Checks if a specific action was pressed in the current frame.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action was pressed, false otherwise.
	*/
	function action_check_pressed(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_pressed, gamepad_button_check_pressed);
	}

	/**
	* Checks if a specific action was released in the current frame.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action was released, false otherwise.
	*/
	function action_check_released(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_released, gamepad_button_check_released);
	}

	/**
	* Checks if a specific action is currently being pressed.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action is currently pressed, false otherwise.
	*/
	function action_check(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check, gamepad_button_check);
	}
	
	/**
	* Persists a number value between game restarts.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {real} _real - The number value to persist
	*/
	function write_real(_game_name, _identifier, _real) {
		in_memory_database[? _identifier] = _real;
	}
	
	/**
	* Loads a previously persisted number value or returns 0 if the identifier is unknown.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {real} _default_value - The value to return if no entry for the given _identifier exists
	* @returns {real} A previously persisted number value or 0 if the identifier is unknown.
	*/
	function read_real(_game_name, _identifier, _default_value = 0) {
		return in_memory_database[? _identifier] ?? _default_value;
	}
	
	/**
	* Persists a string value between game restarts.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {string} _string - The string value to persist
	*/
	function write_string(_game_name, _identifier, _string) {
		in_memory_database[? _identifier] = _string;
	}
	
	/**
	* Loads a previously persisted string value or returns an empty string if the identifier is unknown.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {string} _default_value - The value to return if no entry for the given _identifier exists
	* @returns {string} A previously persisted string value or and empty string if the identifier is unknown.
	*/
	function read_string(_game_name, _identifier, _default_value = "") {
		return in_memory_database[? _identifier] ?? _default_value;
	}
	
	/**
	* Persists a boolean value between game restarts.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {bool} _boolean - The boolean value to persist
	*/
	function write_boolean(_game_name, _identifier, _boolean) {
		in_memory_database[? _identifier] = _boolean;		
	}
	
	/**
	* Loads a previously persisted boolean value or returns false if the identifier is unknown.
	* 
	* @param {string} _game_name - The name of your game. Preferable the name mentioned in the game.json.
	* @param {string} _identifier - The identifier of the value
	* @param {bool} _default_value - The value to return if no entry for the given _identifier exists
	* @returns {bool} A previously persisted boolean value or false if the identifier is unknown.
	*/
	function read_boolean(_game_name, _identifier, _default_value = false) {
		return in_memory_database[? _identifier] ?? _default_value;
	}
	
	/**
	* Reads the localized value for the given _key or returns the _fallback value.
	* 
	* @param {string} _key - A unique key to identify the localized text with
	* @param {string} _fallback - A fallback value to be returned in case no text for the given _key or locale exists.
	* @returns {string} A localized string
	*/
	function localize(_key, _fallback = "") {
		return _fallback;
	}
	
	/**
	* Reads the localized value for the given _key or returns the _fallback value. All {} placeholders will be replaced with the values passed in _args.
	* 
	* @param {string} _key - A unique key to identify the localized text with
	* @param {array} _args - A list of values to be replaced with any {} placeholders in the localized string.
	* @param {string} _fallback - A fallback value to be returned in case no text for the given _key or locale exists.
	* @returns {string} A localized string
	*/
	function localize_args(_key, _args, _fallback = "") {
		var _result = _fallback;
		
		for(var _i = 0; _i < array_length(_args); _i++) {
			_result = string_replace(_result, "{}", _args[_i]);
		}
		
		return _result;
	}
	
	/**
	* This function plays any sound asset in your game using any combination of parameters.
	* 
	* @param {Struct} _struct - A struct containing the key-value pairs for each of the parameters that you want to set. The sound key is required and takes a Sound Asset as a value.
	* 
	* @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	*/
	function play_sound_ext(_struct) {
		return audio_play_sound_ext(_struct);
    }

	/**
	* Plays a sound on a specific audio emitter and registers it for gain management.
	* 
	* @param {asset} _sound - The sound asset to play.
	* @param {real} _emitter - The audio emitter to attach the sound to.
	* @param {boolean} [_loop=false] - Whether the sound should loop.
	* @param {real} [_gain=1] - Initial gain (volume) for the sound.
	* @param {real} [_pitch=1] - Pitch adjustment for the sound.
	* @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	* 
	* @returns {Id.Sound} - The sound instance ID, or -1 if the sound could not be played.
	*/
    function play_sound_on(_sound, _emitter, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return audio_play_sound_on(_sound, _emitter, _loop, _gain, _pitch, _listener_mask);
    }

	/**
	* Plays a 3D sound at a specified position with extended parameters and registers it for gain management.
	* 
	* @param {asset} _sound - The sound asset to play.
	* @param {real} _x - X-coordinate of the sound's position.
	* @param {real} _y - Y-coordinate of the sound's position.
	* @param {real} _z - Z-coordinate of the sound's position.
	* @param {real} [_falloff_ref=1] - Reference distance for sound attenuation.
	* @param {real} [_falloff_max=100] - Maximum distance for sound attenuation.
	* @param {real} [_falloff_factor=1] - Factor controlling the rate of falloff.
	* @param {boolean} [_loop=false] - Whether the sound should loop.
	* @param {real} [_gain=1] - Initial gain (volume) for the sound.
	* @param {real} [_pitch=1] - Pitch adjustment for the sound.
	* @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	* 
	* @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	*/
    function play_sound_at(_sound, _x, _y, _z, _falloff_ref = 1, _falloff_max = 100, _falloff_factor = 1, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return audio_play_sound_at(_sound, _x, _y, _z, _falloff_ref, _falloff_max, _falloff_factor, _loop, _gain, _pitch, _listener_mask);
    }

	/**
	* Plays a sound with optional extended parameters and registers it for gain management.
	* 
	* @param {asset} _sound - The sound asset to play.
	* @param {real} [_priority=1] - Priority of the sound (higher value plays first if resources are limited).
	* @param {boolean} [_loop=false] - Whether the sound should loop.
	* @param {real} [_gain=1] - Initial gain (volume) for the sound.
	* @param {real} [_offset=0] - The time (in seconds) to set the start point to. Values longer than the length of the given sound are ignored.
	* @param {real} [_pitch=1] - Pitch adjustment for the sound.
	* @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	* 
	* @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	*/
    function play_sound(_sound, _priority = 1, _loop = false, _gain = 1, _offset = 0, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
        return audio_play_sound(_sound, _priority, _loop, _gain, _offset, _pitch, _listener_mask);
    }
	
	/**
	* This function plays any sound asset in your game using any combination of parameters.
	* 
	* @param {Struct} _struct - A struct containing the key-value pairs for each of the parameters that you want to set. The sound key is required and takes a Sound Asset as a value.
	* 
	* @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	*/
	function play_music_ext(_struct) {
		return audio_play_sound_ext(_struct);
    }

	/**
	* Plays a sound on a specific audio emitter and registers it for gain management.
	* 
	* @param {asset} _sound - The sound asset to play.
	* @param {real} _emitter - The audio emitter to attach the sound to.
	* @param {boolean} [_loop=false] - Whether the sound should loop.
	* @param {real} [_gain=1] - Initial gain (volume) for the sound.
	* @param {real} [_pitch=1] - Pitch adjustment for the sound.
	* @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	* 
	* @returns {Id.Sound} - The sound instance ID, or -1 if the sound could not be played.
	*/
    function play_music_on(_sound, _emitter, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return audio_play_sound_on(_sound, _emitter, _loop, _gain, _pitch, _listener_mask);
    }

	/**
	* Plays a 3D sound at a specified position with extended parameters and registers it for gain management.
	* 
	* @param {asset} _sound - The sound asset to play.
	* @param {real} _x - X-coordinate of the sound's position.
	* @param {real} _y - Y-coordinate of the sound's position.
	* @param {real} _z - Z-coordinate of the sound's position.
	* @param {real} [_falloff_ref=1] - Reference distance for sound attenuation.
	* @param {real} [_falloff_max=100] - Maximum distance for sound attenuation.
	* @param {real} [_falloff_factor=1] - Factor controlling the rate of falloff.
	* @param {boolean} [_loop=false] - Whether the sound should loop.
	* @param {real} [_gain=1] - Initial gain (volume) for the sound.
	* @param {real} [_pitch=1] - Pitch adjustment for the sound.
	* @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	* 
	* @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	*/
    function play_music_at(_sound, _x, _y, _z, _falloff_ref = 1, _falloff_max = 100, _falloff_factor = 1, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return audio_play_sound_at(_sound, _x, _y, _z, _falloff_ref, _falloff_max, _falloff_factor, _loop, _gain, _pitch, _listener_mask);
    }

	/**
	 * Plays a sound with optional extended parameters and registers it for gain management.
	 * 
	 * @param {asset} _sound - The sound asset to play.
	 * @param {real} [_priority=1] - Priority of the sound (higher value plays first if resources are limited).
	 * @param {boolean} [_loop=false] - Whether the sound should loop.
	 * @param {real} [_gain=1] - Initial gain (volume) for the sound.
	 * @param {real} [_offset=0] - The time (in seconds) to set the start point to. Values longer than the length of the given sound are ignored.
	 * @param {real} [_pitch=1] - Pitch adjustment for the sound.
	 * @param {real} [_listener_mask=0xFFFFFFFF] - Listener mask for 3D sound.
	 * 
	 * @returns {Sound.Id} - The sound instance ID, or -1 if the sound could not be played.
	 */
    function play_music(_sound, _priority = 1, _loop = false, _gain = 1, _offset = 0, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
        return audio_play_sound(_sound, _priority, _loop, _gain, _offset, _pitch, _listener_mask);
    }
}

global.api = new _api_base();
global.launcher.controls = new _controls();

function _controls() constructor {
	keyboard_bindings = ds_map_create();
	gamepad_bindings = ds_map_create();

	// -- Gamepad Controls --
	// UI
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [ord("W"), vk_up];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [ord("S"), vk_down];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [ord("A"), vk_left];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [ord("D"), vk_right];
	keyboard_bindings[? INPUT_ACTION.UI_SELECT] = [vk_enter];
	keyboard_bindings[? INPUT_ACTION.UI_BACK] = [vk_escape];
	keyboard_bindings[? INPUT_ACTION.UI_QUIT] = [vk_escape];

	// Movement
	keyboard_bindings[? INPUT_ACTION.MOVE_UP] = [ord("W"), vk_up];
	keyboard_bindings[? INPUT_ACTION.MOVE_DOWN] = [ord("S"), vk_down];
	keyboard_bindings[? INPUT_ACTION.MOVE_LEFT] = [ord("A"), vk_left];
	keyboard_bindings[? INPUT_ACTION.MOVE_RIGHT] = [ord("D"), vk_right];

	// Gameplay Actions
	keyboard_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [vk_space];
	keyboard_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [ord("E")];

	// -- Gamepad Controls --
	// UI 
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [gp_padu];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [gp_padd];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [gp_padl];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [gp_padr];
	gamepad_bindings[? INPUT_ACTION.UI_SELECT] = [gp_face1];
	gamepad_bindings[? INPUT_ACTION.UI_BACK] = [gp_face2];
	gamepad_bindings[? INPUT_ACTION.UI_QUIT] = [gp_start];

	// Movement
	gamepad_bindings[? INPUT_ACTION.MOVE_UP] = [gp_axislv];
	gamepad_bindings[? INPUT_ACTION.MOVE_DOWN] = [gp_axislv];
	gamepad_bindings[? INPUT_ACTION.MOVE_LEFT] = [gp_axislh];
	gamepad_bindings[? INPUT_ACTION.MOVE_RIGHT] = [gp_axislh];

	// Gameplay Actions
	gamepad_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [gp_face1];
	gamepad_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [gp_face2];

	global.gamepad_id = -1; // Default to -1, indicating no gamepad

	function find_controller() {
		for (var _i = 0; _i < 12; _i++) {
		    if (gamepad_is_connected(_i)) {
		        global.gamepad_id = _i;
		        break;
		    }
		}
	}

	function check_keyboard_any(_action, _check_method) {
		var _bindings = keyboard_bindings[? _action];
	
		if(is_undefined(_bindings)) {
			return false;
		}
	
	    for (var _i = 0; _i < array_length(_bindings); _i++) {
	        if (_check_method(_bindings[_i])) {
	            return true;
	        }
	    }
	
	    return false;
	}

	function check_gamepad_any(_action, _check_method) {
		if(global.gamepad_id == -1) {
	        find_controller();
	    }
	
		if(global.gamepad_id == -1) {
	        return false;
	    }
	
		var _bindings = gamepad_bindings[? _action];
	
		if(is_undefined(_bindings)) {
			return false;
		}
	
	    for (var _i = 0; _i < array_length(_bindings); _i++) {
	        if (_check_method(global.gamepad_id, _bindings[_i])) {
	            return true;
	        }
	    }
	
	    return false;
	}

	function check_any(_action, _keyboard_check, _gamepad_check) {
		if(check_keyboard_any(_action, _keyboard_check)) {
			return true;
		}
	
		if(check_gamepad_any(_action, _gamepad_check)) {
			return true;
		}
	
		return false;
	}
}
