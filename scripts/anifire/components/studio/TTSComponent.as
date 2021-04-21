package anifire.components.studio
{
   import anifire.command.AddSpeechCommand;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.SoundThumb;
   import anifire.core.SpeechData;
   import anifire.core.sound.ImporterSoundAsset;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.TTSManager;
   import anifire.managers.FeatureManager;
   import anifire.popups.SchoolUpgradeOnTts;
   import anifire.popups.UpgradeOnTts;
   import anifire.popups.YouTubeUpgrade;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilSite;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.ComboBox;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class TTSComponent extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _text:String;
      
      public var _TTSComponent_Text1:Text;
      
      public var _TTSComponent_Text2:Text;
      
      public var _TTSComponent_Text3:Text;
      
      public var _TTSComponent_Text4:Text;
      
      public var sound:ImporterSoundAsset;
      
      private var _isActionSelected:Boolean;
      
      public var _TTSComponent_Button1:Button;
      
      public var _TTSComponent_Button2:Button;
      
      private var _1282976579helpPanel:VBox;
      
      private var _1897480864_voices:Array;
      
      private var _bottom:SpeechComponent;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _selectedVoiceIndex:int = 0;
      
      private var _bytes:ByteArray;
      
      private var _1565956469_modifiedText:Boolean = true;
      
      private var _uploadType:String = "tts";
      
      private var _1364258945_ttsText:String;
      
      private var _preview:Boolean;
      
      private var _496680559_txtConvertArea:TextArea;
      
      mx_internal var _watchers:Array;
      
      private var _1880432102editPanel:VBox;
      
      private var _voiceId:String;
      
      private var _1081571786mainVS:ViewStack;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _uploadedAssetXML:XML;
      
      private var _1359179495_cboxVoiceSelect:ComboBox;
      
      mx_internal var _bindings:Array;
      
      private var _assetId:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _isZoomSelected:Boolean;
      
      private var _662307877helpPanel4School:VBox;
      
      public function TTSComponent()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"mainVS",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 4473924;
                     this.paddingLeft = 10;
                     this.paddingRight = 10;
                     this.paddingTop = 10;
                     this.paddingBottom = 10;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"editPanel",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_txtConvertArea",
                                    "events":{"change":"___txtConvertArea_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.color = 2500134;
                                       this.fontSize = 16;
                                       this.backgroundColor = 16777215;
                                       this.borderColor = 13421772;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":90,
                                          "maxChars":140,
                                          "wordWrap":true,
                                          "editable":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_cboxVoiceSelect",
                                    "events":{"change":"___cboxVoiceSelect_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "rowCount":6,
                                          "buttonMode":true,
                                          "styleName":"cbSidePanel"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"helpPanel",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalGap = 0;
                              this.backgroundColor = 16777215;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 14;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text2",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TTSComponent_Button1",
                                    "events":{"click":"___TTSComponent_Button1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "styleName":"btnAskHelp",
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"helpPanel4School",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalGap = 0;
                              this.backgroundColor = 16777215;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text3",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 14;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text4",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TTSComponent_Button2",
                                    "events":{"click":"___TTSComponent_Button2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "styleName":"btnAskHelp",
                                          "buttonMode":true
                                       };
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
         TTSComponent._watcherSetupUtil = param1;
      }
      
      private function initVoice() : void
      {
         var _loc1_:int = 0;
         this._voices = new Array();
         this._voices.push({
            "id":"kimberly",
            "label":"Kimberly",
            "plus":false
         });
         this._voices.push({
            "id":"brian",
            "label":"Brian",
            "plus":false
         });
         this._voices.push({
            "id":"amy",
            "label":"Amy",
            "plus":false
         });
         this._voices.push({
            "id":"eric",
            "label":"Eric",
            "plus":false
         });
         if(FeatureManager.shouldGoPlusTTSVoiceBeShown)
         {
            this._voices.push({
               "id":"emma",
               "label":"Emma",
               "plus":true
            });
            this._voices.push({
               "id":"jennifer",
               "label":"Jennifer",
               "plus":true
            });
            this._voices.push({
               "id":"joey",
               "label":"Joey",
               "plus":true
            });
            this._voices.push({
               "id":"kendra",
               "label":"Kendra",
               "plus":true
            });
         }
         this._voices.push({
            "id":"Kayla",
            "label":"Kalya",
            "plus":false
         });
         this._voices.push({
            "id":"Lawrence",
            "label":"Lawrence",
            "plus":false
         });
         this._voices.push({
            "id":"David",
            "label":"David",
            "plus":false
         });
         this._voices.push({
            "id":"Callie",
            "label":"Callie",
            "plus":false
         });
         this._voices.push({
            "id":"Millie",
            "label":"Millie",
            "plus":false
         });
         this._voices.push({
            "id":"Dallas",
            "label":"Dallas",
            "plus":false
         });
         if(FeatureManager.shouldGoPlusTTSVoiceBeShown)
         {
            this._voices.push({
               "id":"Belle",
               "label":"Belle",
               "plus":true
            });
            this._voices.push({
               "id":"Diesel",
               "label":"Diesel",
               "plus":true
            });
            this._voices.push({
               "id":"Duncan",
               "label":"Duncan",
               "plus":true
            });
            this._voices.push({
               "id":"Evil Genius",
               "label":"Evil Genius",
               "plus":true
            });
            this._voices.push({
               "id":"French-fry",
               "label":"French-fry",
               "plus":true
            });
            this._voices.push({
               "id":"Kidaroo",
               "label":"Kidaroo",
               "plus":true
            });
            this._voices.push({
               "id":"Princess",
               "label":"Princess",
               "plus":true
            });
            this._voices.push({
               "id":"Conrad",
               "label":"Professor",
               "plus":true
            });
            this._voices.push({
               "id":"Robot",
               "label":"Robot",
               "plus":true
            });
            this._voices.push({
               "id":"ShyGirl",
               "label":"Shy Girl",
               "plus":true
            });
            this._voices.push({
               "id":"Damien",
               "label":"Scary Voice",
               "plus":true
            });
            this._voices.push({
               "id":"Robin",
               "label":"Tween-Girl",
               "plus":true
            });
            this._voices.push({
               "id":"Charlie",
               "label":"Young Guy",
               "plus":true
            });
            this._voices.push({
               "id":"Vixen",
               "label":"Vixen",
               "plus":true
            });
            this._voices.push({
               "id":"Wiseguy",
               "label":"Wiseguy",
               "plus":true
            });
            this._voices.push({
               "id":"Zack",
               "label":"Zack",
               "plus":true
            });
         }
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            _loc1_ = 0;
            while(_loc1_ < this._voices.length)
            {
               if(this._voices[_loc1_].plus)
               {
                  this._voices[_loc1_].label = this._voices[_loc1_].label + (" (" + UtilDict.toDisplay("go","Only with GoPlus+") + ")");
               }
               _loc1_++;
            }
         }
      }
      
      public function error(param1:Event) : void
      {
         if(param1 is HTTPStatusEvent)
         {
            if(HTTPStatusEvent(param1).status == 200)
            {
               return;
            }
         }
         this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         this.setButtonStatus(true);
         this.sound = null;
      }
      
      private function set _ttsText(param1:String) : void
      {
         var _loc2_:Object = this._1364258945_ttsText;
         if(_loc2_ !== param1)
         {
            this._1364258945_ttsText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ttsText",_loc2_,param1));
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
         var _loc9_:AnimeSound = null;
         this.initVoice();
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
                  _loc9_ = Console.getConsole().speechManager.getValueByKey(_loc4_) as AnimeSound;
                  this.loadDefaultTTSData(_loc9_.soundThumb.ttsData);
               }
            }
            else
            {
               this.resetForm();
               if(_loc3_.speechVoice != null)
               {
                  this.voiceSelect(_loc3_.speechVoice);
               }
            }
         }
         this._txtConvertArea.restrict = " -~ ^<^>^`";
         if(param1)
         {
            this._bottom = param1;
         }
      }
      
      public function ___TTSComponent_Button1_click(param1:MouseEvent) : void
      {
         this.onAskHelp();
      }
      
      [Bindable(event="propertyChange")]
      public function get editPanel() : VBox
      {
         return this._1880432102editPanel;
      }
      
      private function onVoiceChange(param1:ListEvent) : void
      {
         this._modifiedText = true;
         if(UtilUser.userType == UtilUser.BASIC_USER && this._cboxVoiceSelect.selectedItem.plus)
         {
            this._cboxVoiceSelect.selectedIndex = this._selectedVoiceIndex;
         }
         this._selectedVoiceIndex = this._cboxVoiceSelect.selectedIndex;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function ___cboxVoiceSelect_change(param1:ListEvent) : void
      {
         this.onVoiceChange(param1);
      }
      
      private function onTextChangeHandler() : void
      {
         this._modifiedText = true;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function removeSpeechAndConnection() : void
      {
         var _loc1_:String = SpeechComponent.getAssetSpeechId();
         Console.getConsole().speechManager.ttsManager.removeSoundById(_loc1_);
      }
      
      [Bindable(event="propertyChange")]
      public function get mainVS() : ViewStack
      {
         return this._1081571786mainVS;
      }
      
      private function _TTSComponent_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return _voices;
         },function(param1:Object):void
         {
            _cboxVoiceSelect.dataProvider = param1;
         },"_cboxVoiceSelect.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Text1.text = param1;
         },"_TTSComponent_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Need extra credits for your animation?");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Text2.text = param1;
         },"_TTSComponent_Text2.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Upgrade to GoPlus");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Button1.label = param1;
         },"_TTSComponent_Button1.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Text3.text = param1;
         },"_TTSComponent_Text3.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Your teacher can contact us to get more.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Text4.text = param1;
         },"_TTSComponent_Text4.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Get more credits") + " >";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _TTSComponent_Button2.label = param1;
         },"_TTSComponent_Button2.label");
         result[6] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get helpPanel4School() : VBox
      {
         return this._662307877helpPanel4School;
      }
      
      private function set _voices(param1:Array) : void
      {
         var _loc2_:Object = this._1897480864_voices;
         if(_loc2_ !== param1)
         {
            this._1897480864_voices = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_voices",_loc2_,param1));
         }
      }
      
      public function loadDefaultTTSData(param1:SpeechData) : void
      {
         this._txtConvertArea.text = param1.text;
         this.voiceSelect(param1.voice);
      }
      
      public function set editPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1880432102editPanel;
         if(_loc2_ !== param1)
         {
            this._1880432102editPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editPanel",_loc2_,param1));
         }
      }
      
      public function setButtonStatus(param1:Boolean) : void
      {
         this._txtConvertArea.editable = param1;
         this._cboxVoiceSelect.enabled = param1;
      }
      
      public function ___TTSComponent_Button2_click(param1:MouseEvent) : void
      {
         this.onAskHelp();
      }
      
      public function set helpPanel4School(param1:VBox) : void
      {
         var _loc2_:Object = this._662307877helpPanel4School;
         if(_loc2_ !== param1)
         {
            this._662307877helpPanel4School = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpPanel4School",_loc2_,param1));
         }
      }
      
      public function ___txtConvertArea_change(param1:Event) : void
      {
         this.onTextChangeHandler();
      }
      
      [Bindable(event="propertyChange")]
      public function get helpPanel() : VBox
      {
         return this._1282976579helpPanel;
      }
      
      private function closeAdvance() : void
      {
         this.currentState = "";
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtConvertArea() : TextArea
      {
         return this._496680559_txtConvertArea;
      }
      
      public function saveSoundBySoundThumb(param1:SoundThumb) : void
      {
         Console.getConsole().speechManager.ttsManager.addEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:SpeechData = new SpeechData();
         _loc2_.type = "tts";
         _loc2_.text = this._text;
         _loc2_.voice = this._voiceId;
         param1.ttsData = _loc2_;
         Console.getConsole().speechManager.addSoundByThumb(param1);
         this.setButtonStatus(true);
      }
      
      public function showLogin() : void
      {
         Console.getConsole().showLogin();
      }
      
      public function showSignup() : void
      {
         Console.getConsole().showSignup();
      }
      
      private function onSoundAdded(param1:SoundEvent) : void
      {
         var _loc15_:EffectAsset = null;
         Console.getConsole().speechManager.ttsManager.removeEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:AssetLinkage = new AssetLinkage();
         var _loc3_:Object = param1.getData();
         var _loc4_:String = _loc3_["id"];
         _loc2_.addLinkage(_loc4_);
         var _loc5_:Asset;
         var _loc6_:String = (_loc5_ = Console.getConsole().currentScene.selectedAsset).scene.id + AssetLinkage.LINK + _loc5_.id;
         _loc2_.addLinkage(_loc6_);
         Console.getConsole().linkageController.addLinkage(_loc2_);
         var _loc7_:AddSpeechCommand;
         (_loc7_ = new AddSpeechCommand(Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(_loc4_) as AnimeSound,_loc6_)).execute();
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
         Character(_loc5_).speechVoice = AnimeSound(Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(_loc4_)).soundThumb.ttsData.voice;
         this.dispatchEvent(new Event(Event.COMPLETE));
         this.init();
      }
      
      private function onAskHelp() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc1_ = PopUpManager.createPopUp(this,SchoolUpgradeOnTts,true);
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc1_ = PopUpManager.createPopUp(this,YouTubeUpgrade,true);
         }
         else
         {
            _loc1_ = PopUpManager.createPopUp(this,UpgradeOnTts,true);
         }
         _loc1_.width = 500;
         _loc1_.y = 100;
         _loc1_.x = (this.stage.width - _loc1_.width) / 2;
      }
      
      [Bindable(event="propertyChange")]
      private function get _modifiedText() : Boolean
      {
         return this._1565956469_modifiedText;
      }
      
      [Bindable(event="propertyChange")]
      private function get _ttsText() : String
      {
         return this._1364258945_ttsText;
      }
      
      public function set mainVS(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1081571786mainVS;
         if(_loc2_ !== param1)
         {
            this._1081571786mainVS = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainVS",_loc2_,param1));
         }
      }
      
      public function set helpPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1282976579helpPanel;
         if(_loc2_ !== param1)
         {
            this._1282976579helpPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpPanel",_loc2_,param1));
         }
      }
      
      public function getTextSpeechAsset() : void
      {
         var _loc1_:RegExp = new RegExp(String.fromCharCode(13),"g");
         this._text = this._txtConvertArea.text.replace(_loc1_," ");
         this._voiceId = this._cboxVoiceSelect.selectedItem.id;
         var _loc2_:URLRequest = TTSManager.getRequestOfTextToSpeech(this._text,this._voiceId);
         Util.addFlashVarsToURLvar(_loc2_.data as URLVariables);
         var _loc3_:URLStream = new URLStream();
         _loc3_.addEventListener(Event.COMPLETE,this._bottom.onSentCompleteHandler);
         _loc3_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.error);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.error);
         _loc3_.load(_loc2_);
      }
      
      override public function initialize() : void
      {
         var target:TTSComponent = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._TTSComponent_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_TTSComponentWatcherSetupUtil");
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
      
      public function saveSound(param1:ByteArray, param2:XML) : void
      {
         var _loc3_:SoundThumb = Console.getConsole().speechManager.createSoundThumbByByte(param1,param2);
         this.saveSoundBySoundThumb(_loc3_);
      }
      
      [Bindable(event="propertyChange")]
      private function get _voices() : Array
      {
         return this._1897480864_voices;
      }
      
      private function doCommit(param1:Boolean) : void
      {
         this.getTextSpeechAsset();
      }
      
      public function onSaveHandler(param1:Object) : void
      {
         this._isZoomSelected = param1["zoom"];
         this._isActionSelected = param1["action"];
         this._preview = false;
         if(this.sound != null)
         {
            this.sound.stop();
         }
         if(this._modifiedText)
         {
            this.doCommit(false);
         }
      }
      
      public function resetForm() : void
      {
         this._txtConvertArea.text = UtilDict.toDisplay("go","Type it, and your character will say it.  (Max.  120 chars)");
         this._cboxVoiceSelect.selectedIndex = 0;
      }
      
      public function voiceSelect(param1:String) : void
      {
         this._cboxVoiceSelect.selectedIndex = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._voices.length)
         {
            if(this._voices[_loc2_].id == param1)
            {
               this._cboxVoiceSelect.selectedIndex = _loc2_;
            }
            _loc2_++;
         }
      }
      
      private function _TTSComponent_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._voices;
         _loc1_ = UtilDict.toDisplay("go","Oops.");
         _loc1_ = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Need extra credits for your animation?");
         _loc1_ = UtilDict.toDisplay("go","Upgrade to GoPlus");
         _loc1_ = UtilDict.toDisplay("go","Oops.");
         _loc1_ = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Your teacher can contact us to get more.");
         _loc1_ = UtilDict.toDisplay("go","Get more credits") + " >";
      }
      
      public function set _cboxVoiceSelect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1359179495_cboxVoiceSelect;
         if(_loc2_ !== param1)
         {
            this._1359179495_cboxVoiceSelect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cboxVoiceSelect",_loc2_,param1));
         }
      }
      
      private function onConvertHandler() : void
      {
         this._preview = true;
         if(!this._modifiedText)
         {
            if(this.sound != null)
            {
               this.sound.play();
               this.setButtonStatus(true);
            }
            else
            {
               this.doCommit(true);
            }
         }
         else
         {
            this.doCommit(true);
            this._modifiedText = true;
         }
      }
      
      public function set _txtConvertArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._496680559_txtConvertArea;
         if(_loc2_ !== param1)
         {
            this._496680559_txtConvertArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtConvertArea",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cboxVoiceSelect() : ComboBox
      {
         return this._1359179495_cboxVoiceSelect;
      }
      
      private function set _modifiedText(param1:Boolean) : void
      {
         var _loc2_:Object = this._1565956469_modifiedText;
         if(_loc2_ !== param1)
         {
            this._1565956469_modifiedText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_modifiedText",_loc2_,param1));
         }
      }
      
      public function linkHandler(param1:TextEvent) : void
      {
         switch(param1.text)
         {
            case "signup":
               this.showSignup();
               break;
            case "login":
               this.showLogin();
         }
      }
      
      public function set credit(param1:Number) : void
      {
         if(param1 <= 0)
         {
            if(UtilSite.siteId == UtilSite.SCHOOL)
            {
               this.mainVS.selectedChild = this.helpPanel4School;
            }
            else
            {
               this.mainVS.selectedChild = this.helpPanel;
            }
         }
      }
      
      private function openAdvance() : void
      {
         this.currentState = "advanced";
      }
   }
}
