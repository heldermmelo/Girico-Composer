

-- Your code here

local composer = require("composer")
local scene = composer.newScene( )

--Oulta a barra de status desde o começo
display.setStatusBar( display.HiddenStatusBar )
--inicializa o módulo de física
function scene:create( event )  
  local sceneGroup = self.view
physics =require("physics")

physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
 
-- Inicializa variáveis de exibição da imagem de fundo em duas variáveis. Inicializa variáveis de movimento do carro
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen
--carrega música
 
   
  if (phase == "did") then 
	local scoreTimer = timer.performWithDelay(1000, updateScore, 0)
	left:addEventListener("touch",left)
	right:addEventListener("touch",right)
	Runtime:addEventListener( "collision", onCollision )
	Runtime:addEventListener("enterFrame", moveCarro) 
	Runtime:addEventListener( "enterFrame", move )
	Runtime:addEventListener("touch", stop )
	f = timer.performWithDelay( 1900, createFuel, 0 )
	z = timer.performWithDelay( 800, createZumbi, 0 )
	i = timer.performWithDelay( 5000, createInocente, 0 )
	Runtime:addEventListener("enterFrame", gameOvo)
	
	end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  if (phase == "will") then
    audio.stop( 1 )
    left:removeEventListener( "touch", left )
    right:removeEventListener( "touch", right )
    Runtime:removeEventListener("enterFrame", moveCarro)
	Runtime:removeEventListener("enterFrame", move)
	Runtime:removeEventListener("touch", stop )
	Runtime:removeEventListener('enterFrame', gameOvo)
    Runtime:removeEventListener("collision", onCollision) 
	timer.cancel(scoreTimer)
	scoreTimer=nil
	timer.cancel(f)
	f=nil
	timer.cancel(z)
	z=nil
	timer.cancel(i)
	i=nil
	elseif (phase=="did") then
	end
end

function scene:destroy(event)
	local sceneGroup = self.view
	
	display.remove(newRect)
end
display.newRect(0,0, _W, _H) 
 
 scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
 
