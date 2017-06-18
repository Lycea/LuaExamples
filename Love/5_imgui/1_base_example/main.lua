require "imgui"

local WindowOptions = {}
WindowOptions.NoTitlebar   = false
WindowOptions.NoBorder     = true
WindowOptions.NoResize     = false
WindowOptions.NoMove       = false
WindowOptions.NoScrollbar  = false
WindowOptions.NoCollapse   = false
WindowOptions.NoMenu       = false

local ShowWidgets = {}



--
-- LOVE callbacks
--
function love.load(arg)
  require("mobdebug").start()
end

function love.update(dt)
    imgui.NewFrame()
end

function showWidgets()
  cb_widget = true
  
   if imgui.TreeNode("Trees") then
      --Basic trees
      if imgui.TreeNode("Basic trees") then
        if imgui.TreeNode("Child 0") then
          imgui.Text("blah blah")
          imgui.SameLine(150)
          imgui.Button("print")
          imgui.TreePop()
        end
        if imgui.TreeNode("Child 1") then
          imgui.Text("blah blah")
          imgui.SameLine(150)
          imgui.Button("print")
          imgui.TreePop()
        end
        if imgui.TreeNode("Child 2") then
          imgui.Text("blah blah")
          imgui.SameLine(150)
          imgui.Button("print")
          imgui.TreePop()
        end
        if imgui.TreeNode("Child 3") then
          imgui.Text("blah blah")
          imgui.SameLine(150)
          imgui.Button("print")
          imgui.TreePop()
        end
        if imgui.TreeNode("Child 4") then
          imgui.Text("blah blah")
          imgui.SameLine(150)
          imgui.Button("print")
          imgui.TreePop()
        end
          imgui.TreePop()
      end
      --Advanced trees 
      if imgui.TreeNode("Advanced, with Selectable nodes") then
       imgui.ShowHelpMarker("hiiiiii")
        imgui.TreePop()
      end
    imgui.TreePop()
  end
   if imgui.TreeNode("Collapsing Headers") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Bullets") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Colored Text") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Word Wrapping") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("UTF-8 Text") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Images") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Selectables") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Filtered Text Input") then
    imgui.LogButtons()
    imgui.TreePop()
  end
   if imgui.TreeNode("Multi-line Text Input") then
    imgui.LogButtons()
    imgui.TreePop()
  end
  if imgui.Button("Button") then
    
  end
  
  --imgui.Checkbox("checkbox")
end

function showHelp()
  
end

function showWindowOptions()
  -- the checkboxes
  if imgui.Checkbox ("No titlebar",WindowOptions.NoTitlebar)   then WindowOptions.NoTitlebar = not WindowOptions.NoTitlebar   end
  imgui.SameLine(150)
  if imgui.Checkbox ("No border",WindowOptions.NoBorder)       then WindowOptions.NoBorder = not WindowOptions.NoBorder end
  imgui.SameLine(255)
  if imgui.Checkbox ("No resize",WindowOptions.NoResize)       then WindowOptions.NoResize = not WindowOptions.NoResize end
  
  if imgui.Checkbox ("No move",WindowOptions.NoMove)           then WindowOptions.NoMove = not WindowOptions.NoMove end
  imgui.SameLine(150)
  if imgui.Checkbox ("No scrollbar",WindowOptions.NoScrollbar) then WindowOptions.NoScrollbar = not WindowOptions.NoScrollbar end
  imgui.SameLine(255)
  if imgui.Checkbox ("No collapse",WindowOptions.NoCollapse)   then WindowOptions.NoCollapse = not WindowOptions.NoCollapse end
  
  if imgui.Checkbox ("No menu",WindowOptions.NoMenu)          then WindowOptions.NoMenu = not WindowOptions.NoMenu end
  
  --tree nodes
  if imgui.TreeNode("Style") then
    -- the whole style thing
    
    -- TODO: rewrite it also :)
    imgui.ShowStyleEditor()
    imgui.TreePop()
  end

  if imgui.TreeNode("Logging") then
    imgui.LogButtons()
    imgui.TreePop()
  end
end


function combineWindowFlagToTable ()
  local tab = {}
  if WindowOptions.NoTitlebar == true then
    table.insert(tab,"NoTitleBar")
  end
  if WindowOptions.NoBorder == false then
    table.insert(tab,"ShowBorders")
  end
  if WindowOptions.NoResize == true then
    table.insert(tab,"NoResize")
  end
  if WindowOptions.NoMove == true then
    table.insert(tab,"NoMove")
  end
  if WindowOptions.NoScrollbar == true then
    table.insert(tab,"NoScrollbar")
  end
  if WindowOptions.NoCollapse == true then
    table.insert(tab,"NoCollapse")
  end
  if WindowOptions.NoMenu == false then
    table.insert(tab,"MenuBar")
  end
  return tab
end

function demoRemake()
  --Window with menu bar flag
  imgui.Begin("Demo again",true,combineWindowFlagToTable())
  
    if imgui.BeginMenuBar() then
      if imgui.BeginMenu("Menu") then

      end
      if imgui.BeginMenu("Examples") then
        imgui.MenuItem("hii")
      end
      if imgui.BeginMenu("Help") then
          imgui.MenuItem("hii")
      end
            
      imgui.EndMenuBar()
    end

    imgui.Text("Dear ImGui says hello.")
        
        
    
   -- imgui.BeginChild("g")

    
    
    if imgui.CollapsingHeader("Help") then                   showHelp()               end
    if imgui.CollapsingHeader("Window options") then         showWindowOptions()      end
    if imgui.CollapsingHeader("Widgets") then                showWidgets()            end
    if imgui.CollapsingHeader("Graphs widgets") then         showGraphsWidgets()      end
    if imgui.CollapsingHeader("Layout") then                 showLayouts()            end
    if imgui.CollapsingHeader("Popups & Modal windows") then showPopupsModalWindows() end
    if imgui.CollapsingHeader("Columns") then end
    if imgui.CollapsingHeader("Filtering") then end
    if imgui.CollapsingHeader("Keyboard, Mouse & Focus") then end
   -- imgui.EndChild()
  imgui.End()
end

function docExample()
  imgui.Begin("Dock Example",true)
    imgui.BeginDockspace()
      if imgui.BeginDock("Dock1") then
        imgui.Text("hiii")
      end
      if imgui.BeginDock("Dock2") then
        imgui.Text("dock2")
      end
      imgui.EndDock()
    imgui.EndDockspace()
  imgui.End()
end

function myWindow()
  --imgui.SetNextWindowPos(0,0,"What")
  --imgui.SetNextWindowSize(190,103)
  
  imgui.Begin("TestWindow",true)
    imgui.BeginChild("test")
   if imgui.CollapsingHeader("hiiii") then
      imgui.Text("Hello from the outside")
      imgui.Bullet() imgui.Text("test")
      imgui.Checkbox("Check if checked \n many\n lines :D",true)
      if imgui.TreeNode("hi") then
        imgui.Text(" I'm a child ?")
        imgui.TreeNode("hi2")
        imgui.Button("give me this!!")
      end
      --imgui.TreeNode("hi hi")
    end
    imgui.EndChild()
  imgui.End()
end

function love.draw()
  -- example label
    imgui.Text("hi")
    --example Button
    if imgui.Button("what?") then
      
    end
    --

    
    myWindow()
    docExample()
    imgui.ShowTestWindow(true)
    demoRemake()
    
    -- render the ui above the stuff
    love.graphics.clear(272,404,232,0)
    imgui.Render();
    
end

function love.quit()
    imgui.ShutDown();
end

--
-- User inputs
--
function love.textinput(t)
    imgui.TextInput(t)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.keypressed(key)
    imgui.KeyPressed(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.keyreleased(key)
    imgui.KeyReleased(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.mousemoved(x, y)
    imgui.MouseMoved(x, y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousepressed(x, y, button)
    imgui.MousePressed(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousereleased(x, y, button)
    imgui.MouseReleased(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end