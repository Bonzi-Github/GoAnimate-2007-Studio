package com.adobe.ac.mxeffects
{
   import com.adobe.ac.util.DisplayObjectBoundsUtil;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.core.Container;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponent;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.FlexEvent;
   import mx.managers.PopUpManager;
   
   public class Distortion extends SimpleDistortion
   {
       
      
      public var positionedTarget:DisplayObject;
      
      private var waitForMatrixInitiziation:Boolean;
      
      public function Distortion(param1:DisplayObject, param2:Rectangle = null)
      {
         super(param1,param2);
         buildMode = DistortionConstants.POPUP;
      }
      
      public function displayPopUpAbove(param1:IFlexDisplayObject, param2:DisplayObject) : void
      {
         var _loc3_:Point = null;
         PopUpManager.addPopUp(param1,param2,false);
         _loc3_ = new Point(0,0);
         _loc3_ = param2.localToGlobal(_loc3_);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
      }
      
      override protected function restore(param1:Boolean) : void
      {
         var _loc2_:UIComponent = null;
         if(buildMode == DistortionConstants.POPUP)
         {
            _loc2_ = UIComponent(target);
            if(param1)
            {
               _loc2_.addEventListener(FlexEvent.SHOW,catchShowEvent);
               _loc2_.visible = true;
               _loc2_.removeEventListener(FlexEvent.SHOW,catchShowEvent);
            }
            PopUpManager.removePopUp(IFlexDisplayObject(container));
         }
         else if(buildMode == DistortionConstants.REPLACE)
         {
            _loc2_ = UIComponent(target);
            _loc2_.addEventListener(FlexEvent.ADD,catchAddEvent);
            _loc2_.addEventListener(FlexEvent.REMOVE,catchRemoveEvent);
            super.restore(param1);
            _loc2_.removeEventListener(FlexEvent.ADD,catchAddEvent);
            _loc2_.removeEventListener(FlexEvent.REMOVE,catchRemoveEvent);
         }
         else if(buildMode == DistortionConstants.ADD)
         {
            _loc2_ = UIComponent(target);
            _loc2_.addEventListener(FlexEvent.ADD,catchAddEvent);
            super.restore(param1);
            _loc2_.removeEventListener(FlexEvent.ADD,catchAddEvent);
         }
         else
         {
            super.restore(param1);
         }
      }
      
      override protected function initialize() : void
      {
         var _loc1_:UIComponent = null;
         if(buildMode == DistortionConstants.POPUP)
         {
            createUIComponentContainer();
            _loc1_ = UIComponent(target);
            _loc1_.addEventListener(FlexEvent.HIDE,catchHideEvent);
            _loc1_.visible = false;
            _loc1_.removeEventListener(FlexEvent.HIDE,catchHideEvent);
            if(positionedTarget == null)
            {
               displayPopUpAbove(IFlexDisplayObject(container),target);
            }
            else
            {
               displayPopUpAbove(IFlexDisplayObject(container),positionedTarget);
            }
         }
         else if(buildMode == DistortionConstants.REPLACE)
         {
            createContainer();
            _loc1_ = UIComponent(target);
            _loc1_.addEventListener(FlexEvent.ADD,catchAddEvent);
            _loc1_.addEventListener(FlexEvent.REMOVE,catchRemoveEvent);
            if(targetContainer == null)
            {
               findParent();
            }
            targetContainer.addEventListener(ChildExistenceChangedEvent.CHILD_ADD,catchAddEvent);
            targetContainer.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE,catchRemoveEvent);
            super.initialize();
            _loc1_.removeEventListener(FlexEvent.ADD,catchAddEvent);
            _loc1_.removeEventListener(FlexEvent.REMOVE,catchRemoveEvent);
            targetContainer.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD,catchAddEvent);
            targetContainer.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE,catchRemoveEvent);
         }
         else if(buildMode == DistortionConstants.ADD)
         {
            createContainer();
            _loc1_ = UIComponent(target);
            _loc1_.addEventListener(FlexEvent.ADD,catchAddEvent);
            if(targetContainer == null)
            {
               findParent();
            }
            targetContainer.addEventListener(ChildExistenceChangedEvent.CHILD_ADD,catchAddEvent);
            super.initialize();
            _loc1_.removeEventListener(FlexEvent.ADD,catchAddEvent);
            targetContainer.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD,catchAddEvent);
         }
         else
         {
            createUIComponentContainer();
            super.initialize();
         }
      }
      
      private function catchShowEvent(param1:FlexEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      override protected function getBounds() : void
      {
         offsetRect = new DisplayObjectBoundsUtil().getFlexBoundsForOffsetRect(target,offsetRect);
      }
      
      private function createUIComponentContainer() : void
      {
         var _loc1_:Array = null;
         _loc1_ = container.filters;
         container = new UIComponent();
         container.filters = _loc1_;
      }
      
      private function catchHideEvent(param1:FlexEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function catchRemoveEvent(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      override protected function isMatrixInitialized(param1:DisplayObject) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc2_ = false;
         waitForMatrixInitiziation = false;
         if(param1 is UIComponent && super.isMatrixInitialized(param1))
         {
            _loc3_ = param1.transform.concatenatedMatrix.a == 5 && param1.transform.concatenatedMatrix.d == 5;
            if(UIComponent(param1).initialized && !_loc3_)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function catchAddEvent(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function createContainer() : void
      {
         var _loc1_:Array = null;
         _loc1_ = container.filters;
         container = new Container();
         container.filters = _loc1_;
      }
   }
}
