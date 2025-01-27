kbd = Keyboard.new
kbd.split = true
kbd.mutual_uart_at_my_own_risk = true

kbd.init_direct_pins(
  [
    34,  31,  35, 38, 41,  2,   6,
    30,  29,  36, 11,  3,  4,  11,
    28,  27,  37, 40,  5, 12, nil,
   nil, nil, nil, 17, 18, 14, nil
  ]
)

kbd.add_layer :default, %i[
  KC_TAB  KC_Q  KC_W  KC_E KC_R      KC_T     KC_NO    KC_NO   KC_Y      KC_U    KC_I     KC_O   KC_P      KC_MINUS
  KC_ZKHK KC_A  KC_S  KC_D KC_F      KC_G     KC_NO    KC_NO   KC_H      KC_J    KC_K     KC_L   KC_SCOLON KC_QUOTE
  KC_LSFT KC_Z  KC_X  KC_C KC_V      KC_B                      KC_N      KC_M    KC_COMMA KC_DOT KC_SLASH  KC_EQUAL
  KC_NO   KC_NO KC_NO KC_BSPACE LOWER_SPC KC_LCTL KC_RGUI RAISE_ENT KC_RALT
]

kbd.define_mode_key :RAISE_ENT, [ :KC_ENTER,                 :raise,  150, 150 ]
kbd.define_mode_key :LOWER_SPC, [ :KC_SPACE,                 :lower,  150, 150 ]
kbd.define_mode_key :ADJUST,    [ nil,                       :adjust, nil, nil ]
kbd.define_mode_key :BOOTSEL,   [ Proc.new { kbd.bootsel! }, nil,     300, nil ]

kbd.start!
