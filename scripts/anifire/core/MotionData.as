package anifire.core
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class MotionData extends EventDispatcher
   {
       
      
      private var _interPoints:Array;
      
      private var _startRotation:Number = 0;
      
      private var _startSize:SizeData;
      
      private var _startPoint:Point;
      
      private var _endRotation:Number = 0;
      
      private var _endPoint:Point;
      
      private var _endSize:SizeData;
      
      public function MotionData()
      {
         this._interPoints = new Array();
         this._startSize = new SizeData(0,0);
         this._startPoint = new Point(0,0);
         this._endSize = new SizeData(0,0);
         this._endPoint = new Point(0,0);
         super();
      }
      
      public function get startSize() : SizeData
      {
         return this._startSize;
      }
      
      public function set startSize(param1:SizeData) : void
      {
         this._startSize = param1;
      }
      
      public function set endPoint(param1:Point) : void
      {
         this._endPoint = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get endSize() : SizeData
      {
         return this._endSize;
      }
      
      public function get startPoint() : Point
      {
         return this._startPoint;
      }
      
      public function get endPoint() : Point
      {
         return this._endPoint;
      }
      
      public function get displacement() : Point
      {
         return new Point(this.endPoint.x - this.startPoint.x,this.endPoint.y - this.startPoint.y);
      }
      
      public function set endSize(param1:SizeData) : void
      {
         this._endSize = param1;
      }
      
      public function set startPoint(param1:Point) : void
      {
         this._startPoint = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
