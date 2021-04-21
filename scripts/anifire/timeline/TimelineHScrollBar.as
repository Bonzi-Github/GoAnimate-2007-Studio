package anifire.timeline
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   import mx.collections.ArrayCollection;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.controls.HScrollBar;
   import mx.events.ScrollEvent;
   
   public class TimelineHScrollBar extends HScrollBar
   {
       
      
      private var _currItem:ITimelineElement;
      
      private var _mySort:Sort;
      
      private var timelineHeight:Number = 135;
      
      private var momentum:Number = 0;
      
      private const EXTRA_SPACE_AT_END:uint = 100;
      
      private var _maxWidthContainer:ITimelineContainer;
      
      private var _conatainerArr:ArrayCollection;
      
      private var _changeType:String;
      
      private var background_bg:BackgroundGrid;
      
      private var _currContainer:ITimelineContainer;
      
      public function TimelineHScrollBar()
      {
         super();
         this.styleName = "hScrollBar";
         this.visible = false;
         this._conatainerArr = new ArrayCollection();
         var _loc1_:SortField = new SortField();
         _loc1_.name = "Width";
         _loc1_.numeric = true;
         this._mySort = new Sort();
         this._mySort.fields = [_loc1_];
         this._conatainerArr.sort = this._mySort;
         this._conatainerArr.refresh();
         this.addEventListener(ScrollEvent.SCROLL,this.setContainerView);
      }
      
      public function addContainerToScrollBar(param1:ITimelineContainer) : void
      {
         this._currContainer = param1;
         this._currItem = this._currContainer.getCurrItem();
         this._conatainerArr.addItem({
            "Container":param1,
            "Width":this.getChildTotalWidth(param1)
         });
         this._conatainerArr.sort = this._mySort;
         this._conatainerArr.refresh();
         if(this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Container is SceneContainer)
         {
            this.maxWidthContainer = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Container;
         }
         if(this._currContainer is SoundContainer)
         {
            this.callLater(this.setContainerView,[null]);
         }
         param1.addEventListener("TIMELINE_CHANGE",this.updateScrollBar);
      }
      
      private function setContainerView(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Number = this.getChildTotalWidth(this._maxWidthContainer);
         var _loc3_:Number = this.width;
         var _loc4_:Number = this.scrollPosition == 0?Number(0):Number((_loc2_ - _loc3_) * this.scrollPosition / this.maxScrollPosition);
         if(this.visible && _loc2_ > _loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < this._conatainerArr.length)
            {
               if(this._conatainerArr.getItemAt(_loc5_).Container is SoundContainer)
               {
                  (this._conatainerArr.getItemAt(_loc5_).Container as SoundContainer).setHorizontalView(_loc4_);
               }
               else if(this._conatainerArr.getItemAt(_loc5_).Container is SceneContainer)
               {
                  (this._conatainerArr.getItemAt(_loc5_).Container as SceneContainer).setHorizontalView(_loc4_);
                  this.background_bg.setHorizontalView(_loc4_);
               }
               _loc5_++;
            }
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function resetAllContainerView() : void
      {
         var _loc1_:int = 0;
         if(this._conatainerArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._conatainerArr.length)
            {
               if(this._conatainerArr.getItemAt(_loc1_).Container is SoundContainer)
               {
                  (this._conatainerArr.getItemAt(_loc1_).Container as SoundContainer).setHorizontalView(0);
               }
               else
               {
                  (this._conatainerArr.getItemAt(_loc1_).Container as SceneContainer).setHorizontalView(0);
                  this.background_bg.setHorizontalView(0);
               }
               _loc1_++;
            }
         }
      }
      
      public function initBgGrid(param1:BackgroundGrid) : void
      {
         this.background_bg = param1;
      }
      
      private function getChildTotalWidth(param1:ITimelineContainer) : Number
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:SceneContainer = null;
         var _loc5_:int = 0;
         var _loc2_:Number = 0;
         if(param1 is SoundContainer)
         {
            _loc3_ = param1 as SoundContainer;
            _loc2_ = _loc3_.x + _loc3_.width;
         }
         else if(param1 is SceneContainer)
         {
            _loc4_ = param1 as SceneContainer;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.itemList_hb.numChildren)
            {
               _loc2_ = _loc2_ + _loc4_.itemList_hb.getChildAt(_loc5_).width;
               _loc5_++;
            }
            _loc2_ = _loc2_ + this.EXTRA_SPACE_AT_END;
         }
         return _loc2_;
      }
      
      public function removeSoundBar(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:int = this._conatainerArr.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._conatainerArr.getItemAt(_loc4_).Container is SoundContainer)
            {
               if(param2 || (this._conatainerArr.getItemAt(_loc4_).Container as SoundContainer).name == param1)
               {
                  this._conatainerArr.removeItemAt(_loc4_);
                  _loc3_--;
               }
            }
            _loc4_++;
         }
         this._conatainerArr.sort = this._mySort;
         this._conatainerArr.refresh();
         this.maxWidthContainer = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Container;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if((this.mouseY <= this.width * 0.1 && this.mouseY >= 0 || this.mouseY >= this.width * 0.9 && this.mouseY <= this.width) && this.mouseX >= 0 - this.timelineHeight && this.mouseX <= 0)
         {
            this.momentum = (this.mouseY - this.width / 2) / 15 * -1;
         }
         else
         {
            this.momentum = this.momentum / 2;
         }
         this.scrollPosition = this.scrollPosition - this.momentum;
         if(this.scrollPosition < 0)
         {
            this.scrollPosition = 0;
         }
         else if(this.scrollPosition > this.maxScrollPosition)
         {
            this.scrollPosition = this.maxScrollPosition;
         }
         this.setContainerView(null);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:ITimelineContainer = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         super.visible = param1;
         if(param1 == true)
         {
            if(this._currContainer is SceneContainer && this._changeType != "Resize")
            {
               this.setScrollProperties(this.width / 2,0,this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width);
               this.lineScrollSize = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width / 100;
               this.dispatchEvent(new Event("SCROLL_VISIBLE"));
               _loc2_ = 0;
               _loc3_ = 0;
               while(this._currContainer.getItemAt(_loc3_) != null && this._currContainer.getItemAt(_loc3_) != this._currItem)
               {
                  _loc2_ = _loc2_ + this._currContainer.getItemAt(_loc3_).width;
                  _loc3_++;
               }
               if((_loc4_ = (this._currContainer as SceneContainer).getCurrIndex()) != -1)
               {
                  if(!(this._currContainer as SceneContainer).isSceneVisible(_loc4_))
                  {
                     if((_loc5_ = this.maxScrollPosition * (_loc2_ + this._currItem.width + this.EXTRA_SPACE_AT_END - this.width) / (this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width - this.width)) < 0)
                     {
                        _loc5_ = 0;
                     }
                     this.scrollPosition = _loc5_;
                  }
               }
               this.callLater(this.setContainerView,[null]);
            }
            else if(this._currContainer is SceneContainer && this._changeType == "Resize")
            {
               this.setScrollProperties(this.width / 2,0,this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width);
               this.lineScrollSize = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width / 100;
               this.dispatchEvent(new Event("SCROLL_VISIBLE"));
               _loc7_ = (_loc6_ = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Container as ITimelineContainer).getHorizontalView();
               if(!isNaN(_loc7_))
               {
                  _loc8_ = 0 - _loc7_;
                  this.scrollPosition = this.maxScrollPosition * _loc8_ / (this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width - this.width);
               }
            }
            else if(this._currContainer is SoundContainer)
            {
               if((this._currContainer as SoundContainer).soundReady)
               {
                  this.setScrollProperties(this.width / 2,0,this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width);
                  this.lineScrollSize = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width / 100;
                  this.dispatchEvent(new Event("SCROLL_VISIBLE"));
               }
            }
         }
         else
         {
            this.dispatchEvent(new Event("SCROLL_INVISIBLE"));
            this.resetAllContainerView();
         }
      }
      
      private function updateScrollBar(param1:ExtraDataEvent) : void
      {
         this._currContainer = param1.getEventCreater() as ITimelineContainer;
         this._changeType = param1.getData() as String;
         this._currItem = this._currContainer.getCurrItem();
         var _loc2_:int = 0;
         while(_loc2_ < this._conatainerArr.length)
         {
            if(this._conatainerArr.getItemAt(_loc2_).Container.name == (param1.currentTarget as ITimelineContainer).name)
            {
               this._conatainerArr.setItemAt({
                  "Container":param1.currentTarget,
                  "Width":this.getChildTotalWidth(param1.currentTarget as ITimelineContainer)
               },_loc2_);
            }
            _loc2_++;
         }
         this._conatainerArr.sort = this._mySort;
         this._conatainerArr.refresh();
         if(this._conatainerArr.length > 0)
         {
            this.maxWidthContainer = this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Container;
         }
         this.setContainerView(null);
      }
      
      private function set maxWidthContainer(param1:ITimelineContainer) : void
      {
         this._maxWidthContainer = param1;
         if(this._conatainerArr.getItemAt(this._conatainerArr.length - 1).Width > this.width)
         {
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
      }
   }
}
