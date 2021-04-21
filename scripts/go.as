package
{
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TopButtonBar;
   import anifire.core.Console;
   import anifire.timeline.Timeline;
   import anifire.util.Util;
   import anifire.util.UtilNetwork;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.Panel;
   import mx.controls.ProgressBar;
   import mx.core.Application;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class go extends Application
   {
      
      mx_internal static var _go_StylesInit_done:Boolean = false;
       
      
      private var _trebuchetMSItalic:Class;
      
      private var _1820782830_loadProgress:ProgressBar;
      
      public var _console:Console;
      
      private var _trebuchetMSBold:Class;
      
      private var trayOpen:Boolean = false;
      
      private var _427053173_topButtonBar:TopButtonBar;
      
      private var _2061112671_extSwfContainer:Canvas;
      
      private var _1490827770_effectTray:EffectTray;
      
      private var _159139667_thumbTray:ThumbTray;
      
      private var _1751026874_mainStage:MainStage;
      
      private var _1149811839_screenCapTool:ScreenCapTool;
      
      private var _1550104544dummyCanvas:Canvas;
      
      private var _619629449_overTray:OverTray;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1986132576_timeline:Timeline;
      
      private var _1592971130_tipsLayer:Canvas;
      
      private var _trebuchetMS:Class;
      
      public function go()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function():Object
            {
               return {
                  "width":646,
                  "height":720,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                        this.backgroundAlpha = 1;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":646,
                           "height":720,
                           "x":0,
                           "y":0,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 5460819;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":312,
                                    "y":43,
                                    "width":29,
                                    "height":26
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "stylesFactory":function():void
                              {
                                 this.borderStyle = "solid";
                                 this.cornerRadius = 10;
                                 this.borderColor = 16777215;
                                 this.backgroundColor = 16777215;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":326,
                                    "y":34,
                                    "width":37,
                                    "height":34
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Panel,
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 5460819;
                                 this.borderStyle = "solid";
                                 this.dropShadowEnabled = false;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":14,
                                    "width":326,
                                    "height":79,
                                    "layout":"absolute",
                                    "styleName":"pnlTheaterShadow"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TopButtonBar,
                              "id":"_topButtonBar",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":328,
                                    "y":11,
                                    "width":320
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MainStage,
                              "id":"_mainStage",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":68
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Timeline,
                              "id":"_timeline",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":530,
                                    "width":643,
                                    "styleName":"timeLine"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"dummyCanvas",
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 16777215;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":8,
                                    "y":22,
                                    "width":325,
                                    "height":0,
                                    "alpha":0
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ThumbTray,
                              "id":"_thumbTray",
                              "events":{
                                 "rollOver":"___thumbTray_rollOver",
                                 "rollOut":"___thumbTray_rollOut"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":8,
                                    "y":22
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":OverTray,
                              "id":"_overTray",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":4,
                                    "y":40
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":EffectTray,
                              "id":"_effectTray",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":605,
                                    "y":92
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ScreenCapTool,
                              "id":"_screenCapTool",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_tipsLayer",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_extSwfContainer",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "y":0,
                                    "percentHeight":100,
                                    "percentWidth":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ProgressBar,
                              "id":"_loadProgress",
                              "stylesFactory":function():void
                              {
                                 this.fontFamily = "Arial";
                                 this.fontSize = 10;
                                 this.color = 3355443;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "labelPlacement":"center",
                                    "enabled":true,
                                    "mode":"manual",
                                    "label":"PREPARING...",
                                    "x":326,
                                    "y":72,
                                    "width":271,
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._trebuchetMS = go__trebuchetMS;
         this._trebuchetMSBold = go__trebuchetMSBold;
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundGradientAlphas = [1,1];
            this.backgroundGradientColors = [16777215,16777215];
         };
         mx_internal::_go_StylesInit();
         this.layout = "absolute";
         this.width = 646;
         this.height = 720;
         this.addEventListener("applicationComplete",this.___go_Application1_applicationComplete);
      }
      
      public function ___go_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.initialConsole();
      }
      
      private function trayCloseHandler(param1:Event) : void
      {
         this.dummyCanvas.height = 0;
         this.dummyCanvas.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
      }
      
      [Bindable(event="propertyChange")]
      public function get _overTray() : OverTray
      {
         return this._619629449_overTray;
      }
      
      [Bindable(event="propertyChange")]
      public function get _topButtonBar() : TopButtonBar
      {
         return this._427053173_topButtonBar;
      }
      
      public function set _effectTray(param1:EffectTray) : void
      {
         var _loc2_:Object = this._1490827770_effectTray;
         if(_loc2_ !== param1)
         {
            this._1490827770_effectTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectTray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectTray() : EffectTray
      {
         return this._1490827770_effectTray;
      }
      
      public function set _mainStage(param1:MainStage) : void
      {
         var _loc2_:Object = this._1751026874_mainStage;
         if(_loc2_ !== param1)
         {
            this._1751026874_mainStage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainStage",_loc2_,param1));
         }
      }
      
      public function set _screenCapTool(param1:ScreenCapTool) : void
      {
         var _loc2_:Object = this._1149811839_screenCapTool;
         if(_loc2_ !== param1)
         {
            this._1149811839_screenCapTool = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_screenCapTool",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function trayOpenHandler(param1:Event) : void
      {
         this.dummyCanvas.height = this._thumbTray.height;
         this.dummyCanvas.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
      }
      
      public function set _topButtonBar(param1:TopButtonBar) : void
      {
         var _loc2_:Object = this._427053173_topButtonBar;
         if(_loc2_ !== param1)
         {
            this._427053173_topButtonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_topButtonBar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _extSwfContainer() : Canvas
      {
         return this._2061112671_extSwfContainer;
      }
      
      public function set _loadProgress(param1:ProgressBar) : void
      {
         var _loc2_:Object = this._1820782830_loadProgress;
         if(_loc2_ !== param1)
         {
            this._1820782830_loadProgress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loadProgress",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _timeline() : Timeline
      {
         return this._1986132576_timeline;
      }
      
      [Bindable(event="propertyChange")]
      public function get _loadProgress() : ProgressBar
      {
         return this._1820782830_loadProgress;
      }
      
      [Bindable(event="propertyChange")]
      public function get _thumbTray() : ThumbTray
      {
         return this._159139667_thumbTray;
      }
      
      [Bindable(event="propertyChange")]
      public function get dummyCanvas() : Canvas
      {
         return this._1550104544dummyCanvas;
      }
      
      public function set _overTray(param1:OverTray) : void
      {
         var _loc2_:Object = this._619629449_overTray;
         if(_loc2_ !== param1)
         {
            this._619629449_overTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_overTray",_loc2_,param1));
         }
      }
      
      public function set _extSwfContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2061112671_extSwfContainer;
         if(_loc2_ !== param1)
         {
            this._2061112671_extSwfContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_extSwfContainer",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainStage() : MainStage
      {
         return this._1751026874_mainStage;
      }
      
      public function set _timeline(param1:Timeline) : void
      {
         var _loc2_:Object = this._1986132576_timeline;
         if(_loc2_ !== param1)
         {
            this._1986132576_timeline = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timeline",_loc2_,param1));
         }
      }
      
      public function set dummyCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1550104544dummyCanvas;
         if(_loc2_ !== param1)
         {
            this._1550104544dummyCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dummyCanvas",_loc2_,param1));
         }
      }
      
      public function set _thumbTray(param1:ThumbTray) : void
      {
         var _loc2_:Object = this._159139667_thumbTray;
         if(_loc2_ !== param1)
         {
            this._159139667_thumbTray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_thumbTray",_loc2_,param1));
         }
      }
      
      public function ___thumbTray_rollOut(param1:MouseEvent) : void
      {
         this.trayOpen = false;
      }
      
      public function ___thumbTray_rollOver(param1:MouseEvent) : void
      {
         this.trayOpen = true;
         this._thumbTray.show();
      }
      
      mx_internal function _go_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_go_StylesInit_done)
         {
            return;
         }
         mx_internal::_go_StylesInit_done = true;
         StyleManager.mx_internal::initProtoChainRoots();
      }
      
      private function initialConsole() : void
      {
         Util.gaTracking("/gostudio/initialGoConsole",this.stage);
         UtilNetwork.loadS3crossDomainXml();
         this.stage.scaleMode = StageScaleMode.SHOW_ALL;
         this._console = Console.initializeConsole(this._mainStage,this._topButtonBar,this._thumbTray,this._effectTray,this._timeline,this._extSwfContainer,this._overTray._pw,this._tipsLayer,this._screenCapTool) as Console;
         this._console.initializeLoadingBar(this._loadProgress);
         this._thumbTray.addEventListener("TrayClose",this.trayCloseHandler);
         this._thumbTray.addEventListener("TrayOpen",this.trayOpenHandler);
         application.addEventListener(KeyboardEvent.KEY_UP,this._console.doKeyUp);
      }
      
      private function rollOutHandler(param1:MouseEvent) : void
      {
         this.callLater(this.hideDummyCanvas);
      }
      
      [Bindable(event="propertyChange")]
      public function get _tipsLayer() : Canvas
      {
         return this._1592971130_tipsLayer;
      }
      
      public function set _tipsLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1592971130_tipsLayer;
         if(_loc2_ !== param1)
         {
            this._1592971130_tipsLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tipsLayer",_loc2_,param1));
         }
      }
      
      private function hideDummyCanvas() : void
      {
         if(!this.trayOpen)
         {
            this._thumbTray.hide(null,true);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _screenCapTool() : ScreenCapTool
      {
         return this._1149811839_screenCapTool;
      }
   }
}
