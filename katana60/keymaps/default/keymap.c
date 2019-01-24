#include QMK_KEYBOARD_H
#include "keymap_german.h"

#define ______ KC_NO
#define oooooo KC_TRNS

#define UNDO    LCTL(KC_Z)
#define CUT     LCTL(KC_X)
#define COPY    LCTL(KC_C)
#define PASTE   LCTL(KC_V)
#define CU_WIFI	KC_F13	// XF86Tools
#define CU_BUP	KC_F22	// XF86TouchpadOn
#define CU_BDO	KC_F23	// XF86TouchpadOff

#define BASE 0
#define FN1 1

bool raltset = false;
bool lsftset = false;
bool rsftset = false;

void printKey(bool ralt, bool sft, uint16_t keycode) {
	if (get_mods() & (MOD_BIT(KC_RALT))) {
		unregister_code(KC_RALT);
		raltset = true;
	}
	if (get_mods() & (MOD_BIT(KC_LSFT))) {
		unregister_code(KC_LSFT);
		lsftset = true;
	}
	if (get_mods() & (MOD_BIT(KC_RSFT))) {
		unregister_code(KC_RSFT);
		rsftset = true;
	}

	if (ralt) {
		register_code(KC_RALT);
	}
	if (sft) {
		register_code(KC_LSFT);
	}
	
	register_code(keycode);
	unregister_code(keycode);
	
	unregister_code(KC_RALT);
	unregister_code(KC_RSFT);
	unregister_code(KC_LSFT);

	if (raltset) {
		register_code(KC_RALT);	
	}
	if (lsftset) {
		register_code(KC_LSFT);
	}
	if (rsftset) {
		register_code(KC_RSFT);
	}

	raltset = false;
	lsftset = false;
	rsftset = false;
}

bool lguiset = false;

void lockScreen(void) {
	if (get_mods() & (MOD_BIT(KC_LGUI))) {
		unregister_code(KC_LGUI);
		raltset = true;
	}
	
	register_code(KC_LGUI);
	register_code(KC_L);
	unregister_code(KC_L);
	unregister_code(KC_LGUI);

	if (lguiset) {
		register_code(KC_LGUI);
	}

	lguiset = false;
}

enum macro_id {
	CU_RBRC = SAFE_RANGE,
	CU_LBRC,
	CU_LOCK,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/*
------------------------------------------------------------------------------------------------------------------------
|  ESC  |  DE 1 |  DE 2 |  DE 3 |  DE 4 |  DE 5 |  DE 6 |  DE 7 |  DE 8 |  DE 9 |  DE 0 |   ß   |   ´   |   Backspace  |
------------------------------------------------------------------------------------------------------------------------
|   TAB    | DE Q  |   W   |  DE E |   R   |   T   |  [ {  |  ] }  |   Z   |   U   |   I   |   O   |   P   |   Entf    |
------------------------------------------------------------------------------------------------------------------------
|  CAPS  |   A   |   S   |   D   |   F   |   G   |  HOME   |  PG UP  |   H   |   J   |   K   |   L   | DE  # |  ENTER  |
------------------------------------------------------------------------------------------------------------------------
| SHIFT | DE <  |   Y   |   X   |   C   |   V   |   B   |  END  | PG DO |   N   |   M   | DE , | DE .  | DE -  | SHIFT |
------------------------------------------------------------------------------------------------------------------------
| STRG  |   WIN   |   ALT   | ALT GR  |      SPACE      | DE +  |    SPACE     |  FN   | LEFT  | DOWN  |   UP  | RIGHT |
------------------------------------------------------------------------------------------------------------------------
*/

/*							ALT GR MOD
------------------------------------------------------------------------------------------------------------------------
|  ^ °  |       |       |       |       |       |       |       |       |       |       |       |       |              |
------------------------------------------------------------------------------------------------------------------------
|          |       |       |       |       |       |       |       |       |  ü Ü  |       |  ö Ö  |       |           |
------------------------------------------------------------------------------------------------------------------------
|        |  ä Ä  |       |       |       |       |         |         |       |       |       |       |       |         |
------------------------------------------------------------------------------------------------------------------------
|       |       |       |       |       |       |       |      |       |       |       |       |       |       |       |
------------------------------------------------------------------------------------------------------------------------
|       |         |         |         |                 |      |             |       |        |        |       |       |
------------------------------------------------------------------------------------------------------------------------
*/
[BASE] = LAYOUT(
KC_ESC,	DE_1,	DE_2,	DE_3,	DE_4,	DE_5,	DE_6,	DE_7,	DE_8,	DE_9,	DE_0,	KC_MINS,DE_ACUT,KC_BSPC,KC_BSPC,
KC_TAB, KC_Q,   KC_W,   KC_E,   KC_R,   KC_T,	CU_LBRC,CU_RBRC,DE_Z,   KC_U,   KC_I,   KC_O,   KC_P,   KC_DEL,
KC_CAPS,KC_A,	KC_S,	KC_D,	KC_F,	KC_G,	KC_HOME,KC_PGUP,KC_H,	KC_J,	KC_K,	KC_L,	DE_HASH,KC_ENT,	
KC_LSPO,DE_LESS,DE_Y,	KC_X,	KC_C,	KC_V,	KC_B,	KC_END,	KC_PGDN,KC_N,	KC_M,	KC_COMM,KC_DOT,	DE_MINS,KC_RSPC,	
KC_LCTL,KC_LGUI,KC_LALT,KC_RALT,KC_SPC, DE_PLUS,KC_SPC,	MO(1),	KC_LEFT,KC_DOWN,KC_UP,	KC_RIGHT
),
/*
------------------------------------------------------------------------------------------------------------------------
| FLASH |   F1  |   F2  |   F3  |   F4  |   F5  |   F6  |   F7  |   F8  |   F9  |  F10  |  F11  |  F12  |              |
------------------------------------------------------------------------------------------------------------------------
|          |MOUSE K|MOUSE U|MOUSE C|       |       |       |       |       |       |       |       |       |           |
------------------------------------------------------------------------------------------------------------------------
|        |MOUSE L|MOUSE D|MOUSE R|       |       |  VOL+   | BRIG +  |       |       |       | LOCK  |       |         |
------------------------------------------------------------------------------------------------------------------------
|       |       |       |       |       |       | VOL - |WIFI TOGGLE|  BRIG - |      |      |     |      |      |      |
------------------------------------------------------------------------------------------------------------------------
| STRG  |   WIN   |   ALT   | ALT GR  |      DRUCK     | MUTE  |   INSERT    |       | PREV  | STOP  |PLAY/PAUSE| NEXT |
------------------------------------------------------------------------------------------------------------------------
*/
[FN1] = LAYOUT(
RESET,	KC_F1,	KC_F2,	KC_F3,	KC_F4,	KC_F5,	KC_F6,	KC_F7,	KC_F8,	KC_F9,	KC_F10,	KC_F11,	KC_F12,	______,	______, 
______, KC_BTN1,KC_MS_U,KC_BTN2,______,	______,	______,	______,	______,	______,	______,	______,	______,	______,
______, KC_MS_L,KC_MS_D,KC_MS_R,______,	______,	KC_VOLU,CU_BUP,	______,	______,	______,	CU_LOCK,______,	______,
______, ______,	______,	______,	______,	______,	KC_VOLD,CU_WIFI,CU_BDO,	______,	______,	______,	______,	______,	______,	
oooooo,	oooooo,	oooooo,	oooooo,	KC_PSCR,KC_MUTE,KC_INS,	______,	KC_MPRV,KC_MSTP,KC_MPLY,KC_MNXT	
)
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (record->event.pressed) {
        switch(keycode) {
            case CU_LBRC:
		if (get_mods() & MOD_BIT(KC_LSFT)) {
			printKey(true,false,DE_7);
		} else if (get_mods() & MOD_BIT(KC_RSFT)) {
			printKey(true,false,DE_7);
		} else {
			printKey(true,false,DE_8);
		} 
                return false;
	    case CU_RBRC:
		if (get_mods() & MOD_BIT(KC_LSFT)) {
			printKey(true,false,DE_0);
		} else if (get_mods() & MOD_BIT(KC_RSFT)) {
			printKey(true,false,DE_0);
		} else {
			printKey(true,false,DE_9);
		}
		return false;
	    case KC_O:
		if (get_mods() & (MOD_BIT(KC_RALT))) {
			if (get_mods() & (MOD_BIT(KC_LSFT))) {
				printKey(false,true,DE_OE);
			} else if (get_mods() & (MOD_BIT(KC_RSFT))) {
				printKey(false,true,DE_OE);
			} else {
				printKey(false,false,DE_OE);
			}
			return false;
		} else {
			return true;
		}	
	    case KC_U:
		if (get_mods() & (MOD_BIT(KC_RALT))) {
			if (get_mods() & (MOD_BIT(KC_LSFT))) {
				printKey(false,true,DE_UE);
			} else if (get_mods() & (MOD_BIT(KC_RSFT))) {
				printKey(false,true,DE_UE);
			} else {
				printKey(false,false,DE_UE);
			}
			return false;
		} else {
			return true;
		}	
	    case KC_A:
		if (get_mods() & (MOD_BIT(KC_RALT))) {
			if (get_mods() & (MOD_BIT(KC_LSFT))) {
				printKey(false,true,DE_AE);
			} else if (get_mods() & (MOD_BIT(KC_RSFT))) {
				printKey(false,true,DE_AE);
			} else {
				printKey(false,false,DE_AE);
			}
			return false;
		} else {
			return true;
		}
	    case KC_ESC:
		if (get_mods() & (MOD_BIT(KC_LSFT))) {
			if (get_mods() & (MOD_BIT(KC_RALT))) {
				printKey(false,true,DE_CIRC);
			} else {
				printKey(false,false,DE_CIRC);
			}
		} else {
			return true;
		}
	    case CU_LOCK:
		lockScreen();
		return false;

	}
    }
        switch(keycode) {
		case KC_ESC:
		  if (get_mods() & (MOD_BIT(KC_LSFT))) {
			register_code(KC_BSPC);
			unregister_code(KC_BSPC);
		  }
	}
    return true;
}
