package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.event.ByteLoaderEvent;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class CCManager extends EventDispatcher
   {
       
      
      private var _leftHandCache:Class;
      
      private var _colors:UtilHashArray;
      
      private var _styleName:Array;
      
      private var _propHandStyle:String = "";
      
      private var _styleCollection:UtilHashArray;
      
      private var _rightHandCache:Class;
      
      private var _partName:Array;
      
      public function CCManager()
      {
         this._styleCollection = new UtilHashArray();
         this._styleName = new Array();
         this._partName = new Array();
         this._colors = new UtilHashArray();
         super();
      }
      
      public function addColor(param1:String, param2:SelectedColor) : void
      {
         this._colors.push(param1,param2);
      }
      
      private function isOneOfHandClass(param1:String) : Boolean
      {
         return param1.indexOf(AnimeConstants.HAND) > 0;
      }
      
      private function isOneOfRightHandClass(param1:String) : Boolean
      {
         return param1.indexOf(AnimeConstants.RIGHT) > 0 && this.isOneOfHandClass(param1);
      }
      
      public function getSkin(param1:String, param2:String) : DisplayObjectContainer
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:Class = null;
         var _loc6_:Class = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc3_:LoaderInfo = this._styleCollection.getValueByKey(!!this.isOneOfHandClass(param2)?AnimeConstants.CLASS_GOHAND:param2) as LoaderInfo;
         if(_loc3_ != null)
         {
            if(this.haveProp() && this.isOneOfRightHandClass(param2))
            {
               param1 = AnimeConstants.ASSET_TYPE_PROP + this._propHandStyle + param1;
            }
            if(_loc3_.applicationDomain.hasDefinition(param1))
            {
               _loc5_ = _loc3_.applicationDomain.getDefinition(param1) as Class;
               if(param2 == AnimeConstants.CLASS_GOLEFTLOWERHAND)
               {
                  this._leftHandCache = _loc5_;
               }
               if(param2 == AnimeConstants.CLASS_GORIGHTLOWERHAND)
               {
                  this._rightHandCache = _loc5_;
               }
               _loc4_ = new _loc5_() as DisplayObjectContainer;
            }
            else
            {
               if(param2 == AnimeConstants.CLASS_GOLEFTLOWERHAND)
               {
                  _loc6_ = this._leftHandCache;
               }
               if(param2 == AnimeConstants.CLASS_GORIGHTLOWERHAND)
               {
                  _loc6_ = this._rightHandCache;
               }
               if(_loc6_ != null)
               {
                  _loc4_ = new _loc6_() as DisplayObjectContainer;
               }
            }
            if(_loc4_ != null)
            {
               _loc7_ = UtilPlain.getColorItem(_loc4_);
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc9_ = DisplayObject(_loc7_[_loc8_]).name.split("_");
                  if((_loc10_ = this.getColorByName(_loc9_[1])) != uint.MAX_VALUE)
                  {
                     UtilColor.setRGB(_loc7_[_loc8_],_loc10_);
                  }
                  _loc8_++;
               }
               return _loc4_;
            }
         }
         return null;
      }
      
      private function get leftHandCache() : Class
      {
         return this._leftHandCache;
      }
      
      private function doPrepareFinished(param1:Event) : void
      {
         trace("preparedone");
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function init() : void
      {
      }
      
      public function removeStyle(param1:String) : void
      {
         this._styleCollection.removeByKey(param1);
      }
      
      public function getColorByName(param1:String) : uint
      {
         if(this._colors.getValueByKey(param1) != null)
         {
            return SelectedColor(this._colors.getValueByKey(param1)).dstColor;
         }
         return uint.MAX_VALUE;
      }
      
      private function get rightHandCache() : Class
      {
         return this._rightHandCache;
      }
      
      public function addStyle(param1:String, param2:LoaderInfo) : void
      {
         this._styleCollection.push(param1,param2);
      }
      
      public function set colors(param1:UtilHashArray) : void
      {
         this._colors = param1;
      }
      
      private function haveProp() : Boolean
      {
         if(this._styleCollection.getValueByKey(AnimeConstants.CLASS_GOPROP) != null)
         {
            return true;
         }
         return false;
      }
      
      private function onLoadStyleDone(param1:Event) : void
      {
      }
      
      public function loadPropThumbAsStyle(param1:Object, param2:String) : void
      {
         this._propHandStyle = param2;
         var _loc3_:Loader = new Loader();
         _loc3_.loadBytes(param1 as ByteArray);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadPropThumbDone);
      }
      
      public function get colors() : UtilHashArray
      {
         return this._colors;
      }
      
      public function deleteColor(param1:String) : void
      {
         this._colors.removeByKey(param1);
      }
      
      private function onLoadPropThumbDone(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this._styleCollection.push(AnimeConstants.CLASS_GOPROP,_loc2_);
         this.dispatchEvent(new ByteLoaderEvent(ByteLoaderEvent.LOAD_BYTES_COMPLETE));
      }
   }
}
