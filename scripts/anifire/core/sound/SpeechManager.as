package anifire.core.sound
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.util.UtilUnitConvert;
   import flash.utils.ByteArray;
   
   public class SpeechManager
   {
       
      
      private var _micRecordingManager:MicRecordingManager;
      
      private var _ttsManager:TTSManager;
      
      private var _voiceFileManager:VoiceFileManager;
      
      public function SpeechManager()
      {
         this._ttsManager = new TTSManager();
         this._micRecordingManager = new MicRecordingManager();
         this._voiceFileManager = new VoiceFileManager();
         super();
      }
      
      public function createSoundThumbByByte(param1:ByteArray, param2:XML) : SoundThumb
      {
         var _loc3_:SoundThumb = new SoundThumb();
         _loc3_.deSerializeByUserAssetXML(param2,Console.getConsole().userTheme);
         _loc3_.enable = true;
         _loc3_.initSoundByByteArray(param1);
         Console.getConsole().addNewlyAddedAssetId(param2.id);
         return _loc3_;
      }
      
      public function get micRecordingManager() : MicRecordingManager
      {
         return this._micRecordingManager;
      }
      
      public function addSoundBySound(param1:AnimeSound, param2:Boolean = true) : void
      {
         var _loc3_:SoundThumb = param1.soundThumb;
         if(_loc3_.ttsData.type == "mic")
         {
            this.micRecordingManager.addSoundBySound(param1,param2);
         }
         else if(_loc3_.ttsData.type == "file")
         {
            this.voiceFileManager.addSoundBySound(param1,param2);
         }
         else
         {
            this.ttsManager.addSoundBySound(param1,param2);
         }
      }
      
      public function getValueByKey(param1:String) : AnimeSound
      {
         if(this.ttsManager.sounds.containsKey(param1))
         {
            return this.ttsManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         if(this.micRecordingManager.sounds.containsKey(param1))
         {
            return this.micRecordingManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         if(this.voiceFileManager.sounds.containsKey(param1))
         {
            return this.voiceFileManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         return null;
      }
      
      public function serializeSound(param1:Boolean = true, param2:Object = null) : String
      {
         var _loc3_:String = "";
         param2.phase = "Speech manager began";
         _loc3_ = _loc3_ + this.ttsManager.serializeSound(param1,param2);
         _loc3_ = _loc3_ + this.micRecordingManager.serializeSound(param1,param2);
         _loc3_ = _loc3_ + this.voiceFileManager.serializeSound(param1,param2);
         param2.phase = "Speech manager ended";
         return _loc3_;
      }
      
      public function addSoundByThumb(param1:SoundThumb) : void
      {
         var _loc2_:AnimeSound = new AnimeSound();
         _loc2_.init(param1,0,UtilUnitConvert.secToFrame(param1.duration / 1000));
         this.addSoundBySound(_loc2_);
      }
      
      public function get ttsManager() : TTSManager
      {
         return this._ttsManager;
      }
      
      public function removeSoundById(param1:String) : void
      {
         if(this.ttsManager.sounds.containsKey(param1))
         {
            return this.ttsManager.removeSoundById(param1);
         }
         if(this.micRecordingManager.sounds.containsKey(param1))
         {
            return this.micRecordingManager.removeSoundById(param1);
         }
         if(this.voiceFileManager.sounds.containsKey(param1))
         {
            return this.voiceFileManager.removeSoundById(param1);
         }
      }
      
      public function get voiceFileManager() : VoiceFileManager
      {
         return this._voiceFileManager;
      }
   }
}
