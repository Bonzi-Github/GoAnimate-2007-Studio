package anifire.playback
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class PlainPlayer extends Anime
   {
      
      public static const MOVIE_ZIP_LOADED:int = 2;
      
      public static const MOVIE_ZIP_NOT_YET_LOAD:int = 0;
      
      public static const MOVIE_ZIP_LOADING:int = 1;
       
      
      public var loadingState:int = 0;
      
      public function PlainPlayer()
      {
         super();
      }
      
      public function initMovie(param1:URLRequest, param2:Array, param3:UtilHashArray) : void
      {
         var isLoadMovieComplete:Boolean = false;
         var isMochiComplete:Boolean = false;
         var _this:PlainPlayer = null;
         var readyToPlay:Function = null;
         var primaryUrlRequest:URLRequest = param1;
         var urlRequestArray:Array = param2;
         var flashVars:UtilHashArray = param3;
         try
         {
            if(flashVars.getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
            {
               Util.gaTracking("/goplayer/movie/loading/native/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer().stage);
            }
            else
            {
               Util.gaTracking("/goplayer/movie/loading/embed/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer());
            }
         }
         catch(error:SecurityError)
         {
         }
         isLoadMovieComplete = false;
         isMochiComplete = false;
         _this = this;
         readyToPlay = function(param1:Event):void
         {
            if((param1 as PlayerEvent).type == PlayerEvent.LOAD_MOVIE_COMPLETE)
            {
               isLoadMovieComplete = true;
            }
            if((param1 as PlayerEvent).type == PlayerEvent.MOCHI_COMPLETED)
            {
               isMochiComplete = true;
            }
            if(isLoadMovieComplete && isMochiComplete)
            {
               _this.getDataStock().removeEventListener(PlayerEvent.LOAD_MOVIE_COMPLETE,readyToPlay);
               _this.getDataStock().removeEventListener(PlayerEvent.MOCHI_COMPLETED,readyToPlay);
               readyToPlay = null;
               _this.dispatchEvent(new PlayerEvent(PlayerEvent.REAL_START_PLAY));
               _this.startPlay();
            }
         };
         this.getDataStock().addEventListener(PlayerEvent.LOAD_MOVIE_COMPLETE,readyToPlay,false,0,false);
         this.getDataStock().addEventListener(PlayerEvent.MOCHI_COMPLETED,readyToPlay);
         this.flashVars = flashVars;
         this.getDataStock().addEventListener(PlayerEvent.LOAD_MOVIE_COMPLETE,this.onLoadMovieCompleted,false,0,true);
         this.getDataStock().addEventListener(PlayerEvent.ERROR_LOADING_MOVIE,this.onLoadMovieError,false,0,true);
         this.getDataStock().addEventListener(PlayerEvent.LOAD_MOVIE_PROGRESS,this.onMovieProgress,false,0,true);
         this.getDataStock().initByLoadMovieZip(urlRequestArray);
         this.loadingState = MOVIE_ZIP_LOADING;
      }
      
      public function initAndPreview(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         trace("Movie\'s XML got. The content is: " + param1);
         if(param3 != null)
         {
            this.getDataStock().initByHashArray(param1,param2,param3);
         }
         this.init(this.getDataStock(),true);
         this.startPlay();
         this.loadingState = MOVIE_ZIP_LOADED;
      }
      
      public function goToAndPauseResetMovie() : void
      {
         this.execute(Anime.COMMAND_GOTO_AND_PAUSE_RESET);
      }
      
      public function endMovie() : void
      {
         this.execute(Anime.COMMAND_END);
      }
      
      public function isScenePreview(param1:Number) : void
      {
         this.scenePreviewFirstStart = param1;
      }
      
      private function onLoadMovieCompleted(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            if(flashVars.getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
            {
               Util.gaTracking("/goplayer/movie/complete/native/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer().stage);
            }
            else
            {
               Util.gaTracking("/goplayer/movie/complete/embed/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer());
            }
         }
         catch(error:SecurityError)
         {
         }
         this.init(this.getDataStock());
         try
         {
            if(flashVars.getValueByKey(ServerConstants.PARAM_ISEMBED_ID) as String == "0")
            {
               Util.gaTracking("/goplayer/movie/playing/native/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer().stage);
            }
            else
            {
               Util.gaTracking("/goplayer/movie/playing/embed/" + (flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String),this.getMovieContainer());
            }
         }
         catch(error:SecurityError)
         {
         }
         this.loadingState = MOVIE_ZIP_LOADED;
      }
      
      public function adCompleted() : void
      {
         this.getDataStock().dispatchEvent(new PlayerEvent(PlayerEvent.MOCHI_COMPLETED));
      }
      
      public function setVolume(param1:Number) : void
      {
         this.execute(Anime.COMMAND_SET_VOLUME,param1);
      }
      
      public function goToAndPauseMovie(param1:Number, param2:Boolean = false) : void
      {
         this.execute(Anime.COMMAND_GOTO_AND_PAUSE,param1,param2);
      }
      
      public function onAddEnterFrame() : void
      {
         this.execute(Anime.COMMAND_ADD_ENTER_FRAME);
      }
      
      public function onRemoveEnterFrame() : void
      {
         this.execute(Anime.COMMAND_REMOVE_ENTER_FRAME);
      }
      
      public function pauseMovie(param1:Boolean = true) : void
      {
         this.execute(Anime.COMMAND_PAUSE,param1);
      }
      
      public function playMovie() : void
      {
         this.execute(Anime.COMMAND_PLAY);
      }
      
      private function onLoadMovieError(param1:PlayerEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onMovieProgress(param1:PlayerEvent) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS,param1.getData()));
      }
   }
}
