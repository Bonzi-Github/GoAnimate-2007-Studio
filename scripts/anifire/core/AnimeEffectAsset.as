package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.event.EffectEvt;
   import anifire.util.Util;
   import anifire.util.UtilErrorLogger;
   import anifire.util.UtilUnitConvert;
   import flash.events.MouseEvent;
   
   public class AnimeEffectAsset extends EffectAsset
   {
       
      
      public function AnimeEffectAsset(param1:String = null)
      {
         super(param1);
         this.bundle.mouseEnabled = false;
         this.bundle.mouseChildren = false;
      }
      
      override public function serialize() : String
      {
         var logger:UtilErrorLogger = null;
         var result:String = "";
         var timeStr:String = "";
         try
         {
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  timeStr = "<st>" + UtilUnitConvert.secToFrame(this.sttime) + "</st>" + "<et>" + UtilUnitConvert.secToFrame(this.edtime) + "</et>";
               }
            }
            result = "<" + XML_NODE_NAME + " id=\"" + id + "\" index=\"" + this.bundle.parent.getChildIndex(this.bundle) + "\" >" + this.effect.serialize().toXMLString() + "<x>" + Util.roundNum(this.x) + "</x>" + "<y>" + Util.roundNum(this.y) + "</y>" + "<xscale>" + 1 + "</xscale>" + "<yscale>" + 1 + "</yscale>" + timeStr + "<file>" + this.thumb.theme.id + "." + this.effect.id + "</file>" + "</" + XML_NODE_NAME + ">";
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("AnimeEffectAsset::serialize()",e);
            trace("Error:" + e);
         }
         return result;
      }
      
      override function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      override public function showControl() : void
      {
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
      }
      
      override protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         super.loadAssetImageComplete(param1);
         this.x = AnimeConstants.SCREEN_X;
         this.y = AnimeConstants.SCREEN_Y;
         this.addControl();
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:AnimeEffectAsset = new AnimeEffectAsset();
         _loc3_.id = this.id;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.sttime = this.sttime;
         _loc3_.edtime = this.edtime;
         if(_loc3_._myEffectXML == null)
         {
            _loc3_._myEffectXML = this.effect.serialize();
         }
         _loc3_._myEffectXML.@w = this.effect.width;
         _loc3_._myEffectXML.@h = this.effect.height;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         return _loc3_;
      }
      
      override function onMouseMove(param1:MouseEvent) : void
      {
      }
   }
}
