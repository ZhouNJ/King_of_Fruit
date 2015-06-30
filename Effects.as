private var fadeEffectBitmap:BitmapData = null;

private function Apply_FadeEffect(factor:Number):void
{ 
  if (fadeEffectBitmap == null)
  { 
    fadeEffectBitmap = new BitmapData(SCREEN_WIDTH,SCREEN_HEIGHT,true,0x00000000);
    fadeEffectBitmap.draw(new fadeEffectImg()); 
  }

  if (factor > 0.95)
    factor = 0.95;

  for (var i:int = 0; i < 20; i++)
    screenBuffer.copyPixels(fadeEffectBitmap,
                            new Rectangle(0, (int)(factor * 20) * 30, SCREEN_WIDTH, 30),
                            new Point(0,i * 30)); 
}