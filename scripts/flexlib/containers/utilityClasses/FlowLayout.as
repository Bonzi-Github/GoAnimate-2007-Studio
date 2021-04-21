package flexlib.containers.utilityClasses
{
   import mx.containers.BoxDirection;
   import mx.containers.utilityClasses.BoxLayout;
   import mx.core.EdgeMetrics;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class FlowLayout extends BoxLayout
   {
       
      
      public function FlowLayout()
      {
         super();
         direction = BoxDirection.HORIZONTAL;
      }
      
      private function doLayout(param1:Number, param2:Boolean) : void
      {
         var _loc13_:IFlexDisplayObject = null;
         var _loc14_:IFlexDisplayObject = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc22_:int = 0;
         var _loc3_:EdgeMetrics = target.viewMetricsAndPadding;
         var _loc4_:Number = getHorizontalAlignValue();
         var _loc5_:Number = getVerticalAlignValue();
         var _loc6_:Number = target.getStyle("horizontalGap");
         var _loc7_:Number = target.getStyle("verticalGap");
         var _loc8_:Number = target.numChildren;
         var _loc9_:Array = new Array();
         var _loc10_:Number = 0;
         var _loc11_:Number = _loc3_.top;
         var _loc12_:Number = _loc3_.left;
         var _loc19_:Number = target.getStyle("paddingRight") + target.borderMetrics.right;
         var _loc20_:Number = target.getStyle("paddingLeft") + target.borderMetrics.left;
         var _loc21_:int = 0;
         while(_loc21_ < _loc8_)
         {
            if(!((_loc13_ = IFlexDisplayObject(target.getChildAt(_loc21_))) is UIComponent && !UIComponent(_loc13_).includeInLayout))
            {
               if(_loc12_ + _loc13_.width > param1 - _loc19_)
               {
                  _loc12_ = _loc12_ - _loc6_;
                  _loc12_ = (_loc15_ = Number((_loc15_ = Number(param1 - _loc19_ - _loc12_)) * _loc4_)) == 0?Number(_loc20_):Number(_loc15_);
                  _loc22_ = 0;
                  while(_loc22_ < _loc9_.length)
                  {
                     _loc14_ = _loc9_[_loc22_];
                     _loc16_ = (_loc10_ - _loc14_.height) * _loc5_;
                     if(param2)
                     {
                        _loc14_.move(Math.floor(_loc12_),_loc11_ + Math.floor(_loc16_));
                     }
                     _loc12_ = _loc12_ + (_loc14_.width + _loc6_);
                     _loc22_++;
                  }
                  _loc11_ = _loc11_ + (_loc10_ + _loc7_);
                  _loc12_ = _loc20_;
                  _loc10_ = 0;
                  _loc9_ = [];
               }
               _loc12_ = _loc12_ + (_loc13_.width + _loc6_);
               _loc9_.push(_loc13_);
               _loc10_ = Math.max(_loc13_.height,_loc10_);
            }
            _loc21_++;
         }
         _loc12_ = _loc12_ - _loc6_;
         _loc12_ = (_loc15_ = Number((_loc15_ = Number(param1 - _loc19_ - _loc12_)) * _loc4_)) == 0?Number(_loc20_):Number(_loc15_);
         _loc22_ = 0;
         while(_loc22_ < _loc9_.length)
         {
            _loc14_ = _loc9_[_loc22_];
            _loc16_ = (_loc10_ - _loc14_.height) * _loc5_;
            if(param2)
            {
               _loc14_.move(Math.floor(_loc12_),_loc11_ + Math.floor(_loc16_));
            }
            _loc12_ = _loc12_ + (_loc6_ + _loc14_.width);
            _loc22_++;
         }
         if(!param2)
         {
            target.measuredHeight = _loc11_ + _loc10_ + _loc3_.bottom + _loc3_.top;
         }
      }
      
      override public function measure() : void
      {
         direction = BoxDirection.VERTICAL;
         super.measure();
         direction = BoxDirection.HORIZONTAL;
         if(!isNaN(target.explicitWidth))
         {
            doLayout(target.explicitWidth,false);
         }
         else if(!isNaN(target.percentWidth) && target.parent is UIComponent && !isNaN(UIComponent(target.parent).explicitWidth))
         {
            doLayout(UIComponent(target.parent).explicitWidth * target.percentWidth / 100,false);
         }
      }
      
      override public function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         doLayout(param1,true);
      }
   }
}
