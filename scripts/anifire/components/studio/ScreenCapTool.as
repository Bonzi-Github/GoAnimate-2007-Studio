package anifire.components.studio
{
   import anifire.events.SelectedAreaEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class ScreenCapTool extends Canvas
   {
       
      
      private var _endPt:Point;
      
      private var _startPt:Point;
      
      private var _activeArea:Rectangle;
      
      private var _94436_bg:Canvas;
      
      private var _1173205631_myCursor:Canvas;
      
      private var _1880802801_toolTipText:Label;
      
      private var _436460455_selectedArea:Canvas;
      
      private var _1220422372_toolTipCanvas:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ScreenCapTool()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_bg",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_toolTipCanvas",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 16776960;
                     this.backgroundAlpha = 1;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_toolTipText"
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_selectedArea"
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_myCursor"
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.updateSelectedArea);
         this._endPt = new Point(this._myCursor.x,this._myCursor.y);
         this.dispatchSelectedArea();
      }
      
      public function hide() : void
      {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.followMouse);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._bg.graphics.clear();
         this._myCursor.graphics.clear();
         this._selectedArea.graphics.clear();
         this._toolTipCanvas.visible = false;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         addEventListener(Event.ENTER_FRAME,this.updateSelectedArea);
         this._startPt = new Point(this._myCursor.x,this._myCursor.y);
         this._toolTipCanvas.visible = true;
      }
      
      public function set _myCursor(param1:Canvas) : void
      {
         var _loc2_:Object = this._1173205631_myCursor;
         if(_loc2_ !== param1)
         {
            this._1173205631_myCursor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_myCursor",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get _toolTipText() : Label
      {
         return this._1880802801_toolTipText;
      }
      
      public function set _selectedArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._436460455_selectedArea;
         if(_loc2_ !== param1)
         {
            this._436460455_selectedArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectedArea",_loc2_,param1));
         }
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      private function dispatchSelectedArea() : void
      {
         Mouse.show();
         this.hide();
         var _loc1_:SelectedAreaEvent = new SelectedAreaEvent(SelectedAreaEvent.AREA_SELECTED,this);
         _loc1_.startPt = this._startPt;
         _loc1_.endPt = this._endPt;
         dispatchEvent(_loc1_);
         this._startPt = this._endPt = null;
      }
      
      [Bindable(event="propertyChange")]
      public function get _myCursor() : Canvas
      {
         return this._1173205631_myCursor;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
      }
      
      private function updateSelectedArea(param1:Event) : void
      {
         this._selectedArea.graphics.clear();
         this._selectedArea.graphics.beginFill(16552448,0.2);
         this._selectedArea.graphics.drawRect(this._startPt.x,this._startPt.y,this._myCursor.x - this._startPt.x,this._myCursor.y - this._startPt.y);
         this._selectedArea.graphics.endFill();
         this._toolTipText.text = "[" + Math.abs(this._myCursor.x - this._startPt.x) + "," + Math.abs(this._myCursor.y - this._startPt.y) + "]";
         this._toolTipCanvas.x = this._startPt.x - this._toolTipText.width;
         this._toolTipCanvas.y = this._startPt.y - this._toolTipText.height;
      }
      
      public function set _toolTipCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1220422372_toolTipCanvas;
         if(_loc2_ !== param1)
         {
            this._1220422372_toolTipCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_toolTipCanvas",_loc2_,param1));
         }
      }
      
      public function set _toolTipText(param1:Label) : void
      {
         var _loc2_:Object = this._1880802801_toolTipText;
         if(_loc2_ !== param1)
         {
            this._1880802801_toolTipText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_toolTipText",_loc2_,param1));
         }
      }
      
      private function followMouse(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(this._startPt == null)
         {
            _loc2_ = new Point(this._activeArea.x,this._activeArea.y);
         }
         else
         {
            _loc2_ = new Point(this._startPt.x,this._startPt.y);
         }
         if(param1.stageX >= _loc2_.x && param1.stageX <= this._activeArea.x + this._activeArea.width)
         {
            this._myCursor.x = param1.stageX;
         }
         else if(param1.stageX < _loc2_.x)
         {
            this._myCursor.x = _loc2_.x;
         }
         else if(param1.stageX > this._activeArea.x + this._activeArea.width)
         {
            this._myCursor.x = this._activeArea.x + this._activeArea.width;
         }
         if(param1.stageY >= _loc2_.y && param1.stageY <= this._activeArea.y + this._activeArea.height)
         {
            this._myCursor.y = param1.stageY;
         }
         else if(param1.stageY < _loc2_.y)
         {
            this._myCursor.y = _loc2_.y;
         }
         else if(param1.stageY > this._activeArea.y + this._activeArea.height)
         {
            this._myCursor.y = this._activeArea.y + this._activeArea.height;
         }
      }
      
      public function show(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this._bg.graphics.clear();
         this._bg.graphics.beginFill(16777215,0.5);
         this._bg.graphics.drawRect(0,0,this._bg.width,param2);
         this._bg.graphics.drawRect(0,param2,param1,param4);
         this._bg.graphics.drawRect(param1 + param3,param2,this._bg.width - param1 - param3,param4);
         this._bg.graphics.drawRect(0,param2 + param4,this._bg.width,this._bg.height - param2 - param4);
         this._bg.graphics.beginFill(16777215,0);
         this._bg.graphics.drawRect(param1,param2,param3,param4);
         this._bg.graphics.endFill();
         this._myCursor.graphics.clear();
         this._myCursor.graphics.lineStyle(1,0);
         this._myCursor.graphics.moveTo(-10,0);
         this._myCursor.graphics.lineTo(10,0);
         this._myCursor.graphics.moveTo(0,-10);
         this._myCursor.graphics.lineTo(0,10);
         this._myCursor.graphics.endFill();
         this._myCursor.x = param1 + param3 / 2;
         this._myCursor.y = param2 + param4 / 2;
         addEventListener(MouseEvent.MOUSE_MOVE,this.followMouse);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         Mouse.hide();
         this._activeArea = new Rectangle(param1,param2,param3,param4);
      }
      
      [Bindable(event="propertyChange")]
      public function get _toolTipCanvas() : Canvas
      {
         return this._1220422372_toolTipCanvas;
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectedArea() : Canvas
      {
         return this._436460455_selectedArea;
      }
   }
}
