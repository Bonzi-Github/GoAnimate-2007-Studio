package anifire.events
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   
   public class AssetPurchasedEvent extends ExtraDataEvent
   {
      
      public static const ASSET_PURCHASED:String = "asset_purchased";
       
      
      public var assetId:String;
      
      public function AssetPurchasedEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         var _loc1_:AssetPurchasedEvent = new AssetPurchasedEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
         _loc1_.assetId = this.assetId;
         return _loc1_;
      }
   }
}
