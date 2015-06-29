private static const ACTIVATION_SHOW:int = 1;
private static const ACTIVATION_WAIT:int = 2;
private static const ACTIVATION_HIDE:int = 3;

private var activationState:int = ACTIVATION_SHOW;
private var activationTime:Number = 0;


private function Draw_Activation(ellapsedTime:Number):void
{ 
  activationTime += ellapsedTime;

  Draw_TitleScreen();
  Draw_ActivationBanner(); 

  switch (activationState)
  {
  case ACTIVATION_SHOW: 
    Apply_FadeEffect(1 - activationTime); 

    if (activationTime >= 1)
    {
      activationState = ACTIVATION_WAIT;
      activationTime = 0;
    }
    break;
  case ACTIVATION_WAIT:
    break; 
  case ACTIVATION_HIDE: 
    if (activationTime >= 1)
    {
      state = GAME_MENU;
      gameMenuState = GAMEOPTIONS_IN;
    } 
    break; 
  } 
}

private var activationBannerBitmap:BitmapData = null;

private function Draw_ActivationBanner():void
{
  if (activationBannerBitmap == null)
  {
    activationBannerBitmap = new BitmapData(SCREEN_WIDTH,36,true,0x00000000);
    activationBannerBitmap.draw(new activationBannerImg());
  }

  screenBuffer.copyPixels(activationBannerBitmap,
                          new Rectangle(0, 0, SCREEN_WIDTH , 36),
                          new Point(0,500)); 
}

private function MouseUp_Activation(event:MouseEvent):void 
{ 
  state = GAME_MENU;
}