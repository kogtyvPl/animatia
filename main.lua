
local filesystem = require("Filesystem")
local screen = require("Screen")
--local color = require("Color")
local image = require("Image")
local GUI = require("GUI")
local system = require("System")
local event = require("Event")
local component = require("Component.lua")
--local os = require("OS")

------------------------------------------------------------------------------------------

local spinnersPath = filesystem.path(system.getCurrentScript())
local spinners = {}
local currentSpinner = 5
local spinnerLimit = 7
local spinnerHue = math.random(0, 360)
local spinnerHueStep = 20
local delaySlider = 50
local cadr = 1

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0x0))
local spinnerImage = workspace:addChild(GUI.image(1, 1, {50, 25}))

--local container = GUI.addBackgroundContainer(workspace, true, true, "Run")
--local delaySlider = container.layout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0x2D2D2D, 0xE1E1E1, 0x878787, 0, 500, 200, false, "Delay: ", " ms"))
--delaySlider.roundValues = true
------------------------------------------------------------------------------------------

local function changeColor(hue, saturation)
  for i = 1, #spinners do
    for y = 1, image.getHeight(spinners[i]) do
      for x = 1, image.getWidth(spinners[i]) do
        local background, foreground, alpha, symbol = image.get(spinners[i], x, y)
        local hBackground, sBackground, bBackground = color.integerToHSB(background)
        local hForeground, sForeground, bForeground = color.integerToHSB(foreground)
        image.set(
          spinners[i],
          x,
          y,
          color.HSBToInteger(hue, saturation, bBackground),
          color.HSBToInteger(hue, saturation, bForeground),
          alpha,
          symbol
        )
      end
    end
  end
  spinnerImage.image = spinners[currentSpinner]
end

workspace.eventHandler = function(workspace, object, e1, e2, e3, e4, e5)
  if e1 == "key_down" then
    workspace:stop()
    --image.load(spinnersPath .. cadr .. ".pic")
    --cadr = cadr + 1
    --if cadr > spinnerLimit then
      --cadr = 1
    --end
  elseif e1 == "touch" then
    spinnerHue = spinnerHue + spinnerHueStep * (e5 == 1 and -1 or 1)
    if spinnerHue > 360 then
      spinnerHue = 0
    elseif spinnerHue < 0 then
      spinnerHue = 360
    end
    --changeColor(spinnerHue, 1)
  end
  
  currentSpinner = currentSpinner + 1
  if currentSpinner > #spinners then
    currentSpinner = 1
  end
  computer.beep(20, 0.01)
  spinnerImage.image = spinners[currentSpinner]
  
  workspace:draw()
end

------------------------------------------------------------------------------------------

--while true do
  --if e1 == "key_down" then
    --workspace:stop()
    --image.load(spinnersPath .. cadr .. ".pic")
    --cadr = cadr + 1
    --if cadr > spinnerLimit then
      --cadr = 1
    --end
  --end
  --spinners[cadr] = image.load(spinnersPath .. cadr .. ".pic")
--end

for i = 1, spinnerLimit do
  --for j = 1, 20 do
    --j = j + 1
    --spinners[i] = image.load(spinnersPath .. j .. ".pic")
    --if j > 19 then
      --j = 1
    --end
    
  --end
  spinners[i] = image.load(spinnersPath .. i .. ".pic")
  --i = 1
end
-- while true do
   --local eventData = {event.pull(delaySlider.value / 1000)}
   --if eventData[1] == "touch" or eventData[1] == "key_down" then
     --break
   --end
  --end
--spinnerImage.width = image.getWidth(spinners[currentSpinner])
--spinnerImage.height = image.getHeight(spinners[currentSpinner]) 
spinnerImage.localX = math.floor(workspace.width / 2 - spinnerImage.width / 2)
spinnerImage.localY = math.floor(workspace.height / 2 - spinnerImage.height/ 2)

--changeColor(spinnerHue, 1)
screen.flush()
--workspace:draw()

workspace:start(0)
