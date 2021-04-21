package anifire.core
{
   import anifire.core.sound.SoundEvent;
   import anifire.util.UtilErrorLogger;
   import flash.events.EventDispatcher;
   
   public class LinkageController
   {
       
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _linkages:Array;
      
      public function LinkageController()
      {
         this._eventDispatcher = new EventDispatcher();
         super();
         this._linkages = new Array();
      }
      
      public function getCharIdOfSpeech(param1:String) : String
      {
         var _loc4_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Array = this.isLinkageExist(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.concat();
            _loc4_.splice(_loc4_.indexOf(param1),1);
            _loc2_ = _loc4_.join("");
         }
         return _loc2_;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function getSpeechIdOfAsset(param1:Asset) : String
      {
         var _loc2_:Asset = param1;
         return _loc2_.scene != null?this.getSpeechIdByScene(_loc2_.scene):"";
      }
      
      public function serialize() : String
      {
         var i:int = 0;
         var linkage:AssetLinkage = null;
         var logger:UtilErrorLogger = null;
         var str:String = "";
         try
         {
            i = 0;
            while(i < this._linkages.length)
            {
               linkage = this.getLinkageByIndex(i);
               str = str + linkage.serialize();
               i++;
            }
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("LinkageController::serialize()",e);
            trace("Error:" + e);
         }
         return str;
      }
      
      public function removeLinkage(param1:AssetLinkage) : void
      {
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.UPDATED,this);
         _loc2_.sceneId = param1.getSceneId();
         this.eventDispatcher.dispatchEvent(_loc2_);
         var _loc3_:Number = this._linkages.indexOf(param1);
         this._linkages.splice(_loc3_,1);
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function addLinkage(param1:AssetLinkage) : void
      {
         this._linkages.push(param1);
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.UPDATED,this);
         _loc2_.sceneId = param1.getSceneId();
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      public function getLinkageByIndex(param1:int) : AssetLinkage
      {
         return this._linkages[param1];
      }
      
      public function getSpeechIdByScene(param1:AnimeScene) : String
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Character = null;
         var _loc12_:Array = null;
         var _loc2_:String = "";
         var _loc5_:XML;
         if(_loc5_ = param1.sceneXML)
         {
            _loc6_ = false;
            for each(_loc7_ in _loc5_.children())
            {
               _loc8_ = _loc7_.name();
               switch(_loc8_)
               {
                  case Character.XML_NODE_NAME:
                     _loc4_ = _loc5_.@id + AssetLinkage.LINK + _loc7_.@id;
                     _loc3_ = this.isLinkageExist(_loc4_);
                     if(_loc3_ != null)
                     {
                        _loc6_ = true;
                     }
               }
               if(_loc6_)
               {
                  break;
               }
            }
         }
         else
         {
            _loc9_ = param1.characters.length;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc4_ = (_loc11_ = param1.characters.getValueByIndex(_loc10_) as Character).scene.id + AssetLinkage.LINK + _loc11_.id;
               _loc3_ = this.isLinkageExist(_loc4_);
               if(_loc3_ != null)
               {
                  break;
               }
               _loc10_++;
            }
         }
         if(_loc3_ != null)
         {
            _loc12_ = _loc3_.concat();
            _loc12_.splice(_loc12_.indexOf(_loc4_),1);
            _loc2_ = _loc12_.join("");
         }
         return _loc2_;
      }
      
      public function deleteLinkage(param1:Asset) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         _loc3_ = param1.scene.id + AssetLinkage.LINK + param1.id;
         return this.deleteLinkageById(_loc3_);
      }
      
      public function deleteLinkageById(param1:String) : String
      {
         var _loc4_:AssetLinkage = null;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < this._linkages.length)
         {
            if((_loc4_ = this.getLinkageByIndex(_loc3_)).getLinkage().indexOf(param1) > -1)
            {
               if(_loc4_.getLinkage().length <= 2)
               {
                  this.removeLinkage(_loc4_);
               }
               _loc4_.removeLinkage(param1);
               _loc2_ = _loc4_.getLinkage().join("");
               _loc4_ = null;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function isLinkageExist(param1:String) : Array
      {
         var _loc3_:AssetLinkage = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._linkages.length)
         {
            _loc3_ = this.getLinkageByIndex(_loc2_);
            if(_loc3_.getLinkage().indexOf(param1) > -1)
            {
               return _loc3_.getLinkage();
            }
            _loc2_++;
         }
         return null;
      }
      
      public function isDemoSpeechNeeded(param1:Character) : Boolean
      {
         var _loc2_:String = this.getSpeechIdByScene(param1.scene);
         var _loc3_:String = this.getCharIdOfSpeech(_loc2_);
         var _loc4_:String;
         return (_loc4_ = AssetLinkage.getCharIdFromLinkage(_loc3_)) == param1.id;
      }
      
      public function deserialize(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:AssetLinkage = null;
         var _loc5_:String = null;
         var _loc6_:AnimeScene = null;
         var _loc7_:String = null;
         _loc3_ = 0;
         while(_loc3_ < param1.child(AssetLinkage.XML_TAG).length())
         {
            _loc2_ = param1.child(AssetLinkage.XML_TAG)[_loc3_];
            (_loc4_ = new AssetLinkage()).deserialize(_loc2_);
            _loc5_ = _loc4_.getSceneId();
            if(_loc6_ = Console.getConsole().getScenebyId(_loc5_))
            {
               this.addLinkage(_loc4_);
            }
            else
            {
               _loc7_ = _loc4_.getSoundId();
               Console.getConsole().speechManager.removeSoundById(_loc7_);
            }
            _loc3_++;
         }
      }
   }
}
