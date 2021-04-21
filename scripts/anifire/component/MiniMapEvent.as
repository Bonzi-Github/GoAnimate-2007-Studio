package anifire.component
{
   import flash.events.Event;
   import flash.geom.Point;
   
   public class MiniMapEvent extends Event
   {
      
      public static const VIEW_CHANGE:String = "viewChanged";
       
      
      private var _viewPoint:Point;
      
      public function MiniMapEvent(param1:String, param2:Point = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._viewPoint = param2;
      }
      
      public function get viewPoint() : Point
      {
         return this._viewPoint;
      }
      
      override public function clone() : Event
      {
         return new MiniMapEvent(type,this._viewPoint);
      }
   }
}
