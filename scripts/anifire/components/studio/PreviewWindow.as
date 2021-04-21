package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.event.LoadMgrEvent;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilUser;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.TitleWindow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class PreviewWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1731063772_btnBack:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _watchers:Array;
      
      public var _PreviewWindow_Label1:Label;
      
      private var _301526948_movieName:String;
      
      private var _1730556742_btnSave:Button;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindings:Array;
      
      private var _1722718208_player:PreviewPlayer;
      
      public function PreviewWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"popupWindowBackground"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":PreviewPlayer,
                     "id":"_player",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":32,
                           "y":57,
                           "width":550,
                           "height":384,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnSave",
                     "events":{"click":"___btnSave_click"},
                     "stylesFactory":function():void
                     {
                        this.right = "32";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":454,
                           "minWidth":132,
                           "height":32,
                           "styleName":"btnBlack",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnBack",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":32,
                           "y":454,
                           "minWidth":132,
                           "height":32,
                           "styleName":"btnBlack",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_PreviewWindow_Label1",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":25,
                           "y":15,
                           "styleName":"title"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnCloseTop",
                     "events":{
                        "click":"___btnCloseTop_click",
                        "creationComplete":"___btnCloseTop_creationComplete"
                     },
                     "stylesFactory":function():void
                     {
                        this.right = "10";
                        this.top = "10";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnCloseTop",
                           "buttonMode":true,
                           "labelPlacement":"left"
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.layout = "absolute";
         this.width = 616;
         this.height = 500;
         this.styleName = "popupWindow";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("initialize",this.___PreviewWindow_TitleWindow1_initialize);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PreviewWindow._watcherSetupUtil = param1;
      }
      
      public function ___PreviewWindow_TitleWindow1_initialize(param1:FlexEvent) : void
      {
         this.setFocus();
      }
      
      public function addPublishListener(param1:Function) : void
      {
         this._btnSave.addEventListener(MouseEvent.CLICK,param1,false,0,true);
      }
      
      public function pause(param1:Boolean = false) : void
      {
         this._player.pause(true,param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _player() : PreviewPlayer
      {
         return this._1722718208_player;
      }
      
      private function _PreviewWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","previewwindow_save");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.label = param1;
         },"_btnSave.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "< " + UtilDict.toDisplay("go","Back to editing");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnBack.label = param1;
         },"_btnBack.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","previewwindow_preview") + _movieName;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PreviewWindow_Label1.text = param1;
         },"_PreviewWindow_Label1.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Close");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCloseTop.label = param1;
         },"_btnCloseTop.label");
         result[3] = binding;
         return result;
      }
      
      public function initAndPreviewMovie(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var filmXML:XML = param1;
         var imageDatas:UtilHashArray = param2;
         var loaddedThemes:UtilHashArray = param3;
         this._player.initAndPreview(filmXML,imageDatas,loaddedThemes);
         this.initPlayerEndScreen();
         this._btnBack.addEventListener(MouseEvent.CLICK,this.onCancelHandler,false,0,true);
         stage.frameRate = AnimeConstants.FRAME_PER_SEC;
         var setFrameRate:Function = function():void
         {
            stage.frameRate = AnimeConstants.FRAME_PER_SEC;
         };
         this.addEventListener(FlexEvent.CREATION_COMPLETE,setFrameRate,false,0,true);
         if(!UtilUser.loggedIn || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            this._btnSave.enabled = false;
         }
         if(Console.getConsole().isTutorialOn)
         {
            this._btnSave.enabled = false;
            this._btnBack.enabled = false;
         }
      }
      
      override public function initialize() : void
      {
         var target:PreviewWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._PreviewWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PreviewWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      private function initPlayerEndScreen() : void
      {
         this._player.endScreen.isPreviewMode = true;
         this._player.playerControl.fullScreenControl.visible = false;
      }
      
      public function set _player(param1:PreviewPlayer) : void
      {
         var _loc2_:Object = this._1722718208_player;
         if(_loc2_ !== param1)
         {
            this._1722718208_player = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_player",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBack() : Button
      {
         return this._1731063772_btnBack;
      }
      
      private function doResetFramerate(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Stage = _loc2_.getExtraData() as Stage;
         _loc3_.frameRate = AnimeConstants.FRAME_PER_SEC_FAST;
         this._player.removeEventListener(Event.REMOVED_FROM_STAGE,this.doResetFramerate);
      }
      
      public function destoryMC() : void
      {
         this._player.destroyMC();
         this._player = null;
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.showPublishWindow();
      }
      
      public function play(param1:Boolean = false) : void
      {
         this._player.play(param1);
      }
      
      public function set movieName(param1:String) : void
      {
         this._movieName = param1;
      }
      
      private function set _movieName(param1:String) : void
      {
         var _loc2_:Object = this._301526948_movieName;
         if(_loc2_ !== param1)
         {
            this._301526948_movieName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_movieName",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : Button
      {
         return this._1730556742_btnSave;
      }
      
      public function addExitListener(param1:Function) : void
      {
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      public function set _btnBack(param1:Button) : void
      {
         var _loc2_:Object = this._1731063772_btnBack;
         if(_loc2_ !== param1)
         {
            this._1731063772_btnBack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBack",_loc2_,param1));
         }
      }
      
      private function onCancelHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      public function get movieName() : String
      {
         return this._movieName;
      }
      
      [Bindable(event="propertyChange")]
      private function get _movieName() : String
      {
         return this._301526948_movieName;
      }
      
      private function _PreviewWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","previewwindow_save");
         _loc1_ = "< " + UtilDict.toDisplay("go","Back to editing");
         _loc1_ = UtilDict.toDisplay("go","previewwindow_preview") + this._movieName;
         _loc1_ = UtilDict.toDisplay("player","Close");
      }
      
      private function showPublishWindow() : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.onCancelHandler(param1);
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._1730556742_btnSave;
         if(_loc2_ !== param1)
         {
            this._1730556742_btnSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSave",_loc2_,param1));
         }
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
   }
}
