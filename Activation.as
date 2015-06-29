private function Draw_Activation(elapsedTime:Number):void
{ 
  Draw_TitleScreen();
  Draw_ActivationBanner(); 
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