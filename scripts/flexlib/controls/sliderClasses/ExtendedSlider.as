package flexlib.controls.sliderClasses
{
   import flash.display.Graphics;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flexlib.baseClasses.SliderBase;
   import mx.controls.sliderClasses.SliderDataTip;
   import mx.controls.sliderClasses.SliderDirection;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.events.SliderEvent;
   import mx.events.SliderEventClickTarget;
   import mx.formatters.NumberFormatter;
   
   use namespace mx_internal;
   
   public class ExtendedSlider extends SliderBase
   {
       
      
      private var dataTips:Array;
      
      private var draggingRegion:Boolean = false;
      
      public var lockRegionsWhileDragging:Boolean = false;
      
      protected var highlightHitArea:UIComponent;
      
      private var counter:Number = 0;
      
      public function ExtendedSlider()
      {
         super();
      }
      
      override mx_internal function onThumbMove(param1:Object) : void
      {
         var _loc2_:Number = getValueFromX(param1.xPosition);
         var _loc3_:SliderDataTip = dataTips[param1.thumbIndex];
         if(showDataTip)
         {
            _loc3_.text = _dataTipFormatFunction != null?_dataTipFormatFunction(_loc2_):dataFormatter.format(_loc2_);
            _loc3_.setActualSize(_loc3_.getExplicitOrMeasuredWidth(),_loc3_.getExplicitOrMeasuredHeight());
            positionDataTip(param1);
         }
         if(liveDragging)
         {
            interactionClickTarget = SliderEventClickTarget.THUMB;
            setValueAt(_loc2_,param1.thumbIndex);
         }
         var _loc4_:SliderEvent;
         (_loc4_ = new SliderEvent(SliderEvent.THUMB_DRAG)).value = _loc2_;
         _loc4_.thumbIndex = param1.thumbIndex;
         dispatchEvent(_loc4_);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!highlightHitArea)
         {
            highlightHitArea = new UIComponent();
            mx_internal::innerSlider.addChild(highlightHitArea);
            highlightHitArea.addEventListener(MouseEvent.MOUSE_DOWN,highlight_mouseDownHandler);
         }
         dataTips = new Array();
         this.sliderThumbClass = SliderThumb;
         var _loc1_:* = getStyle("thumbSkin");
         if(_loc1_ != null)
         {
            setStyle("thumbUpSkin",_loc1_);
            setStyle("thumbDownSkin",_loc1_);
            setStyle("thumbOverSkin",_loc1_);
            setStyle("thumbDisabledSkin",_loc1_);
         }
      }
      
      override mx_internal function drawTrackHighlight() : void
      {
         var _loc8_:SliderThumb = null;
         var _loc9_:Graphics = null;
         var _loc1_:SliderThumb = SliderThumb(this.getThumbAt(0));
         var _loc2_:SliderThumb = _loc1_;
         var _loc3_:int = 0;
         while(_loc3_ < this.thumbCount)
         {
            if((_loc8_ = SliderThumb(this.getThumbAt(_loc3_))).xPosition < _loc1_.xPosition)
            {
               _loc1_ = _loc8_;
            }
            if(_loc8_.xPosition > _loc2_.xPosition)
            {
               _loc2_ = _loc8_;
            }
            _loc3_++;
         }
         var _loc4_:Number = _loc1_.xPosition;
         var _loc5_:Number = _loc2_.xPosition - _loc1_.xPosition;
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = _loc1_.getExplicitOrMeasuredHeight()) - 2;
         if(highlightTrack)
         {
            highlightTrack.move(_loc4_,track.y - highlightTrack.height / 2 + 2);
            highlightTrack.setActualSize(_loc5_ > 0?Number(_loc5_):Number(0),highlightTrack.height);
         }
         if(highlightHitArea)
         {
            (_loc9_ = highlightHitArea.graphics).clear();
            _loc9_.beginFill(16711680,0);
            _loc9_.drawRect(_loc4_,track.y + track.height / 2 - _loc7_ / 2,_loc5_ > 0?Number(_loc5_):Number(0),_loc7_);
            _loc9_.endFill();
         }
      }
      
      public function get dragHitArea() : UIComponent
      {
         return highlightHitArea;
      }
      
      override protected function positionDataTip(param1:Object) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:SliderDataTip = dataTips[param1.thumbIndex];
         var _loc5_:Number = param1.x;
         var _loc6_:Number = param1.y;
         var _loc7_:String = getStyle("dataTipPlacement");
         var _loc8_:Number = getStyle("dataTipOffset");
         if(_direction == SliderDirection.HORIZONTAL)
         {
            _loc3_ = _loc5_;
            _loc4_ = _loc6_;
            if(_loc7_ == "left")
            {
               _loc3_ = _loc3_ - (_loc8_ + _loc2_.width);
               _loc4_ = _loc4_ + (param1.height - _loc2_.height) / 2;
            }
            else if(_loc7_ == "right")
            {
               _loc3_ = _loc3_ + (_loc8_ + param1.width);
               _loc4_ = _loc4_ + (param1.height - _loc2_.height) / 2;
            }
            else if(_loc7_ == "top")
            {
               _loc4_ = _loc4_ - (_loc8_ + _loc2_.height);
               _loc3_ = _loc3_ - (_loc2_.width - param1.width) / 2;
            }
            else if(_loc7_ == "bottom")
            {
               _loc4_ = _loc4_ + (_loc8_ + param1.height);
               _loc3_ = _loc3_ - (_loc2_.width - param1.width) / 2;
            }
         }
         else
         {
            _loc3_ = _loc6_;
            _loc4_ = unscaledHeight - _loc5_ - (_loc2_.height + param1.width) / 2;
            if(_loc7_ == "left")
            {
               _loc3_ = _loc3_ - (_loc8_ + _loc2_.width);
            }
            else if(_loc7_ == "right")
            {
               _loc3_ = _loc3_ + (_loc8_ + param1.height);
            }
            else if(_loc7_ == "top")
            {
               _loc4_ = _loc4_ - (_loc8_ + (_loc2_.height + param1.width) / 2);
               _loc3_ = _loc3_ - (_loc2_.width - param1.height) / 2;
            }
            else if(_loc7_ == "bottom")
            {
               _loc4_ = _loc4_ + (_loc8_ + (_loc2_.height + param1.width) / 2);
               _loc3_ = _loc3_ - (_loc2_.width - param1.height) / 2;
            }
         }
         var _loc9_:Point = new Point(_loc3_,_loc4_);
         var _loc10_:Point = localToGlobal(_loc9_);
         _loc2_.x = _loc10_.x < 0?Number(0):Number(_loc10_.x);
         _loc2_.y = _loc10_.y < 0?Number(0):Number(_loc10_.y);
      }
      
      override mx_internal function onThumbRelease(param1:Object) : void
      {
         var _loc5_:SliderEvent = null;
         var _loc2_:SliderDataTip = dataTips[param1.thumbIndex];
         if(_loc2_)
         {
            systemManager.toolTipChildren.removeChild(_loc2_);
            _loc2_ = null;
            dataTips[param1.thumbIndex] = null;
         }
         --counter;
         interactionClickTarget = SliderEventClickTarget.THUMB;
         var _loc3_:SliderThumb = SliderThumb(thumbs.getChildAt(param1.thumbIndex));
         var _loc4_:* = counter == 0;
         setValueAt(getValueFromX(_loc3_.xPosition),param1.thumbIndex,!_loc4_);
         if(_loc4_)
         {
            (_loc5_ = new SliderEvent(SliderEvent.THUMB_RELEASE)).value = getValueFromX(param1.xPosition);
            _loc5_.thumbIndex = param1.thumbIndex;
            dispatchEvent(_loc5_);
         }
      }
      
      private function regionDraggingStopped(param1:MouseEvent) : void
      {
         draggingRegion = false;
      }
      
      private function highlight_mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc5_:SliderThumb = null;
         var _loc2_:Number = param1.stageX;
         var _loc3_:Number = param1.stageY;
         draggingRegion = true;
         systemManager.addEventListener(MouseEvent.MOUSE_UP,regionDraggingStopped,false,0,true);
         var _loc4_:int = 0;
         while(_loc4_ < thumbCount)
         {
            _loc5_ = SliderThumb(thumbs.getChildAt(_loc4_));
            param1.localX = _loc5_.globalToLocal(new Point(_loc2_,_loc3_)).x;
            param1.localY = _loc5_.globalToLocal(new Point(_loc2_,_loc3_)).y;
            _loc5_.focusEnabled = false;
            _loc5_.dispatchEvent(param1);
            _loc4_++;
         }
      }
      
      override mx_internal function getXBounds(param1:int) : Object
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(!draggingRegion || !lockRegionsWhileDragging)
         {
            return super.getXBounds(param1);
         }
         for each(_loc4_ in values)
         {
            if(isNaN(_loc2_) || _loc4_ < _loc2_)
            {
               _loc2_ = _loc4_;
            }
            if(isNaN(_loc3_) || _loc4_ > _loc3_)
            {
               _loc3_ = _loc4_;
            }
         }
         _loc5_ = values[param1] - _loc2_ + minimum;
         _loc6_ = maximum - (_loc3_ - values[param1]);
         _loc7_ = getXFromValue(_loc5_);
         _loc8_ = getXFromValue(_loc6_);
         return {
            "min":_loc7_,
            "max":_loc8_
         };
      }
      
      override mx_internal function onThumbPress(param1:Object) : void
      {
         var _loc3_:SliderDataTip = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         ++counter;
         if(showDataTip)
         {
            dataFormatter = new NumberFormatter();
            dataFormatter.precision = getStyle("dataTipPrecision");
            _loc3_ = dataTips[param1.thumbIndex];
            if(!_loc3_)
            {
               _loc3_ = SliderDataTip(new sliderDataTipClass());
               dataTips[param1.thumbIndex] = _loc3_;
               systemManager.toolTipChildren.addChild(_loc3_);
               if(_loc5_ = getStyle("dataTipStyleName"))
               {
                  _loc3_.styleName = _loc5_;
               }
            }
            if(_dataTipFormatFunction != null)
            {
               _loc4_ = this._dataTipFormatFunction(getValueFromX(param1.xPosition));
            }
            else
            {
               _loc4_ = dataFormatter.format(getValueFromX(param1.xPosition));
            }
            _loc3_.text = _loc4_;
            _loc3_.validateNow();
            _loc3_.setActualSize(_loc3_.getExplicitOrMeasuredWidth(),_loc3_.getExplicitOrMeasuredHeight());
            positionDataTip(param1);
         }
         keyInteraction = false;
         var _loc2_:SliderEvent = new SliderEvent(SliderEvent.THUMB_PRESS);
         _loc2_.value = getValueFromX(param1.xPosition);
         _loc2_.thumbIndex = param1.thumbIndex;
         dispatchEvent(_loc2_);
      }
   }
}
