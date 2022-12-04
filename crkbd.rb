require "sounder"
# Initialize a Keyboard
kbd = Keyboard.new

# `split=` should happen before `init_pins`
kbd.split = true

kbd.mutual_uart_at_my_own_risk = true

# If your right hand of CRKBD is the "anchor"
# kbd.set_anchor(:right)

# Initialize GPIO assign
kbd.init_pins(
  [ 4, 5, 6, 7 ],            # row0, row1,... respectively
  [ 29, 28, 27, 26, 18, 20 ] # col0, col1,... respectively
)

kbd.add_layer :default, [
# LEFT BOARD                                                   #RIGHT BOARD
#|           |       |       |           |           |         |         |           |          |        |           |
  :KC_ESCAPE, :KC_Q,  :KC_W,  :KC_E,      :KC_R,      :KC_T,    :KC_Y,    :KC_U,      :KC_I,     :KC_O,   :KC_P,      :KC_BSLASH,
  :KC_TAB,    :KC_A,  :KC_S,  :KC_D,      :KC_F,      :KC_G,    :KC_H,    :KC_J,      :KC_K,     :KC_L,   :KC_SCOLON, :KC_QUOTE,
  :KC_LSFT,   :KC_Z,  :KC_X,  :KC_C,      :KC_V,      :KC_B,    :KC_N,    :KC_M,      :KC_COMMA, :KC_DOT, :KC_SLASH,  :KC_MINUS,
  :KC_NO,     :KC_NO, :KC_NO, :KC_BSPACE, :LOWER_SPC, :KC_LCTL, :KC_RGUI, :RAISE_ENT, :KC_RALT,  :KC_NO,  :KC_NO,     :KC_NO,
#|           |       |       |           |           |         |         |           |          |        |           |
]
kbd.add_layer :raise, [
# LEFT BOARD                                                       #RIGHT BOARD
#|          |         |         |             |         |          |         |           |          |          |          |
  :KC_GRAVE, :KC_EXLM, :KC_AT,   :KC_HASH,     :KC_DLR,  :KC_PERC,  :KC_CIRC, :KC_AMPR,   :KC_ASTER, :KC_LPRN,  :KC_RPRN,  :KC_PIPE,
  :KC_TAB,   :KC_LABK, :KC_LCBR, :KC_LBRACKET, :KC_LPRN, :KC_QUOTE, :KC_LEFT, :KC_DOWN,   :KC_UP,    :KC_RIGHT, :KC_UNDS,  :KC_PLUS,
  :KC_LSFT,  :KC_RABK, :KC_RCBR, :KC_RBRACKET, :KC_RPRN, :KC_DQUO,  :KC_TILD, :KC_BSLASH, :KC_COMMA, :KC_DOT,   :KC_SLASH, :KC_EQUAL,
  :KC_NO,    :KC_NO,   :KC_NO,   :KC_LANG2,    :ADJUST,  :KC_LCTL,  :KC_RGUI, :RAISE_ENT, :KC_RALT,  :KC_NO,    :KC_NO,    :KC_NO,
#|          |         |         |             |         |          |         |           |          |          |          |
]
kbd.add_layer :lower, [
# LEFT BOARD                                                #RIGHT BOARD
#|           |         |         |             |            |          |        |        |          |       |          |
  :KC_ESCAPE, :KC_1,    :KC_2,    :KC_3,        :KC_4,       :KC_5,     :KC_6,   :KC_7,   :KC_8,     :KC_9,  :KC_0,     :KC_PLUS,
  :KC_TAB,    :KC_NO,   :KC_NO,   :KC_NO,       :KC_LPRN,    :KC_QUOTE, :KC_DOT, :KC_4,   :KC_5,     :KC_6,  :KC_PLUS,  :KC_ASTER,
  :KC_LSFT,   :KC_RABK, :KC_RCBR, :KC_RBRACKET, :KC_RPRN,    :KC_DQUO,  :KC_0,   :KC_1,   :KC_2,     :KC_3,  :KC_SLASH, :KC_COMMA,
  :KC_NO,     :KC_NO,   :KC_NO,   :KC_BSPACE,    :LOWER_SPC, :KC_LCTL,  :KC_RGUI,:ADJUST, :KC_LANG1, :KC_NO, :KC_NO,    :KC_NO,
#|           |         |         |             |            |          |        |        |          |       |          |
]

kbd.add_layer :adjust, [
# LEFT BOARD                                                  #RIGHT BOARD
#|         |         |         |         |         |          |         |        |       |        |        |
  :KC_F1,   :KC_F2,   :KC_F3,   :KC_F4,   :KC_F5,   :KC_F6,    :KC_F7,   :KC_F8,  :KC_F9, :KC_F10, :KC_F11, :KC_F12,
  :RGB_TOG, :RGB_SPI, :RGB_HUI, :RGB_SAI, :RGB_VAI, :RGB_MOD,  :KC_NO,   :KC_NO,  :KC_NO, :KC_NO,  :KC_NO,  :BOOTSEL,
  :RGB_TOG, :RGB_SPD, :RGB_HUD, :RGB_SAD, :RGB_VAD, :RGB_RMOD, :KC_NO,   :KC_NO,  :KC_NO, :KC_NO,  :KC_NO,  :KC_NO,
  :KC_NO,   :KC_NO,   :KC_NO,   :DQ,      :ADJUST,  :KC_LCTL,  :SPC_CTL, :ADJUST, :DQ,    :KC_NO,  :KC_NO,  :KC_NO,
]

kbd.define_composite_key :SPC_CTL, %i(KC_SPACE KC_RCTL)

kbd.define_mode_key :ALT_AT,    [ :KC_AT,                    :KC_LALT, 150, 150 ]
kbd.define_mode_key :RAISE_ENT, [ :KC_ENTER,                 :raise,   150, 150 ]
kbd.define_mode_key :LOWER_SPC, [ :KC_SPACE,                 :lower,   150, 150 ]
kbd.define_mode_key :RUBY_GUI,  [ Proc.new { kbd.ruby },     nil,      300, nil ]
kbd.define_mode_key :ADJUST,    [ nil,                       :adjust,  nil, nil ]
kbd.define_mode_key :BOOTSEL,   [ Proc.new { kbd.bootsel! }, nil,      300, nil ]

# Initialize RGBLED with pin, underglow_size, backlight_size and is_rgbw.
rgb = RGB.new(
  0,    # pin number
  6,    # size of underglow pixel
  21,   # size of backlight pixel
  false # 32bit data will be sent to a pixel if true while 24bit if false
)
rgb.effect = :circle
rgb.speed = 28
[
  # Under glow
  # 👇[0, 10],[74,10],[148,10], 👈Starts here and goes left
  # 👉[0, 30],[74,50],[148,50], 👉Connects to back lights
  [148,10],[74,10],[0, 10],[0, 30],[74,50],[148,50],
  #
  # Back light
  #    👇   👈         👇   👈          👇    👈
  # [0, 0],[37, 0],[74, 0],[111, 0],[148, 0],[185, 0],
  # [0,21],[37,21],[74,21],[111,21],[148,21],[185,21],
  # [0,42],[37,42],[74,42],[111,42],[148,42],[185,42],👆
  #    ↑      👆   👈     [129,63],[166,63],[222,63] 👈Starts here and goes upwards
  # The last pixel                       👆    👈
  [222,63],[185,42],[185,21],[185, 0],
  [148, 0],[148,21],[148,42],[166,63],
  [129,63],[111,42],[111,21],[111, 0],
  [74, 0],[74,21],[74,42],
  [37,42],[37,21],[37, 0],
  [0, 0],[0,21],[0,42]
].each do |p|
  rgb.add_pixel(p[0], p[1])
end
kbd.append rgb

#
# You only can get the right answer from `Keyboard#anchor?` inside the `Keyboard#on_start`
# callback because anchor or not is undecided until the kbd starts.
#
# The song is split into 2 parts because memory is short if it's united.
#
kbd.on_start do
end

# When you tap :DQ key, the sounder will play the song's first half.
# When you tap it again, you should hear the second part.
kbd.start!
