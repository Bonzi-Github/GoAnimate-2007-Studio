package anifire.core
{
   public class AssetLinkage
   {
      
      public static const LINK:String = "~~~";
      
      public static const XML_TAG:String = "linkage";
       
      
      private var _relationship:Array;
      
      public function AssetLinkage()
      {
         super();
         this._relationship = new Array();
      }
      
      public static function getCharIdFromLinkage(param1:String) : String
      {
         return param1.split(LINK)[1];
      }
      
      public static function getSceneIdFromLinkage(param1:String) : String
      {
         return param1.split(LINK)[0];
      }
      
      public function serialize() : String
      {
         var _loc1_:String = "";
         if(this._relationship.length >= 2)
         {
            _loc1_ = _loc1_ + ("<linkage>" + this._relationship.join(",") + "</linkage>");
         }
         return _loc1_;
      }
      
      public function removeLinkage(param1:String) : void
      {
         this._relationship.splice(this._relationship.indexOf(param1),1);
      }
      
      public function getSceneAndCharId() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._relationship.length)
         {
            if(String(this._relationship[_loc2_]).indexOf(LINK) > -1)
            {
               _loc1_ = this._relationship[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addLinkage(param1:String) : void
      {
         this._relationship.push(param1);
      }
      
      public function getCharId() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._relationship.length)
         {
            if(String(this._relationship[_loc2_]).indexOf(LINK) > -1)
            {
               _loc1_ = this._relationship[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_.split(LINK)[1];
      }
      
      public function getSceneId() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._relationship.length)
         {
            if(String(this._relationship[_loc2_]).indexOf(LINK) > -1)
            {
               _loc1_ = this._relationship[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_.split(LINK)[0];
      }
      
      public function getSoundId() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._relationship.length)
         {
            if(String(this._relationship[_loc2_]).indexOf(LINK) == -1)
            {
               _loc1_ = this._relationship[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function deserialize(param1:String) : void
      {
         if(param1 != null)
         {
            this._relationship = param1.split(",");
         }
      }
      
      public function getLinkage() : Array
      {
         return this._relationship;
      }
   }
}
