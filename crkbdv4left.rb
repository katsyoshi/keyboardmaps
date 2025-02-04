kbd = Keyboard.new
kbd.split = true
kbd.mutual_uart_at_my_own_risk = true

kbd.init_direct_pins(
  [
    22, 20, 23, 26, 29, 0, 4,
    19, 18, 24, 27,  1, 2, 8,
    17, 16, 25, 28,  3, 9,
                14, 15, 11
  ]
)

kbd.add_layer :default, %i[
  KC_TAB  KC_Q  KC_W KC_E      KC_R      KC_T    KC_VOLUP
  KC_ZKHK KC_A  KC_S KC_D      KC_F      KC_G    KC_PGUP
  KC_LSFT KC_Z  KC_X KC_C      KC_V      KC_B
                     KC_BSPACE LOWER_SPC KC_LCTL
]

kbd.define_mode_key :RAISE_ENT, [ :KC_ENTER,                 :raise,  150, 150 ]
kbd.define_mode_key :LOWER_SPC, [ :KC_SPACE,                 :lower,  150, 150 ]
kbd.define_mode_key :ADJUST,    [ nil,                       :adjust, nil, nil ]
kbd.define_mode_key :BOOTSEL,   [ Proc.new { kbd.bootsel! }, nil,     300, nil ]

kbd.start!
