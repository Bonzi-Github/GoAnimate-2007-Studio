package anifire.tutorial
{
   import anifire.constant.ServerConstants;
   import anifire.core.Asset;
   import anifire.core.Console;
   import anifire.managers.FeatureManager;
   import anifire.timeline.Timeline;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.Resize;
   import mx.effects.Rotate;
   import mx.events.EffectEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class TutorialManager extends Canvas implements IBindingClient
   {
      
      mx_internal static var _TutorialManager_StylesInit_done:Boolean = false;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _actionArray:Array;
      
      private var _853725098_btnMessage:Button;
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      private const TITLE_HEIGHT:Number = 28;
      
      private var _console:IEventDispatcher;
      
      private var _myWalkerGuide:WalkerGuide;
      
      private var _543526166_txtMessage:Text;
      
      private var _523592727_effMove:Move;
      
      private var _guideMode:Boolean;
      
      private const MESSAGE_BOX_X_DEFAULT:uint = 276;
      
      private const MESSAGE_BOX_Y_DEFAULT:uint = 380;
      
      private var _ptButtonBarPos:Point = null;
      
      private var _extraData:Object;
      
      private var GUIDE_ID:String;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1549296987_boxMessage:Canvas;
      
      private var _985212102_content:VBox;
      
      private var _1480345928_cover:Canvas;
      
      private var _hasSoundGuideShown:Boolean = false;
      
      private var _ptSoundPos:Point = null;
      
      private var _804523041_effRotate:Rotate;
      
      mx_internal var _watchers:Array;
      
      private var _795265914_effResize:Resize;
      
      private var _447569799_effFadeIn:Fade;
      
      private var _1553599489filterBlur:BlurFilter;
      
      private var _1476485635_guide:Button;
      
      private var _currAction:String;
      
      private var _ptCharacterPos:Point = null;
      
      private var _currentTutorial:ITutorial;
      
      private var _206195195btnSkip:Button;
      
      private var _1266936593_overlay:Canvas;
      
      private var _1126112268_guideArrow:Button;
      
      private var _currStepNum:int;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _existingUser:Boolean;
      
      private var _xmlTutorial:XML;
      
      public var _TutorialManager_Button1:Button;
      
      private var _guide_location_y:Number = 430;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _989767980_effFadeOut:Fade;
      
      private var _729258365_guideHead:Button;
      
      public function TutorialManager()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":954,
                  "height":629,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_cover",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_boxMessage",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "clipContent":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "id":"_TutorialManager_Button1",
                              "events":{"click":"___TutorialManager_Button1_click"},
                              "stylesFactory":function():void
                              {
                                 this.right = "10";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnStopTutorial",
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"_content",
                              "stylesFactory":function():void
                              {
                                 this.horizontalAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"messageBox",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"_txtMessage",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"message",
                                             "width":400
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnMessage",
                                       "events":{"click":"___btnMessage_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnMessage",
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_guideArrow",
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"guideArrow"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_guideHead",
                              "stylesFactory":function():void
                              {
                                 this.right = "-80";
                                 this.top = "-30";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"guideHead",
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnSkip",
                     "events":{"click":"__btnSkip_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "buttonMode":true,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_guide",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"guideChar",
                           "x":700,
                           "y":480
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_overlay",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
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
         mx_internal::_TutorialManager_StylesInit();
         this.width = 954;
         this.height = 629;
         this.visible = false;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._TutorialManager_Fade1_i();
         this._TutorialManager_Fade2_i();
         this._TutorialManager_Move1_i();
         this._TutorialManager_Resize1_i();
         this._TutorialManager_Rotate1_i();
         this._TutorialManager_DropShadowFilter1_i();
         this._TutorialManager_BlurFilter1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TutorialManager._watcherSetupUtil = param1;
      }
      
      public function set _guide(param1:Button) : void
      {
         var _loc2_:Object = this._1476485635_guide;
         if(_loc2_ !== param1)
         {
            this._1476485635_guide = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guide",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSkip() : Button
      {
         return this._206195195btnSkip;
      }
      
      [Bindable(event="propertyChange")]
      public function get _guideArrow() : Button
      {
         return this._1126112268_guideArrow;
      }
      
      public function set filterBlur(param1:BlurFilter) : void
      {
         var _loc2_:Object = this._1553599489filterBlur;
         if(_loc2_ !== param1)
         {
            this._1553599489filterBlur = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"filterBlur",_loc2_,param1));
         }
      }
      
      private function _TutorialManager_Rotate1_i() : Rotate
      {
         var _loc1_:Rotate = new Rotate();
         this._effRotate = _loc1_;
         _loc1_.duration = 1000;
         return _loc1_;
      }
      
      public function set _effFadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._447569799_effFadeIn;
         if(_loc2_ !== param1)
         {
            this._447569799_effFadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effFadeIn",_loc2_,param1));
         }
      }
      
      private function updateGuideArrow(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(this._xmlTutorial.step[param1].hasOwnProperty("focus"))
         {
            _loc5_ = 0;
            _loc6_ = 0;
            if(this._xmlTutorial.step[param1].focus.@target == "lastAddedCharacter" && this._ptCharacterPos)
            {
               _loc5_ = this._ptCharacterPos.x - 47 + 361;
               _loc6_ = this._ptCharacterPos.y - 30 + 60;
            }
            else if(this._xmlTutorial.step[param1].focus.@target == "assetButtonBar" && this._ptButtonBarPos)
            {
               _loc5_ = this._ptButtonBarPos.x;
               _loc6_ = this._ptButtonBarPos.y;
            }
            else if(this._xmlTutorial.step[param1].focus.@target == "lastAddedSound" && this._ptSoundPos)
            {
               _loc5_ = this._ptSoundPos.x;
               _loc6_ = this._ptSoundPos.y;
            }
            else
            {
               _loc5_ = this._xmlTutorial.step[param1].focus.@x;
               _loc6_ = this._xmlTutorial.step[param1].focus.@y;
            }
            _loc2_ = _loc5_ - this._boxMessage.x;
            _loc3_ = _loc6_ - this._boxMessage.y;
            if(_loc2_ < 0)
            {
               _loc4_ = -90;
               _loc2_ = this.boundaryCheck(_loc2_,5 - this._guideArrow.height,this._boxMessage.width);
               _loc3_ = this.boundaryCheck(_loc3_ + this._guideArrow.width / 2,0,this._boxMessage.height);
            }
            else if(_loc3_ < 0)
            {
               _loc4_ = 0;
               _loc2_ = this.boundaryCheck(_loc2_ - this._guideArrow.width / 2,0,this._boxMessage.width - this._guideArrow.width);
               _loc3_ = this.boundaryCheck(_loc3_,5 - this._guideArrow.height,this._boxMessage.height);
            }
            else
            {
               _loc4_ = 180;
               _loc2_ = this.boundaryCheck(this._guideArrow.width,0,this._boxMessage.width);
               _loc3_ = this.boundaryCheck(_loc3_ + this._guideArrow.height - 5,5 - this._guideArrow.height,this._boxMessage.height + this._guideArrow.height);
            }
            this._guideArrow.visible = true;
         }
         else
         {
            this._guideArrow.visible = false;
         }
         this._guideArrow.x = _loc2_;
         this._guideArrow.y = _loc3_;
         this._guideArrow.rotation = _loc4_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _effMove() : Move
      {
         return this._523592727_effMove;
      }
      
      private function get myWalkerGuide() : WalkerGuide
      {
         return this._myWalkerGuide;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMessage() : Text
      {
         return this._543526166_txtMessage;
      }
      
      private function _TutorialManager_Resize1_i() : Resize
      {
         var _loc1_:Resize = new Resize();
         this._effResize = _loc1_;
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _overlay() : Canvas
      {
         return this._1266936593_overlay;
      }
      
      private function onMoveEffectEnd(param1:Event) : void
      {
         this._overlay.graphics.clear();
      }
      
      private function _TutorialManager_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this._effMove = _loc1_;
         _loc1_.duration = 1000;
         _loc1_.addEventListener("effectStart",this.___effMove_effectStart);
         _loc1_.addEventListener("effectEnd",this.___effMove_effectEnd);
         return _loc1_;
      }
      
      public function set btnSkip(param1:Button) : void
      {
         var _loc2_:Object = this._206195195btnSkip;
         if(_loc2_ !== param1)
         {
            this._206195195btnSkip = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSkip",_loc2_,param1));
         }
      }
      
      private function updateEventListener() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._currStepNum > 0)
         {
            _loc1_ = this._xmlTutorial.step[this._currStepNum - 1].event.@type;
            _loc2_ = this._xmlTutorial.step[this._currStepNum].event.@type;
            if(this._console)
            {
               this._console.removeEventListener(_loc1_,this.onStepDone);
               this._console.addEventListener(_loc2_,this.onStepDone);
            }
         }
      }
      
      public function set _guideArrow(param1:Button) : void
      {
         var _loc2_:Object = this._1126112268_guideArrow;
         if(_loc2_ !== param1)
         {
            this._1126112268_guideArrow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guideArrow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effRotate() : Rotate
      {
         return this._804523041_effRotate;
      }
      
      public function ___effMove_effectStart(param1:EffectEvent) : void
      {
         this.onMoveEffectStart(param1);
      }
      
      public function set _effMove(param1:Move) : void
      {
         var _loc2_:Object = this._523592727_effMove;
         if(_loc2_ !== param1)
         {
            this._523592727_effMove = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effMove",_loc2_,param1));
         }
      }
      
      public function set _overlay(param1:Canvas) : void
      {
         var _loc2_:Object = this._1266936593_overlay;
         if(_loc2_ !== param1)
         {
            this._1266936593_overlay = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_overlay",_loc2_,param1));
         }
      }
      
      private function set myWalkerGuide(param1:WalkerGuide) : void
      {
         this._myWalkerGuide = param1;
      }
      
      public function set _filterShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._18423959_filterShadow;
         if(_loc2_ !== param1)
         {
            this._18423959_filterShadow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_filterShadow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _content() : VBox
      {
         return this._985212102_content;
      }
      
      [Bindable(event="propertyChange")]
      public function get _effFadeOut() : Fade
      {
         return this._989767980_effFadeOut;
      }
      
      private function onTutorialEnd() : void
      {
         this._guideMode = false;
         this.visible = false;
         this.claimTutorialBadges();
         var _loc1_:TutorialEvent = new TutorialEvent(TutorialEvent.TUTORIAL_DONE,!!this._extraData?this._extraData:null);
         this.dispatchEvent(_loc1_);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialCompleted");
         }
      }
      
      public function ___effMove_effectEnd(param1:EffectEvent) : void
      {
         this.onMoveEffectEnd(param1);
      }
      
      public function set _txtMessage(param1:Text) : void
      {
         var _loc2_:Object = this._543526166_txtMessage;
         if(_loc2_ !== param1)
         {
            this._543526166_txtMessage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMessage",_loc2_,param1));
         }
      }
      
      public function set _effRotate(param1:Rotate) : void
      {
         var _loc2_:Object = this._804523041_effRotate;
         if(_loc2_ !== param1)
         {
            this._804523041_effRotate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effRotate",_loc2_,param1));
         }
      }
      
      public function startSoundTutorial(param1:Timeline, param2:Object = null) : void
      {
         this._extraData = param2;
         if(!this._hasSoundGuideShown)
         {
            this._currStepNum = 0;
            this.GUIDE_ID = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE_CC);
            this._currentTutorial = new SoundGuide();
            this._xmlTutorial = this._currentTutorial.data;
            this._ptSoundPos = new Point(param1.x + 72,param1.y);
            this.visible = true;
            this._effResize.duration = 0;
            this.stage.addEventListener(Event.RESIZE,this.onStageResize);
            this.onStageResize();
            this._hasSoundGuideShown = true;
            this.nextStep();
         }
         else
         {
            this.onTutorialEnd();
         }
      }
      
      private function _TutorialManager_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this._effFadeOut = _loc1_;
         _loc1_.duration = 1000;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         return _loc1_;
      }
      
      public function set _btnMessage(param1:Button) : void
      {
         var _loc2_:Object = this._853725098_btnMessage;
         if(_loc2_ !== param1)
         {
            this._853725098_btnMessage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMessage",_loc2_,param1));
         }
      }
      
      public function set _effFadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._989767980_effFadeOut;
         if(_loc2_ !== param1)
         {
            this._989767980_effFadeOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effFadeOut",_loc2_,param1));
         }
      }
      
      public function ___TutorialManager_Button1_click(param1:MouseEvent) : void
      {
         this.onTutorialEnd();
      }
      
      public function set _guideHead(param1:Button) : void
      {
         var _loc2_:Object = this._729258365_guideHead;
         if(_loc2_ !== param1)
         {
            this._729258365_guideHead = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guideHead",_loc2_,param1));
         }
      }
      
      private function nextStep(param1:TutorialEvent = null) : void
      {
         if(this._currStepNum >= this._xmlTutorial.step.length())
         {
            this.onTutorialEnd();
            return;
         }
         if(param1 && param1.data is Asset)
         {
            this._ptCharacterPos = new Point(param1.data.x,param1.data.y);
            this._ptButtonBarPos = new Point(Console.getConsole().mainStage._assetButtonBar.x + 311 + 10,Console.getConsole().mainStage._assetButtonBar.y + 36 + 20);
         }
         this.updateMessageBox(param1);
         this.updateGuideArrow(this._currStepNum);
         this.updateCover();
         this.updateGuideCharacter();
         this.updateEventListener();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialStep",this._currStepNum);
         }
         ++this._currStepNum;
      }
      
      public function __btnSkip_click(param1:MouseEvent) : void
      {
         this.nextStep();
      }
      
      private function _TutorialManager_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         this._filterShadow = _loc1_;
         _loc1_.distance = 10;
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.angle = 45;
         _loc1_.color = 0;
         _loc1_.alpha = 0.5;
         return _loc1_;
      }
      
      private function _TutorialManager_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = [this.filterBlur];
         _loc1_ = this._effMove;
         _loc1_ = [this._filterShadow];
         _loc1_ = UtilDict.toDisplay("go","Stop Tutorial") + " x";
         _loc1_ = this._content.height - 8;
         _loc1_ = FeatureManager.shouldStopTutorialButtonBeShown;
         _loc1_ = this._effResize;
         _loc1_ = UtilDict.toDisplay("go","Continue") + " >";
         _loc1_ = this._effMove;
         _loc1_ = this._effFadeIn;
         _loc1_ = this._effFadeOut;
         _loc1_ = UtilDict.toDisplay("go","Skip") + " >";
         _loc1_ = this._effFadeIn;
         _loc1_ = this._effFadeOut;
      }
      
      private function onStepDone(param1:TutorialEvent) : void
      {
         var _loc2_:String = null;
         if(this._currStepNum > 0)
         {
            _loc2_ = this._xmlTutorial.step[this._currStepNum - 1].event.@type;
            if(param1.type == _loc2_)
            {
               this.nextStep(param1);
            }
         }
      }
      
      private function updateCover() : void
      {
         var _loc1_:XML = null;
         this._cover.graphics.clear();
         this._cover.graphics.beginFill(0,0.5);
         this._cover.graphics.drawRect(0,0,this.width,this.height);
         if(this._xmlTutorial.step[this._currStepNum])
         {
            for each(_loc1_ in this._xmlTutorial.step[this._currStepNum].uncover.rect)
            {
               this._cover.graphics.drawRect(_loc1_.@x,_loc1_.@y,_loc1_.@w,_loc1_.@h);
            }
         }
         this._cover.graphics.endFill();
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxMessage() : Canvas
      {
         return this._1549296987_boxMessage;
      }
      
      public function set _content(param1:VBox) : void
      {
         var _loc2_:Object = this._985212102_content;
         if(_loc2_ !== param1)
         {
            this._985212102_content = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_content",_loc2_,param1));
         }
      }
      
      public function set _cover(param1:Canvas) : void
      {
         var _loc2_:Object = this._1480345928_cover;
         if(_loc2_ !== param1)
         {
            this._1480345928_cover = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cover",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effResize() : Resize
      {
         return this._795265914_effResize;
      }
      
      private function onClaimBadgesComplete(param1:Event) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _effFadeIn() : Fade
      {
         return this._447569799_effFadeIn;
      }
      
      private function claimTutorialBadges() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = UtilNetwork.addTutorialGoPoint(-1);
         _loc1_.addEventListener(Event.COMPLETE,this.onClaimBadgesComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onClaimBadgesFail);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onClaimBadgesFail);
         _loc1_.load(_loc2_);
      }
      
      [Bindable(event="propertyChange")]
      public function get _guideHead() : Button
      {
         return this._729258365_guideHead;
      }
      
      override public function initialize() : void
      {
         var target:TutorialManager = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._TutorialManager_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_tutorial_TutorialManagerWatcherSetupUtil");
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
      
      private function _TutorialManager_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this._effFadeIn = _loc1_;
         _loc1_.duration = 1000;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _filterShadow() : DropShadowFilter
      {
         return this._18423959_filterShadow;
      }
      
      private function _TutorialManager_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Array
         {
            return [filterBlur];
         },function(param1:Array):void
         {
            _cover.filters = param1;
         },"_cover.filters");
         result[0] = binding;
         binding = new Binding(this,function():*
         {
            return _effMove;
         },function(param1:*):void
         {
            _boxMessage.setStyle("moveEffect",param1);
         },"_boxMessage.moveEffect");
         result[1] = binding;
         binding = new Binding(this,function():Array
         {
            return [_filterShadow];
         },function(param1:Array):void
         {
            _boxMessage.filters = param1;
         },"_boxMessage.filters");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Stop Tutorial") + " x";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TutorialManager_Button1.label = param1;
         },"_TutorialManager_Button1.label");
         result[3] = binding;
         binding = new Binding(this,function():Number
         {
            return _content.height - 8;
         },function(param1:Number):void
         {
            _TutorialManager_Button1.y = param1;
         },"_TutorialManager_Button1.y");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldStopTutorialButtonBeShown;
         },function(param1:Boolean):void
         {
            _TutorialManager_Button1.visible = param1;
         },"_TutorialManager_Button1.visible");
         result[5] = binding;
         binding = new Binding(this,function():*
         {
            return _effResize;
         },function(param1:*):void
         {
            _content.setStyle("resizeEffect",param1);
         },"_content.resizeEffect");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Continue") + " >";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnMessage.label = param1;
         },"_btnMessage.label");
         result[7] = binding;
         binding = new Binding(this,function():*
         {
            return _effMove;
         },function(param1:*):void
         {
            _guideArrow.setStyle("moveEffect",param1);
         },"_guideArrow.moveEffect");
         result[8] = binding;
         binding = new Binding(this,function():*
         {
            return _effFadeIn;
         },function(param1:*):void
         {
            _guideHead.setStyle("showEffect",param1);
         },"_guideHead.showEffect");
         result[9] = binding;
         binding = new Binding(this,function():*
         {
            return _effFadeOut;
         },function(param1:*):void
         {
            _guideHead.setStyle("hideEffect",param1);
         },"_guideHead.hideEffect");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Skip") + " >";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnSkip.label = param1;
         },"btnSkip.label");
         result[11] = binding;
         binding = new Binding(this,function():*
         {
            return _effFadeIn;
         },function(param1:*):void
         {
            _guide.setStyle("showEffect",param1);
         },"_guide.showEffect");
         result[12] = binding;
         binding = new Binding(this,function():*
         {
            return _effFadeOut;
         },function(param1:*):void
         {
            _guide.setStyle("hideEffect",param1);
         },"_guide.hideEffect");
         result[13] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMessage() : Button
      {
         return this._853725098_btnMessage;
      }
      
      private function _TutorialManager_BlurFilter1_i() : BlurFilter
      {
         var _loc1_:BlurFilter = new BlurFilter();
         this.filterBlur = _loc1_;
         _loc1_.blurX = 5;
         _loc1_.blurY = 5;
         return _loc1_;
      }
      
      public function get currStepNum() : int
      {
         return this._currStepNum;
      }
      
      private function updateGuideCharacter() : void
      {
         if(this._currStepNum == 0 || this._currStepNum > 0 && this._xmlTutorial.step[this._currStepNum].guide.@action != this._xmlTutorial.step[this._currStepNum - 1].guide.@action)
         {
            this.loadCharacter(this.GUIDE_ID,this._xmlTutorial.step[this._currStepNum].guide.@action);
         }
         this._guide.visible = this._xmlTutorial.step[this._currStepNum].guide.@visible == "true";
         this._guideHead.visible = this._xmlTutorial.step[this._currStepNum].guide.@visible != "true";
         if(this._currStepNum + 1 == 1 || this._currStepNum + 1 == 2 || this._currStepNum + 1 == this._xmlTutorial.step.length())
         {
            this._guide.y = 180;
         }
         else
         {
            this._guide.y = 280;
         }
      }
      
      public function get guideMode() : Boolean
      {
         return this._guideMode;
      }
      
      mx_internal function _TutorialManager_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TutorialManager_StylesInit_done)
         {
            return;
         }
         mx_internal::_TutorialManager_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".btnMessage");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnMessage",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.color = 16777215;
               this.cornerRadius = 10;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [39423,39423];
               this.fillAlphas = [1,1];
            };
         }
         style = StyleManager.getStyleDeclaration(".message");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".message",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.fontSize = 18;
            };
         }
         style = StyleManager.getStyleDeclaration(".btnStopTutorial");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnStopTutorial",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.paddingTop = 10;
               this.borderColor = 4742946;
               this.color = 2635279;
               this.borderThickness = 1;
               this.cornerRadius = 10;
               this.highlightAlphas = [0,0];
               this.fontSize = 12;
               this.fillColors = [4742946,4742946,5730604,5730604];
               this.fillAlphas = [1,1];
               this.themeColor = 4742946;
            };
         }
         style = StyleManager.getStyleDeclaration(".messageBox");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".messageBox",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 16777215;
               this.paddingTop = 10;
               this.backgroundColor = 8963870;
               this.cornerRadius = 10;
               this.borderThickness = 5;
               this.paddingLeft = 10;
               this.paddingBottom = 10;
               this.paddingRight = 10;
            };
         }
      }
      
      public function set _boxMessage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1549296987_boxMessage;
         if(_loc2_ !== param1)
         {
            this._1549296987_boxMessage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxMessage",_loc2_,param1));
         }
      }
      
      public function set console(param1:IEventDispatcher) : void
      {
         this._console = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cover() : Canvas
      {
         return this._1480345928_cover;
      }
      
      public function ___btnMessage_click(param1:MouseEvent) : void
      {
         this.nextStep();
      }
      
      private function onMoveEffectStart(param1:Event) : void
      {
         this._overlay.graphics.clear();
         this._overlay.graphics.beginFill(0,0);
         this._overlay.graphics.drawRect(0,0,this.width,this.height);
         this._overlay.graphics.endFill();
      }
      
      private function loadCharacter(param1:String, param2:String) : void
      {
      }
      
      public function startTutorial(param1:int = 0, param2:Boolean = true, param3:Boolean = false, param4:Object = null) : void
      {
         this.GUIDE_ID = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE_CC);
         this._currStepNum = param1;
         this._guideMode = param2;
         this._existingUser = param3;
         this._extraData = param4;
         this._actionArray = new Array();
         if(!this._guideMode)
         {
         }
         this._currentTutorial = new BasicTutorial();
         this._xmlTutorial = this._currentTutorial.data;
         this.visible = true;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialStarted");
         }
         this.nextStep();
      }
      
      public function get hasSoundGuideShown() : Boolean
      {
         return this._hasSoundGuideShown;
      }
      
      private function onClaimBadgesFail(param1:Event) : void
      {
      }
      
      private function updateMessageBox(param1:TutorialEvent = null) : void
      {
         this._txtMessage.htmlText = UtilDict.toDisplay("go",this._xmlTutorial.step[this._currStepNum].message);
         this._boxMessage.validateNow();
         if(this._xmlTutorial.step[this._currStepNum].focus.@target == "lastAddedCharacter" && this._ptCharacterPos)
         {
            this._boxMessage.x = this._ptCharacterPos.x - 47 + 361 - 400;
            this._boxMessage.y = this._ptCharacterPos.y - 30 + 60 + 100;
         }
         else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "assetButtonBar" && this._ptButtonBarPos)
         {
            this._boxMessage.x = this._ptButtonBarPos.x - 400;
            this._boxMessage.y = this._ptButtonBarPos.y + 50;
         }
         else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "lastAddedSound" && this._ptSoundPos)
         {
            this._boxMessage.height = 347;
            this._boxMessage.x = this._ptSoundPos.x;
            this._boxMessage.y = this._ptSoundPos.y - this._boxMessage.height;
         }
         else
         {
            this._boxMessage.x = this._xmlTutorial.step[this._currStepNum].message.@x;
            this._boxMessage.y = this._xmlTutorial.step[this._currStepNum].message.@y;
         }
         this._btnMessage.visible = this._btnMessage.includeInLayout = this._xmlTutorial.step[this._currStepNum].event.@type == MouseEvent.CLICK;
         if(this._currStepNum + 1 == this._xmlTutorial.step.length() && this._xmlTutorial.step[this._currStepNum].focus.@target != "lastAddedSound")
         {
         }
      }
      
      private function onStageResize(param1:Event = null) : void
      {
         this.updateCover();
      }
      
      public function set _effResize(param1:Resize) : void
      {
         var _loc2_:Object = this._795265914_effResize;
         if(_loc2_ !== param1)
         {
            this._795265914_effResize = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effResize",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _guide() : Button
      {
         return this._1476485635_guide;
      }
      
      private function boundaryCheck(param1:Number, param2:Number = -9999999, param3:Number = 9999999) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get filterBlur() : BlurFilter
      {
         return this._1553599489filterBlur;
      }
   }
}
