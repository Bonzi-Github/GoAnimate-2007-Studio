package anifire.core
{
   import anifire.components.containers.SoundTileCell;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.sound.EmbedSound;
   import anifire.core.sound.ISoundable;
   import anifire.core.sound.ProgressiveSound;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.StreamSound;
   import anifire.managers.*;
   import anifire.util.Util;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import mx.core.DragSource;
   import mx.core.UIComponent;
   import mx.events.FlexEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   
   public class SoundThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "sound";
      
      private static var _logger:ILogger = Log.getLogger("core.SoundThumb");
       
      
      private var _downloadType:String;
      
      private var _duration:Number;
      
      private var _tileCell:SoundTileCell;
      
      private var _sound:ISoundable;
      
      private var _subType:String;
      
      private var _lengthFrame:Number = -1;
      
      private var _isLoading:Boolean = false;
      
      private var _ttsData:SpeechData;
      
      public function SoundThumb()
      {
         super();
         _logger.info("SoundThumb initialized");
         this._tileCell = new SoundTileCell();
         this._tileCell.soundThumb = this;
         this.getTileCell().addEventListener(SoundTileCell.EVENT_PLAY_BUT_CLICK,this.onTilePlayButClick);
         this.getTileCell().addEventListener(FlexEvent.CREATION_COMPLETE,this.initTileCell);
      }
      
      private static function createSoundObj(param1:SoundThumb) : ISoundable
      {
         if(param1.downloadType == AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE)
         {
            return new ProgressiveSound();
         }
         if(param1.downloadType == AnimeConstants.DOWNLOAD_TYPE_EMBED)
         {
            return new EmbedSound();
         }
         if(param1.downloadType == AnimeConstants.DOWNLOAD_TYPE_STREAM)
         {
            return new StreamSound();
         }
         return null;
      }
      
      public static function initSoundObj(param1:ISoundable, param2:SoundThumb) : void
      {
         var _loc3_:ProgressiveSound = null;
         var _loc4_:StreamSound = null;
         var _loc5_:EmbedSound = null;
         if(param2.downloadType == AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE)
         {
            _loc3_ = param1 as ProgressiveSound;
            _loc3_.init(UtilNetwork.getGetSoundAssetRequest(param2.theme.id,param2.id,param2.downloadType),param2._duration);
         }
         else if(param2.downloadType == AnimeConstants.DOWNLOAD_TYPE_STREAM)
         {
            (_loc4_ = param1 as StreamSound).init(ServerConstants.ACTION_GET_STREAM_SOUND,param2.id,param2._duration);
         }
         else if(param2.downloadType == AnimeConstants.DOWNLOAD_TYPE_EMBED)
         {
            _loc5_ = param1 as EmbedSound;
            if(param2.imageData != null)
            {
               _loc5_.initByByteArray(param2.imageData as ByteArray);
            }
            else
            {
               _loc5_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
               _loc5_.initByUrl(UtilNetwork.getGetSoundAssetRequest(param2.theme.id,param2.id,param2.downloadType),param2.theme.id == "ugc",param2.theme.id != "ugc");
            }
         }
      }
      
      public function onTilePlayButClick(param1:Event) : void
      {
         if(this.sound == null || !this.sound.getIsReadyToPlay())
         {
            this.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.getTileCell().playSound);
            this.initSoundFromNetwork();
         }
         Util.gaTracking("/gostudio/playSound/" + theme.id + "/" + id,Console.getConsole().mainStage.stage);
      }
      
      public function set downloadType(param1:String) : void
      {
         this._downloadType = param1;
      }
      
      public function initSoundFromNetwork() : void
      {
         if(!this._isLoading)
         {
            this._isLoading = true;
            this._sound = createSoundObj(this);
            this.getTileCell().tileLabel = "Loading...";
            this._sound.addEventListener(SoundEvent.READY_TO_PLAY,this.doSayLoadThumbComplete);
            initSoundObj(this._sound,this);
         }
      }
      
      public function get info() : String
      {
         var info:String = "";
         if(this.subType == "tribeofnoise")
         {
            info = info + "<info>";
            info = info + ("<title>" + this.name + "</title>");
            info = info + ("<author>" + SoundStore.dbTribeOfNoise.sound.(@aid == this.aid).@author + "</author>");
            info = info + "</info>";
         }
         return info;
      }
      
      private function getHitArea() : UIComponent
      {
         return this.getTileCell().getHitArea();
      }
      
      override function loadProxyImageComplete(param1:Event) : void
      {
         var _loc2_:SoundTileCell = SoundTileCell(param1.target);
         _loc2_.tileLabel = this.name;
         _loc2_.hideButton();
         _loc2_.width = this.getTileCell().width;
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function get sound() : ISoundable
      {
         return this._sound;
      }
      
      public function get subType() : String
      {
         return this._subType;
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = param1.@name;
         this.theme = param2;
         this.premium = param1.@is_premium == "Y"?true:false;
         this.enable = param1.@enable == "N"?false:true;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.enable = false;
         }
         if(!FeatureManager.isPremiumStuffVisible && this.premium && Number(param1.@sharing) > 0)
         {
            this.enable = false;
         }
         this.cost = [param1.@money,param1.@sharing];
         if(param1.@downloadtype == AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE || param1.@downloadtype == AnimeConstants.DOWNLOAD_TYPE_STREAM)
         {
            this._downloadType = param1.@downloadtype;
         }
         else
         {
            this._downloadType = AnimeConstants.DOWNLOAD_TYPE_EMBED;
         }
         this._duration = parseInt(param1.@duration);
         this.subType = param1.@subtype != null?param1.@subtype:AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
         if(this.theme.id == "ugc")
         {
            this.tags = param1.tags;
            this.isPublished = param1.@published == "1"?true:false;
         }
         this.updateTileCellLabel(this.name,this.getTileCell());
      }
      
      public function get downloadType() : String
      {
         return this._downloadType;
      }
      
      public function set isLoading(param1:Boolean) : void
      {
         this._isLoading = param1;
      }
      
      public function get lengthFrame() : Number
      {
         return this._lengthFrame;
      }
      
      private function doSayLoadThumbComplete(param1:Event) : void
      {
         var _loc2_:EmbedSound = null;
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doSayLoadThumbComplete);
         }
         if(this.sound is EmbedSound)
         {
            _loc2_ = this.sound as EmbedSound;
            this.imageData = _loc2_.byteArray;
         }
         this.getTileCell().sound = this.sound;
         this._lengthFrame = UtilUnitConvert.secToFrame(this.sound.getDuration() / 1000);
         this._duration = this.sound.getDuration();
         this.getTileCell().tileLabel = this.name;
         this._isLoading = false;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function updateTileCellLabel(param1:String, param2:SoundTileCell) : void
      {
         param2.tileLabel = param1;
      }
      
      public function requestSoundObjCopy() : ISoundable
      {
         return this._sound.clone();
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:UIComponent = null;
         var _loc3_:DragSource = null;
         var _loc4_:UIComponent = null;
         var _loc5_:SoundTileCell = null;
         if(purchased)
         {
            _loc2_ = param1.currentTarget as UIComponent;
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            _loc4_ = new UIComponent();
            (_loc5_ = new SoundTileCell()).tileLabel = this.getTileCell().tileLabel;
            _loc5_.addEventListener(FlexEvent.CREATION_COMPLETE,this.loadProxyImageComplete);
            _loc4_.addChild(_loc5_);
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      public function initTileCell(param1:Event) : void
      {
         this.getTileCell().getHitArea().addEventListener(MouseEvent.MOUSE_DOWN,this.doDrag);
      }
      
      private function getSubTypeLabel(param1:String) : String
      {
         var _loc2_:String = "";
         if(param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            _loc2_ = "(music)";
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
         {
            _loc2_ = "(effect)";
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            _loc2_ = "(voice)";
         }
         return _loc2_;
      }
      
      public function get isLoading() : Boolean
      {
         return this._isLoading;
      }
      
      public function set subType(param1:String) : void
      {
         this._subType = param1;
      }
      
      public function getTileCell() : SoundTileCell
      {
         return this._tileCell;
      }
      
      public function deSerializeByUserAssetXML(param1:XML, param2:Theme) : void
      {
         this.id = param1.child("file")[0].toString();
         this.name = param1.child("title")[0].toString();
         this.theme = param2;
         this.subType = param1.child("subtype").length() > 0?param1.child("subtype")[0].toString():AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
         this._downloadType = param1.child("downloadtype")[0].toString();
         this._duration = parseInt(param1.child("duration")[0].toString());
         if(this.theme.id == "ugc")
         {
            this.tags = param1.tags;
            this.isPublished = param1.published == "1"?true:false;
         }
         this.updateTileCellLabel(this.name,this.getTileCell());
         var _loc3_:XML = new XML("<theme><sound id=\"" + this.id + "\" name=\"" + UtilXmlInfo.xmlEscape(this.name) + "\" enable=\"Y\" downloadtype=\"" + this._downloadType + "\" subtype=\"" + this.subType + "\" duration=\"" + this._duration + "\" /></theme>");
         param2.mergeThemeXML(_loc3_);
      }
      
      public function set ttsData(param1:SpeechData) : void
      {
         this._ttsData = param1;
      }
      
      public function initSoundByByteArray(param1:ByteArray) : void
      {
         if(!this._isLoading)
         {
            this._isLoading = true;
            this.imageData = param1;
            this._sound = createSoundObj(this);
            this._sound.addEventListener(SoundEvent.READY_TO_PLAY,this.doSayLoadThumbComplete);
            initSoundObj(this._sound,this);
         }
      }
      
      public function get ttsData() : SpeechData
      {
         return this._ttsData;
      }
   }
}
