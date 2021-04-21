package anifire.control
{
   import anifire.core.MotionData;
   import anifire.util.UtilDraw;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.core.UIComponent;
   
   public class MotionControl extends UIComponent
   {
       
      
      private var _bitmap:Bitmap;
      
      private const MOTION_PATH_COLOR:Number = 16633879;
      
      private var _motionPath:Sprite;
      
      private var _image:Sprite;
      
      private var _motionData:MotionData;
      
      public function MotionControl(param1:MotionData = null, param2:DisplayObject = null)
      {
         super();
         this.motionData = param1;
         this._image = new Sprite();
         this.addChild(this._image);
         this._image.addEventListener(MouseEvent.MOUSE_DOWN,this.onImageMouseDown);
         this.motionImage = param2;
         this._motionPath = new Sprite();
         this._motionPath.mouseChildren = false;
         this._motionPath.mouseEnabled = false;
         this.addChild(this._motionPath);
         this.buttonMode = true;
         this.updateAll();
      }
      
      private function updateControlBorder() : void
      {
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         if(this._image)
         {
            this._image.stopDrag();
         }
      }
      
      private function updateMotionPath() : void
      {
         if(this._motionData && this._motionPath)
         {
            this._motionPath.graphics.clear();
            this._motionPath.graphics.lineStyle(5,this.MOTION_PATH_COLOR);
            UtilDraw.drawDashLineWithArrow(this._motionPath,this._motionData.startPoint,this._motionData.endPoint,10,5,15);
         }
      }
      
      private function updateAll() : void
      {
         this.updateImage();
         this.updateMotionPath();
      }
      
      public function set motionImage(param1:DisplayObject) : void
      {
         var _loc2_:BitmapData = null;
         if(param1)
         {
            if(this._bitmap)
            {
               this._image.removeChild(this._bitmap);
            }
            _loc2_ = new BitmapData(param1.width,param1.height,true,16777215);
            _loc2_.draw(param1);
            this._bitmap = new Bitmap(_loc2_);
            this._bitmap.alpha = 0.5;
            this._image.addChild(this._bitmap);
            this._motionData.endSize.width = param1.width;
            this._motionData.endSize.height = param1.height;
            this.updateAll();
         }
      }
      
      private function onImageMouseDown(param1:MouseEvent) : void
      {
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         if(this._image)
         {
            this._image.startDrag();
         }
      }
      
      public function set motionData(param1:MotionData) : void
      {
         if(this._motionData)
         {
            this._motionData.removeEventListener(Event.CHANGE,this.onMotionDataChange);
         }
         if(param1)
         {
            param1.addEventListener(Event.CHANGE,this.onMotionDataChange);
         }
         this._motionData = param1;
         this.updateAll();
      }
      
      private function get imageCenter() : Point
      {
         if(this._image)
         {
            return new Point(this._image.x + this._image.width / 2,this._image.y + this._image.height / 2);
         }
         return null;
      }
      
      private function onMotionDataChange(param1:Event) : void
      {
         this.updateAll();
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         if(this._motionData)
         {
            this._motionData.endPoint = this.imageCenter;
         }
      }
      
      private function updateImage() : void
      {
         if(this._motionData && this._image)
         {
            this._image.x = this._motionData.endPoint.x - this._motionData.endSize.width / 2;
            this._image.y = this._motionData.endPoint.y - this._motionData.endSize.height / 2;
            this._image.width = this._motionData.endSize.width;
            this._image.height = this._motionData.endSize.height;
         }
      }
   }
}
