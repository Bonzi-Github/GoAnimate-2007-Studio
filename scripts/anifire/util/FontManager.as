package anifire.util
{
   import anifire.event.LoadMgrEvent;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import mx.managers.CursorManager;
   
   public class FontManager
   {
      
      private static var _fontManager:FontManager;
       
      
      private var _fonts:UtilHashArray;
      
      public function FontManager()
      {
         super();
      }
      
      public static function getFontManager() : FontManager
      {
         if(_fontManager == null)
         {
            _fontManager = new FontManager();
            _fontManager.init();
         }
         return _fontManager;
      }
      
      public function setFontAsLoaded(param1:String, param2:ByteArray) : void
      {
         this._fonts.push(param1,param2,false);
      }
      
      public function nameToFileName(param1:String) : String
      {
         switch(param1)
         {
            case "Blambot Casual":
               return "FontFileCasual";
            case "BadaBoom BB":
               return "FontFileBoom";
            case "Entrails BB":
               return "FontFileEntrails";
            case "Tokyo Robot Intl BB":
               return "FontFileTokyo";
            case "Accidental Presidency":
               return "FontFileAccidental";
            case "BodoniXT":
               return "FontFileBodoniXT";
            case "Budmo Jiggler":
               return "FontFileBJiggler";
            case "Budmo Jigglish":
               return "FontFileBJigglish";
            case "Existence Light":
               return "FontFileExistence";
            case "HeartlandRegular":
               return "FontFileHeartland";
            case "Honey Script":
               return "FontFileHoney";
            case "I hate Comic Sans":
               return "FontFileIHate";
            case "Impact Label":
               return "FontFileImpactLabel";
            case "loco tv":
               return "FontFileLocotv";
            case "Mail Ray Stuff":
               return "FontFileMailRay";
            case "Mia\'s Scribblings ~":
               return "FontFileMia";
            case "Shanghai":
               return "FontFileShanghai";
            case "Comic Book":
               return "FontFileComicBook";
            case "Wood Stamp":
               return "FontFileWoodStamp";
            default:
               return "";
         }
      }
      
      public function getFonts() : UtilHashArray
      {
         return this._fonts;
      }
      
      public function init() : void
      {
         this._fonts = new UtilHashArray();
      }
      
      private function onFontCallBack(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         _loc2_.removeEventListener(LoadMgrEvent.ALL_COMPLETE,this.onFontCallBack);
         CursorManager.removeBusyCursor();
         var _loc3_:String = (_loc2_.getExtraData() as Array)[0] as String;
         var _loc4_:Function;
         if((_loc4_ = (_loc2_.getExtraData() as Array)[1] as Function) != null)
         {
            _loc4_(param1,_loc3_);
         }
      }
      
      public function registerFontByName(param1:String, param2:Class) : void
      {
      }
      
      public function loadFont(param1:String, param2:Function = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:Loader = new Loader();
         var _loc5_:UtilLoadMgr;
         (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onFontCallBack);
         _loc5_.addEventDispatcher(_loc4_.contentLoaderInfo,Event.COMPLETE);
         _loc3_ = this.nameToFileName(param1) + ".swf";
         _loc4_.name = param1;
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoaded);
         _loc4_.load(new URLRequest(UtilNetwork.getFont(_loc3_)));
         _loc5_.setExtraData(new Array(param1,param2));
         _loc5_.commit();
         CursorManager.setBusyCursor();
      }
      
      private function onFontLoaded(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader as Loader;
         _loc2_.removeEventListener(Event.COMPLETE,this.onFontLoaded);
         var _loc3_:String = _loc2_.name;
         var _loc4_:ByteArray;
         (_loc4_ = new ByteArray()).writeBytes(param1.target.bytes as ByteArray);
         this._fonts.push(_loc3_,_loc4_,true);
      }
      
      public function isFontLoaded(param1:String) : Boolean
      {
         if(this._fonts.containsKey(param1))
         {
            return true;
         }
         return false;
      }
   }
}
