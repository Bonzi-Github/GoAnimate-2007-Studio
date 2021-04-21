package anifire.core
{
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.util.Util;
   import anifire.util.UtilErrorLogger;
   import anifire.util.UtilUnitConvert;
   import flash.geom.Rectangle;
   import mx.events.MenuEvent;
   
   public class ProgramEffectAsset extends EffectAsset
   {
       
      
      private var _needControl:Boolean = false;
      
      public function ProgramEffectAsset(param1:String = "")
      {
         super(param1);
      }
      
      override public function serialize() : String
      {
         var bound:Rectangle = null;
         var timeStr:String = null;
         var isSpeech:String = null;
         var stdur:String = null;
         var eddur:String = null;
         var logger:UtilErrorLogger = null;
         var result:String = "";
         try
         {
            bound = this.effect.getRect(this.bundle.parent);
            timeStr = "";
            isSpeech = !!fromSpeech?"1":"0";
            stdur = this.effect.type == EffectMgr.TYPE_ZOOM?"dur=\"" + UtilUnitConvert.secToFrame(this.stzoom,false,true) + "\"":"";
            eddur = this.effect.type == EffectMgr.TYPE_ZOOM?"dur=\"" + UtilUnitConvert.secToFrame(this.edzoom,false,true) + "\"":"";
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  timeStr = "<st " + stdur + ">" + UtilUnitConvert.secToFrame(this.sttime) + "</st>" + "<et " + eddur + ">" + UtilUnitConvert.secToFrame(this.edtime) + "</et>";
               }
            }
            result = "<" + XML_NODE_NAME + " id=\"" + id + "\" themecode=\"" + this.thumb.theme.id + "\" index=\"" + this.bundle.parent.getChildIndex(this.bundle) + "\" >" + this.effect.serialize().toXMLString() + "<x>" + this.serializeMotion("x",motionShadow) + "</x>" + "<y>" + this.serializeMotion("y",motionShadow) + "</y>" + "<width>" + this.serializeMotion("width",motionShadow) + "</width>" + "<height>" + this.serializeMotion("height",motionShadow) + "</height>" + "<speech>" + isSpeech + "</speech>" + timeStr + "</" + XML_NODE_NAME + ">";
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("ProgramEffectAsset::serialize()",e);
            trace("Error:" + e);
         }
         return result;
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._widths.length,this._heights.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      public function get needControl() : Boolean
      {
         return this._needControl;
      }
      
      override protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         super.loadAssetImageComplete(param1);
         var _loc2_:SuperEffect = param1.getEventCreater() as SuperEffect;
         if(_fromTray)
         {
            this.x = this.x - _loc2_.width / 2;
            this.y = this.y - _loc2_.height / 2;
            this.width = _loc2_.width;
            this.height = _loc2_.height;
         }
         var _loc3_:EffectAsset = this.scene.getEffectAssetById(this.id,-1);
         if(_loc3_ != null && _fromTray && !fromSpeech)
         {
            this.bundle.x = _loc3_.bundle.x;
            this.bundle.y = _loc3_.bundle.y;
            _loc2_.width = _loc3_.effect.width;
            _loc2_.height = _loc3_.effect.height;
            if(_loc3_.motionShadow != null && !isMotionShadow())
            {
               this.bundle.x = _loc3_.motionShadow.bundle.x;
               this.bundle.y = _loc3_.motionShadow.bundle.y;
               _loc2_.width = _loc3_.motionShadow.effect.width;
               _loc2_.height = _loc3_.motionShadow.effect.height;
            }
         }
         _loc2_.showEffect(scene.canvas);
         updateObjectPosition(this);
      }
      
      private function setMotionProperties() : void
      {
         if(this.shouldHasMotion())
         {
            addMotionShadow(this._xs,this._ys,this._widths,this._heights);
         }
      }
      
      public function set needControl(param1:Boolean) : void
      {
         this._needControl = param1;
      }
      
      override public function showControl() : void
      {
         if(this.needControl)
         {
            super.showControl();
         }
      }
      
      public function serializeMotion(param1:String, param2:EffectAsset) : Array
      {
         var _loc5_:Rectangle = null;
         var _loc3_:Array = new Array();
         var _loc4_:Rectangle = this.effect.getRect(this.bundle.parent);
         switch(param1)
         {
            case "x":
               _loc3_.push(Util.roundNum(_loc4_.left));
               break;
            case "y":
               _loc3_.push(Util.roundNum(_loc4_.top));
               break;
            case "width":
               _loc3_.push(Util.roundNum(_loc4_.width));
               break;
            case "height":
               _loc3_.push(Util.roundNum(_loc4_.height));
         }
         if(param2 != null)
         {
            _loc5_ = param2.effect.getRect(this.bundle.parent);
            switch(param1)
            {
               case "x":
                  _loc3_.push(Util.roundNum(_loc5_.left));
                  break;
               case "y":
                  _loc3_.push(Util.roundNum(_loc5_.top));
                  break;
               case "width":
                  _loc3_.push(Util.roundNum(_loc5_.width));
                  break;
               case "height":
                  _loc3_.push(Util.roundNum(_loc5_.height));
            }
         }
         return _loc3_;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:ProgramEffectAsset = new ProgramEffectAsset();
         _loc3_.id = this.id;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.effect = this.effect;
         _loc3_.sttime = this.sttime;
         _loc3_.edtime = this.edtime;
         _loc3_.stzoom = this.stzoom;
         _loc3_.edzoom = this.edzoom;
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
      
      override public function doMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:XML = XML(param1.item);
         if(_loc2_.attribute("label").toString() == MENU_LABEL_SHOW)
         {
            effect.showEffect(scene.canvas);
         }
         else if(_loc2_.attribute("label").toString() == MENU_LABEL_HIDE)
         {
            effect.hideEffect(scene.canvas);
         }
         else if(_loc2_.attribute("label").toString() == MENU_LABEL_DELETE)
         {
            effect.hideEffect(scene.canvas);
         }
         super.doMenuClick(param1);
      }
      
      override public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true, param4:Boolean = true) : void
      {
         this._myEffectXML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         var _loc5_:String = EffectAsset.getThemeIdFromAssetXml(param1);
         var _loc6_:EffectThumb = Console.getConsole().getTheme(_loc5_).getEffectThumbById(EffectMgr.getId(this._myEffectXML));
         this.scene = param2;
         if(param3)
         {
            this.id = param1.@id;
         }
         this._xs = String(param1.x).split(",");
         this._ys = String(param1.y).split(",");
         this._widths = String(param1.width).split(",");
         this._heights = String(param1.height).split(",");
         this.x = this._xs[0];
         this.y = this._ys[0];
         this.bundle.width = this._widths[0];
         this.bundle.height = this._heights[0];
         this.fromSpeech = String(param1.speech) == "1"?true:false;
         if(param1.child("st").length() > 0 && param1.child("st").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToSec(param1.st,false);
            this.edtime = UtilUnitConvert.frameToSec(param1.et,false);
            if(_loc6_.getExactType() == "zoom" && param1.st.@dur > -1 && param1.et.@dur > -1)
            {
               this.stzoom = UtilUnitConvert.frameToSec(param1.st.@dur,false);
               this.edzoom = UtilUnitConvert.frameToSec(param1.et.@dur,false);
            }
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         if(param4)
         {
            this.thumb = _loc6_;
         }
         else
         {
            super.thumb = _loc6_;
         }
         this.isLoadded = true;
         this.bundle.callLater(this.setMotionProperties);
      }
   }
}
