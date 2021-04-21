package anifire.components.studio
{
   import anifire.core.BubbleAsset;
   import anifire.core.SoundThumb;
   
   public class BubbleMsgChooserItem
   {
       
      
      public var msg:String;
      
      public var bubbleAsset:BubbleAsset;
      
      public var isSound:Boolean;
      
      public var soundThumb:SoundThumb;
      
      public var displayText:String;
      
      public const TYPE_BUBBLE:uint = 2;
      
      public var isBubble:Boolean;
      
      public const TYPE_SOUND:uint = 1;
      
      public function BubbleMsgChooserItem(param1:String, param2:String, param3:Boolean, param4:BubbleAsset, param5:Boolean, param6:SoundThumb)
      {
         super();
         this.isBubble = param3;
         this.isSound = param5;
         this.displayText = param2;
         this.msg = param1;
         this.bubbleAsset = param4;
         this.soundThumb = param6;
      }
   }
}
