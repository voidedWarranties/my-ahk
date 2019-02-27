clear()

local deviceID = 'E14056F'
if deviceID == '' then
  lmc_assign_keyboard('MACROS')
  lmc_print_devices()
else lmc_device_set_name('MACROS', deviceID)
end

local keymap = { -- Welp this is mostly useless
  [string.byte('Q')] = 'q',
  [string.byte('W')] = 'w',
  [string.byte('E')] = 'e',
  [string.byte('R')] = 'r',
  [string.byte('T')] = 't',
  [string.byte('Y')] = 'y',
  [string.byte('U')] = 'u',
  [string.byte('I')] = 'i',
  [string.byte('O')] = 'o',
  [string.byte('P')] = 'p',
  [string.byte('A')] = 'a',
  [string.byte('S')] = 's',
  [string.byte('D')] = 'd',
  [string.byte('F')] = 'f',
  [string.byte('G')] = 'g',
  [string.byte('H')] = 'h',
  [string.byte('J')] = 'j',
  [string.byte('K')] = 'k',
  [string.byte('L')] = 'l',
  [string.byte('Z')] = 'z',
  [string.byte('X')] = 'x',
  [string.byte('C')] = 'c',
  [string.byte('V')] = 'v',
  [string.byte('B')] = 'b',
  [string.byte('N')] = 'n',
  [string.byte('M')] = 'm',

  [string.byte('0')] = '0',
  [string.byte('1')] = '1',
  [string.byte('2')] = '2',
  [string.byte('3')] = '3',
  [string.byte('4')] = '4',
  [string.byte('5')] = '5',
  [string.byte('6')] = '6',
  [string.byte('7')] = '7',
  [string.byte('8')] = '8',
  [string.byte('9')] = '9',

  [17] = 'ctrl',
  [18] = 'alt',
  [16] = 'shift',

  [9] = 'TAB',
  [192] = '`',
  [189] = '-',
  [187] = '=',
  [8] = 'BKSP',
  [219] = '[',
  [221] = ']',
  [220] = '\\',
  [186] = ';',
  [222] = '\'',
  [13] = 'ENTER',
  [188] = ',',
  [190] = '.',
  [191] = '/',
  [45] = 'INS',
  [46] = 'DELETE',
  [36] = 'HOME',
  [35] = 'end',
  [33] = 'PGUP',
  [34] = 'PGDN',
  [27] = 'ESC',
  [112] = 'F1',
  [113] = 'F2',
  [114] = 'F3',
  [115] = 'F4',
  [116] = 'F5',
  [117] = 'F6',
  [118] = 'F7',
  [119] = 'F8',
  [120] = 'F9',
  [121] = 'F10',
  [122] = 'F11',
  [123] = 'F12',
  [32] = 'SPACE',
  [93] = 'menu',
  [38] = 'UP',
  [40] = 'DOWN',
  [37] = 'LEFT',
  [39] = 'RIGHT',
  [111] = 'NUMDIVIDE',
  [106] = 'NUMMULTIPLY',
  [109] = 'NUMMINUS',
  [107] = 'NUMPLUS',
  [110] = 'NUMDECIMAL',
  [96] = 'NUM0',
  [97] = 'NUM1',
  [98] = 'NUM2',
  [99] = 'NUM3',
  [100] = 'NUM4',
  [101] = 'NUM5',
  [102] = 'NUM6',
  [103] = 'NUM7',
  [104] = 'NUM8',
  [105] = 'NUM9'
}

local isCtrlDown = false
local isAltDown = false
local isShiftDown = false

lmc_set_handler('MACROS', function(button, direction)
  if (button == 255) then return end -- PrintScreen or arrow keys w/ NumLock on

  if (direction == 1) then
    if (keymap[button] == 'ctrl') then
      isCtrlDown = true
      return
    end
    if (keymap[button] == 'alt') then
      isAltDown = true
      return
    end
    if (keymap[button] == 'shift') then
      isShiftDown = true
      return
    end
  end

  if (direction == 0) then
    if (keymap[button] == 'ctrl') then isCtrlDown = false end
    if (keymap[button] == 'alt') then isAltDown = false end
    if (keymap[button] == 'shift') then isShiftDown = false end
    return
  end
  --print(button)
  --print(keymap[button])

  lmc_send_input(135, 0, 0)
  if (isShiftDown) then lmc_send_input(16, 0, 0) end
  if (isAltDown) then lmc_send_input(18, 0, 0) end
  if (isCtrlDown) then lmc_send_input(17, 0, 0) end
  lmc_send_input(button, 0, 0)
  lmc_send_input(button, 0, 2)
  if (isCtrlDown) then lmc_send_input(17, 0, 2) end
  if (isAltDown) then lmc_send_input(18, 0, 2) end
  if (isShiftDown) then lmc_send_input(16, 0, 2) end
  lmc_send_input(135, 0, 2)
end)
