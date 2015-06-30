private static const OPTIONSIN_SOUND:int = 1;
private static const OPTIONSOUT_SOUND:int = 2;
private static const OPTIONSELECTED_SOUND:int = 3;

private var soundVolume:Number = 0.7;

[Embed(source="Sounds/OptionsIn.mp3")] private var optionsInSnd:Class;
[Embed(source="Sounds/OptionsOut.mp3")] private var optionsOutSnd:Class;
[Embed(source="Sounds/OptionSelected.mp3")] private var optionSelectedSnd:Class;

private function PlaySound(type:int) : void
{
  var sfx:Sound = null;

  switch (type)
  {
  case OPTIONSIN_SOUND:
    sfx = new optionsInSnd() as Sound;
    break;
  case OPTIONSOUT_SOUND:
    sfx = new optionsOutSnd() as Sound;
    break;
  case OPTIONSELECTED_SOUND:
    sfx = new optionSelectedSnd() as Sound;
    break; 
  }

  if (sfx != null)
    sfx.play(0,0,new SoundTransform(soundVolume));
}