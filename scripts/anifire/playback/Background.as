package anifire.playback
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class Background extends Asset
   {
      
      public static const STATE_ACTION:int = 1;
      
      public static const STATE_NULL:int = 0;
      
      public static const XML_TAG:String = "bg";
       
      
      private var _isFirstBg:Boolean;
      
      private var _firstBg:Background;
      
      private var _file:String;
      
      private var _bgInPrevScene:Background;
      
      private var _bgInNextScene:Background;
      
      private var _startFrameOffset:Number;
      
      private var _myLoader:UtilCommonLoader = null;
      
      public function Background()
      {
         super();
      }
      
      public function initRemoteData(param1:PlayerDataStock) : void
      {
         var iDataStock:PlayerDataStock = param1;
         try
         {
            this.getLoader().addEventListener(Event.COMPLETE,this.onInitRemoteCompleted);
            this.getLoader().shouldPauseOnLoadBytesComplete = true;
            this.getLoader().loadBytes(iDataStock.getPlayerData(this.file) as ByteArray);
         }
         catch(e:Error)
         {
            trace(e.message);
            trace("    key:" + this.file);
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         if(this._bgInNextScene == null)
         {
            this.pause();
         }
         if(param1)
         {
            this.setLoader(null);
         }
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         PlayerConstant.goToAndStopFamily(this.getBundle(),param1 + this.startFrameOffset);
      }
      
      private function set startFrameOffset(param1:Number) : void
      {
         this._startFrameOffset = param1;
      }
      
      private function getLoader() : UtilCommonLoader
      {
         return this._myLoader;
      }
      
      private function get isFirstBg() : Boolean
      {
         return this._isFirstBg;
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:PlayerDataStock) : Boolean
      {
         var _loc5_:XML = null;
         var _loc7_:SelectedColor = null;
         super.initAsset(param1.@id,param1.@index,param2);
         this.file = UtilXmlInfo.getZipFileNameOfBg(param1["file"].toString());
         this.setState(Background.STATE_NULL);
         this._xs = new Array();
         this._xs.push(AnimeConstants.SCREEN_X);
         this._ys = new Array();
         this._ys.push(AnimeConstants.SCREEN_Y);
         var _loc4_:String;
         if((_loc4_ = UtilXmlInfo.getThemeIdFromFileName(this.file)) != "ugc")
         {
            param3.decryptPlayerData(this.file);
         }
         if(param3.getPlayerData(this.file) == null)
         {
            trace("init AnimeSound failure. Reason: failure getting file: " + this.file);
            return false;
         }
         var _loc6_:uint = 0;
         customColor = new UtilHashArray();
         _loc6_ = 0;
         while(_loc6_ < param1.child("color").length())
         {
            _loc5_ = param1.child("color")[_loc6_];
            _loc7_ = new SelectedColor(_loc5_.@r,_loc5_.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(_loc5_.@oc),uint(_loc5_));
            addCustomColor(_loc5_.@r,_loc7_);
            _loc6_++;
         }
         return true;
      }
      
      private function get firstBg() : Background
      {
         return this._firstBg;
      }
      
      private function setLoader(param1:UtilCommonLoader) : void
      {
         this._myLoader = param1;
      }
      
      private function set isFirstBg(param1:Boolean) : void
      {
         this._isFirstBg = param1;
      }
      
      private function get startFrameOffset() : Number
      {
         return this._startFrameOffset;
      }
      
      public function updateProperties(param1:Number) : void
      {
      }
      
      private function onInitRemoteCompleted(param1:Event) : void
      {
         var _loc2_:Class = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteCompleted);
         if(this.getLoader().content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc2_ = this.getLoader().content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc2_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      private function set firstBg(param1:Background) : void
      {
         this._firstBg = param1;
      }
      
      override public function propagateSceneState(param1:int) : void
      {
         if(param1 == AnimeScene.STATE_ACTION)
         {
            this.getLoader().alpha = 1;
            this.getLoader().visible = true;
            UtilPlain.removeAllSon(this.getBundle());
            this.getBundle().addChild(this.getLoader());
            if(this.isFirstBg)
            {
               this.resume();
            }
            this.setState(Background.STATE_ACTION);
         }
         else if(param1 == AnimeScene.STATE_NULL)
         {
            this.setState(Background.STATE_NULL);
         }
      }
      
      private function set file(param1:String) : void
      {
         this._file = param1;
      }
      
      public function initDependency(param1:Background, param2:Number) : void
      {
         this.initAssetDependency();
         this._bgInPrevScene = param1;
         if(this._bgInPrevScene != null && this._bgInPrevScene.file == this.file)
         {
            this.firstBg = this._bgInPrevScene.firstBg;
            this.isFirstBg = false;
            this._bgInPrevScene._bgInNextScene = this;
            this.setLoader(this.firstBg.getLoader());
            this.startFrameOffset = param1.startFrameOffset + param2;
         }
         else
         {
            this.firstBg = this;
            this.isFirstBg = true;
            this.setLoader(new UtilCommonLoader());
            this.startFrameOffset = 0;
         }
      }
      
      private function get file() : String
      {
         return this._file;
      }
   }
}
