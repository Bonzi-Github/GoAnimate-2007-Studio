package com.adobe.ac.mxeffects
{
   import com.adobe.ac.mxeffects.effectClasses.FlipInstance;
   import flash.filters.BlurFilter;
   import mx.effects.IEffectInstance;
   import mx.effects.TweenEffect;
   
   public class Flip extends TweenEffect
   {
      
      public static var defaultBuildMode:String = "POPUP";
      
      public static var defaultDirection:String = "RIGHT";
       
      
      public var siblings:Array;
      
      public var distortion:Number;
      
      public var smooth:Boolean;
      
      public var buildMode:String;
      
      public var liveUpdateInterval:int = 0;
      
      public var liveUpdate:Boolean = false;
      
      private var hasCustomExceedBounds:Boolean;
      
      public var blur:BlurFilter;
      
      private var _exceedBounds:Boolean;
      
      public var direction:String;
      
      public function Flip(param1:Object = null)
      {
         liveUpdate = false;
         liveUpdateInterval = 0;
         super(param1);
         instanceClass = FlipInstance;
      }
      
      public function get exceedBounds() : Boolean
      {
         return _exceedBounds;
      }
      
      public function set exceedBounds(param1:Boolean) : void
      {
         hasCustomExceedBounds = true;
         _exceedBounds = param1;
      }
      
      override protected function initInstance(param1:IEffectInstance) : void
      {
         var _loc2_:FlipInstance = null;
         super.initInstance(param1);
         _loc2_ = FlipInstance(param1);
         _loc2_.siblings = siblings;
         _loc2_.direction = direction;
         _loc2_.buildMode = buildMode;
         _loc2_.smooth = smooth;
         _loc2_.distortion = distortion;
         _loc2_.liveUpdate = liveUpdate;
         _loc2_.liveUpdateInterval = liveUpdateInterval;
         _loc2_.blur = blur;
         _loc2_.exceedBounds = exceedBounds;
         _loc2_.hasCustomExceedBounds = hasCustomExceedBounds;
      }
   }
}
