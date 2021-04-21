package anifire.playback
{
   import anifire.component.DownloadManager;
   import anifire.constant.AnimeConstants;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class AnimeSound extends EventDispatcher
   {
      
      public static const XML_TAG:String = "sound";
      
      public static const FORMAT_MP3:String = "mp3";
      
      public static const FORMAT_SWF:String = "swf";
       
      
      private var _endMilliSec:Number;
      
      private var _inner_volume:Number = 1;
      
      private var _fadeFactor:Number = 1;
      
      private var _movieId:String;
      
      protected var _endFrame:Number;
      
      protected var _bufferProgress:Number = 0;
      
      private var _myMovieSegmentEndMilliSecond:Number;
      
      private var _volume:Number = 0.5;
      
      private var _id:String;
      
      private var _subtype:String = null;
      
      private var _startMilliSec:Number;
      
      protected var _startFrame:Number;
      
      private var _speechData:String;
      
      private var _file:String = "";
      
      private var _duration_in_millisec:Number;
      
      public function AnimeSound()
      {
         super();
      }
      
      private static function getEndFrameFromSoundXML(param1:XML) : Number
      {
         return Number(param1["stop"].toString());
      }
      
      private static function getStartFrameFromSoundXML(param1:XML) : Number
      {
         return Number(param1["start"].toString());
      }
      
      protected static function splitSoundXmlBySoundDuration(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Array
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = undefined;
         var _loc5_:Array = new Array();
         var _loc9_:AnimeSound;
         if(!(_loc9_ = new AnimeSound()).init(param1,param2,param3,param4))
         {
            return _loc5_;
         }
         _loc6_ = _loc9_.getStartFrame();
         _loc7_ = _loc9_.getEndFrame();
         if((_loc8_ = UtilUnitConvert.secToFrame(_loc9_.durationInMillisec / 1000)) <= 0)
         {
            return _loc5_;
         }
         var _loc10_:Number = _loc6_;
         do
         {
            _loc11_ = Math.min(_loc10_ + _loc8_,_loc7_);
            ((_loc12_ = param1.copy()).child("start")[0] as XML).setChildren(_loc10_.toString());
            (_loc12_.child("stop")[0] as XML).setChildren(_loc11_.toString());
            _loc5_.push(_loc12_);
            _loc10_ = _loc11_;
         }
         while(_loc7_ - _loc11_ > 2);
         
         return _loc5_;
      }
      
      public static function createAndInitSounds(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Array
      {
         var isInitSuccess:Boolean = false;
         var embedSound:EmbedSound = null;
         var progressiveSound:ProgressiveSound = null;
         var splitedSoundXMLArray:Array = null;
         var curSplitedXML:XML = null;
         var streamSound:StreamSound = null;
         var i:int = 0;
         var soundXML:XML = param1;
         var themeXMLs:UtilHashArray = param2;
         var movieId:String = param3;
         var dataStock:PlayerDataStock = param4;
         var soundArray:Array = new Array();
         var downloadType:String = AnimeConstants.DOWNLOAD_TYPE_EMBED;
         var zipFileName:String = UtilXmlInfo.getZipFileNameOfSound(soundXML["sfile"].toString());
         var thumbId:String = UtilXmlInfo.getThumbIdFromFileName(zipFileName);
         var themeId:String = UtilXmlInfo.getThemeIdFromFileName(zipFileName);
         var themeXml:XML = themeXMLs.getValueByKey(themeId) as XML;
         var byteArray:ByteArray = dataStock.getPlayerData(zipFileName) as ByteArray;
         var soundXmlNode:XML = null;
         if(themeXml != null)
         {
            soundXmlNode = XMLList(themeXml.sound.(@id == thumbId))[0];
         }
         if(soundXmlNode != null)
         {
            downloadType = soundXmlNode.@downloadtype;
         }
         else if(byteArray != null && byteArray.length > 0 && UtilXmlInfo.getFileNameExtension(zipFileName) == "swf")
         {
            downloadType = AnimeConstants.DOWNLOAD_TYPE_EMBED;
         }
         else
         {
            downloadType = AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE;
         }
         if(downloadType == AnimeConstants.DOWNLOAD_TYPE_EMBED)
         {
            embedSound = new EmbedSound();
            isInitSuccess = embedSound.init(soundXML,themeXMLs,movieId,dataStock);
            if(isInitSuccess)
            {
               soundArray.push(embedSound);
            }
         }
         else if(downloadType == AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE)
         {
            progressiveSound = new ProgressiveSound();
            isInitSuccess = progressiveSound.init(soundXML,themeXMLs,movieId,dataStock);
            if(isInitSuccess)
            {
               soundArray.push(progressiveSound);
            }
         }
         else if(downloadType == AnimeConstants.DOWNLOAD_TYPE_STREAM)
         {
            splitedSoundXMLArray = splitSoundXmlBySoundDuration(soundXML,themeXMLs,movieId,dataStock);
            i = 0;
            while(i < splitedSoundXMLArray.length)
            {
               curSplitedXML = splitedSoundXMLArray[i] as XML;
               streamSound = new StreamSound();
               isInitSuccess = streamSound.init(curSplitedXML,themeXMLs,movieId,dataStock);
               if(isInitSuccess)
               {
                  soundArray.push(streamSound);
               }
               i++;
            }
         }
         return soundArray;
      }
      
      private function updateEndMilliSecFromEndFrame() : void
      {
         this.endMilliSec = UtilUnitConvert.frameToSec(this.getEndFrame()) * 1000;
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function mute_inner_volume() : void
      {
         this._inner_volume = 0;
      }
      
      protected function set startMilliSec(param1:Number) : void
      {
         this._startMilliSec = param1;
      }
      
      public function fadeVolumeBySubtype(param1:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Number = 500;
         var _loc3_:Number = 1;
         var _loc4_:Number = 1;
         var _loc5_:Number;
         if((_loc5_ = this.myMovieSegmentEndMilliSecond - param1) < _loc2_ && _loc5_ > 0)
         {
            _loc4_ = _loc5_ / _loc2_;
         }
         else if(param1 > this.myMovieSegmentEndMilliSecond)
         {
            _loc4_ = 0;
         }
         if(this.subtype == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            _loc7_ = this.startMilliSec + _loc2_;
            _loc8_ = this.endMilliSec - _loc2_;
            if(this.endMilliSec - this.startMilliSec <= _loc2_ * 2)
            {
               _loc3_ = 1;
            }
            else if(param1 >= _loc7_ && param1 <= _loc8_)
            {
               _loc3_ = 1;
            }
            else if(param1 >= this.startMilliSec && param1 <= _loc7_)
            {
               _loc3_ = (param1 - this.startMilliSec) / _loc2_;
            }
            else if(param1 >= _loc8_ && param1 <= this.endMilliSec)
            {
               _loc3_ = (this.endMilliSec - param1) / _loc2_;
            }
            else
            {
               _loc3_ = 0;
            }
         }
         var _loc6_:Number = _loc4_ * _loc3_;
         if(this.fadeFactor != _loc6_)
         {
            this.fadeVolume(_loc6_);
         }
      }
      
      protected function setBufferProgress(param1:Number) : void
      {
         this._bufferProgress = param1;
      }
      
      public function init(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Boolean
      {
         var themeId:String = null;
         var themeXml:XML = null;
         var thumbId:String = null;
         var soundXmlNode:XML = null;
         var soundXML:XML = param1;
         var themeXMLs:UtilHashArray = param2;
         var movieId_input:String = param3;
         var dataStock:PlayerDataStock = param4;
         this.setStartFrame(getStartFrameFromSoundXML(soundXML));
         this.setEndFrame(getEndFrameFromSoundXML(soundXML));
         this.updateStartMilliSecFromEndFrame();
         this.updateEndMilliSecFromEndFrame();
         this.id = soundXML.attribute("id").toString();
         this.movieId = movieId_input;
         if(soundXML.attribute("vol").length() != 0)
         {
            this.inner_volume = Number(soundXML.attribute("vol"));
         }
         else
         {
            this.inner_volume = 1;
         }
         this.file = UtilXmlInfo.getZipFileNameOfSound(soundXML["sfile"].toString());
         try
         {
            themeId = UtilXmlInfo.getThemeIdFromFileName(this.file);
            themeXml = themeXMLs.getValueByKey(themeId) as XML;
            thumbId = UtilXmlInfo.getThumbIdFromFileName(this.file);
            soundXmlNode = XMLList(themeXml.sound.(@id == thumbId))[0];
            this.subtype = soundXmlNode.attribute("subtype").length() > 0?soundXmlNode.@subtype:AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
            this.durationInMillisec = parseFloat(soundXmlNode.@duration);
         }
         catch(e:Error)
         {
            trace("warning error occur in initializing sound");
            this.subtype = AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
         }
         return true;
      }
      
      public function goToAndPause(param1:Number) : void
      {
      }
      
      public function getBufferProgress() : Number
      {
         return this._bufferProgress;
      }
      
      public function initDependency(param1:Number, param2:Number, param3:DownloadManager) : void
      {
         var _loc4_:Number = this.getStartFrame() + param1;
         var _loc5_:Number = this.getEndFrame() + param1;
         this._myMovieSegmentEndMilliSecond = UtilUnitConvert.frameToSec(param1 + param2) * 1000;
         if(_loc4_ < param1 + param2)
         {
            if(_loc5_ > param1 + param2)
            {
               _loc5_ = param1 + param2;
            }
         }
         else
         {
            this.inner_volume = 0;
         }
         this.setStartFrame(_loc4_);
         this.setEndFrame(_loc5_);
         this.updateStartMilliSecFromEndFrame();
         this.updateEndMilliSecFromEndFrame();
      }
      
      protected function get volume() : Number
      {
         return this._volume;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function setVolume(param1:Number) : void
      {
      }
      
      public function getStartFrame() : Number
      {
         return this._startFrame;
      }
      
      protected function get inner_volume() : Number
      {
         return this._inner_volume;
      }
      
      protected function setStartFrame(param1:Number) : void
      {
         this._startFrame = param1;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      protected function set volume(param1:Number) : void
      {
         this._volume = param1;
      }
      
      public function resume() : void
      {
      }
      
      protected function get endMilliSec() : Number
      {
         return this._endMilliSec;
      }
      
      private function updateStartMilliSecFromEndFrame() : void
      {
         this.startMilliSec = UtilUnitConvert.frameToSec(this.getStartFrame()) * 1000;
      }
      
      protected function set durationInMillisec(param1:Number) : void
      {
         this._duration_in_millisec = param1;
      }
      
      public function play(param1:Number) : void
      {
      }
      
      public function get speechData() : String
      {
         return this._speechData;
      }
      
      public function fadeVolume(param1:Number) : void
      {
      }
      
      protected function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
      }
      
      public function getEndFrame() : Number
      {
         return this._endFrame;
      }
      
      protected function get startMilliSec() : Number
      {
         return this._startMilliSec;
      }
      
      protected function setEndFrame(param1:Number) : void
      {
         this._endFrame = param1;
      }
      
      public function get myMovieSegmentEndMilliSecond() : Number
      {
         return this._myMovieSegmentEndMilliSecond;
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
      }
      
      protected function set fadeFactor(param1:Number) : void
      {
         this._fadeFactor = param1;
      }
      
      public function set speechData(param1:String) : void
      {
         this._speechData = param1;
      }
      
      protected function get fadeFactor() : Number
      {
         return this._fadeFactor;
      }
      
      protected function get durationInMillisec() : Number
      {
         return this._duration_in_millisec;
      }
      
      protected function set subtype(param1:String) : void
      {
         this._subtype = param1;
      }
      
      protected function set file(param1:String) : void
      {
         this._file = param1;
      }
      
      protected function get subtype() : String
      {
         return this._subtype;
      }
      
      protected function get file() : String
      {
         return this._file;
      }
      
      public function pause(param1:Number) : void
      {
      }
      
      protected function set endMilliSec(param1:Number) : void
      {
         this._endMilliSec = param1;
      }
   }
}
