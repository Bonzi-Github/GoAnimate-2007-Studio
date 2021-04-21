package com.adobe.ac.mxeffects.effectClasses
{
   import com.adobe.ac.mxeffects.Distortion;
   import com.adobe.ac.mxeffects.DistortionConstants;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.filters.BlurFilter;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mx.core.Container;
   import mx.core.ContainerCreationPolicy;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.effects.Tween;
   import mx.effects.effectClasses.TweenEffectInstance;
   import mx.events.TweenEvent;
   
   use namespace mx_internal;
   
   public class DistortBaseInstance extends TweenEffectInstance
   {
       
      
      protected var currentSibling:int;
      
      public var offsetRect:Rectangle;
      
      public var buildMode:String;
      
      private var _containerChild:DisplayObject;
      
      public var blur:BlurFilter;
      
      protected var currentTarget:UIComponent;
      
      private var _siblings:Array;
      
      protected var siblingDuration:Number;
      
      public var direction:String;
      
      protected var container:DisplayObjectContainer;
      
      public var distortion:Number;
      
      public var smooth:Boolean;
      
      public var liveUpdateInterval:int = 0;
      
      private var originalContainerCreationPolicy:String;
      
      public var liveUpdate:Boolean = false;
      
      private var concatenatedMatrices:Dictionary;
      
      private var distortDeletionPending:Distortion;
      
      public var quality:String;
      
      public function DistortBaseInstance(param1:Object)
      {
         liveUpdate = false;
         liveUpdateInterval = 0;
         super(param1);
      }
      
      protected function getContainerChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         if(param1.parent == null)
         {
            _loc2_ = containerChild;
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      protected function initializeNextTarget() : void
      {
         ++currentSibling;
         currentTarget = siblings[currentSibling];
         initializeBounds(currentTarget);
      }
      
      protected function initializePreviousTarget() : void
      {
         --currentSibling;
         currentTarget = siblings[currentSibling];
         initializeBounds(currentTarget);
      }
      
      protected function get containerChild() : DisplayObject
      {
         if(_containerChild == null)
         {
            _containerChild = findContainerChild();
         }
         else if(_containerChild.parent == null)
         {
            _containerChild = findContainerChild();
         }
         return _containerChild;
      }
      
      protected function set containerChild(param1:DisplayObject) : void
      {
         _containerChild = param1;
      }
      
      override public function play() : void
      {
         super.play();
         initializeProperties();
      }
      
      private function reset() : void
      {
         siblings.shift();
         siblingDuration = 0;
         currentSibling = 0;
         currentTarget = null;
         container = null;
         originalContainerCreationPolicy = null;
      }
      
      private function initializeChildrenForCapture() : void
      {
         var _loc1_:Container = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         concatenatedMatrices = new Dictionary();
         _loc1_ = Container(container);
         _loc2_ = siblings.length;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = siblings[_loc3_]).parent == null)
            {
               _loc1_.addChild(_loc4_);
               _loc1_.validateNow();
               concatenatedMatrices[_loc4_] = _loc4_.transform.concatenatedMatrix;
               _loc1_.removeChild(_loc4_);
            }
            else
            {
               concatenatedMatrices[_loc4_] = _loc4_.transform.concatenatedMatrix;
            }
            _loc3_++;
         }
      }
      
      private function findContainerChild() : DisplayObject
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         _loc2_ = siblings.length;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = siblings[_loc3_]).parent != null)
            {
               _loc1_ = _loc4_;
               break;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      protected function initializeBounds(param1:UIComponent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Container = null;
         _loc2_ = DisplayObject(target);
         if(container is Container)
         {
            _loc3_ = Container(container);
            originalContainerCreationPolicy = _loc3_.creationPolicy;
            _loc3_.creationPolicy = ContainerCreationPolicy.ALL;
            _loc3_.validateNow();
         }
         param1.setActualSize(_loc2_.width,_loc2_.height);
         param1.validateNow();
      }
      
      override public function onTweenEnd(param1:Object) : void
      {
         var _loc2_:Container = null;
         if(originalContainerCreationPolicy != null)
         {
            _loc2_ = Container(container);
            _loc2_.creationPolicy = originalContainerCreationPolicy;
         }
         reset();
         super.onTweenEnd(param1);
      }
      
      protected function delayDeletion(param1:Distortion) : void
      {
         distortDeletionPending = param1;
         addEventListener(TweenEvent.TWEEN_START,performDistortDeletion);
      }
      
      private function onEnd(param1:Object) : void
      {
      }
      
      protected function applyCoordSpaceChange(param1:Distortion, param2:DisplayObject) : void
      {
         var _loc3_:* = false;
         var _loc4_:Boolean = false;
         _loc3_ = buildMode == DistortionConstants.POPUP;
         if(_loc4_ = _loc3_ && currentTarget.parent == null)
         {
            param1.positionedTarget = DisplayObject(param2);
         }
      }
      
      private function findContainer() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         if(this.container == null)
         {
            if(target.parent != null)
            {
               _loc1_ = target.parent;
            }
            else
            {
               _loc2_ = siblings.length;
               while(_loc3_ < _loc2_)
               {
                  if((_loc4_ = siblings[_loc3_]).parent != null)
                  {
                     _loc1_ = DisplayObjectContainer(_loc4_.parent);
                     containerChild = _loc4_;
                     break;
                  }
                  _loc3_++;
               }
            }
            this.container = _loc1_;
         }
      }
      
      private function performDistortDeletion(param1:TweenEvent) : void
      {
         if(distortDeletionPending != null)
         {
            distortDeletionPending.destroy();
            distortDeletionPending = null;
            removeEventListener(TweenEvent.TWEEN_START,performDistortDeletion);
         }
      }
      
      protected function animate(param1:Object, param2:Object, param3:Number, param4:Function, param5:Function) : void
      {
         var _loc6_:Object = null;
         var _loc7_:Tween = null;
         _loc6_ = new Object();
         _loc7_ = createTween(_loc6_,param1,param2,param3);
         if(param5 == null)
         {
            param5 = onEnd;
         }
         _loc7_.setTweenHandlers(param4,param5);
      }
      
      protected function initializeProperties() : void
      {
         if(isNaN(distortion))
         {
            distortion = 20;
         }
         siblingDuration = duration / siblings.length;
         currentSibling = -1;
         siblings.unshift(target);
         findContainer();
         initializeChildrenForCapture();
      }
      
      protected function applyDistortionMode(param1:Distortion) : void
      {
         if(buildMode != null)
         {
            param1.buildMode = buildMode;
         }
         param1.smooth = smooth;
         param1.liveUpdate = liveUpdate;
         findContainer();
         param1.targetContainer = container;
         param1.concatenatedMatrix = concatenatedMatrices[param1.target];
      }
      
      public function get siblings() : Array
      {
         return _siblings;
      }
      
      protected function applyBlur(param1:DisplayObject) : void
      {
         var _loc2_:Array = null;
         if(blur != null)
         {
            _loc2_ = param1.filters;
            _loc2_.push(blur);
            param1.filters = _loc2_;
         }
      }
      
      public function set siblings(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.indexOf(null);
         if(_loc2_ > -1)
         {
            throw new Error("siblings: [" + param1 + "] contains a null value at position " + _loc2_);
         }
         _siblings = param1;
      }
   }
}
