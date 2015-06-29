import flash.display.*; 
import flash.events.*;
import mx.events.*;
import mx.controls.*;

include "Images.as";

private static const SCREEN_WIDTH:int = 800;
private static const SCREEN_HEIGHT:int = 600; 

private static const OPTION_SINGLE:int = 0;
private static const OPTION_DOUBLE:int = 1;
private static const OPTION_GUIDES:int = 2;

private var pressedOption:int = -1;

private var initializationCompleted:Boolean = false;
private var screenBuffer:BitmapData = null;

public function Init():void 
{ 
  screenBuffer = new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT, false, 0x00000000);

  initializationCompleted = true;
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

  Draw(elapsedTime);

  gamePanel.graphics.clear(); 
  gamePanel.graphics.beginBitmapFill(screenBuffer, null, false, false);
  gamePanel.graphics.drawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  gamePanel.graphics.endFill(); 
}

private function Draw(elapsedTime:Number):void
{
Draw_TitleScreen();
Draw_GameOptions();

}

private var titleScreenBitmap:BitmapData = null;
private function Draw_TitleScreen():void
{
  if (titleScreenBitmap == null)
  {
    titleScreenBitmap = new BitmapData(SCREEN_WIDTH,SCREEN_HEIGHT);
    titleScreenBitmap.draw(new titleScreenImg()); 
  }

  screenBuffer.copyPixels(titleScreenBitmap, 
                          new Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT),
                          new Point(0,0)); 
}

private var gameOptionsBitmap:BitmapData = null;
private var gameOptionBackgroundBitmap:BitmapData = null;
private function Draw_GameOptions():void
{
  if (gameOptionBackgroundBitmap == null)
{ 
  gameOptionBackgroundBitmap = new BitmapData(300,200,true,0x00000000);
  gameOptionBackgroundBitmap.draw(new gameOptionBackgroundImg()); 
}
  if (gameOptionsBitmap == null)
  {
    gameOptionsBitmap = new BitmapData(300,300,true,0x00000000);
    gameOptionsBitmap.draw(new gameOptionsImg());
  }
  
  for(var i:int = OPTION_SINGLE; i<= OPTION_GUIDES; i++)
  {
	var srcY:int = pressedOption == i ? 0 : 100;
  
    screenBuffer.copyPixels(gameOptionBackgroundBitmap,
                        new Rectangle(0, srcY, 300, 100),
                        new Point(250,230+i*100+(pressedOption == i ? 1:0) ));

    screenBuffer.copyPixels(gameOptionsBitmap,
                          new Rectangle(50, 30+i*100, 200, 40),
                          new Point(300,260+i*100+(pressedOption == i ? 1:0) )); 
  
  }
  
}


private function MouseDown(event:MouseEvent):void 
{ 
  var mx:int = event.localX;
  var my:int = event.localY;

  for (var i:int = OPTION_SINGLE; i <= OPTION_GUIDES; i++)
      	if ( (mx >=270)&&(mx<520)&&(my>=240 + i*100)&&(my<=310+i*100) )
        pressedOption = i;
}

private function MouseUp( event:MouseEvent):void
{
	var mx:int = event.localX;
	var my:int = event.localY;
	
	pressedOption = -1;
}

private function MouseMoved(event:MouseEvent):void
{
	var mx:int = event.localX;
	var my:int = event.localY;
	
	for (var i:int = OPTION_SINGLE; i<= OPTION_GUIDES; i++)
		if( pressedOption == i)
			if ( (mx >=270)||(mx<520)||(my>=240 + i*100)||(my<=310+i*100) )
			pressedOption = -1;
}
