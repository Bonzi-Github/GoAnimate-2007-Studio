package anifire.component
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.VSlider;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.NumberFormatter;
   
   public class VolumeButton extends Canvas
   {
       
      
      private var _2947092_vol:VSlider;
      
      private var _1931449851percentFormatter:NumberFormatter;
      
      private var _281986877_sliderControl:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function VolumeButton()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":42,
                  "height":40,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___VolumeButton_Button1_click"},
                     "stylesFactory":function():void
                     {
                        this.left = "5";
                        this.bottom = "3";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnVolumeSlide",
                           "buttonMode":true,
                           "useHandCursor":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sliderControl",
                     "stylesFactory":function():void
                     {
                        this.bottom = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"imgVolumeSlideBg",
                           "width":42,
                           "height":125,
                           "visible":false,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VSlider,
                              "id":"_vol",
                              "stylesFactory":function():void
                              {
                                 this.top = "5";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":8,
                                    "height":80,
                                    "liveDragging":true,
                                    "sliderThumbClass":ZoomSliderThumb,
                                    "buttonMode":true,
                                    "dataTipFormatFunction":zoomSliderDataTip,
                                    "styleName":"zoomSlider"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "stylesFactory":function():void
                              {
                                 this.bottom = "0";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"imgBtnVolume",
                                    "width":42,
                                    "height":42
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 42;
         this.height = 40;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.clipContent = false;
         this._VolumeButton_NumberFormatter1_i();
         this.addEventListener("creationComplete",this.___VolumeButton_Canvas1_creationComplete);
      }
      
      private function hideSlider() : void
      {
         this._sliderControl.visible = false;
         this._sliderControl.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         this.dispatchVolume();
      }
      
      [Bindable(event="propertyChange")]
      public function get percentFormatter() : NumberFormatter
      {
         return this._1931449851percentFormatter;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set percentFormatter(param1:NumberFormatter) : void
      {
         var _loc2_:Object = this._1931449851percentFormatter;
         if(_loc2_ !== param1)
         {
            this._1931449851percentFormatter = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"percentFormatter",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vol() : VSlider
      {
         return this._2947092_vol;
      }
      
      private function zoomSliderDataTip(param1:Number) : String
      {
         return this.percentFormatter.format(100 * param1) + " %";
      }
      
      private function init() : void
      {
      }
      
      private function onClickVolume() : void
      {
         this.showSlider();
      }
      
      public function set _vol(param1:VSlider) : void
      {
         var _loc2_:Object = this._2947092_vol;
         if(_loc2_ !== param1)
         {
            this._2947092_vol = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vol",_loc2_,param1));
         }
      }
      
      private function _VolumeButton_NumberFormatter1_i() : NumberFormatter
      {
         var _loc1_:NumberFormatter = new NumberFormatter();
         this.percentFormatter = _loc1_;
         _loc1_.precision = 0;
         _loc1_.rounding = "nearest";
         return _loc1_;
      }
      
      public function ___VolumeButton_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function dispatchVolume() : void
      {
         var _loc1_:Number = this._vol.value;
         var _loc2_:ExtraDataEvent = new ExtraDataEvent(ExtraDataEvent.UPDATE,this,_loc1_);
         this.dispatchEvent(_loc2_);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.hideSlider();
      }
      
      public function set _sliderControl(param1:Canvas) : void
      {
         var _loc2_:Object = this._281986877_sliderControl;
         if(_loc2_ !== param1)
         {
            this._281986877_sliderControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderControl",_loc2_,param1));
         }
      }
      
      public function ___VolumeButton_Button1_click(param1:MouseEvent) : void
      {
         this.onClickVolume();
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderControl() : Canvas
      {
         return this._281986877_sliderControl;
      }
      
      private function showSlider() : void
      {
         this._sliderControl.visible = true;
         this._sliderControl.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
   }
}
