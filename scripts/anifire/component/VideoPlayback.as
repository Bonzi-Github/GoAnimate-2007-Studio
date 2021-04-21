package anifire.component
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.VideoNetStreamEvent;
   import flash.display.Sprite;
   import flash.events.AsyncErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   
   public class VideoPlayback extends Sprite
   {
       
      
      private var ns:NetStream;
      
      private var vid:Video;
      
      private var nc:NetConnection;
      
      public function VideoPlayback()
      {
         super();
         this.nc = new NetConnection();
         this.nc.connect(null);
         this.nc.addEventListener(NetStatusEvent.NET_STATUS,this.showStatus);
         this.ns = new NetStream(this.nc);
         this.ns.addEventListener(NetStatusEvent.NET_STATUS,this.showStatus);
         this.vid = new Video();
      }
      
      private function doDetectWhenVideoStartPlay(param1:Number) : void
      {
         var _loc2_:VideoNetStreamEvent = null;
         if(this.vid.videoHeight > 0 || this.vid.videoWidth > 0)
         {
            _loc2_ = new VideoNetStreamEvent(VideoNetStreamEvent.VIDEO_START_TO_PLAY,this);
            _loc2_.playhead = param1;
            this.dispatchEvent(_loc2_);
         }
         else
         {
            setTimeout(this.doDetectWhenVideoStartPlay,AnimeConstants.FRAME_PER_SEC,param1);
         }
      }
      
      public function reset() : void
      {
      }
      
      public function pause() : void
      {
         this.ns.pause();
      }
      
      private function showStatus(param1:NetStatusEvent) : void
      {
         trace(param1);
      }
      
      public function play() : void
      {
         this.ns.resume();
      }
      
      private function correctVideoScaling(param1:VideoNetStreamEvent) : void
      {
         var _loc2_:Number = param1.playhead;
         this.removeEventListener(VideoNetStreamEvent.VIDEO_START_TO_PLAY,this.correctVideoScaling);
         this.vid.width = this.vid.videoWidth;
         this.vid.height = this.vid.videoHeight;
         this.vid.x = -1 * this.vid.width / 2;
         this.vid.y = -1 * this.vid.height / 2;
         this.vid.visible = true;
         this.pause();
         this.seekAndPlay(_loc2_);
      }
      
      public function seekAndPlay(param1:Number) : void
      {
         this.ns.seek(param1);
         this.play();
      }
      
      public function loadAndSeekPlayVideoByAssetId(param1:String, param2:Number) : void
      {
         var _loc3_:Object = new Object();
         this.ns.client = _loc3_;
         this.ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.asyncErrorHandler);
         trace("loadAndPlayVideoByAssetId:" + param1);
         var _loc4_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_ASSET);
         this.ns.play(_loc4_.url + param1);
         this.vid.attachNetStream(this.ns);
         this.vid.visible = false;
         this.addEventListener(VideoNetStreamEvent.VIDEO_START_TO_PLAY,this.correctVideoScaling);
         addChild(this.vid);
         this.doDetectWhenVideoStartPlay(param2);
      }
      
      private function asyncErrorHandler(param1:AsyncErrorEvent) : void
      {
      }
   }
}
