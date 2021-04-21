package anifire.component
{
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class MiniMap extends Canvas
   {
       
      
      private var _viewRect:Rectangle;
      
      private var MINI_MAP_FACTOR:Number = 0.2;
      
      private var _1269235461_miniView:Canvas;
      
      private var _map:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1269510846_miniMask:Canvas;
      
      private var _872235962_miniMap:Canvas;
      
      public function MiniMap()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_miniMap",
                  "events":{"mouseDown":"___miniMap_mouseDown"},
                  "stylesFactory":function():void
                  {
                     this.borderColor = 16777215;
                     this.borderStyle = "solid";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "buttonMode":true,
                        "width":100,
                        "height":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_miniMask",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "mouseEnabled":false,
                                 "percentHeight":100,
                                 "percentWidth":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_miniView",
                           "events":{"mouseDown":"___miniView_mouseDown"},
                           "stylesFactory":function():void
                           {
                              this.borderColor = 16777215;
                              this.borderStyle = "solid";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"buttonMode":true};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._map = new Canvas();
         this._viewRect = new Rectangle();
         super();
         mx_internal::_document = this;
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this._miniMap.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this._miniView.stopDrag();
      }
      
      [Bindable(event="propertyChange")]
      public function get _miniMask() : Canvas
      {
         return this._1269510846_miniMask;
      }
      
      public function ___miniView_mouseDown(param1:MouseEvent) : void
      {
         this.onMiniViewMouseDown(param1);
      }
      
      public function show() : void
      {
         this.drawMap();
      }
      
      public function set _miniView(param1:Canvas) : void
      {
         var _loc2_:Object = this._1269235461_miniView;
         if(_loc2_ !== param1)
         {
            this._1269235461_miniView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_miniView",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _miniMap() : Canvas
      {
         return this._872235962_miniMap;
      }
      
      [Bindable(event="propertyChange")]
      public function get _miniView() : Canvas
      {
         return this._1269235461_miniView;
      }
      
      public function set _miniMask(param1:Canvas) : void
      {
         var _loc2_:Object = this._1269510846_miniMask;
         if(_loc2_ !== param1)
         {
            this._1269510846_miniMask = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_miniMask",_loc2_,param1));
         }
      }
      
      private function onMiniViewMouseDown(param1:MouseEvent) : void
      {
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this._miniMap.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         var _loc2_:Rectangle = new Rectangle(0,0,this._miniMap.width - this._miniView.width,this._miniMap.height - this._miniView.height);
         this._miniView.startDrag(false,_loc2_);
      }
      
      public function ___miniMap_mouseDown(param1:MouseEvent) : void
      {
         this.onMiniMapMouseDown(param1);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set viewRect(param1:Rectangle) : void
      {
         if(param1)
         {
            this._viewRect = param1;
            this.updateMap();
         }
      }
      
      private function updateMap() : void
      {
         this._miniView.width = this._miniMap.width * this._viewRect.width / this._map.width;
         this._miniView.height = this._miniMap.height * this._viewRect.height / this._map.height;
         this._miniView.x = this.viewCenter.x * this.MINI_MAP_FACTOR - this._miniView.width / 2;
         this._miniView.y = this.viewCenter.y * this.MINI_MAP_FACTOR - this._miniView.height / 2;
         var _loc1_:Rectangle = new Rectangle(0,0,this._miniMask.width,this._miniMask.height);
         this._miniMask.graphics.clear();
         this._miniMap.graphics.lineStyle(1,16777215);
         this._miniMask.graphics.beginFill(0,0.5);
         this._miniMask.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         _loc1_ = _loc1_.intersection(new Rectangle(this._miniView.x,this._miniView.y,this._miniView.width,this._miniView.height));
         this._miniMask.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         this._miniMask.graphics.endFill();
      }
      
      public function set _miniMap(param1:Canvas) : void
      {
         var _loc2_:Object = this._872235962_miniMap;
         if(_loc2_ !== param1)
         {
            this._872235962_miniMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_miniMap",_loc2_,param1));
         }
      }
      
      public function set factor(param1:Number) : void
      {
         if(param1)
         {
            this.MINI_MAP_FACTOR = param1;
         }
      }
      
      private function onMiniMapMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(param1.target.name != "_miniView")
         {
            _loc2_ = new Point(param1.localX / this.MINI_MAP_FACTOR,param1.localY / this.MINI_MAP_FACTOR);
            this.dispatchEvent(new MiniMapEvent(MiniMapEvent.VIEW_CHANGE,_loc2_));
            this.onMiniViewMouseDown(param1);
         }
      }
      
      private function get viewCenter() : Point
      {
         return new Point((this._viewRect.x + this._viewRect.width / 2) / this._map.scaleX,(this._viewRect.y + this._viewRect.height / 2) / this._map.scaleX);
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(param1.buttonDown)
         {
            _loc2_ = new Point((this._miniView.x + this._miniView.width / 2) / this.MINI_MAP_FACTOR,(this._miniView.y + this._miniView.height / 2) / this.MINI_MAP_FACTOR);
            this.dispatchEvent(new MiniMapEvent(MiniMapEvent.VIEW_CHANGE,_loc2_));
         }
      }
      
      public function set map(param1:Canvas) : void
      {
         if(param1)
         {
            this._map = param1;
            this._miniMap.width = this.MINI_MAP_FACTOR * param1.width;
            this._miniMap.height = this.MINI_MAP_FACTOR * param1.height;
         }
      }
      
      private function drawMap() : void
      {
         var _loc1_:BitmapData = new BitmapData(this._miniMap.width,this._miniMap.height,false,16777215);
         var _loc2_:Matrix = new Matrix();
         _loc2_.scale(this.MINI_MAP_FACTOR,this.MINI_MAP_FACTOR);
         _loc1_.draw(this._map,_loc2_);
         _loc2_.scale(1,1);
         this._miniMap.graphics.clear();
         this._miniMap.graphics.beginBitmapFill(_loc1_,new Matrix());
         this._miniMap.graphics.drawRect(0,0,this._miniMap.width,this._miniMap.height);
         this.updateMap();
      }
   }
}
