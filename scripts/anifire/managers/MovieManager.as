package anifire.managers
{
   import anifire.constant.ServerConstants;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.IDataInput;
   
   public class MovieManager extends EventDispatcher
   {
      
      public static const SAVE_MOVIE_COMPLETE:String = "save_movie_complete";
      
      public static const SAVE_MOVIE_ERROR:String = "save_movie_error";
       
      
      private var urlRequest:URLRequest;
      
      private var contingency_server_index:int;
      
      public var data:IDataInput;
      
      private var urlStream:URLStream;
      
      public function MovieManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      private function removeListenerFromStream() : void
      {
         this.urlStream.removeEventListener(Event.COMPLETE,this.onComplete);
         this.urlStream.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function saveAgain(param1:int) : void
      {
         this.urlRequest.url = ServerConstants.get_ACTION_SAVE_MOVIE(param1);
         this.urlStream.load(this.urlRequest);
      }
      
      private function addEventListenerToStream() : void
      {
         this.urlStream.addEventListener(Event.COMPLETE,this.onComplete);
         this.urlStream.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function onError(param1:Event) : void
      {
         ++this.contingency_server_index;
         if(this.contingency_server_index < ServerConstants.get_contingency_web_server_array().length)
         {
            this.saveAgain(this.contingency_server_index);
         }
         else
         {
            this.removeListenerFromStream();
            this.data = this.urlStream;
            if(param1.type == IOErrorEvent.IO_ERROR)
            {
               this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            }
            else if(param1.type == SecurityErrorEvent.SECURITY_ERROR)
            {
               this.dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
            }
         }
      }
      
      public function saveMovie(param1:URLVariables) : void
      {
         this.contingency_server_index = -1;
         this.urlRequest = new URLRequest(ServerConstants.get_ACTION_SAVE_MOVIE());
         this.urlRequest.method = URLRequestMethod.POST;
         this.urlRequest.data = param1;
         this.urlStream = new URLStream();
         this.addEventListenerToStream();
         this.urlStream.load(this.urlRequest);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.removeListenerFromStream();
         this.data = this.urlStream;
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
