package anifire.events
{
   import anifire.core.Asset;
   import flash.events.Event;
   
   public class AssetEvent extends Event
   {
      
      public static const MOUSE_UP_ASSET:String = "mouseUpAsset";
      
      public static const ROLL_OVER_ASSET:String = "rollOverAsset";
      
      public static const COLOR_CHANGE:String = "colorChange";
      
      public static const MOUSE_DOWN_ASSET:String = "mouseDownAsset";
      
      public static const ACTION_CHANGE:String = "actionChange";
      
      public static const ROLL_OUT_ASSET:String = "rollOutAsset";
      
      public static const STATE_CHANGE:String = "stateChange";
       
      
      private var _asset:Asset;
      
      private var _shiftKey:Boolean;
      
      public function AssetEvent(param1:String, param2:Asset = null, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._asset = param2;
         this._shiftKey = param3;
      }
      
      public function get asset() : Asset
      {
         return this._asset;
      }
      
      override public function clone() : Event
      {
         return new AssetEvent(type,this._asset);
      }
      
      public function get shiftKey() : Boolean
      {
         return this._shiftKey;
      }
   }
}
