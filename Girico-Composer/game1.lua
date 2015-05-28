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
end
--carrega música
 backgroundMusic = audio.loadStream("04.mp3")
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )
scrollSpeed = 35; -- Define a velocidade do background.
speed=0--define a velocidade com que o carro se move para os lados

movimentox=0;-- o carro permanece sem ir para os lados, se nenhum botão é apertado
pontuacao=0
maxHealth = 100
currentHealth = 100



function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  local previousScene = composer.getSceneName( "previous" )
  composer.removeScene( previousScene )
   
  if (phase == "did") then 
	local function updateScore()
     print(score.height)  
     score.height = score.height - 50
	   
end
--nada - teste


-- Adiciona primeiro background!
local bg1 = display.newImageRect("estradaImagem.png", 460, 480)
bg1.anchorX=0.0;
bg1.anchorY=0.0;
--scene.view:insert( bg1 )

 
-- Adiciona segundo background
local bg2 = display.newImageRect("estradaImagem.png", 460, 480)
bg2.anchorX=0.0;
bg2.anchorY=bg1.anchorY*2;
--scene.view:insert( bg2 )

 
-- Adiciona terceiro background
local bg3 = display.newImageRect("estradaImagem.png", 460, 480)
bg3.anchorX=0.0
bg3.anchorY=bg1.anchorY*3;
--scene.view:insert( bg3 )



-- Adiciona quarto background
local bg4 = display.newImageRect("estradaImagem.png", 460, 480)
bg4.anchorX=0.0;
bg4.anchorY=bg1.anchorY*4;
--scene.view:insert( bg4 )

score = display.newRect( 390, 450, 20, 300 )
score.anchorY=496
scoreTxt = display.newText( "GAS:", 390,470, "Helvetica", 16 )
--scene.view:insert( scoreTxt )

facemain = display.newImage( "CorraArthurCorra.png", 410, 60 )
facemain.xScale = 0.07
facemain.yScale = 0.07

facesmile = display.newImage( "MataZumbiBaralho.png", 410, 60 )
facesmile.xScale = 0.07
facesmile.yScale = 0.07
facesmile.alpha = -1

facezoombie = display.newImage( "PorUmTriz.png", 410, 60 )
facezoombie.xScale = 0.07
facezoombie.yScale = 0.07
facezoombie.alpha = -1

faceinocente = display.newImage( "NAAAAO.png", 410, 60 )
faceinocente.xScale = 0.07
faceinocente.yScale = 0.07
faceinocente.alpha = -1

faceover = display.newImage( "GameOvoExpression.png", 410, 60 )
faceover.xScale = 0.07
faceover.yScale = 0.07
faceover.alpha = -1
 
 local function move(event)
 
-- move fundo para baixo, à velocidade da variável "scrollSpeed"
bg1.y = bg1.y + scrollSpeed
bg2.y = bg2.y + scrollSpeed
bg3.y = bg3.y + scrollSpeed
bg4.y = bg4.y + scrollSpeed
 
-- Estabelece listeners para perceber quando a imagem vai acabar
-- e mover o background para o começo da tela.


if (bg1.y + bg1.contentHeight) >480*4 then
bg1:translate( 0, -480 )
end
if (bg2.y +  bg2.contentHeight) > 480*3 then
bg2:translate( 0, -480)
end
if (bg3.y +  bg3.contentHeight) > 480*2 then
bg3:translate( 0, -480)
end
if (bg4.y +  bg4.contentHeight) > 480 then
bg4:translate( 0, -480)
end
end


--[[characterGroup = display.newGroup( )
characterGroup.x = display.contentCenterX
characterGroup.y = display.contentCenterY--]]
 
--set maxHealth and currentHealth values
local carroHeroi=display.newImage("carrinho.png")
--characterGroup:insert( carroHeroi )
carroHeroi.myName="carroHeroi"
carroHeroi.x = _H/2 - 173
carroHeroi.y = _W/2 + 100

-- create green health bar
healthBar = display.newRect(0,-45, maxHealth, 10)
 
healthBar:setFillColor( 000/255, 255/255, 0/255 )
healthBar.strokeWidth = 1
healthBar:setStrokeColor( 255, 255, 255, .5 )
--characterGroup:insert(healthBar)
 
-- create red damage bar (-create it second so it lays on top)
damageBar = display.newRect(0,-45,0, 10)
 
damageBar:setFillColor( 255/255, 0/255, 0/255 )
--characterGroup:insert(damageBar)



-- Adiciona botão esquerdo
 local left = display.newImage ("btn_arrow.jpg")
 left.x = 45; left.y = 430;
 left:scale(0.4,0.4)
 left.rotation = 180;




-- Adiciona botão direito
 local right = display.newImage ("btn_arrow.jpg")
 right.x = 290; right.y = 430;
 right:scale(0.4, 0.4)


 -- Quando botão de left é apertado, carro se move à esquerda
 function left:touch()
 movimentox = speed-5;
  end



-- Quando a seta de right é apertada, carro se move à esquerda.
 
 function right:touch()
 movimentox = speed+5;
 end
 
 
--Função que move o carro

 local function moveCarro (event)
carroHeroi.x=carroHeroi.x+movimentox
 
end
local createFuel = function()
	fuel = display.newImage( "Fuel.png",math.random(20,300),25, math.random(0,  320)) 
	physics.addBody( fuel, "dynamic",{ density=0, friction=0, bounce=0} )
	fuel:setLinearVelocity(0, scrollSpeed*15)
	fuel.myName="fuel"
    return fuel 	
end


--Adiciona física
local rightWall = display.newRect( bg1.width, 0, 10, bg1.height*6 )

 physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 1, isSensor = false})
 
  rightWall.myName="paredeDireita"

physics.addBody( carroHeroi, "kinematic", { friction=0, bounce=0, density=60 })

--Cria zumbis
local createZumbi = function(event)
	zumbi = display.newImage( "zumbi.png",math.random(20,300), -25, math.random(0,320)) 
	physics.addBody( zumbi, "dynamic",{ density=2, friction=0, bounce=1} )
	zumbi:setLinearVelocity(0, scrollSpeed*15)
	zumbi.myName="zumbi"
    return zumbi	
end


--Cria pobres inocentes 

local createInocente = function(event)
	inocente = display.newImage( "chibi.png",math.random(20,300), -25, math.random(0,320))  
	physics.addBody( inocente, "dynamic",{ density=2, friction=0, bounce=1} )
	inocente:setLinearVelocity(0, scrollSpeed*15)
	inocente.myName="inocente"
    return inocente	
end


 local function stop (event)
 		if (event.phase =="ended") then
		 movimentox = 0;
		 end
 end
 
 local function onCollision( event )
    if (event.phase == "began" ) then
        if (event.object1.myName=="carroHeroi" and event.object2.myName=="fuel") 
        	then
			event.object2:removeSelf( );
			score.height=score.height+5;
			facemain.alpha = -1
			facesmile.alpha = 1
			facemain.alpha = -1
			facezoombie.alpha = -1
			faceinocente.alpha = -1
			elseif  (event.object1.myName=="carroHeroi" and event.object2.myName=="zumbi") 
			then 
			pontuacao = pontuacao + 1
			facesmile.alpha = -1
			facemain.alpha = -1
			facezoombie.alpha = 1
			faceinocente.alpha = -1
			elseif  (event.object1.myName=="carroHeroi" and event.object2.myName=="inocente") 
			then 
			pontuacao = pontuacao -1
			facemain.alpha = -1
            facesmile.alpha = -1
			facezoombie.alpha = -1
			faceinocente.alpha = 1
			elseif (event.object1.myName=="carroHeroi" and event.object2.myName=="paredeDireita") 
			then 
			currentHealth=currentHealth - 50
			facesmile.alpha = -1
			facezoombie.alpha = -1
			faceinocente.alpha = 1
			facemain.alpha = 1
			
        end 
       print(pontuacao)
 end
 end
 
-- update the damage bar
function updateDamageBar()
	damageBar.x = currentHealth / 2
	damageBar.width = maxHealth - currentHealth
end
 
-- lower the character's currentHealth
function damageCharacter(damageTaken)
	currentHealth = currentHealth - damageTaken
	updateDamageBar()
end
 function gameOvo( )
 	
	if(score.height ==0 or currentHealth <=0)
 	then gameOvo= display.newText( "GAME OVO, BRODER", display.contentCenterX, display.contentCenterY, "Helvetica", 30) 
	scrollSpeed=0
	facemain.alpha = -1
	facesmile.alpha = -1
	facezoombie.alpha = -1
	faceinocente.alpha = -1
	faceover.alpha = 1
 	gameIsActive = false  
 	physics.pause()
	--timer.cancel(z)
	--timer.cancel(i)
	--timer.cancel(f)
	left:removeEventListener( "touch", left )
    right:removeEventListener( "touch", right )
    Runtime:removeEventListener("enterFrame", moveCarro)
	Runtime:removeEventListener("enterFrame", move)
	Runtime:removeEventListener("touch", stop )
	Runtime:removeEventListener('enterFrame', gameOvo)
    Runtime:removeEventListener("collision", onCollision) 
	
	--timer.cancel(scoreTimer)
  	audio.stop(backgroundMusicChannel)
	if (pontuacao <=25)
	then
	display.newText("(Mas tu é ruinzinho hein?)", (display.contentCenterX), (display.contentCenterY - 50),"Helvetica", 20)
	elseif (pontuacao >= 25 )
	then
	display.newText("(VOCÊ É O REI DESTA BIROSCA!!!", (display.contentCenterX), (display.contentCenterY - 50),"Helvetica", 20)
	end
	
	--local menuBtn = display.newImageRect( "menu.png", 200, 260)
	--menuBtn.x = _W2/2
	--menuBtn.y = _H2
	
	
	
	composer.gotoScene( "gameOvo" )
 	end
	end
	
	scoreTimer = timer.performWithDelay(1000, updateScore, 0)
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
	else
	end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase
  
  if (phase == "did") then
   	 audio.stop( 1 )
    --left:removeEventListener( "touch", left )
    --right:removeEventListener( "touch", right )
    --Runtime:removeEventListener("enterFrame", moveCarro)
	--Runtime:removeEventListener("enterFrame", move)
	--Runtime:removeEventListener("touch", stop )
	--Runtime:removeEventListener('enterFrame', gameOvo)
    --Runtime:removeEventListener("collision", onCollision) 
    timer.cancel(scoreTimer)
	scoreTimer=nil
	timer.cancel(f)
	f=nil
	timer.cancel(z)
	z=nil
	timer.cancel(i)
	i=nil
	display.remove(bg1, bg2,bg3,bg4, carroHeroi, left, right)
	elseif (phase=="will") then
	end
end

function scene:destroy(event)
	--local sceneGroup = self.view
	
	display.remove(newRect)
end


 
 scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
 
