package anifire.component
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.ProgressEvent;
   import mx.collections.ArrayCollection;
   
   public class ProgressMonitor extends EventDispatcher
   {
      
      private static var _instance:ProgressMonitor;
       
      
      private var _progresses:ArrayCollection;
      
      public function ProgressMonitor(param1:IEventDispatcher = null)
      {
         super(param1);
         this._progresses = new ArrayCollection();
      }
      
      public static function getInstance() : ProgressMonitor
      {
         if(!_instance)
         {
            _instance = new ProgressMonitor();
         }
         return _instance;
      }
      
      public function addProgressEventDispatcher(param1:IEventDispatcher) : void
      {
         this._progresses.addItem({
            "dispatcher":param1,
            "progress":null
         });
         param1.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS,true);
         for each(_loc3_ in this._progresses)
         {
            if(_loc3_.dispatcher == param1.target)
            {
               _loc3_.progress = param1;
            }
            if(_loc3_.progress)
            {
               _loc2_.bytesLoaded = _loc2_.bytesLoaded + _loc3_.progress.bytesLoaded;
               _loc2_.bytesTotal = _loc2_.bytesTotal + _loc3_.progress.bytesTotal;
            }
         }
         this.dispatchEvent(_loc2_);
      }
   }
}
