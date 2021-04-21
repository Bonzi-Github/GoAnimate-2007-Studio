package anifire.util
{
   import anifire.event.LazyHelperEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.containers.Accordion;
   import mx.containers.ViewStack;
   import mx.controls.scrollClasses.ScrollBarDirection;
   import mx.core.Container;
   import mx.events.IndexChangedEvent;
   import mx.events.ScrollEvent;
   
   public class UtilLazyHelper extends EventDispatcher
   {
       
      
      private var container:Container;
      
      private var containerParent:Accordion;
      
      private var containerParentParent:ViewStack;
      
      private var tileWidth:Number;
      
      private var tileHeight:Number;
      
      private var _tempData:Object;
      
      public function UtilLazyHelper(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function attachTempDataToMe(param1:Object) : void
      {
         this._tempData = param1;
      }
      
      private function removeListerToParents() : void
      {
         this.containerParent.removeEventListener(IndexChangedEvent.CHANGE,this.onParentsIndexChange);
         this.containerParentParent.removeEventListener(IndexChangedEvent.CHANGE,this.onParentsIndexChange);
      }
      
      private function onParentsIndexChange(param1:Event) : void
      {
         if(this.containerParentParent.selectedChild == this.containerParent && this.containerParent.selectedChild == this.container)
         {
            this.removeListerToParents();
            this.dispatchLazyEvent();
         }
      }
      
      public function start() : void
      {
         if(this.containerParentParent.selectedChild == this.containerParent && this.containerParent.selectedChild == this.container)
         {
            this.dispatchLazyEvent();
         }
         else
         {
            this.addListenerToParents();
         }
         this.container.addEventListener(ScrollEvent.SCROLL,this.onScrolled);
      }
      
      private function dispatchLazyEvent() : void
      {
         var _loc1_:LazyHelperEvent = new LazyHelperEvent(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this);
         this.dispatchEvent(_loc1_);
      }
      
      public function clear() : void
      {
         this.container.removeEventListener(ScrollEvent.SCROLL,this.onScrolled);
         this.removeListerToParents();
         this.attachTempDataToMe(null);
      }
      
      private function onScrolled(param1:ScrollEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:LazyHelperEvent = null;
         this.removeListerToParents();
         if(param1.direction == ScrollBarDirection.VERTICAL)
         {
            _loc2_ = this.container.verticalScrollPosition;
            _loc3_ = this.container.maxVerticalScrollPosition;
         }
         else
         {
            _loc2_ = this.container.horizontalScrollPosition;
            _loc3_ = this.container.maxHorizontalScrollPosition;
         }
         if(_loc2_ >= _loc3_ - this.tileHeight)
         {
            _loc4_ = new LazyHelperEvent(LazyHelperEvent.SCROLLED_TO_THE_END,this);
            this.dispatchEvent(_loc4_);
         }
      }
      
      private function addListenerToParents() : void
      {
         this.containerParent.addEventListener(IndexChangedEvent.CHANGE,this.onParentsIndexChange);
         this.containerParentParent.addEventListener(IndexChangedEvent.CHANGE,this.onParentsIndexChange);
      }
      
      public function registerScrollBarEventDispatcher(param1:Container, param2:Accordion, param3:ViewStack, param4:Number, param5:Number) : void
      {
         this.container = param1;
         this.containerParent = param2;
         this.containerParentParent = param3;
         this.tileHeight = param5;
      }
      
      public function getAttachedTempData() : Object
      {
         return this._tempData;
      }
   }
}
