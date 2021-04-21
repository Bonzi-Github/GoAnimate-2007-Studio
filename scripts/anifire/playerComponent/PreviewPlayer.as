package anifire.playerComponent
{
   import anifire.component.MochiAdDisplay;
   import anifire.component.ProgressMonitor;
   import anifire.component.timeFrameSynchronizer;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.LoadMgrEvent;
   import anifire.playback.PlainPlayer;
   import anifire.playback.PlayerEvent;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreen;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreenEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilMovieInfoXMLLoader;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObjectContainer;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Box;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.ProgressBar;
   import mx.controls.ProgressBarMode;
   import mx.controls.Text;
   import mx.core.Application;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.easing.Exponential;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class PreviewPlayer extends Canvas implements IBindingClient
   {
      
      private static var PLAYHEAD_STATE_NULL:int = 0;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static var PLAYHEAD_STATE_PLAY:int = 1;
      
      private static const LOADING_ICON_NAME:String = "loading_icon";
      
      private static var _logger:ILogger = Log.getLogger("playerComponent.PlayerControl");
      
      mx_internal static var _PreviewPlayer_StylesInit_done:Boolean = false;
      
      private static var PLAYHEAD_STATE_MOVIE_END:int = 3;
      
      private static var PLAYHEAD_STATE_PAUSE:int = 2;
       
      
      private var _566693337curtainBox:Box;
      
      private var _shouldPauseWhenLoadingMovie:Boolean = false;
      
      private var _1274894500txtLicenserDisclaimer:Text;
      
      private var _imageData:UtilHashArray;
      
      private var _168901560googleAdsAttribution:Text;
      
      private var _1690319114fadeMoveShow:Parallel;
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _PreviewPlayer_SetProperty1:SetProperty;
      
      public var _PreviewPlayer_SetProperty2:SetProperty;
      
      private var _231891831loadingText:Text;
      
      private var previewSceneFirstStart:Boolean = true;
      
      private var _1593500967endScreen:PlayerEndScreen;
      
      private var showingAdsVideo:Boolean = false;
      
      private var _690449604playerControl:PlayerControl;
      
      private var _filmXML:XML;
      
      private var _flashVars:UtilHashArray;
      
      private var _ad:MochiAdDisplay;
      
      private var _isInited:Boolean = false;
      
      private var _expectedPlayHeadState:int;
      
      private var _459583688loadingScreen:Canvas;
      
      private var _1254676919createYourOwn:Label;
      
      private var _themeXMLs:UtilHashArray;
      
      private var _1462422359alertText:Text;
      
      private var _1840541266movieStage:Canvas;
      
      private var _336650556loading:Label;
      
      private var previewSceneNum:Number = 0;
      
      protected var plainPlayer:PlainPlayer;
      
      private var _3327403logo:Button;
      
      private var _1523976162timeFrameSynchronizer:timeFrameSynchronizer;
      
      private var _subComponents:Array;
      
      private var _1915233234licensorLogo:Button;
      
      private var params:Object;
      
      private var previewMode:Boolean = false;
      
      private var firstStart:Boolean = true;
      
      mx_internal var _watchers:Array;
      
      private var movieInfoLoader:UtilMovieInfoXMLLoader;
      
      private var _owner:String = "";
      
      private var _urlRequest:URLRequest;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1689992015fadeMoveHide:Parallel;
      
      private var _urlRequestArray:Array;
      
      private var _1645408545mochiContainer:UIComponent;
      
      mx_internal var _bindings:Array;
      
      private var pb:ProgressBar;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function PreviewPlayer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "height":384,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"movieStage",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":550,
                           "height":354
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"loadingScreen",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":550,
                           "height":354,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"createYourOwn",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"createYourOwn",
                                    "y":296,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"loading",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"loading",
                                    "y":208,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"txtLicenserDisclaimer",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":38,
                                    "y":214,
                                    "styleName":"txtLicenserDisclaimer",
                                    "text":"",
                                    "width":469
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":UIComponent,
                     "id":"mochiContainer"
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"logo",
                     "events":{
                        "click":"__logo_click",
                        "creationComplete":"__logo_creationComplete",
                        "render":"__logo_render"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "label":"",
                           "styleName":"btnLogo",
                           "x":10,
                           "y":323
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"licensorLogo",
                     "events":{"click":"__licensorLogo_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "label":"",
                           "styleName":"btnLicensorLogo",
                           "x":400,
                           "y":310
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":PlayerEndScreen,
                     "id":"endScreen",
                     "events":{
                        "btn_replay_click":"__endScreen_btn_replay_click",
                        "nor_screen":"__endScreen_nor_screen"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"alertText",
                     "stylesFactory":function():void
                     {
                        this.textAlign = "center";
                        this.fontSize = 14;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":14.5,
                           "y":126,
                           "width":521,
                           "height":228,
                           "enabled":false,
                           "mouseEnabled":false,
                           "text":""
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":timeFrameSynchronizer,
                     "id":"timeFrameSynchronizer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":249,
                           "y":0,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":PlayerControl,
                     "id":"playerControl",
                     "events":{
                        "onPlayButClicked":"__playerControl_onPlayButClicked",
                        "onPauseButClicked":"__playerControl_onPauseButClicked",
                        "onTimeLineDrag":"__playerControl_onTimeLineDrag",
                        "onTimeLinePress":"__playerControl_onTimeLinePress",
                        "onTimeLineRelease":"__playerControl_onTimeLineRelease",
                        "volume_change":"__playerControl_volume_change",
                        "full_screen":"__playerControl_full_screen",
                        "nor_screen":"__playerControl_nor_screen"
                     },
                     "stylesFactory":function():void
                     {
                        this.cornerRadius = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":354,
                           "width":550,
                           "height":30
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Box,
                     "id":"curtainBox",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"visible":false};
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"loadingText",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.textAlign = "center";
                        this.horizontalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"loadingText",
                           "text":"loading...",
                           "visible":false,
                           "y":350
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"googleAdsAttribution",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.textAlign = "right";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"loadingText",
                           "text":"Ads By Google",
                           "visible":false,
                           "x":300,
                           "y":16
                        };
                     }
                  })]
               };
            }
         });
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_NULL;
         this._subComponents = new Array();
         this.pb = new ProgressBar();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 16777215;
         };
         mx_internal::_PreviewPlayer_StylesInit();
         this.width = 550;
         this.height = 384;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.states = [this._PreviewPlayer_State1_c()];
         this._PreviewPlayer_Parallel2_i();
         this._PreviewPlayer_Parallel1_i();
         this.addEventListener("creationComplete",this.___PreviewPlayer_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PreviewPlayer._watcherSetupUtil = param1;
      }
      
      private function _PreviewPlayer_Parallel2_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.fadeMoveHide = _loc1_;
         _loc1_.children = [this._PreviewPlayer_Move2_c()];
         return _loc1_;
      }
      
      private function hideEndScreen(... rest) : void
      {
         this.endScreen.visible = false;
         this.playerControl.fullScreenControl.fullBut.enableBut1(true);
      }
      
      private function onCreationCompleted(... rest) : void
      {
         var _loc5_:UtilLoadMgr = null;
         Util.initLog();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_NULL;
         this.addComponents();
         this.movieStage.scrollRect = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this.plainPlayer = new PlainPlayer();
         this.plainPlayer.addEventListener(PlayerEvent.REAL_START_PLAY,this.doEnableTimelineRelatedStuff,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doRemoveLoadingScreen);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.doTriggerPauseWhenMovieLoad);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doNotTriggerPauseWhenMovieLoad);
         this.plainPlayer.addEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.onMovieTimeChange,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_MOVIE_END,this.onMovieEnd,false,0,true);
         if(Util.isVideoRecording())
         {
            (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doTellVideoRecordingSoftwareMovieStart);
            _loc5_.addEventDispatcher(this.plainPlayer.eventDispatcher,PlayerEvent.BUFFER_READY_WHEN_MOVIE_START);
            _loc5_.addEventDispatcher(this.plainPlayer.eventDispatcher,PlayerEvent.PLAYHEAD_TIME_CHANGE);
            _loc5_.commit();
         }
         this.initializeBufferExhaustListener();
         this.loadMovieInfoXML();
         var _loc2_:DisplayObjectContainer = this.plainPlayer.getMovieContainer();
         var _loc3_:UIComponent = new UIComponent();
         _loc3_.addChild(_loc2_);
         this.movieStage.addChild(_loc3_);
         var _loc4_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc4_);
         if(_loc4_["movieOwner"] != "")
         {
            this._owner = _loc4_["movieOwner"];
         }
         if(this.previewMode)
         {
            this.startPreview();
         }
         this._ad = new MochiAdDisplay();
         this.mochiContainer.addChild(this._ad.movieClip);
         this.endScreen.addEventListener("btn_nextmovie_click",this.onNextMovieClick);
         this._isInited = true;
      }
      
      private function curtaining() : void
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey("playcount") as String;
         var _loc2_:String = Util.getFlashVar().getValueByKey("duration") as String;
         if(_loc1_ && Number(_loc2_) > 59)
         {
         }
      }
      
      public function set fadeMoveShow(param1:Parallel) : void
      {
         var _loc2_:Object = this._1690319114fadeMoveShow;
         if(_loc2_ !== param1)
         {
            this._1690319114fadeMoveShow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeMoveShow",_loc2_,param1));
         }
      }
      
      private function doRemoveLoadingScreen(param1:Event = null) : void
      {
         this.plainPlayer.removeEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doRemoveLoadingScreen);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doRemoveLoadingScreen);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.doTriggerPauseWhenMovieLoad);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doNotTriggerPauseWhenMovieLoad);
         if(this.contains(this.loadingScreen))
         {
            this.removeChild(this.loadingScreen);
         }
         this.playerControl.initializingFinishListener();
         this.dispatchEvent(new Event("info_load_complete"));
      }
      
      public function showSharingPanel(param1:Boolean = true) : void
      {
         if(this.firstStart)
         {
            this.showEndScreen(null,param1);
         }
         else
         {
            this.plainPlayer.endMovie();
         }
      }
      
      private function setVolumeInPlainPlayer(param1:Number) : void
      {
         this.plainPlayer.setVolume(param1);
      }
      
      public function __endScreen_btn_replay_click(param1:PlayerEndScreenEvent) : void
      {
         this.onReplayButtonClick();
      }
      
      public function resume() : void
      {
         this.resumePlainPlayer(true,true,true);
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$startPreview: PLAYHEAD_STATE_PLAY");
      }
      
      private function doNotTriggerPauseWhenMovieLoad(param1:Event) : void
      {
         this._shouldPauseWhenLoadingMovie = false;
      }
      
      private function _PreviewPlayer_Parallel1_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this.fadeMoveShow = _loc1_;
         _loc1_.children = [this._PreviewPlayer_Move1_c()];
         return _loc1_;
      }
      
      private function _PreviewPlayer_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._PreviewPlayer_SetProperty2 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_PreviewPlayer_SetProperty2",this._PreviewPlayer_SetProperty2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get googleAdsAttribution() : Text
      {
         return this._168901560googleAdsAttribution;
      }
      
      private function onMovieTimeChange(param1:PlayerEvent) : void
      {
         this.playerControl.timeChangeListener(this.plainPlayer.currentFrame);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_TIME_CHANGE));
      }
      
      public function set endScreen(param1:PlayerEndScreen) : void
      {
         var _loc2_:Object = this._1593500967endScreen;
         if(_loc2_ !== param1)
         {
            this._1593500967endScreen = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endScreen",_loc2_,param1));
         }
      }
      
      private function doNorScreen(param1:PlayerEvent = null) : void
      {
         stage.displayState = StageDisplayState.NORMAL;
      }
      
      private function onPlayButClick() : void
      {
         if(this._expectedPlayHeadState == PLAYHEAD_STATE_MOVIE_END)
         {
            this.replay();
         }
         else
         {
            this.play();
         }
      }
      
      public function __playerControl_nor_screen(param1:PlayerEvent) : void
      {
         this.doNorScreen(param1);
      }
      
      public function __playerControl_onTimeLineRelease(param1:Event) : void
      {
         this.onTimeLineRelease(param1);
      }
      
      private function doEnableTimelineRelatedStuff(param1:Event) : void
      {
         this.plainPlayer.removeEventListener(PlayerEvent.REAL_START_PLAY,this.doEnableTimelineRelatedStuff);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doEnableTimelineRelatedStuff);
         this.playerControl.enableTimeLine();
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         if(_loc2_[ServerConstants.PARAM_ISSLIDE] == "1")
         {
            this.playerControl.enableTimeLine(false);
            this.playerControl.timeLine.liveDragging = false;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY_WHEN_MOVIE_START));
      }
      
      private function _PreviewPlayer_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._PreviewPlayer_SetProperty1 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_PreviewPlayer_SetProperty1",this._PreviewPlayer_SetProperty1);
         return _loc1_;
      }
      
      public function getParams() : Object
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.params = {};
         var _loc1_:String = ExternalInterface.call("window.location.search.substring",1);
         if(_loc1_)
         {
            _loc2_ = _loc1_.split("&");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if((_loc4_ = _loc2_[_loc3_].indexOf("=")) != -1)
               {
                  _loc5_ = _loc2_[_loc3_].substring(0,_loc4_);
                  _loc6_ = _loc2_[_loc3_].substring(_loc4_ + 1);
                  this.params[_loc5_] = _loc6_;
               }
               _loc3_++;
            }
         }
         return this.params;
      }
      
      public function set loading(param1:Label) : void
      {
         var _loc2_:Object = this._336650556loading;
         if(_loc2_ !== param1)
         {
            this._336650556loading = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loading",_loc2_,param1));
         }
      }
      
      private function onTimeLineRelease(... rest) : void
      {
         this.timeFrameSynchronizer.startSyn();
         if(this._expectedPlayHeadState == PreviewPlayer.PLAYHEAD_STATE_PLAY)
         {
            this.resumePlainPlayer(false,true,true);
         }
         else if(this._expectedPlayHeadState == PLAYHEAD_STATE_MOVIE_END)
         {
            this._expectedPlayHeadState = PLAYHEAD_STATE_PAUSE;
            trace("$$$$$$$$$$$$$$$$$$$$$$$$onTimeLineRelease: timeline released, play head state is pause");
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadingText() : Text
      {
         return this._231891831loadingText;
      }
      
      private function onMovieEnd(param1:PlayerEvent) : void
      {
         this.pause();
         navigateToURL(new URLRequest("FSCommand:stop"));
         this._expectedPlayHeadState = PLAYHEAD_STATE_MOVIE_END;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$onMovieEnd: PLAYHEAD_STATE_MOVIE_END");
         if(this.plainPlayer.licensedSoundInfo != "")
         {
            this.endScreen.showCreditScreen(this.plainPlayer.licensedSoundInfo);
         }
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_GOTOANDPAUSE,this.hideEndScreen,false,0,true);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.hideEndScreen,false,0,true);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.hideEndScreen,false,0,true);
         this.timeFrameSynchronizer.stopSyn();
         this.showEndScreen();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_MOVIE_END));
      }
      
      private function addComponents() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._subComponents.length)
         {
            this.addChild(this._subComponents[_loc1_]);
            _loc1_++;
         }
      }
      
      public function set playerControl(param1:PlayerControl) : void
      {
         var _loc2_:Object = this._690449604playerControl;
         if(_loc2_ !== param1)
         {
            this._690449604playerControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerControl",_loc2_,param1));
         }
      }
      
      public function set googleAdsAttribution(param1:Text) : void
      {
         var _loc2_:Object = this._168901560googleAdsAttribution;
         if(_loc2_ !== param1)
         {
            this._168901560googleAdsAttribution = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"googleAdsAttribution",_loc2_,param1));
         }
      }
      
      public function set fadeMoveHide(param1:Parallel) : void
      {
         var _loc2_:Object = this._1689992015fadeMoveHide;
         if(_loc2_ !== param1)
         {
            this._1689992015fadeMoveHide = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeMoveHide",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get alertText() : Text
      {
         return this._1462422359alertText;
      }
      
      private function showEndScreen(param1:Object = null, param2:Boolean = true) : void
      {
         var _loc3_:Fade = null;
         this.endScreen.visible = true;
         this.playerControl.fullScreenControl.fullBut.enableBut1(false);
         if(param2)
         {
            _loc3_ = new Fade();
            _loc3_.target = this.endScreen;
            _loc3_.alphaFrom = 0;
            _loc3_.alphaTo = 1;
            _loc3_.easingFunction = Exponential.easeIn;
            _loc3_.play();
         }
      }
      
      public function adSenseStarted(param1:Event) : void
      {
         param1.target.removeEventListener("ADS_FINISH_LOADING",this.adSenseStarted);
         this.loadingText.text = "Your video is loading, and this ad will close automatically.";
      }
      
      public function set txtLicenserDisclaimer(param1:Text) : void
      {
         var _loc2_:Object = this._1274894500txtLicenserDisclaimer;
         if(_loc2_ !== param1)
         {
            this._1274894500txtLicenserDisclaimer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtLicenserDisclaimer",_loc2_,param1));
         }
      }
      
      public function __licensorLogo_click(param1:MouseEvent) : void
      {
         this.onLogoClick();
      }
      
      private function onTimeLinePress(... rest) : void
      {
         this.timeFrameSynchronizer.stopSyn();
         this.pausePlainPlayer(false,true,true);
      }
      
      private function startPlay() : void
      {
         var playFunc:Function = null;
         var image:Image = new Image();
         var loadingCSSClassDec:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".myloading");
         var MyImageClass:Class = loadingCSSClassDec.getStyle("mybg") as Class;
         image.source = MyImageClass;
         image.name = LOADING_ICON_NAME;
         this.loadingScreen.addChildAt(image,0);
         this.loadingScreen.addChild(this.pb);
         this.pb.name = "ppProgressBar";
         this.pb.mode = ProgressBarMode.MANUAL;
         this.pb.styleName = "loadProgress";
         this.pb.label = "";
         if(UtilLicense.getCurrentLicenseId() == "7")
         {
            this.pb.width = 236;
            this.pb.height = 9.5;
            this.pb.x = 163;
            this.pb.y = 167;
            this.pb.setStyle("trackAlpha",0);
         }
         else if(UtilLicense.getCurrentLicenseId() == "8")
         {
            this.pb.width = 236;
            this.pb.height = 9.5;
            this.pb.x = 163;
            this.pb.y = 187;
            this.pb.setStyle("trackAlpha",0);
         }
         else
         {
            this.pb.width = 236;
            this.pb.height = 9.5;
            this.pb.x = 163;
            this.pb.y = 187;
         }
         currentState = "loadingScreenDisplayed";
         var ptext:Text = new Text();
         ptext.name = "ppText";
         ptext.x = 74;
         ptext.y = 258;
         ptext.width = 407;
         ptext.height = 45;
         ptext.selectable = false;
         ptext.setStyle("textAlign","center");
         ptext.setStyle("fontSize","16");
         var domain:String = UtilDict.toDisplay("player","sharing_website_displayname");
         if(this._owner != "" && this._owner != "null" && this._owner != null)
         {
            ptext.text = this._owner + " " + UtilDict.toDisplay("player","player_frontpromo1") + " " + domain;
         }
         else
         {
            ptext.text = UtilDict.toDisplay("player","player_frontpromo2") + " " + domain;
         }
         this.loadingScreen.addChild(ptext);
         _logger.debug("init and play url: " + this._urlRequest.url);
         this.timeFrameSynchronizer.stopSyn();
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doStartTimeFrameSynchronized);
         this.plainPlayer.addEventListener(PlayerEvent.ERROR_LOADING_MOVIE,this.onErrorLoadingMovie,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.LOAD_MOVIE_PROGRESS,this.onMovieProgress,false,0,true);
         ProgressMonitor.getInstance().addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         var initFunc:Function = function():void
         {
            plainPlayer.initMovie(_urlRequest,_urlRequestArray,_flashVars);
            playerControl.playListener();
            if(showingAdsVideo == false)
            {
               plainPlayer.adCompleted();
            }
         };
         if(this.movieInfoLoader && this.movieInfoLoader.loading)
         {
            playFunc = function(param1:Event):void
            {
               movieInfoLoader.removeEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,playFunc);
               initFunc();
            };
            this.movieInfoLoader.addEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,playFunc);
         }
         else
         {
            initFunc();
         }
      }
      
      private function doFullScreen(param1:PlayerEvent) : void
      {
         stage.displayState = StageDisplayState.FULL_SCREEN;
         stage.align = StageAlign.BOTTOM;
      }
      
      [Bindable(event="propertyChange")]
      public function get loadingScreen() : Canvas
      {
         return this._459583688loadingScreen;
      }
      
      private function onTimeLineDrag(... rest) : void
      {
         this.pausePlainPlayer(false,true,true);
         this.timeFrameSynchronizer.stopSyn();
         this.goToAndPausePlainPlayer(false,true,true,this.playerControl.getCurFrame(),true);
      }
      
      public function __logo_render(param1:Event) : void
      {
         this.updateLogoPosition(param1);
      }
      
      private function get isMochiAdShown() : Boolean
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.PARAM_ISEMBED_ID);
         var _loc4_:String = _loc1_.getValueByKey("ad");
         var _loc5_:Boolean = true;
         return false;
      }
      
      public function __playerControl_volume_change(param1:PlayerEvent) : void
      {
         this.onVolumeChange(param1);
      }
      
      private function resumePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.initializeBufferExhaustListener();
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_RESUME));
         }
         if(param2)
         {
            this.plainPlayer.playMovie();
         }
         if(param1)
         {
            this.playerControl.playListener();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mochiContainer() : UIComponent
      {
         return this._1645408545mochiContainer;
      }
      
      private function onMovieStructureReady(param1:PlayerEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onMovieStructureReady);
         this.playerControl.init(this.plainPlayer.getDuration());
         this.playerControl.initializingListener();
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doEnableTimelineRelatedStuff);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doRemoveLoadingScreen);
         if(this._shouldPauseWhenLoadingMovie)
         {
            this.doRemoveLoadingScreen();
         }
         this.endScreen.movieDuration = UtilUnitConvert.frameToSec(this.plainPlayer.getDuration());
         this.endScreen.resetUI();
      }
      
      private function goToAndPausePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Number, param5:Boolean = false) : void
      {
         this.initializeBufferExhaustListener();
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_GOTOANDPAUSE));
         }
         if(param2)
         {
            this.plainPlayer.goToAndPauseMovie(param4,param5);
         }
         if(param1)
         {
            this.playerControl.timeChangeListener(param4);
         }
      }
      
      public function set subComponents(param1:Array) : void
      {
         this._subComponents = param1;
      }
      
      private function onVolumeChange(param1:PlayerEvent) : void
      {
         var _loc2_:Number = param1.getData() as Number;
         this.setVolumeInPlainPlayer(_loc2_);
      }
      
      private function onReplayButtonClick() : void
      {
         if(this.previewSceneNum > 0)
         {
            this.loadScenePreview(this.previewSceneNum);
            this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
         }
         else if(this.firstStart)
         {
            this.play();
         }
         else
         {
            this.replay();
         }
      }
      
      public function __playerControl_onPauseButClicked(param1:Event) : void
      {
         this.onPauseButClick();
      }
      
      public function __playerControl_onPlayButClicked(param1:Event) : void
      {
         this.onPlayButClick();
      }
      
      private function startPreview() : void
      {
         _logger.debug("start Preview");
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doStartTimeFrameSynchronized);
         this.plainPlayer.initAndPreview(this._filmXML,this._themeXMLs,this._imageData);
         this.playerControl.playListener();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$startPreview: PLAYHEAD_STATE_PLAY");
         this.playerControl.enableTimeLine(true);
         this.playerControl.timeLine.liveDragging = true;
         this.firstStart = false;
      }
      
      public function turnOnLogo(param1:Boolean) : void
      {
         this.logo.buttonMode = param1;
         this.logo.enabled = param1;
         this.licensorLogo.buttonMode = param1;
         this.licensorLogo.enabled = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeMoveShow() : Parallel
      {
         return this._1690319114fadeMoveShow;
      }
      
      private function _PreviewPlayer_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("player","Create your own in minutes!");
         _loc1_ = (this.loadingScreen.width - this.createYourOwn.width) / 2;
         _loc1_ = UtilDict.toDisplay("player","Loading ...");
         _loc1_ = (this.loadingScreen.width - this.loading.width) / 2;
         _loc1_ = this.isLogoShouldBeShown();
         _loc1_ = this.isLogoShouldBeShown();
         _loc1_ = this.fadeMoveShow;
         _loc1_ = this.fadeMoveHide;
         _loc1_ = this.createYourOwn;
         _loc1_ = this.loading;
         _loc1_ = Application.application.width;
         _loc1_ = Application.application.height;
         _loc1_ = Application.application.width;
      }
      
      public function init(param1:URLRequest, param2:Array, param3:UtilHashArray) : void
      {
         this._urlRequest = param1;
         this._urlRequestArray = param2;
         this._flashVars = param3;
         this.loadMovieInfoXML();
      }
      
      public function set loadingText(param1:Text) : void
      {
         var _loc2_:Object = this._231891831loadingText;
         if(_loc2_ !== param1)
         {
            this._231891831loadingText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadingText",_loc2_,param1));
         }
      }
      
      public function destroyMC() : void
      {
         if(!this._isInited)
         {
            return;
         }
         try
         {
            if(this.plainPlayer != null)
            {
               this.plainPlayer.destroyAllScene();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function ___PreviewPlayer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
         this.curtaining();
      }
      
      public function initAndPreview(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         this._filmXML = param1;
         this._imageData = param2;
         this._themeXMLs = param3;
         this.previewMode = true;
         trace("Movie\'s XML got. The content is: " + this._filmXML);
      }
      
      [Bindable(event="propertyChange")]
      public function get endScreen() : PlayerEndScreen
      {
         return this._1593500967endScreen;
      }
      
      private function onBufferExhaust(param1:PlayerEvent) : void
      {
         this.pausePlainPlayer(false,true,false);
         this.initializeBufferReadyListener();
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this.pb)
         {
            _loc2_ = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
            this.pb.setProgress(_loc2_,100);
         }
      }
      
      public function getMovieDuration() : Number
      {
         return this.plainPlayer.getDuration();
      }
      
      public function play(param1:Boolean = false) : void
      {
         if(this.previewSceneFirstStart == false)
         {
            this.timeFrameSynchronizer.startSyn();
         }
         this.previewSceneFirstStart = false;
         if(param1)
         {
            this.plainPlayer.onAddEnterFrame();
         }
         if(this.firstStart)
         {
            this.hideEndScreen();
            this.startPlainPlayer();
         }
         else
         {
            this.resumePlainPlayer(true,true,true);
         }
         this.firstStart = false;
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$play: PLAYHEAD_STATE_PLAY");
      }
      
      [Bindable(event="propertyChange")]
      public function get loading() : Label
      {
         return this._336650556loading;
      }
      
      private function loadMovieInfoXML() : void
      {
         try
         {
            if(this.plainPlayer != null && this._flashVars != null)
            {
               this.movieInfoLoader = new UtilMovieInfoXMLLoader();
               this.movieInfoLoader.load(UtilNetwork.getGetMovieInfoRequest(this._flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID)));
               this.movieInfoLoader.addEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,this.onLoadInfoCompleted);
            }
         }
         catch(ex:Error)
         {
            trace("Error: unable to get movie info [PreviewPlayer]");
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playerControl() : PlayerControl
      {
         return this._690449604playerControl;
      }
      
      private function onNextMovieClick(param1:Event) : void
      {
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.NEXTMOVIE);
         this.dispatchEvent(_loc2_);
      }
      
      public function turnOnPauseFirstStart(param1:Number) : void
      {
         this.plainPlayer.isScenePreview(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeMoveHide() : Parallel
      {
         return this._1689992015fadeMoveHide;
      }
      
      public function set alertText(param1:Text) : void
      {
         var _loc2_:Object = this._1462422359alertText;
         if(_loc2_ !== param1)
         {
            this._1462422359alertText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alertText",_loc2_,param1));
         }
      }
      
      private function doTriggerPauseWhenMovieLoad(param1:Event) : void
      {
         if(this.plainPlayer.loadingState == PlainPlayer.MOVIE_ZIP_LOADED)
         {
            this.doRemoveLoadingScreen();
         }
         this._shouldPauseWhenLoadingMovie = true;
      }
      
      public function set logo(param1:Button) : void
      {
         var _loc2_:Object = this._3327403logo;
         if(_loc2_ !== param1)
         {
            this._3327403logo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logo",_loc2_,param1));
         }
      }
      
      public function set movieStage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1840541266movieStage;
         if(_loc2_ !== param1)
         {
            this._1840541266movieStage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieStage",_loc2_,param1));
         }
      }
      
      private function onErrorLoadingMovie(param1:PlayerEvent) : void
      {
         var _loc2_:String = param1.getData() as String;
         if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_NOT_FOUND)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errnotfound");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_DELETED)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errdeleted");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_NOT_SHARE)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errprivated");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_MODERATING)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errprocess");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_NO_ACCESS)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_err_noaccess");
         }
         else
         {
            this.alertText.text = UtilDict.toDisplay("player","player_err_miscellaneous");
         }
         this.alertText.enabled = true;
         if(this.contains(this.loadingScreen))
         {
            this.removeChild(this.loadingScreen);
            currentState = "";
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtLicenserDisclaimer() : Text
      {
         return this._1274894500txtLicenserDisclaimer;
      }
      
      private function updateLogoPosition(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.updateLogoPosition);
         if(UtilLicense.getCurrentLicenseId() == "7")
         {
            this.logo.x = -2;
            this.logo.y = 308;
         }
         else
         {
            _loc2_ = 5;
            this.logo.y = this.movieStage.height - this.logo.getBounds(this.logo).height - _loc2_;
            this.logo.x = _loc2_;
         }
      }
      
      private function isLogoShouldBeShown() : Boolean
      {
         if(Util.isVideoRecording() && Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_LOGO_HIDDEN) as String == "1")
         {
            return false;
         }
         return true;
      }
      
      private function initializeBufferReadyListener(param1:Object = null) : void
      {
         this.plainPlayer.removeEventListener(PlayerEvent.BUFFER_EXHAUST,this.onBufferExhaust);
         this.plainPlayer.removeEventListener(PlayerEvent.BUFFER_READY,this.onBufferReady);
         this.plainPlayer.addEventListener(PlayerEvent.BUFFER_READY,this.onBufferReady,false,0,true);
         this.playerControl.bufferExhaustListener();
      }
      
      private function doTellVideoRecordingSoftwareMovieStart(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doTellVideoRecordingSoftwareMovieStart);
         navigateToURL(new URLRequest("FSCommand:start"));
      }
      
      public function __logo_creationComplete(param1:FlexEvent) : void
      {
         this.updateLogoPosition(param1);
      }
      
      public function set createYourOwn(param1:Label) : void
      {
         var _loc2_:Object = this._1254676919createYourOwn;
         if(_loc2_ !== param1)
         {
            this._1254676919createYourOwn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createYourOwn",_loc2_,param1));
         }
      }
      
      private function _PreviewPlayer_Move2_c() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 500;
         _loc1_.yFrom = 324;
         _loc1_.yTo = 354;
         return _loc1_;
      }
      
      private function pausePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean = true) : void
      {
         this.initializeBufferExhaustListener();
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_PAUSE));
         }
         if(param2)
         {
            this.plainPlayer.pauseMovie(param4);
         }
         if(param1)
         {
            this.playerControl.pauseListener();
         }
      }
      
      public function get subComponents() : Array
      {
         return this._subComponents;
      }
      
      private function doStartTimeFrameSynchronized(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartTimeFrameSynchronized);
         this.timeFrameSynchronizer.startSyn();
      }
      
      private function startPlainPlayer() : void
      {
         if(this.previewMode)
         {
            this.startPreview();
         }
         else
         {
            this.startPlay();
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_START_PLAY));
      }
      
      private function onLogoClick() : void
      {
         var _loc1_:PlayerEvent = new PlayerEvent(PlayerEvent.LOGO_CLICK);
         this.dispatchEvent(_loc1_);
      }
      
      override public function initialize() : void
      {
         var target:PreviewPlayer = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._PreviewPlayer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_playerComponent_PreviewPlayerWatcherSetupUtil");
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
      
      public function turnOnVideoRecordMode() : void
      {
         this.playerControl.visible = false;
      }
      
      public function __endScreen_nor_screen(param1:PlayerEndScreenEvent) : void
      {
         this.doNorScreen();
      }
      
      public function setDisclaimer(param1:String) : void
      {
         this.txtLicenserDisclaimer.text = param1;
      }
      
      public function set loadingScreen(param1:Canvas) : void
      {
         var _loc2_:Object = this._459583688loadingScreen;
         if(_loc2_ !== param1)
         {
            this._459583688loadingScreen = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadingScreen",_loc2_,param1));
         }
      }
      
      public function loadScenePreview(param1:Number) : void
      {
         var movieBuffer:Number = NaN;
         var num:Number = param1;
         this.previewSceneNum = num;
         movieBuffer = 2;
         var myTimer:Timer = new Timer(900,1);
         this.playerControl.playPauseBut.enabled = false;
         myTimer.addEventListener("timer",function():void
         {
            playerControl.scenePreview(previewSceneNum + movieBuffer);
            setVolumeInPlainPlayer(0.5);
         });
         myTimer.start();
         this.setVolumeInPlainPlayer(0);
      }
      
      public function adSenseComplete(param1:Event) : void
      {
         param1.target.removeEventListener("ADS_COMPELTED",this.adSenseComplete);
         this.removeChild(this.curtainBox);
         this.removeChild(this.loadingText);
         this.removeChild(this.googleAdsAttribution);
         this.plainPlayer.adCompleted();
      }
      
      public function set licensorLogo(param1:Button) : void
      {
         var _loc2_:Object = this._1915233234licensorLogo;
         if(_loc2_ !== param1)
         {
            this._1915233234licensorLogo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"licensorLogo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieStage() : Canvas
      {
         return this._1840541266movieStage;
      }
      
      private function _PreviewPlayer_Move1_c() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 500;
         _loc1_.yFrom = 354;
         _loc1_.yTo = 324;
         return _loc1_;
      }
      
      public function set curtainBox(param1:Box) : void
      {
         var _loc2_:Object = this._566693337curtainBox;
         if(_loc2_ !== param1)
         {
            this._566693337curtainBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curtainBox",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get createYourOwn() : Label
      {
         return this._1254676919createYourOwn;
      }
      
      private function _PreviewPlayer_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "loadingScreenDisplayed";
         _loc1_.overrides = [this._PreviewPlayer_SetProperty1_i(),this._PreviewPlayer_SetProperty2_i()];
         return _loc1_;
      }
      
      private function _PreviewPlayer_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Create your own in minutes!");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            createYourOwn.text = param1;
         },"createYourOwn.text");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return (loadingScreen.width - createYourOwn.width) / 2;
         },function(param1:Number):void
         {
            createYourOwn.x = param1;
         },"createYourOwn.x");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Loading ...");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            loading.text = param1;
         },"loading.text");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return (loadingScreen.width - loading.width) / 2;
         },function(param1:Number):void
         {
            loading.x = param1;
         },"loading.x");
         result[3] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isLogoShouldBeShown();
         },function(param1:Boolean):void
         {
            logo.visible = param1;
         },"logo.visible");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isLogoShouldBeShown();
         },function(param1:Boolean):void
         {
            licensorLogo.visible = param1;
         },"licensorLogo.visible");
         result[5] = binding;
         binding = new Binding(this,function():*
         {
            return fadeMoveShow;
         },function(param1:*):void
         {
            playerControl.setStyle("showEffect",param1);
         },"playerControl.showEffect");
         result[6] = binding;
         binding = new Binding(this,function():*
         {
            return fadeMoveHide;
         },function(param1:*):void
         {
            playerControl.setStyle("hideEffect",param1);
         },"playerControl.hideEffect");
         result[7] = binding;
         binding = new Binding(this,function():Object
         {
            return createYourOwn;
         },function(param1:Object):void
         {
            _PreviewPlayer_SetProperty1.target = param1;
         },"_PreviewPlayer_SetProperty1.target");
         result[8] = binding;
         binding = new Binding(this,function():Object
         {
            return loading;
         },function(param1:Object):void
         {
            _PreviewPlayer_SetProperty2.target = param1;
         },"_PreviewPlayer_SetProperty2.target");
         result[9] = binding;
         binding = new Binding(this,function():Number
         {
            return Application.application.width;
         },function(param1:Number):void
         {
            curtainBox.width = param1;
         },"curtainBox.width");
         result[10] = binding;
         binding = new Binding(this,function():Number
         {
            return Application.application.height;
         },function(param1:Number):void
         {
            curtainBox.height = param1;
         },"curtainBox.height");
         result[11] = binding;
         binding = new Binding(this,function():Number
         {
            return Application.application.width;
         },function(param1:Number):void
         {
            loadingText.width = param1;
         },"loadingText.width");
         result[12] = binding;
         return result;
      }
      
      public function set mochiContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = this._1645408545mochiContainer;
         if(_loc2_ !== param1)
         {
            this._1645408545mochiContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mochiContainer",_loc2_,param1));
         }
      }
      
      public function __playerControl_full_screen(param1:PlayerEvent) : void
      {
         this.doFullScreen(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get logo() : Button
      {
         return this._3327403logo;
      }
      
      public function set timeFrameSynchronizer(param1:timeFrameSynchronizer) : void
      {
         var _loc2_:Object = this._1523976162timeFrameSynchronizer;
         if(_loc2_ !== param1)
         {
            this._1523976162timeFrameSynchronizer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timeFrameSynchronizer",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get licensorLogo() : Button
      {
         return this._1915233234licensorLogo;
      }
      
      public function __logo_click(param1:MouseEvent) : void
      {
         this.onLogoClick();
      }
      
      private function onLoadInfoCompleted(param1:Event) : void
      {
         this.plainPlayer.movieInfo = this.movieInfoLoader.info;
      }
      
      [Bindable(event="propertyChange")]
      public function get curtainBox() : Box
      {
         return this._566693337curtainBox;
      }
      
      public function __playerControl_onTimeLinePress(param1:Event) : void
      {
         this.onTimeLinePress(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get timeFrameSynchronizer() : timeFrameSynchronizer
      {
         return this._1523976162timeFrameSynchronizer;
      }
      
      private function onMovieProgress(param1:PlayerEvent) : void
      {
         var _loc2_:ProgressEvent = ProgressEvent(param1.getData());
         var _loc3_:Number = Math.round(_loc2_.bytesLoaded / _loc2_.bytesTotal * 100);
         if(this.pb != null)
         {
         }
         var _loc4_:PlayerEvent = new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS);
         this.dispatchEvent(_loc4_);
      }
      
      public function replay() : void
      {
         this.timeFrameSynchronizer.startSyn();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$replay: PLAYHEAD_STATE_PAUSE");
         this.pausePlainPlayer(true,true,true);
         this.goToAndPausePlainPlayer(true,true,true,1);
         this.plainPlayer.goToAndPauseResetMovie();
         this.resumePlainPlayer(true,true,true);
      }
      
      private function onBufferReady(param1:PlayerEvent) : void
      {
         if(this._expectedPlayHeadState == PLAYHEAD_STATE_PLAY)
         {
            this.resumePlainPlayer(false,true,false);
            this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
            trace("$$$$$$$$$$$$$$$$$$$$$$$$onBufferReady: PLAYHEAD_STATE_PLAY");
         }
         this.initializeBufferExhaustListener();
      }
      
      private function initializeBufferExhaustListener(param1:Object = null) : void
      {
         this.plainPlayer.removeEventListener(PlayerEvent.BUFFER_EXHAUST,this.onBufferExhaust);
         this.plainPlayer.addEventListener(PlayerEvent.BUFFER_EXHAUST,this.onBufferExhaust,false,0,true);
         this.plainPlayer.removeEventListener(PlayerEvent.BUFFER_READY,this.onBufferReady);
         this.playerControl.bufferReadyListener();
      }
      
      public function __playerControl_onTimeLineDrag(param1:Event) : void
      {
         this.onTimeLineDrag(param1);
      }
      
      public function destroy() : void
      {
         if(!this._isInited)
         {
            return;
         }
         try
         {
            if(this.plainPlayer != null)
            {
               this.plainPlayer.destroy();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function pause(param1:Boolean = true, param2:Boolean = false) : void
      {
         if(param2)
         {
            this.plainPlayer.onRemoveEnterFrame();
         }
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$pause: PLAYHEAD_STATE_PAUSE");
         this.pausePlainPlayer(true,true,true,param1);
      }
      
      private function onPauseButClick() : void
      {
         this.pausePlainPlayer(false,true,true);
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
         trace("$$$$$$$$$$$$$$$$$$$$$$$$onPauseButClick: PLAYHEAD_STATE_PAUSE");
      }
      
      mx_internal function _PreviewPlayer_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_PreviewPlayer_StylesInit_done)
         {
            return;
         }
         mx_internal::_PreviewPlayer_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".loadingText");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".loadingText",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontFamily = "Verdana";
               this.fontSize = 11;
            };
         }
      }
   }
}
