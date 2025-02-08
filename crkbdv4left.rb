require "consumer_key"
kbd = Keyboard.new
kbd.split = true
kbd.uart_pin = 13

kbd.init_direct_pins(
  [
    22, 20, 23, 26, 29,  0, 4, 25, 27,  1,  2,  3,  9,  8,
    19, 18, 24, 27,  1,  2, 8, 23, 26, 28,  0,  4, 14, 11,
    17, 16, 25, 28,  3,  9,        22, 20, 29,  5, 19, 15,
                14, 15, 11,        19, 17, 16,
  ]
)

kbd.add_layer :default, %i[
  KC_TAB  KC_Q  KC_W KC_E    KC_R  KC_T    KC_VOLU KC_VOLD KC_Y   KC_U  KC_I     KC_O   KC_P      KC_BSLS
  KC_ZKHK KC_A  KC_S KC_D    KC_F  KC_G    KC_PGUP KC_PGDN KC_H   KC_J  KC_K     KC_L   KC_SCOLON KC_QUOT
  KC_LSFT KC_Z  KC_X KC_C    KC_V  KC_B                    KC_M   KC_M  KC_COMMA KC_DOT KC_SLSH   KC_EQL
                     KC_BSPC L_SPC KC_LCTL                 KC_WIN R_ENT KC_RALT
]

kbd.define_mode_key :R_ENT,   [ :KC_ENTER,                 :raise,  150, 150 ]
kbd.define_mode_key :L_SPC,   [ :KC_SPACE,                 :lower,  150, 150 ]
kbd.define_mode_key :ADJUST,  [ nil,                       :adjust, nil, nil ]
kbd.define_mode_key :BOOTSEL, [ Proc.new { kbd.bootsel! }, nil,     300, nil ]

kbd.start!
