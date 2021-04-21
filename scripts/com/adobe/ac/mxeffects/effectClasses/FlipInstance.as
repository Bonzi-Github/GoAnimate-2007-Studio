package com.adobe.ac.mxeffects.effectClasses
{
   import com.adobe.ac.mxeffects.Distortion;
   import com.adobe.ac.mxeffects.DistortionConstants;
   import com.adobe.ac.mxeffects.Flip;
   
   public class FlipInstance extends DistortBaseInstance
   {
       
      
      public var hasCustomExceedBounds:Boolean;
      
      private var distortBack:Distortion;
      
      public var horizontalLightingLocation:String;
      
      private var distortFront:Distortion;
      
      public var verticalLightingLocation:String;
      
      public var exceedBounds:Boolean;
      
      public function FlipInstance(param1:Object)
      {
         super(param1);
      }
      
      private function endFront(param1:Object) : void
      {
         if(buildMode == DistortionConstants.REPLACE)
         {
            container.removeChild(distortFront.container);
         }
         startFlipBack();
      }
      
      override public function play() : void
      {
         if(direction == null)
         {
            direction = Flip.defaultDirection;
         }
         if(buildMode == null)
         {
            buildMode = Flip.defaultBuildMode;
         }
         if(!hasCustomExceedBounds)
         {
            exceedBounds = true;
         }
         super.play();
         startFlipFront();
      }
      
      private function endBack(param1:Object) : void
      {
         var _loc2_:* = false;
         distortFront.destroy(false);
         _loc2_ = siblings.length > currentSibling + 1;
         if(_loc2_)
         {
            --currentSibling;
            delayDeletion(distortBack);
            startFlipFront();
         }
         else
         {
            distortBack.destroy();
            super.onTweenEnd(param1);
         }
      }
      
      private function updateBack(param1:Object) : void
      {
         distortBack.flipBack(Number(param1),direction,distortion,exceedBounds);
      }
      
      private function startFlipBack() : void
      {
         var _loc1_:Function = null;
         initializeNextTarget();
         distortBack = new Distortion(currentTarget);
         applyCoordSpaceChange(distortBack,getContainerChild(siblings[currentSibling - 1]));
         applyDistortionMode(distortBack);
         applyBlur(distortBack.container);
         _loc1_ = updateBack;
         animate(0,100,siblingDuration / 2,_loc1_,endBack);
      }
      
      private function startFlipFront() : void
      {
         var _loc1_:Function = null;
         initializeNextTarget();
         distortFront = new Distortion(currentTarget);
         applyCoordSpaceChange(distortFront,getContainerChild(siblings[currentSibling]));
         applyDistortionMode(distortFront);
         applyBlur(distortFront.container);
         _loc1_ = updateFront;
         animate(0,100,siblingDuration / 2,_loc1_,endFront);
      }
      
      private function updateFront(param1:Object) : void
      {
         distortFront.flipFront(Number(param1),direction,distortion,exceedBounds);
      }
   }
}
