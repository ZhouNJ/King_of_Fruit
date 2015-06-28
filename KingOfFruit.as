import flash.display.*; 
import flash.events.*;
import mx.events.*;
import mx.controls.*;

include "Images.as";

private static const SCREEN_WIDTH:int = 800;
private static const SCREEN_HEIGHT:int = 600; 

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
private function Draw_GameOptions():void
{
  if (gameOptionsBitmap == null)
  {
    gameOptionsBitmap = new BitmapData(300,300,true,0x00000000);
    gameOptionsBitmap.draw(new gameOptionsImg());
  }

  screenBuffer.copyPixels(gameOptionsBitmap,
                          new Rectangle(0, 0, 300, 100),
                          new Point(250,280));

  screenBuffer.copyPixels(gameOptionsBitmap,
                          new Rectangle(0, 110, 300, 100),
                          new Point(250,380));

  screenBuffer.copyPixels(gameOptionsBitmap,
                          new Rectangle(0, 200, 300, 100),
                          new Point(250,480));
}