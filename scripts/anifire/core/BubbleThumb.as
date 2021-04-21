package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   
   public class BubbleThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "bubble";
      
      private static var _logger:ILogger = Log.getLogger("core.BubbleThumb");
       
      
      private var _isShowMsg:Boolean;
      
      private var _thumbnailImageData:ByteArray;
      
      private var _type:String;
      
      public function BubbleThumb()
      {
         super();
         _logger.debug("BubbleThumb initialize");
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         this.imageData = param1;
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.premium = param1.@is_premium == "Y"?true:false;
         this.theme = param2;
         this.type = param1.@type;
         this.enable = param1.@enable == "N"?false:true;
         this.isShowMsg = param1.@isShowMsg == "Y"?true:false;
         this.setFileName(param1.@thumb);
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc4_:UtilCrypto = null;
         trace("char thumb load image complete:" + this.id);
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:ByteArray = _loc2_.data;
         this.thumbImageData = _loc3_;
         if(this.theme.id != "ugc")
         {
            (_loc4_ = new UtilCrypto()).decrypt(ByteArray(this.thumbImageData));
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      private function doPositionProxyImage(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doPositionProxyImage);
         var _loc2_:Loader = param1.target.loader as Loader;
         var _loc3_:Rectangle = new Rectangle(0,0,AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT);
         UtilPlain.centerAlignObj(_loc2_,_loc3_,true);
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc5_:Loader = null;
         var _loc6_:Bubble = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Image = Image(param1.currentTarget);
         var _loc3_:DragSource = new DragSource();
         _loc3_.addData(this,"thumb");
         var _loc4_:Image = new Image();
         if(this.isShowMsg)
         {
            if(this.thumbImageData != null)
            {
               (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.doPositionProxyImage);
               _loc5_.loadBytes(this.thumbImageData as ByteArray);
               _loc4_.addChild(_loc5_);
            }
         }
         else
         {
            (_loc6_ = BubbleMgr.getBubbleByXML(XML(this.imageData))).text = "";
            _loc7_ = _loc6_.getSize();
            _loc8_ = 1;
            _loc9_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc10_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            if(!(_loc7_.width <= _loc9_ && _loc7_.height <= _loc10_))
            {
               if(_loc7_.width > _loc9_ && _loc7_.height <= _loc10_)
               {
                  _loc8_ = _loc9_ / _loc7_.width;
               }
               else if(_loc7_.width <= _loc9_ && _loc7_.height > _loc10_)
               {
                  _loc8_ = _loc10_ / _loc7_.height;
               }
               else
               {
                  _loc8_ = _loc9_ / _loc7_.width;
                  if(_loc7_.height * _loc8_ > _loc10_)
                  {
                     _loc8_ = _loc10_ / _loc7_.height;
                  }
               }
            }
            _loc6_.scale = _loc8_;
            _loc4_.addChild(_loc6_);
         }
         DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
         Console.getConsole().currDragSource = _loc3_;
      }
      
      public function set isShowMsg(param1:Boolean) : void
      {
         this._isShowMsg = param1;
      }
      
      public function get isShowMsg() : Boolean
      {
         return this._isShowMsg;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.getFileName(),ServerConstants.PARAM_BUBBLE);
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(_loc1_);
      }
   }
}
