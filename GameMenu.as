private static const OPTION_SINGLE:int = 0;
private static const OPTION_DOUBLE:int = 1;
private static const OPTION_GUIDES:int = 2;

private static const TITLE_SHOW:int = 1;
private static const GAMEOPTIONS_IN:int = 2;
private static const GAMEOPTIONS_WAIT:int = 3;
private static const GAMEOPTIONS_OUT:int = 4;
private static const TITLE_HIDE:int = 5;

private var gameMenuState:int = TITLE_SHOW;
private var gameMenuTime:Number = 0;

private var pressedOption:int = -1;
private var selectedOption:int = -1;

private function Draw_GameMenu(elapsedTime:Number):void
{
  gameMenuTime += elapsedTime;
 
  switch (gameMenuState)
  {
  case TITLE_SHOW:
    Draw_TitleScreen(); 
    
    Apply_FadeEffect(1 - gameMenuTime); 
    
    if (gameMenuTime >= 1)
		ChangeState_GameMenu(GAMEOPTIONS_IN);
    break;
  case GAMEOPTIONS_IN:
    Draw_TitleScreen();
    Draw_GameOptions();
    
    if (gameMenuTime >= 1)
		ChangeState_GameMenu(GAMEOPTIONS_WAIT);    
    break;   
  case GAMEOPTIONS_WAIT: 
    Draw_TitleScreen();
    Draw_GameOptions();
    break;   
  case GAMEOPTIONS_OUT:  
    Draw_TitleScreen();
    Draw_GameOptions();
    
    if (gameMenuTime >= 1)
		ChangeState_GameMenu(TITLE_HIDE);
    break;    
  case TITLE_HIDE:
    Draw_TitleScreen();
    
    Apply_FadeEffect(gameMenuTime);
    
    if (gameMenuTime >= 1)
      switch (selectedOption)
      {
      case OPTION_SINGLE:
        state = GAME;
        New_Game();
        break;       
      }
    break;  
 
  }

}

private function ChangeState_GameMenu(newState:int):void
{
  switch(newState)
  {
  case GAMEOPTIONS_IN: 
    PlaySound(OPTIONSIN_SOUND); 
    break;
  case GAMEOPTIONS_OUT:
    PlaySound(OPTIONSOUT_SOUND); 
    break;
  }

  gameMenuState = newState;
  gameMenuTime = 0;
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
	
	var srcX:int = 0;
    
    if (gameMenuState == GAMEOPTIONS_IN) 
    {
      srcX = -((1 - gameMenuTime) * 3 - Number((OPTION_GUIDES - i) / 2)) * 400;
      
      if (srcX > 0)
        srcX = 0;      
    }
      
    if (gameMenuState == GAMEOPTIONS_OUT)
    {
      srcX = (gameMenuTime * 3 - Number(i / 2)) * 400;
      
      if (srcX < 0)
        srcX = 0;   
    }  
  
    screenBuffer.copyPixels(gameOptionBackgroundBitmap,
                        new Rectangle(0, srcY, 300, 100),
                        new Point(250+srcX,230+i*100+(pressedOption == i ? 1:0) ));
	
    screenBuffer.copyPixels(gameOptionsBitmap,
                          new Rectangle(50, 30+i*100, 200, 40),
                          new Point(300 + srcX,260+i*100+(pressedOption == i ? 1:0) )); 
  
  }
  
}


private function MouseDown_GameMenu(event:MouseEvent):void 
{ 
  var mx:int = event.localX;
  var my:int = event.localY;

  if (gameMenuState == GAMEOPTIONS_WAIT)
  for (var i:int = OPTION_SINGLE; i <= OPTION_GUIDES; i++)
      	if ( (mx >=270)&&(mx<520)&&(my>=240 + i*100)&&(my<=310+i*100) )
        {	  	 
          pressedOption = i;
          PlaySound(OPTIONSELECTED_SOUND);          
        }
}

private function MouseUp_GameMenu( event:MouseEvent):void
{
	var mx:int = event.localX;
	var my:int = event.localY;
	
  switch (gameMenuState)
  {
  case GAMEOPTIONS_WAIT:  
    switch (pressedOption)
    {
    case OPTION_SINGLE:		
	  selectedOption = OPTION_SINGLE;
      ChangeState_GameMenu(GAMEOPTIONS_OUT);;
      break;
    }
    break;
  }  
	
	pressedOption = -1;
}

private function MouseMoved_GameMenu(event:MouseEvent):void
{
	var mx:int = event.localX;
	var my:int = event.localY;
	
	for (var i:int = OPTION_SINGLE; i<= OPTION_GUIDES; i++)
		if( pressedOption == i)
			if ( (mx >=270)||(mx<520)||(my>=240 + i*100)||(my<=310+i*100) )
			pressedOption = -1;
}

