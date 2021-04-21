package anifire.components.studio
{
   import anifire.command.AddSpeechCommand;
   import anifire.component.TimerDisplay;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.MicRecordingHelper;
   import anifire.core.SoundThumb;
   import anifire.core.SpeechData;
   import anifire.core.sound.MicRecordingManager;
   import anifire.core.sound.SoundEvent;
   import anifire.events.MicLevelEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilURLStream;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.HSlider;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.VRule;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   
   use namespace mx_internal;
   
   public class MicRecordingComponent extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _watchers:Array;
      
      private var _238961815_slideBg:Canvas;
      
      private var _isActionSelected:Boolean;
      
      private var _214400986_hbSlider:HBox;
      
      private var _1105747804_mainBtn:ViewStack;
      
      private var _1672197220_timerDisplay:TimerDisplay;
      
      private var _1730538689_btnStop:Canvas;
      
      private var _1471410550_meter:Canvas;
      
      private var _1652681086_pitchSlider:HSlider;
      
      private var _bottom:SpeechComponent;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _helper:MicRecordingHelper;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1329648051_btnRec:Canvas;
      
      public var _MicRecordingComponent_Label1:Label;
      
      private var _1730636175_btnPlay:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _isZoomSelected:Boolean;
      
      public function MicRecordingComponent()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.backgroundColor = 13421772;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingBottom = 5;
                                       this.paddingTop = 5;
                                       this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":HBox,
                                          "stylesFactory":function():void
                                          {
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
                                             this.horizontalGap = 10;
                                             this.paddingLeft = 12;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"_mainBtn",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"_btnRec",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___MicRecordingComponent_Button1_click"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "label":"",
                                                                  "styleName":"btnMicRec",
                                                                  "buttonMode":true,
                                                                  "useHandCursor":true
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"_btnStop",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___MicRecordingComponent_Button2_click"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "label":"",
                                                                  "styleName":"btnMicStop",
                                                                  "buttonMode":true,
                                                                  "useHandCursor":true
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   })]};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "events":{"creationComplete":"___MicRecordingComponent_Canvas5_creationComplete"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentHeight":90,
                                                      "width":16,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_meter",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.backgroundColor = 32768;
                                                            this.bottom = "0";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentHeight":5,
                                                               "width":8,
                                                               "x":4
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentHeight":95,
                                                      "width":1
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.horizontalAlign = "center";
                                                   this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentHeight":100,
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Spacer,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"height":16};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "events":{"creationComplete":"___MicRecordingComponent_Canvas7_creationComplete"},
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":TimerDisplay,
                                                               "id":"_timerDisplay"
                                                            })]};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_MicRecordingComponent_Label1"
                                                      })]
                                                   };
                                                }
                                             })]};
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_hbSlider",
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = -5;
                              this.backgroundColor = 8306713;
                              this.paddingTop = 8;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":42,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_slideBg",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":230,
                                          "height":28,
                                          "styleName":"pitchSliderBg",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HSlider,
                                             "id":"_pitchSlider",
                                             "events":{"change":"___pitchSlider_change"},
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalCenter = "1";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "y":6,
                                                   "percentWidth":72,
                                                   "maximum":4,
                                                   "minimum":-4,
                                                   "value":0,
                                                   "showDataTip":false
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_btnPlay",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "events":{"click":"___MicRecordingComponent_Button3_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnMicPlay",
                                                "buttonMode":true,
                                                "useHandCursor":true,
                                                "width":26,
                                                "height":26
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MicRecordingComponent._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pitchSlider() : HSlider
      {
         return this._1652681086_pitchSlider;
      }
      
      private function updateTimer(param1:TimerEvent) : void
      {
         this._timerDisplay.setSingleTime(this.helper.timer.currentCount);
      }
      
      public function set _btnStop(param1:Canvas) : void
      {
         var _loc2_:Object = this._1730538689_btnStop;
         if(_loc2_ !== param1)
         {
            this._1730538689_btnStop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnStop",_loc2_,param1));
         }
      }
      
      private function error(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.error);
         this.dispatchEvent(new Event(UtilURLStream.TIME_OUT));
      }
      
      [Bindable(event="propertyChange")]
      public function get _meter() : Canvas
      {
         return this._1471410550_meter;
      }
      
      private function onClickStop(param1:Event = null) : void
      {
         this.helper.stopRecordHandler();
         this._mainBtn.selectedChild = this._btnRec;
         this.highlightSlider(true);
      }
      
      public function onClickSave(param1:Object) : void
      {
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         this.onClickStop();
         this._isZoomSelected = param1["zoom"];
         this._isActionSelected = param1["action"];
         var _loc2_:ByteArray = this.helper.getWaveByteArray();
         if(_loc2_ != null)
         {
            _loc3_ = MicRecordingManager.getRequestOfMicRecording(_loc2_);
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this._bottom.onSentCompleteHandler);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.error);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.error);
            _loc4_.load(_loc3_);
            this.highlightSlider(false);
         }
         else
         {
            this.dispatchEvent(new Event(Event.CLOSE));
         }
      }
      
      public function init(param1:SpeechComponent = null) : void
      {
         var _loc3_:Character = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         this.resetForm();
         var _loc2_:Asset = Console.getConsole().currentScene.selectedAsset;
         if(_loc2_ is Character)
         {
            _loc3_ = _loc2_ as Character;
            if((_loc4_ = SpeechComponent.getAssetSpeechId()) != "")
            {
               _loc7_ = (_loc6_ = (_loc5_ = SpeechComponent.getAssetIdBySpeechId(_loc4_)).split(AssetLinkage.LINK))[0];
               _loc8_ = _loc6_[1];
               if(_loc3_.scene.id == _loc7_ && _loc3_.id == _loc8_)
               {
               }
            }
         }
         if(param1)
         {
            this._bottom = param1;
         }
      }
      
      public function saveSound(param1:ByteArray, param2:XML) : void
      {
         var _loc3_:SoundThumb = Console.getConsole().speechManager.createSoundThumbByByte(param1,param2);
         this.saveSoundBySoundThumb(_loc3_);
      }
      
      public function set _pitchSlider(param1:HSlider) : void
      {
         var _loc2_:Object = this._1652681086_pitchSlider;
         if(_loc2_ !== param1)
         {
            this._1652681086_pitchSlider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pitchSlider",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _timerDisplay() : TimerDisplay
      {
         return this._1672197220_timerDisplay;
      }
      
      public function ___MicRecordingComponent_Button2_click(param1:MouseEvent) : void
      {
         this.onClickStop();
      }
      
      private function onClickRecord() : void
      {
         trace("on click record  ");
         this.helper.startRecHandler();
         this._mainBtn.selectedChild = this._btnStop;
         this.highlightSlider(false);
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function updateMeterByEvent(param1:MicLevelEvent) : void
      {
         var _loc2_:Number = param1.level;
         this._meter.height = _loc2_;
      }
      
      private function _MicRecordingComponent_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Max. 20 sec.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MicRecordingComponent_Label1.text = param1;
         },"_MicRecordingComponent_Label1.text");
         result[0] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _slideBg() : Canvas
      {
         return this._238961815_slideBg;
      }
      
      private function pitchUpdate() : void
      {
         this.helper.pitchShiftFactor = this._pitchSlider.value;
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainBtn() : ViewStack
      {
         return this._1105747804_mainBtn;
      }
      
      public function ___pitchSlider_change(param1:SliderEvent) : void
      {
         this.pitchUpdate();
      }
      
      public function get helper() : MicRecordingHelper
      {
         return this._helper;
      }
      
      private function removeSpeechAndConnection() : void
      {
         var _loc1_:String = SpeechComponent.getAssetSpeechId();
         Console.getConsole().speechManager.micRecordingManager.removeSoundById(_loc1_);
      }
      
      private function drawBg(param1:Event) : void
      {
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         _loc2_.graphics.clear();
         _loc2_.graphics.beginFill(6710886);
         _loc2_.graphics.drawRoundRect(0,0,_loc2_.width,_loc2_.height,10,10);
         _loc2_.graphics.endFill();
      }
      
      public function set _meter(param1:Canvas) : void
      {
         var _loc2_:Object = this._1471410550_meter;
         if(_loc2_ !== param1)
         {
            this._1471410550_meter = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_meter",_loc2_,param1));
         }
      }
      
      public function set _timerDisplay(param1:TimerDisplay) : void
      {
         var _loc2_:Object = this._1672197220_timerDisplay;
         if(_loc2_ !== param1)
         {
            this._1672197220_timerDisplay = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timerDisplay",_loc2_,param1));
         }
      }
      
      public function resetForm() : void
      {
         this._helper = new MicRecordingHelper();
         this.helper.addEventListener(TimerEvent.TIMER,this.updateTimer);
         this.helper.addEventListener(TimerEvent.TIMER_COMPLETE,this.onClickStop);
         this.helper.addEventListener(MicLevelEvent.ACTIVITY_LEVEL,this.updateMeterByEvent);
         this._timerDisplay.setSingleTime(0);
         this._mainBtn.selectedChild = this._btnRec;
         this.highlightSlider(false);
      }
      
      public function ___MicRecordingComponent_Canvas7_creationComplete(param1:FlexEvent) : void
      {
         this.drawBg(param1);
      }
      
      private function onClickPlay() : void
      {
         this.helper.playRecordHandler();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnStop() : Canvas
      {
         return this._1730538689_btnStop;
      }
      
      public function highlightSlider(param1:Boolean) : void
      {
         if(param1)
         {
            this._hbSlider.setStyle("backgroundColor","0x7EC019");
            this._hbSlider.enabled = true;
            this._btnPlay.enabled = true;
            this._slideBg.styleName = "pitchSliderBg";
         }
         else
         {
            this._hbSlider.setStyle("backgroundColor","0xCCCCCC");
            this._hbSlider.enabled = false;
            this._btnPlay.enabled = false;
            this._slideBg.styleName = "pitchSliderBgDisabled";
         }
      }
      
      public function setButtonStatus(param1:Boolean) : void
      {
      }
      
      public function set _mainBtn(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1105747804_mainBtn;
         if(_loc2_ !== param1)
         {
            this._1105747804_mainBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRec() : Canvas
      {
         return this._1329648051_btnRec;
      }
      
      public function endRecording() : void
      {
         if(this.helper != null)
         {
            this.helper.endRecording();
         }
      }
      
      private function openAdvance() : void
      {
         this.currentState = "advanced";
      }
      
      public function set _slideBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._238961815_slideBg;
         if(_loc2_ !== param1)
         {
            this._238961815_slideBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_slideBg",_loc2_,param1));
         }
      }
      
      public function set helper(param1:MicRecordingHelper) : void
      {
         this._helper = param1;
      }
      
      public function ___MicRecordingComponent_Button1_click(param1:MouseEvent) : void
      {
         this.onClickRecord();
      }
      
      public function ___MicRecordingComponent_Button3_click(param1:MouseEvent) : void
      {
         this.onClickPlay();
      }
      
      [Bindable(event="propertyChange")]
      public function get _hbSlider() : HBox
      {
         return this._214400986_hbSlider;
      }
      
      public function set _btnPlay(param1:Canvas) : void
      {
         var _loc2_:Object = this._1730636175_btnPlay;
         if(_loc2_ !== param1)
         {
            this._1730636175_btnPlay = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPlay",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:MicRecordingComponent = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._MicRecordingComponent_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MicRecordingComponentWatcherSetupUtil");
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
      
      public function ___MicRecordingComponent_Canvas5_creationComplete(param1:FlexEvent) : void
      {
         this.drawBg(param1);
      }
      
      public function set _btnRec(param1:Canvas) : void
      {
         var _loc2_:Object = this._1329648051_btnRec;
         if(_loc2_ !== param1)
         {
            this._1329648051_btnRec = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRec",_loc2_,param1));
         }
      }
      
      private function closeAdvance() : void
      {
         this.currentState = "";
      }
      
      private function _MicRecordingComponent_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Max. 20 sec.");
      }
      
      private function onSoundAdded(param1:SoundEvent) : void
      {
         var _loc15_:EffectAsset = null;
         Console.getConsole().speechManager.micRecordingManager.removeEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:AssetLinkage = new AssetLinkage();
         var _loc3_:Object = param1.getData();
         var _loc4_:String = _loc3_["id"];
         _loc2_.addLinkage(_loc4_);
         var _loc5_:Asset;
         var _loc6_:String = (_loc5_ = Console.getConsole().currentScene.selectedAsset).scene.id + AssetLinkage.LINK + _loc5_.id;
         _loc2_.addLinkage(_loc6_);
         Console.getConsole().linkageController.addLinkage(_loc2_);
         var _loc7_:AddSpeechCommand;
         (_loc7_ = new AddSpeechCommand(Console.getConsole().speechManager.micRecordingManager.sounds.getValueByKey(_loc4_) as AnimeSound,_loc6_)).execute();
         var _loc8_:Boolean = false;
         var _loc9_:UtilHashArray;
         var _loc10_:int = (_loc9_ = Console.getConsole().currentScene.effects).length - 1;
         while(_loc10_ >= 0)
         {
            if((_loc15_ = _loc9_.getValueByIndex(_loc10_) as EffectAsset).fromSpeech)
            {
               _loc8_ = true;
            }
            _loc10_--;
         }
         if(this._isZoomSelected && !_loc8_)
         {
            Console.getConsole().addCutEffectonChar(Character(_loc5_));
         }
         Character(_loc5_).demoSpeech = true;
         var _loc11_:Boolean = false;
         if(this._isActionSelected)
         {
            _loc11_ = Character(_loc5_).changeActionAsTalk();
         }
         if(!_loc11_)
         {
            Character(_loc5_).reloadAssetImage();
         }
         var _loc12_:Number = Util.roundNum(_loc3_["duration"] as Number);
         var _loc13_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.doUpdateTimelineLength(UtilUnitConvert.secToPixel(_loc12_),true);
         var _loc14_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.updateEffectTray(_loc14_,_loc13_);
         Console.getConsole().currentScene.refreshEffectTray();
         this.dispatchEvent(new Event(Event.COMPLETE));
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPlay() : Canvas
      {
         return this._1730636175_btnPlay;
      }
      
      public function saveSoundBySoundThumb(param1:SoundThumb) : void
      {
         Console.getConsole().speechManager.micRecordingManager.addEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:SpeechData = new SpeechData();
         _loc2_.type = "mic";
         param1.ttsData = _loc2_;
         Console.getConsole().speechManager.addSoundByThumb(param1);
      }
      
      public function set _hbSlider(param1:HBox) : void
      {
         var _loc2_:Object = this._214400986_hbSlider;
         if(_loc2_ !== param1)
         {
            this._214400986_hbSlider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hbSlider",_loc2_,param1));
         }
      }
   }
}
