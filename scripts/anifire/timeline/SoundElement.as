package anifire.timeline
{
   import anifire.event.ExtraDataEvent;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class SoundElement extends Canvas implements ITimelineElement
   {
       
      
      private var _inner_volume:Number = 1;
      
      private const DBAR_OFFSETY:Number = 0.5;
      
      private var _timelineControl:Timeline = null;
      
      private var _fillColor:uint;
      
      private var _2934560_ind:Canvas;
      
      private const DBAR_RADIUS:Number = 10;
      
      private var _94436_bg:Image;
      
      private var _soundContainer:SoundContainer = null;
      
      private var _360573147soundLabel:Label;
      
      private var _focus:Boolean = false;
      
      private var _1602107397_length:Number = 100;
      
      private const MIN_WIDTH:Number = 30;
      
      private var _1465432895_stime:Number = 0;
      
      private const MAX_WIDTH:Number = 90000;
      
      private var _fillColors:Array;
      
      private var _hasMarker:Boolean = false;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SoundElement()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "height":18,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Image,
                     "id":"_bg",
                     "propertiesFactory":function():Object
                     {
                        return {"width":21};
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_ind"
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"soundLabel",
                     "stylesFactory":function():void
                     {
                        this.color = 0;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "truncateToFit":true,
                           "buttonMode":true,
                           "useHandCursor":true,
                           "mouseChildren":false,
                           "y":2,
                           "x":6
                        };
                     }
                  })]
               };
            }
         });
         this._fillColors = [6974058,6974058];
         this._fillColor = this._fillColors[0];
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundAlpha = 0.6;
         };
         this.height = 18;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___SoundElement_Canvas1_creationComplete);
      }
      
      [Bindable(event="propertyChange")]
      private function get _length() : Number
      {
         return this._1602107397_length;
      }
      
      private function set _stime(param1:Number) : void
      {
         var _loc2_:Object = this._1465432895_stime;
         if(_loc2_ !== param1)
         {
            this._1465432895_stime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stime",_loc2_,param1));
         }
      }
      
      private function set _length(param1:Number) : void
      {
         var _loc2_:Object = this._1602107397_length;
         if(_loc2_ !== param1)
         {
            this._1602107397_length = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_length",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set time(param1:Number) : void
      {
         this._stime = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ind() : Canvas
      {
         return this._2934560_ind;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get soundLabel() : Label
      {
         return this._360573147soundLabel;
      }
      
      public function updateLabel(param1:String) : void
      {
         this.soundLabel.text = param1;
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
      }
      
      public function set _ind(param1:Canvas) : void
      {
         var _loc2_:Object = this._2934560_ind;
         if(_loc2_ !== param1)
         {
            this._2934560_ind = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ind",_loc2_,param1));
         }
      }
      
      public function set _bg(param1:Image) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      public function clearIndicator() : void
      {
         this._ind.graphics.clear();
         this._hasMarker = false;
      }
      
      public function set soundLabel(param1:Label) : void
      {
         var _loc2_:Object = this._360573147soundLabel;
         if(_loc2_ !== param1)
         {
            this._360573147soundLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundLabel",_loc2_,param1));
         }
      }
      
      public function set length(param1:Number) : void
      {
         this._length = param1;
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function get time() : Number
      {
         return this._stime;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function get length() : Number
      {
         return this._length;
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
      }
      
      public function ___SoundElement_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      [Bindable(event="propertyChange")]
      private function get _stime() : Number
      {
         return this._1465432895_stime;
      }
      
      private function initApp() : void
      {
         this.redraw();
      }
      
      public function updateIndicator(param1:Number = 0, param2:Number = 0) : void
      {
         this._ind.graphics.clear();
         this._ind.graphics.lineStyle(1,6710886,1);
         this._ind.graphics.beginFill(65280,0.5);
         this._ind.graphics.drawRoundRect(param1,this.DBAR_OFFSETY,param2,height - this.DBAR_OFFSETY * 2,this.DBAR_RADIUS,this.DBAR_RADIUS);
         this._ind.graphics.endFill();
         this._hasMarker = true;
      }
      
      public function hasMarker() : Boolean
      {
         return this._hasMarker;
      }
      
      public function redraw() : void
      {
         this._bg.graphics.clear();
         if(this._length > 0)
         {
            this._bg.graphics.lineStyle(1,6710886,1);
            this._bg.graphics.beginFill(this._fillColor,1);
            this._bg.graphics.drawRoundRect(0,this.DBAR_OFFSETY,this._length,height - this.DBAR_OFFSETY * 2,this.DBAR_RADIUS,this.DBAR_RADIUS);
            this._bg.graphics.endFill();
            if(this._length < 2880)
            {
               this._ind.scrollRect = new Rectangle(0,0,this._length,18);
            }
            else
            {
               this._ind.scrollRect = null;
            }
         }
         this.soundLabel.width = this._length > 1000?Number(1000):this._length < 0?Number(0):Number(this._length - 10);
         this.soundLabel.x = 5;
         this.soundLabel.visible = this.soundLabel.width > 5?true:false;
         this.invalidateProperties();
         this.invalidateDisplayList();
      }
      
      public function setSoundContainerReferer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Image
      {
         return this._94436_bg;
      }
   }
}
