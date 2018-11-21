/* Copyright 2017 Baris Tosun
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H
#include "keymap_german.h"

#define ______ KC_NO
#define oooooo KC_TRNS

// Windows based definitions.
#define UNDO    LCTL(KC_Z)         // UNDO
#define CUT     LCTL(KC_X)         // CUT
#define COPY    LCTL(KC_C)         // COPY
#define PASTE   LCTL(KC_V)         // PASTE
#define CU_WIFI	KC_F13
#define CU_VUP	KC_F14
#define CU_VDO	KC_F15
#define CU_VMU  KC_F16
#define CU_MNXT KC_F17
#define CU_MPRE KC_F18
#define CU_MSTO KC_F20
#define CU_MPLY KC_F21
#define CU_BUP	KC_F22
#define CU_BDO	KC_F23

#define BASE 0 // Default
#define FN1 1 // Numbers

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

enum macro_id {
	CU_RBRC = SAFE_RANGE,
	CU_LBRC,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[BASE] = LAYOUT(
KC_ESC,	DE_1,	DE_2,	DE_3,	DE_4,	DE_5,	DE_6,	DE_7,	DE_8,	DE_9,	DE_0,	KC_MINS,DE_ACUT,KC_BSPC,KC_BSPC,
KC_TAB, KC_Q,   KC_W,   KC_E,   KC_R,   KC_T,	CU_LBRC,CU_RBRC,DE_Z,   KC_U,   KC_I,   KC_O,   KC_P,   KC_DEL,
KC_CAPS,KC_A,	KC_S,	KC_D,	KC_F,	KC_G,	KC_HOME,KC_PGUP,KC_H,	KC_J,	KC_K,	KC_L,	DE_HASH,KC_ENT,	
KC_LSFT,DE_LESS,DE_Y,	KC_X,	KC_C,	KC_V,	KC_B,	KC_END,	KC_PGDN,KC_N,	KC_M,	KC_COMM,KC_DOT,	DE_MINS,KC_RSFT,	
KC_LCTL,KC_LGUI,KC_LALT,KC_RALT,KC_SPC, DE_PLUS,KC_SPC,	MO(1),	KC_LEFT,KC_DOWN,KC_UP,	KC_RIGHT
),
[FN1] = LAYOUT(
RESET,	KC_F1,	KC_F2,	KC_F3,	KC_F4,	KC_F5,	KC_F6,	KC_F7,	KC_F8,	KC_F9,	KC_F10,	KC_F11,	KC_F12,	______,	______, 
______,	______,	______,	______,	______,	______,	______,	______,	______,	______,	______,	______,	______,	______,
______,	______,	______,	______,	______,	______,	CU_VUP, CU_BUP,	______,	______,	______,	______,	______,	______,
______, ______,	______,	______,	______,	______,	CU_VDO, CU_WIFI,CU_BDO,	______,	______,	______,	______,	______,	______,	
oooooo,	oooooo,	oooooo,	oooooo,	______,	CU_VMU,	KC_INS,	______,	CU_MPRE,CU_MSTO,CU_MPLY,CU_MNXT	
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
	}
    }
    return true;
}
