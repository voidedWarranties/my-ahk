clear()

local deviceID = 'E14056F'
if deviceID == '' then
  lmc_assign_keyboard('MACROS')
  lmc_print_devices()
else lmc_device_set_name('MACROS', deviceID)
end

local keymap = { -- Welp this is mostly useless
  [17] = 'ctrl',
  [18] = 'alt',
  [16] = 'shift'
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
