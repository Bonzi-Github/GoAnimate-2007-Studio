package anifire.core
{
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.interfaces.ICustomCharacterMaker;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import flash.utils.setTimeout;
   
   public class GoBaseWorkerImp extends GoBaseWorker
   {
       
      
      private var _myDisplayObject:DisplayObjectContainer;
      
      public function GoBaseWorkerImp()
      {
         super();
      }
      
      private function refreshSkin(param1:Event = null) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.refreshSkin);
         }
         this.initSkin();
      }
      
      private function needToUseCacheBitmap(param1:String) : Boolean
      {
         if(param1 == "body")
         {
            return true;
         }
         return false;
      }
      
      public function initSkin(param1:DisplayObjectContainer = null) : void
      {
         var _loc5_:Loader = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:DisplayObjectContainer = null;
         if(this._myDisplayObject == null)
         {
            this._myDisplayObject = param1;
         }
         if(param1 == null && this._myDisplayObject != null)
         {
            param1 = this._myDisplayObject;
         }
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:String = getQualifiedSuperclassName(param1);
         var _loc4_:Number = _loc3_.lastIndexOf(":");
         _loc3_ = _loc3_.substr(_loc4_ + 1);
         if(param1.loaderInfo != null)
         {
            if((_loc5_ = Loader(param1.loaderInfo.loader)) != null)
            {
               if((_loc6_ = _loc5_.parent) != null && _loc6_ is ICustomCharacterMaker)
               {
                  if(param1.numChildren > 0)
                  {
                     param1.removeChildAt(0);
                  }
                  if(this.needToUseCacheBitmap(_loc2_))
                  {
                     param1.cacheAsBitmap = true;
                  }
                  if((_loc7_ = ICustomCharacterMaker(_loc6_).CCM.getSkin(_loc2_,_loc3_)) != null)
                  {
                     param1.addChild(_loc7_ as DisplayObject);
                  }
                  ICustomCharacterMaker(_loc6_).eventDispatcher.removeEventListener(LoadEmbedMovieEvent.RELOAD_MOVIE_EVENT,this.refreshSkin);
                  ICustomCharacterMaker(_loc6_).eventDispatcher.addEventListener(LoadEmbedMovieEvent.RELOAD_MOVIE_EVENT,this.refreshSkin);
               }
               else
               {
                  setTimeout(this.refreshSkin,200);
               }
            }
         }
      }
   }
}
