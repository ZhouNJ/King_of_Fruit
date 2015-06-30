import flash.display.*; 
import flash.events.*;
import mx.events.*;
import mx.controls.*;
import flash.external.ExternalInterface;

include "GameMenu.as";
include "Game.as"
include "Activation.as";
include "Effects.as"
include "Images.as";

private static const SCREEN_WIDTH:int = 800;
private static const SCREEN_HEIGHT:int = 600; 


private var initializationCompleted:Boolean = false;
private var screenBuffer:BitmapData = null

private static const ACTIVATION:int = 0;
private static const GAME_MENU:int = 1;
private static const GAME:int = 2;


private var state:int = GAME_MENU;

public function Init():void 
{ 
  screenBuffer = new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT, false, 0x00000000);
  initializationCompleted = true;
  if (ExternalInterface.available)
  state = ACTIVATION;
}

private var prevTime:Date = null;

private function UpdateFrame():void
{
  if (!initializationCompleted)
    return;

  var currTime:Date = new Date();
  var elapsedTime:Number = 0; 

  if (prevTime != null) 
    elapsedTime = (currTime.getTime() - prevTime.getTime()) / 1000.0;
  
  prevTime = currTime;
  
  Draw(elapsedTime);
  
  gamePanel.graphics.clear(); 
  gamePanel.graphics.beginBitmapFill(screenBuffer, null, false, false);
  gamePanel.graphics.drawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  gamePanel.graphics.endFill(); 
}

private function Draw(elapsedTime:Number):void
{
  switch (state)
  {
  case GAME_MENU:
    Draw_GameMenu(elapsedTime);
    break;
  case GAME:
    Draw_Game(elapsedTime); 
    break; 
  case ACTIVATION:
	Draw_Activation(elapsedTime);
	break;
  }
}

private function MouseDown(event:MouseEvent):void 
{ 
  switch (state)
  {
  case GAME_MENU:
    MouseDown_GameMenu(event);
    break;
  case GAME:
    MouseDown_Game(event);
    break;
  }
} 


private function MouseUp(event:MouseEvent):void 
{ 
  switch (state)
  {
  case GAME_MENU:
    MouseUp_GameMenu(event);
    break;
  case GAME:
    MouseUp_Game(event);
    break;
  case ACTIVATION:
	MouseUp_Activation(event);
	break;
  }
}

private function MouseMoved(event:MouseEvent):void 
{
  switch (state)
  {
  case GAME_MENU:
    MouseMoved_GameMenu(event);
    break;
  case GAME:
    MouseMoved_Game(event);
    break;
  }
}

