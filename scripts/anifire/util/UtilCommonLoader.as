package anifire.util
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import mx.core.UIComponent;
   
   public dynamic class UtilCommonLoader extends Loader
   {
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
      
      public static const STATE_NULL:String = "null";
      
      private static const CALL_LATER_HELPER:UIComponent = new UIComponent();
      
      public static const STATE_LOADING:String = "loading";
       
      
      private var _completeEvent:Event;
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private var _state:String;
      
      private var _customData:String;
      
      public function UtilCommonLoader()
      {
         super();
         this._shouldPauseOnLoadByteComplete = false;
         this.state = STATE_NULL;
      }
      
      override public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void
      {
         if(this.state == STATE_NULL)
         {
            this.state = STATE_LOADING;
            this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadByteComplete,false,int.MAX_VALUE);
            this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadByteError,false);
            super.loadBytes(param1,param2);
         }
         else if(this.state != STATE_LOADING)
         {
            if(this.state == STATE_FINISH_LOAD)
            {
               setTimeout(this.dispatchEvent,100,this._completeEvent);
            }
         }
      }
      
      private function onLoadByteComplete(param1:Event) : void
      {
         if(this.shouldPauseOnLoadBytesComplete)
         {
            UtilPlain.gotoAndStopFamilyAt1(this);
         }
         this.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadByteComplete);
         this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadByteError);
         this._completeEvent = param1.clone();
         this.state = STATE_FINISH_LOAD;
         this.dispatchEvent(param1);
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      private function get state() : String
      {
         return this._state;
      }
      
      public function get customData() : String
      {
         return this._customData;
      }
      
      public function set customData(param1:String) : void
      {
         this._customData = param1;
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      private function onLoadByteError(param1:Event) : void
      {
         this.state = STATE_NULL;
         this.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadByteComplete);
         this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadByteError);
      }
   }
}
