package com.adobe.ac.mxeffects
{
   import com.adobe.ac.util.DisplayObjectBounds;
   import com.adobe.ac.util.SimpleDisplayObjectBoundsUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import sandy.util.DistortImage;
   
   public class SimpleDistortion
   {
       
      
      public var container:DisplayObject;
      
      private var distort:DistortImage;
      
      public var target:DisplayObject;
      
      private var justAddChild:Boolean;
      
      public var offsetRect:Rectangle;
      
      public var buildMode:String;
      
      public var smooth:Boolean;
      
      public var liveUpdateInterval:int = 0;
      
      public var bottomLeftX:Number;
      
      public var bottomRightX:Number;
      
      public var bottomRightY:Number;
      
      public var bottomLeftY:Number;
      
      public var liveUpdate:Boolean = false;
      
      public var topLeftX:Number;
      
      public var topLeftY:Number;
      
      public var isDistorted:Boolean = false;
      
      private var liveUpdateIntervalCounter:int;
      
      public var targetContainer:DisplayObjectContainer;
      
      public var topRightX:Number;
      
      public var topRightY:Number;
      
      public var concatenatedMatrix:Matrix;
      
      public function SimpleDistortion(param1:DisplayObject, param2:Rectangle = null)
      {
         liveUpdate = false;
         liveUpdateInterval = 0;
         isDistorted = false;
         super();
         buildMode = DistortionConstants.REPLACE;
         smooth = false;
         this.target = param1;
         this.offsetRect = param2;
         container = new Shape();
      }
      
      private function renderCornersWithBounds(param1:DisplayObjectBounds, param2:Point, param3:Point, param4:Point, param5:Point) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         _loc6_ = param1.bottomLeft.y - param1.topLeft.y;
         _loc7_ = param1.topRight.x - param1.topLeft.x;
         _loc8_ = param1.bottomRight.y - param1.topRight.y;
         _loc9_ = param1.bottomRight.x - param1.bottomLeft.x;
         _loc10_ = getValue(param2.x,_loc7_);
         _loc11_ = getValue(param2.y,_loc6_);
         _loc12_ = getValue(param3.x,_loc7_);
         _loc13_ = getValue(param3.y,_loc8_);
         _loc14_ = getValue(param4.x,_loc9_);
         _loc15_ = getValue(param4.y,_loc8_);
         _loc16_ = getValue(param5.x,_loc9_);
         _loc17_ = getValue(param5.y,_loc6_);
         setTransform(_loc7_ - _loc10_,_loc6_ - _loc11_,_loc12_,_loc8_ - _loc13_,_loc14_,_loc15_,_loc9_ - _loc16_,_loc17_);
      }
      
      public function renderSides(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:DisplayObjectBounds = null;
         initDistortImage();
         _loc5_ = getSimpleBounds();
         renderSidesWithBounds(_loc5_,param1,param2,param3,param4);
      }
      
      public function destroy(param1:Boolean = true) : void
      {
         if(!isDistorted)
         {
            return;
         }
         restore(param1);
         if(distort != null)
         {
            if(distort.texture != null)
            {
               distort.texture.dispose();
            }
         }
         distort = null;
         isDistorted = false;
      }
      
      private function renderSidesInPixelsWithBounds(param1:DisplayObjectBounds, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         _loc6_ = param1.bottomLeft.y - param1.topLeft.y;
         _loc7_ = param1.topRight.x - param1.topLeft.x;
         _loc8_ = param1.bottomRight.y - param1.topRight.y;
         _loc9_ = param1.bottomRight.x - param1.bottomLeft.x;
         _loc10_ = getDelta(param2,_loc6_);
         _loc11_ = getDelta(param3,_loc7_);
         _loc12_ = getDelta(param4,_loc8_);
         _loc13_ = getDelta(param5,_loc9_);
         setTransform(param1.topLeft.x + _loc11_,param1.topLeft.y + _loc10_,param1.topRight.x - _loc11_,param1.topRight.y + _loc12_,param1.bottomRight.x - _loc13_,param1.bottomRight.y - _loc12_,param1.bottomLeft.x + _loc13_,param1.bottomLeft.y - _loc10_);
      }
      
      public function openDoor(param1:Number, param2:String, param3:Number = NaN) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         param3 = getDistortion(param3);
         _loc8_ = 100 - param1;
         _loc9_ = getDistortedPercentage(param1,param3);
         if(param2 == DistortionConstants.LEFT)
         {
            _loc4_ = new Point(100,100);
            _loc5_ = new Point(_loc8_,_loc9_);
            _loc6_ = new Point(_loc8_,_loc9_);
            _loc7_ = new Point(100,100);
         }
         else if(param2 == DistortionConstants.TOP)
         {
            _loc4_ = new Point(100,100);
            _loc5_ = new Point(100,100);
            _loc6_ = new Point(_loc9_,_loc8_);
            _loc7_ = new Point(_loc9_,_loc8_);
         }
         else if(param2 == DistortionConstants.RIGHT)
         {
            _loc4_ = new Point(_loc8_,_loc9_);
            _loc5_ = new Point(100,100);
            _loc6_ = new Point(100,100);
            _loc7_ = new Point(_loc8_,_loc9_);
         }
         else
         {
            if(param2 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param2);
            }
            _loc4_ = new Point(_loc9_,_loc8_);
            _loc5_ = new Point(_loc9_,_loc8_);
            _loc6_ = new Point(100,100);
            _loc7_ = new Point(100,100);
         }
         renderCorners(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      public function push(param1:Number, param2:String, param3:Number = NaN) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         param3 = getDistortion(param3);
         _loc8_ = getInversedDistortedPercentage(param1,param3);
         if(param2 == DistortionConstants.LEFT)
         {
            _loc4_ = new Point(param1,100);
            _loc5_ = new Point(100,_loc8_);
            _loc6_ = new Point(100,_loc8_);
            _loc7_ = new Point(param1,100);
         }
         else if(param2 == DistortionConstants.TOP)
         {
            _loc4_ = new Point(100,param1);
            _loc5_ = new Point(100,param1);
            _loc6_ = new Point(_loc8_,100);
            _loc7_ = new Point(_loc8_,100);
         }
         else if(param2 == DistortionConstants.RIGHT)
         {
            _loc4_ = new Point(100,_loc8_);
            _loc5_ = new Point(param1,100);
            _loc6_ = new Point(param1,100);
            _loc7_ = new Point(100,_loc8_);
         }
         else
         {
            if(param2 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param2);
            }
            _loc4_ = new Point(_loc8_,100);
            _loc5_ = new Point(_loc8_,100);
            _loc6_ = new Point(100,param1);
            _loc7_ = new Point(100,param1);
         }
         renderCorners(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function getDistortedPercentage(param1:Number, param2:Number) : Number
      {
         return 100 - param1 / 100 * param2;
      }
      
      private function catchAddedEvent(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      protected function initialize() : void
      {
         if(buildMode == DistortionConstants.REPLACE)
         {
            findParent();
            target.addEventListener(Event.ADDED,catchAddedEvent);
            target.addEventListener(Event.REMOVED,catchRemovedEvent);
            if(targetContainer.contains(target))
            {
               justAddChild = false;
               replaceTarget(DisplayObject(target),DisplayObject(container));
            }
            else
            {
               justAddChild = true;
               addContainer(DisplayObject(container));
            }
            target.removeEventListener(Event.ADDED,catchAddedEvent);
            target.removeEventListener(Event.REMOVED,catchRemovedEvent);
         }
         else if(buildMode == DistortionConstants.ADD)
         {
            findParent();
            target.addEventListener(Event.ADDED,catchAddedEvent);
            target.addEventListener(Event.REMOVED,catchRemovedEvent);
            addContainer(DisplayObject(container));
            target.removeEventListener(Event.ADDED,catchAddedEvent);
            target.removeEventListener(Event.REMOVED,catchRemovedEvent);
         }
         else if(buildMode == DistortionConstants.OVERWRITE)
         {
            container = target;
         }
      }
      
      public function renderCornersInPixels(param1:Point, param2:Point, param3:Point, param4:Point) : void
      {
         initDistortImage();
         setTransform(param1.x,param1.y,param2.x,param2.y,param3.x,param3.y,param4.x,param4.y);
      }
      
      private function getDelta(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Number((param2 - param1) / 2);
      }
      
      private function getInversedDistortedPercentage(param1:Number, param2:Number) : Number
      {
         return 100 - (param2 - param1 / 100 * param2);
      }
      
      protected function getBounds() : void
      {
         offsetRect = new SimpleDisplayObjectBoundsUtil().getBoundsForOffsetRect(target,offsetRect);
      }
      
      protected function restore(param1:Boolean) : void
      {
         if(buildMode == DistortionConstants.REPLACE)
         {
            if(justAddChild)
            {
               removeContainer(DisplayObject(container));
            }
            else if(param1)
            {
               replaceTarget(container,DisplayObject(target));
            }
         }
         else if(buildMode == DistortionConstants.ADD)
         {
            removeContainer(DisplayObject(container));
         }
      }
      
      private function setTransform(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         this.topLeftX = param1;
         this.topLeftY = param2;
         this.topRightX = param3;
         this.topRightY = param4;
         this.bottomRightX = param5;
         this.bottomRightY = param6;
         this.bottomLeftX = param7;
         this.bottomLeftY = param8;
         distort.setTransform(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      private function getValue(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Number(param1 / 100 * param2);
      }
      
      public function flipFront(param1:Number, param2:String, param3:Number = NaN, param4:Boolean = false) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         param3 = getDistortion(param3);
         _loc9_ = 100 - param1;
         _loc10_ = getDistortedPercentage(param1,param3);
         _loc11_ = 100 - _loc10_;
         if(param2 == DistortionConstants.LEFT)
         {
            _loc5_ = _loc10_;
            _loc6_ = _loc9_;
            _loc7_ = !!param4?Number(100 + _loc11_):Number(100);
            _loc8_ = _loc9_;
         }
         else if(param2 == DistortionConstants.TOP)
         {
            _loc5_ = _loc9_;
            _loc6_ = _loc10_;
            _loc7_ = _loc9_;
            _loc8_ = !!param4?Number(100 + _loc11_):Number(100);
         }
         else if(param2 == DistortionConstants.RIGHT)
         {
            _loc5_ = !!param4?Number(100 + _loc11_):Number(100);
            _loc6_ = _loc9_;
            _loc7_ = _loc10_;
            _loc8_ = _loc9_;
         }
         else
         {
            if(param2 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param2);
            }
            _loc5_ = _loc9_;
            _loc6_ = !!param4?Number(100 + _loc11_):Number(100);
            _loc7_ = _loc9_;
            _loc8_ = _loc10_;
         }
         renderSides(_loc5_,_loc6_,_loc7_,_loc8_);
      }
      
      public function reverseDirection(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1 == DistortionConstants.LEFT)
         {
            _loc2_ = DistortionConstants.RIGHT;
         }
         else if(param1 == DistortionConstants.TOP)
         {
            _loc2_ = DistortionConstants.BOTTOM;
         }
         else if(param1 == DistortionConstants.RIGHT)
         {
            _loc2_ = DistortionConstants.LEFT;
         }
         else
         {
            if(param1 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param1);
            }
            _loc2_ = DistortionConstants.TOP;
         }
         return _loc2_;
      }
      
      protected function findParent() : void
      {
         if(targetContainer == null)
         {
            if(target.parent == null)
            {
               throw new Error("target " + target + " needs to have a valid parent property in buildMode " + buildMode);
            }
            targetContainer = target.parent;
         }
      }
      
      protected function isMatrixInitialized(param1:DisplayObject) : Boolean
      {
         return param1.parent != null;
      }
      
      public function popUp(param1:Number, param2:String, param3:Number = NaN) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         param3 = getDistortion(param3);
         param3 = param3 * 4;
         _loc8_ = 100 - param1;
         _loc9_ = getDistortedPercentage(param1,param3);
         container.alpha = _loc8_ / 100;
         _loc10_ = getDoubledDistortedPercentage(param1,param3);
         _loc11_ = 100 + (100 - _loc10_);
         _loc12_ = getHalfedDistortedPercentage(param1,param3);
         _loc13_ = 100 + (100 - _loc12_);
         _loc14_ = getExpandedYDistortion(param1);
         if(param2 == DistortionConstants.LEFT)
         {
            _loc4_ = new Point(_loc13_,_loc13_);
            _loc5_ = new Point(_loc14_,_loc11_);
            _loc6_ = new Point(_loc14_,_loc11_);
            _loc7_ = new Point(_loc13_,_loc13_);
         }
         else if(param2 == DistortionConstants.TOP)
         {
            _loc4_ = new Point(_loc13_,_loc13_);
            _loc5_ = new Point(_loc13_,_loc13_);
            _loc6_ = new Point(_loc11_,_loc14_);
            _loc7_ = new Point(_loc11_,_loc14_);
         }
         else if(param2 == DistortionConstants.RIGHT)
         {
            _loc4_ = new Point(_loc14_,_loc11_);
            _loc5_ = new Point(_loc13_,_loc13_);
            _loc6_ = new Point(_loc13_,_loc13_);
            _loc7_ = new Point(_loc14_,_loc11_);
         }
         else
         {
            if(param2 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param2);
            }
            _loc4_ = new Point(_loc11_,_loc14_);
            _loc5_ = new Point(_loc11_,_loc14_);
            _loc6_ = new Point(_loc13_,_loc13_);
            _loc7_ = new Point(_loc13_,_loc13_);
         }
         renderCorners(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      public function closeDoor(param1:Number, param2:String, param3:Number = NaN) : void
      {
         openDoor(100 - param1,param2,param3);
      }
      
      public function renderCorners(param1:Point, param2:Point, param3:Point, param4:Point) : void
      {
         var _loc5_:DisplayObjectBounds = null;
         initDistortImage();
         _loc5_ = getSimpleBounds();
         renderCornersWithBounds(_loc5_,param1,param2,param3,param4);
      }
      
      private function renderSidesWithBounds(param1:DisplayObjectBounds, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         _loc6_ = param1.bottomLeft.y - param1.topLeft.y;
         _loc7_ = param1.topRight.x - param1.topLeft.x;
         _loc8_ = param1.bottomRight.y - param1.topRight.y;
         _loc9_ = param1.bottomRight.x - param1.bottomLeft.x;
         _loc10_ = getDelta(getValue(param2,_loc6_),_loc6_);
         _loc11_ = getDelta(getValue(param3,_loc7_),_loc7_);
         _loc12_ = getDelta(getValue(param4,_loc8_),_loc8_);
         _loc13_ = getDelta(getValue(param5,_loc9_),_loc9_);
         setTransform(param1.topLeft.x + _loc11_,param1.topLeft.y + _loc10_,param1.topRight.x - _loc11_,param1.topRight.y + _loc12_,param1.bottomRight.x - _loc13_,param1.bottomRight.y - _loc12_,param1.bottomLeft.x + _loc13_,param1.bottomLeft.y - _loc10_);
      }
      
      public function pop(param1:Number, param2:String, param3:Number = NaN) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         param3 = getDistortion(param3);
         _loc8_ = 100 - param1;
         _loc9_ = getDistortedPercentage(param1,param3);
         if(param2 == DistortionConstants.LEFT)
         {
            _loc4_ = new Point(100,_loc9_);
            _loc5_ = new Point(_loc8_,100);
            _loc6_ = new Point(_loc8_,100);
            _loc7_ = new Point(100,_loc9_);
         }
         else if(param2 == DistortionConstants.TOP)
         {
            _loc4_ = new Point(_loc9_,100);
            _loc5_ = new Point(_loc9_,100);
            _loc6_ = new Point(100,_loc8_);
            _loc7_ = new Point(100,_loc8_);
         }
         else if(param2 == DistortionConstants.RIGHT)
         {
            _loc4_ = new Point(_loc8_,100);
            _loc5_ = new Point(100,_loc9_);
            _loc6_ = new Point(100,_loc9_);
            _loc7_ = new Point(_loc8_,100);
         }
         else
         {
            if(param2 != DistortionConstants.BOTTOM)
            {
               throw new Error("Invalid direction " + param2);
            }
            _loc4_ = new Point(100,_loc8_);
            _loc5_ = new Point(100,_loc8_);
            _loc6_ = new Point(_loc9_,100);
            _loc7_ = new Point(_loc9_,100);
         }
         renderCorners(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function getExpandedYDistortion(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc2_ = param1 / 100 * 225;
         _loc3_ = _loc2_ * Math.PI / 180;
         return Number((_loc4_ = Math.sin(_loc3_ * 0.75) * 100) + 100);
      }
      
      public function renderSidesInPixels(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:DisplayObjectBounds = null;
         initDistortImage();
         _loc5_ = getSimpleBounds();
         renderSidesInPixelsWithBounds(_loc5_,param1,param2,param3,param4);
      }
      
      private function getDistortion(param1:Number) : Number
      {
         if(isNaN(param1))
         {
            param1 = 20;
         }
         return param1;
      }
      
      private function replaceTarget(param1:DisplayObject, param2:DisplayObject) : void
      {
         removeContainer(param1);
         targetContainer.addChild(param2);
      }
      
      private function removeContainer(param1:DisplayObject) : void
      {
         if(targetContainer.contains(param1))
         {
            targetContainer.removeChild(param1);
         }
      }
      
      protected function initDistortImage() : void
      {
         if(distort == null)
         {
            isDistorted = true;
            liveUpdateIntervalCounter = 0;
            initialize();
            getBounds();
            if(buildMode != DistortionConstants.OVERWRITE)
            {
               container.width = offsetRect.width;
               container.height = offsetRect.height;
            }
            container.x = container.x + offsetRect.x;
            container.y = container.y + offsetRect.y;
            distort = new DistortImage();
            distort.smooth = smooth;
            distort.container = container;
            distort.target = target;
            distort.initialize(2,2,offsetRect);
            distort.render();
         }
         else
         {
            ++liveUpdateIntervalCounter;
            if(liveUpdate && liveUpdateIntervalCounter >= liveUpdateInterval)
            {
               liveUpdateIntervalCounter = 0;
               distort.initialize(2,2,offsetRect);
               distort.render();
            }
         }
      }
      
      private function getDoubledDistortedPercentage(param1:Number, param2:Number) : Number
      {
         return 100 - param1 / 100 * (param2 * 1.5);
      }
      
      public function flipBack(param1:Number, param2:String, param3:Number = NaN, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         _loc5_ = reverseDirection(param2);
         flipFront(100 - param1,_loc5_,param3,param4);
      }
      
      private function catchRemovedEvent(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function addContainer(param1:DisplayObject) : void
      {
         targetContainer.addChild(param1);
      }
      
      private function getHalfedDistortedPercentage(param1:Number, param2:Number) : Number
      {
         return 100 - param1 / 100 * (param2 / 2);
      }
      
      protected function getSimpleBounds() : DisplayObjectBounds
      {
         var _loc1_:DisplayObjectBounds = null;
         _loc1_ = new DisplayObjectBounds();
         if(concatenatedMatrix == null)
         {
            if(isMatrixInitialized(target))
            {
               concatenatedMatrix = target.transform.concatenatedMatrix;
            }
         }
         _loc1_.getActualBounds(target,offsetRect,concatenatedMatrix);
         return _loc1_;
      }
   }
}
