package anifire.core
{
   import anifire.util.UtilHashArray;
   import flash.utils.ByteArray;
   
   public class ThemeTree
   {
       
      
      private var _videoPropThumbs:UtilHashArray;
      
      private var _propThumbs:UtilHashArray;
      
      private var _soundThumbs:UtilHashArray;
      
      private var _bgThumbs:UtilHashArray;
      
      private var _themeID:String;
      
      private var _bubbleThumbs:UtilHashArray;
      
      private var _themeXml:XML = null;
      
      private var _charThumbs:UtilHashArray;
      
      private var _effectThumbs:UtilHashArray;
      
      public function ThemeTree(param1:String)
      {
         this._charThumbs = new UtilHashArray();
         this._bgThumbs = new UtilHashArray();
         this._soundThumbs = new UtilHashArray();
         this._bubbleThumbs = new UtilHashArray();
         this._propThumbs = new UtilHashArray();
         this._videoPropThumbs = new UtilHashArray();
         this._effectThumbs = new UtilHashArray();
         super();
         this.setThemeID(param1);
      }
      
      public static function mergeThemeTrees(param1:UtilHashArray, param2:UtilHashArray) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2.getKey(_loc4_);
            if(param1.containsKey(_loc3_))
            {
               (param1.getValueByKey(_loc3_) as ThemeTree).mergeThemeTree(param2.getValueByKey(_loc3_) as ThemeTree);
            }
            else
            {
               param1.push(_loc3_,param2.getValueByKey(_loc3_));
            }
            _loc4_++;
         }
      }
      
      public static function mergeThemeTreeToThemeTrees(param1:UtilHashArray, param2:ThemeTree) : void
      {
         var _loc3_:String = param2.getThemeID();
         var _loc4_:ThemeTree;
         if((_loc4_ = param1.getValueByKey(_loc3_) as ThemeTree) != null)
         {
            _loc4_.mergeThemeTree(param2);
         }
         else
         {
            param1.push(_loc3_,param2);
         }
      }
      
      public function getEffectThumbs() : UtilHashArray
      {
         return this._effectThumbs;
      }
      
      public function getVideoPropThumbs() : UtilHashArray
      {
         return this._videoPropThumbs;
      }
      
      public function getCharThumbs() : UtilHashArray
      {
         return this._charThumbs;
      }
      
      public function getThemeXml() : XML
      {
         return this._themeXml;
      }
      
      public function isPropThumbExist(param1:String) : Boolean
      {
         return this.getPropThumbs().containsKey(param1);
      }
      
      public function addThemeXml(param1:XML) : void
      {
         this._themeXml = param1;
      }
      
      public function addSoundThumbId(param1:String, param2:ByteArray) : void
      {
         this.getSoundThumbs().push(param1,param2);
      }
      
      public function addPropThumbId(param1:String, param2:ByteArray) : void
      {
         this.getPropThumbs().push(param1,param2);
      }
      
      public function isBubThumbExist(param1:String) : Boolean
      {
         return this.getBubbleThumbs().containsKey(param1);
      }
      
      public function getSoundThumbs() : UtilHashArray
      {
         return this._soundThumbs;
      }
      
      public function isVideoPropThumbExist(param1:String) : Boolean
      {
         return this.getVideoPropThumbs().containsKey(param1);
      }
      
      public function getPropThumbs() : UtilHashArray
      {
         return this._propThumbs;
      }
      
      public function isEffectThumbExist(param1:String) : Boolean
      {
         return this.getEffectThumbs().containsKey(param1);
      }
      
      public function addEffectThumbId(param1:String, param2:ByteArray) : void
      {
         this.getEffectThumbs().push(param1,param2);
      }
      
      private function setThemeID(param1:String) : void
      {
         this._themeID = param1;
      }
      
      public function addBubThumbId(param1:String, param2:ByteArray) : void
      {
         this.getBubbleThumbs().push(param1,param2);
      }
      
      public function addCharBehaviour(param1:String, param2:String, param3:ByteArray, param4:Boolean) : void
      {
         var _loc5_:UtilHashArray = null;
         if(param4)
         {
            if(this.getCharThumbs().containsKey(param1))
            {
               _loc5_ = this.getCharThumbs().getValueByKey(param1) as UtilHashArray;
            }
            else
            {
               _loc5_ = new UtilHashArray();
               this.getCharThumbs().push(param1,_loc5_);
            }
         }
         else if(this.getPropThumbs().containsKey(param1))
         {
            _loc5_ = this.getPropThumbs().getValueByKey(param1) as UtilHashArray;
         }
         else
         {
            _loc5_ = new UtilHashArray();
            this.getPropThumbs().push(param1,_loc5_);
         }
         _loc5_.push(param2,param3);
      }
      
      public function getThemeID() : String
      {
         return this._themeID;
      }
      
      public function mergeThemeTree(param1:ThemeTree) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(param1.getThemeID() != this.getThemeID())
         {
            throw new Error("The input theme is different from currentTheme");
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getBgThumbs().length)
         {
            this.addBgThumb(param1.getBgThumbs().getKey(_loc2_),param1.getBgThumbs().getValueByIndex(_loc2_));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getBubbleThumbs().length)
         {
            this.addBubThumbId(param1.getBubbleThumbs().getKey(_loc2_),param1.getBubbleThumbs().getValueByIndex(_loc2_));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getSoundThumbs().length)
         {
            this.addSoundThumbId(param1.getSoundThumbs().getKey(_loc2_),param1.getSoundThumbs().getValueByIndex(_loc2_));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getEffectThumbs().length)
         {
            this.addEffectThumbId(param1.getEffectThumbs().getKey(_loc2_),param1.getEffectThumbs().getValueByIndex(_loc2_));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getPropThumbs().length)
         {
            if(param1.getPropThumbs().getValueByIndex(_loc2_) is UtilHashArray)
            {
               _loc5_ = param1.getPropThumbs().getKey(_loc2_);
               if(this.getPropThumbs().containsKey(_loc5_))
               {
                  _loc4_ = this.getPropThumbs().getValueByKey(_loc5_);
               }
               else
               {
                  _loc4_ = new UtilHashArray();
                  this.getPropThumbs().push(_loc5_,_loc4_);
               }
               _loc4_.insert(0,param1.getPropThumbs().getValueByKey(_loc5_) as UtilHashArray);
            }
            else
            {
               this.addPropThumbId(param1.getPropThumbs().getKey(_loc2_),param1.getPropThumbs().getValueByIndex(_loc2_));
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getVideoPropThumbs().length)
         {
            if(param1.getVideoPropThumbs().getValueByIndex(_loc2_) is UtilHashArray)
            {
               _loc6_ = param1.getVideoPropThumbs().getKey(_loc2_);
               if(this.getVideoPropThumbs().containsKey(_loc6_))
               {
                  _loc4_ = this.getVideoPropThumbs().getValueByKey(_loc6_);
               }
               else
               {
                  _loc4_ = new UtilHashArray();
                  this.getVideoPropThumbs().push(_loc6_,_loc4_);
               }
               _loc4_.insert(0,param1.getVideoPropThumbs().getValueByKey(_loc6_) as UtilHashArray);
            }
            else
            {
               this.addVideoPropThumbId(param1.getVideoPropThumbs().getKey(_loc2_),param1.getVideoPropThumbs().getValueByIndex(_loc2_));
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.getCharThumbs().length)
         {
            _loc7_ = param1.getCharThumbs().getKey(_loc2_);
            if(this.getCharThumbs().containsKey(_loc7_))
            {
               _loc4_ = this.getCharThumbs().getValueByKey(_loc7_);
            }
            else
            {
               _loc4_ = new UtilHashArray();
               this.getCharThumbs().push(_loc7_,_loc4_);
            }
            _loc4_.insert(0,param1.getCharThumbs().getValueByKey(_loc7_) as UtilHashArray);
            _loc2_++;
         }
      }
      
      public function addBgThumb(param1:String, param2:ByteArray) : void
      {
         this.getBgThumbs().push(param1,param2);
      }
      
      public function isSoundThumbExist(param1:String) : Boolean
      {
         return this.getSoundThumbs().containsKey(param1);
      }
      
      public function isBgThumbExist(param1:String) : Boolean
      {
         return this.getBgThumbs().containsKey(param1);
      }
      
      public function getBgThumbs() : UtilHashArray
      {
         return this._bgThumbs;
      }
      
      public function isCharBehaviourExist(param1:String, param2:String, param3:Boolean) : Boolean
      {
         var _loc4_:UtilHashArray = null;
         if(param3)
         {
            if(!this.getCharThumbs().containsKey(param1))
            {
               return false;
            }
            _loc4_ = this.getCharThumbs().getValueByKey(param1) as UtilHashArray;
         }
         else
         {
            if(!this.getPropThumbs().containsKey(param1))
            {
               return false;
            }
            _loc4_ = this.getPropThumbs().getValueByKey(param1) as UtilHashArray;
         }
         return _loc4_.containsKey(param2);
      }
      
      public function addVideoPropThumbId(param1:String, param2:ByteArray) : void
      {
         this.getVideoPropThumbs().push(param1,param2);
      }
      
      public function getBubbleThumbs() : UtilHashArray
      {
         return this._bubbleThumbs;
      }
   }
}
