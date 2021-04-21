package anifire.components.studio
{
   import anifire.command.RemoveSpeechCommand;
   import anifire.component.TextButton;
   import anifire.component.UploadHelper;
   import anifire.component.VolumeButton;
   import anifire.constant.ServerConstants;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.SoundThumb;
   import anifire.core.sound.ImporterSoundAsset;
   import anifire.core.sound.TTSManager;
   import anifire.event.ExtraDataEvent;
   import anifire.managers.FeatureManager;
   import anifire.popups.GoPopUp;
   import anifire.popups.SchoolUpgradeOnTts;
   import anifire.popups.UpgradeOnTts;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.Util;
   import anifire.util.UtilColor;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNavigate;
   import anifire.util.UtilSite;
   import anifire.util.UtilURLStream;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.Container;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.states.Transition;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class SpeechComponent extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _child:Container;
      
      private var _1496708709micRecordComponent:MicRecordingComponent;
      
      private var _soundBytes:ByteArray;
      
      public var _SpeechComponent_Move1:Move;
      
      public var _SpeechComponent_Move2:Move;
      
      private var _1325312007_boxAdv:Canvas;
      
      private var _1730990113_btnDown:Button;
      
      public var _SpeechComponent_Parallel1:Parallel;
      
      public var _SpeechComponent_Parallel2:Parallel;
      
      private var _1523220375_images:ObjectProxy;
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _SpeechComponent_SetProperty1:SetProperty;
      
      public var _SpeechComponent_SetProperty2:SetProperty;
      
      private var _1699525965_speechZone:ViewStack;
      
      private var _796392160fileUploadComponent:FileUploadComponent;
      
      private var _1335907850lbTTSCredit:Label;
      
      private var _725271361_cboxImages:ArrayCollection;
      
      private var _1378618854_micReminder:VBox;
      
      private var _1864898021_boxDrop:HBox;
      
      private var _799538870_optAction:CheckBox;
      
      private var _342238643_dropMenu:ComboBox;
      
      private var _assetId:String;
      
      private var _1338722904_btnDelete:Button;
      
      private var _2044402600_btnCloseAdv:TextButton;
      
      private var _610816353speechMenu:ViewStack;
      
      private var _1860220302_txtSpeechErr:Text;
      
      private var sound:ImporterSoundAsset;
      
      private var _micReminderShown:Boolean = false;
      
      private var _91078296_main:VBox;
      
      private var _533064615playerError:Canvas;
      
      private var _1358002274_speechVolumeControl:VolumeButton;
      
      private var _719389622ttsComponent:TTSComponent;
      
      private var _2108350849_btnRight:Button;
      
      private var _1364423252_btnOpenAdv:TextButton;
      
      private var _644396432_advPanel:VBox;
      
      private var _132804193__boxBtnCan:Canvas;
      
      private var _1396342996banner:GoAdv;
      
      private var _1108302823_optZoom:CheckBox;
      
      mx_internal var _watchers:Array;
      
      public var _SpeechComponent_Label2:Label;
      
      public var _SpeechComponent_Label3:Label;
      
      public var _SpeechComponent_Label4:Label;
      
      private var _1730556742_btnSave:Button;
      
      private var _1728617444_speechControl:VBox;
      
      private var _668849914_boxOpenBtn:Canvas;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1956509072_boxCloseBtn:Canvas;
      
      private var _1124607024btnTTSCredit:Button;
      
      private var _uploadedAssetXML:XML;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function SpeechComponent()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"_main",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_boxDrop",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"lbTTSCredit",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btnTTSCredit",
                                    "events":{"click":"__btnTTSCredit_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"ttsDollar",
                                          "buttonMode":true,
                                          "visible":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_dropMenu",
                                    "events":{"change":"___dropMenu_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"cbSidePanel",
                                          "width":120
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ViewStack,
                           "id":"speechMenu",
                           "events":{"change":"__speechMenu_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TTSComponent,
                                    "id":"ttsComponent",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":MicRecordingComponent,
                                    "id":"micRecordComponent",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":FileUploadComponent,
                                    "id":"fileUploadComponent",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"playerError",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_txtSpeechErr",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 16;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "selectable":false
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ViewStack,
                           "id":"_speechZone",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_speechControl",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"__boxBtnCan",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"_boxOpenBtn",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_btnRight",
                                                            "events":{"click":"___btnRight_click"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "y":2,
                                                                  "styleName":"btnPanRight",
                                                                  "height":12,
                                                                  "buttonMode":true
                                                               };
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":TextButton,
                                                            "id":"_btnOpenAdv",
                                                            "events":{"click":"___btnOpenAdv_click"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "x":16,
                                                                  "textDecoration":"none",
                                                                  "txtSize":12
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"_boxCloseBtn",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "visible":false,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Button,
                                                               "id":"_btnDown",
                                                               "events":{"click":"___btnDown_click"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "y":3,
                                                                     "styleName":"btnPanDown",
                                                                     "width":12,
                                                                     "buttonMode":true
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":TextButton,
                                                               "id":"_btnCloseAdv",
                                                               "events":{"click":"___btnCloseAdv_click"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "x":16,
                                                                     "textDecoration":"none",
                                                                     "txtSize":12
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_boxAdv",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":VBox,
                                                      "id":"_advPanel",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":CheckBox,
                                                               "id":"_optZoom",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "selected":false,
                                                                     "width":250
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":CheckBox,
                                                               "id":"_optAction",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "selected":false,
                                                                     "width":250
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalAlign = "center";
                                                this.verticalAlign = "middle";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"_btnSave",
                                                      "events":{"click":"___btnSave_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"btnAddVoice"};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":VolumeButton,
                                                      "id":"_speechVolumeControl",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"includeInLayout":false};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"_btnDelete",
                                                      "events":{"click":"___btnDelete_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":38,
                                                            "height":38,
                                                            "styleName":"btnTrash"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_micReminder",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_SpeechComponent_Label2",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 17;
                                                this.color = 6710886;
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_SpeechComponent_Label3",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 17;
                                                this.color = 6710886;
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_SpeechComponent_Label4",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 17;
                                                this.color = 6710886;
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"percentHeight":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":GoAdv,
                           "id":"banner",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
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
         this.states = [this._SpeechComponent_State1_c()];
         this.transitions = [this._SpeechComponent_Transition1_c(),this._SpeechComponent_Transition2_c()];
         this._SpeechComponent_ArrayCollection1_i();
         this._SpeechComponent_ObjectProxy1_i();
         this.addEventListener("creationComplete",this.___SpeechComponent_Canvas1_creationComplete);
      }
      
      public static function getAssetIdBySpeechId(param1:String) : String
      {
         var _loc4_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Array = Console.getConsole().linkageController.isLinkageExist(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.concat();
            _loc4_.splice(_loc4_.indexOf(param1),1);
            _loc2_ = _loc4_.join("");
         }
         return _loc2_;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SpeechComponent._watcherSetupUtil = param1;
      }
      
      public static function getAssetSpeechId() : String
      {
         var _loc1_:Asset = Console.getConsole().currentScene.selectedAsset;
         return Console.getConsole().linkageController.getSpeechIdOfAsset(_loc1_);
      }
      
      private function onVolumeUpdate(param1:ExtraDataEvent) : void
      {
         var _loc2_:Number = param1.getData() as Number;
         var _loc3_:String = getAssetSpeechId();
         var _loc4_:AnimeSound;
         (_loc4_ = Console.getConsole().speechManager.getValueByKey(_loc3_) as AnimeSound).inner_volume = _loc2_;
      }
      
      private function updateTTSCredit() : void
      {
         if(FeatureManager.shouldTTSCreditBeShown && this.speechMenu.selectedChild == this.ttsComponent)
         {
            this.lbTTSCredit.text = UtilDict.toDisplay("go","Credit") + ": " + String(TTSManager.credit);
            if(TTSManager.credit <= 0)
            {
               this.lbTTSCredit.setStyle("color",16711680);
            }
            this.btnTTSCredit.visible = this.lbTTSCredit.visible = true;
         }
         else
         {
            this.btnTTSCredit.visible = this.lbTTSCredit.visible = false;
         }
         this.ttsComponent.credit = TTSManager.credit;
         if(this.speechMenu.selectedChild == this.ttsComponent && TTSManager.credit <= 0)
         {
            this._speechZone.includeInLayout = this._speechZone.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbTTSCredit() : Label
      {
         return this._1335907850lbTTSCredit;
      }
      
      private function onClickSave() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc1_:Object = new Object();
         _loc1_["zoom"] = !!this._optZoom.enabled?this._optZoom.selected:false;
         _loc1_["action"] = !!this._optAction.enabled?this._optAction.selected:false;
         if(getAssetSpeechId() != "")
         {
            _loc2_ = true;
            _loc3_ = true;
            this.deleteSpeech(_loc3_,_loc2_);
         }
         if(this.speechMenu.selectedChild == this.ttsComponent)
         {
            this.ttsComponent.addEventListener(IOErrorEvent.IO_ERROR,this.onSpeechTimeOut);
            this.ttsComponent.addEventListener(Event.COMPLETE,this.onSpeechAdded);
            this.ttsComponent.onSaveHandler(_loc1_);
         }
         else if(this.speechMenu.selectedChild == this.micRecordComponent)
         {
            this.micRecordComponent.addEventListener(UtilURLStream.TIME_OUT,this.onSpeechTimeOut);
            this.micRecordComponent.addEventListener(Event.CLOSE,this.onSpeechTimeOut);
            this.micRecordComponent.addEventListener(Event.COMPLETE,this.onSpeechAdded);
            this.micRecordComponent.onClickSave(_loc1_);
         }
         else if(this.speechMenu.selectedChild == this.fileUploadComponent)
         {
            this.fileUploadComponent.addEventListener(IOErrorEvent.IO_ERROR,this.onSpeechTimeOut);
            this.fileUploadComponent.addEventListener(Event.COMPLETE,this.onSpeechAdded);
            this.fileUploadComponent.onClickUpload(_loc1_);
         }
      }
      
      private function _SpeechComponent_ArrayCollection1_i() : ArrayCollection
      {
         var _loc1_:ArrayCollection = new ArrayCollection();
         this._cboxImages = _loc1_;
         BindingManager.executeBindings(this,"_cboxImages",this._cboxImages);
         _loc1_.initialized(this,"_cboxImages");
         return _loc1_;
      }
      
      private function error(param1:IOErrorEvent) : void
      {
      }
      
      public function set _boxOpenBtn(param1:Canvas) : void
      {
         var _loc2_:Object = this._668849914_boxOpenBtn;
         if(_loc2_ !== param1)
         {
            this._668849914_boxOpenBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxOpenBtn",_loc2_,param1));
         }
      }
      
      public function set _boxAdv(param1:Canvas) : void
      {
         var _loc2_:Object = this._1325312007_boxAdv;
         if(_loc2_ !== param1)
         {
            this._1325312007_boxAdv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxAdv",_loc2_,param1));
         }
      }
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         this.onClickDelete();
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxDrop() : HBox
      {
         return this._1864898021_boxDrop;
      }
      
      [Bindable(event="propertyChange")]
      public function get _speechControl() : VBox
      {
         return this._1728617444_speechControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxAdv() : Canvas
      {
         return this._1325312007_boxAdv;
      }
      
      public function ___SpeechComponent_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function trim(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.length - 1;
         if(_loc3_ < 1)
         {
            return "";
         }
         while(param1.charAt(_loc2_) < "!" && _loc2_ < param1.length)
         {
            _loc2_++;
         }
         while(param1.charAt(_loc3_) < "!" && _loc3_ >= 0)
         {
            _loc3_--;
         }
         if(_loc3_ < _loc2_)
         {
            return "";
         }
         return param1.substring(_loc2_,_loc3_ + 1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _micReminder() : VBox
      {
         return this._1378618854_micReminder;
      }
      
      private function _SpeechComponent_Parallel2_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this._SpeechComponent_Parallel2 = _loc1_;
         _loc1_.children = [this._SpeechComponent_Move2_i()];
         BindingManager.executeBindings(this,"_SpeechComponent_Parallel2",this._SpeechComponent_Parallel2);
         return _loc1_;
      }
      
      public function set _micReminder(param1:VBox) : void
      {
         var _loc2_:Object = this._1378618854_micReminder;
         if(_loc2_ !== param1)
         {
            this._1378618854_micReminder = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_micReminder",_loc2_,param1));
         }
      }
      
      public function set _boxDrop(param1:HBox) : void
      {
         var _loc2_:Object = this._1864898021_boxDrop;
         if(_loc2_ !== param1)
         {
            this._1864898021_boxDrop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxDrop",_loc2_,param1));
         }
      }
      
      public function set _speechControl(param1:VBox) : void
      {
         var _loc2_:Object = this._1728617444_speechControl;
         if(_loc2_ !== param1)
         {
            this._1728617444_speechControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_speechControl",_loc2_,param1));
         }
      }
      
      public function __btnTTSCredit_click(param1:MouseEvent) : void
      {
         this.onCreditBtnClick();
      }
      
      private function onUpgradeClick(param1:Event) : void
      {
         PopUpManager.removePopUp(Canvas(param1.target));
         UtilNavigate.toUpgradePage();
      }
      
      [Bindable(event="propertyChange")]
      public function get _dropMenu() : ComboBox
      {
         return this._342238643_dropMenu;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseAdv() : TextButton
      {
         return this._2044402600_btnCloseAdv;
      }
      
      private function onSpeechTimeOut(param1:Event) : void
      {
         Alert.show("Error");
         Console.getConsole().requestLoadStatus(false,true);
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _speechVolumeControl() : VolumeButton
      {
         return this._1358002274_speechVolumeControl;
      }
      
      private function onCreditBtnClick() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc1_ = PopUpManager.createPopUp(this,SchoolUpgradeOnTts,true);
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
      public function get micRecordComponent() : MicRecordingComponent
      {
         return this._1496708709micRecordComponent;
      }
      
      public function set banner(param1:GoAdv) : void
      {
         var _loc2_:Object = this._1396342996banner;
         if(_loc2_ !== param1)
         {
            this._1396342996banner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"banner",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ttsComponent() : TTSComponent
      {
         return this._719389622ttsComponent;
      }
      
      private function deleteSpeech(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:EffectAsset = null;
         var _loc3_:String = getAssetSpeechId();
         var _loc4_:String = Console.getConsole().linkageController.getCharIdOfSpeech(_loc3_);
         var _loc5_:RemoveSpeechCommand;
         (_loc5_ = new RemoveSpeechCommand(Console.getConsole().speechManager.getValueByKey(_loc3_) as AnimeSound,_loc4_)).execute();
         this.removeSpeechAndConnection();
         var _loc6_:Character = Console.getConsole().currentScene.getCharacterById(_loc4_.split(AssetLinkage.LINK)[1]);
         if(!param2)
         {
            if(_loc9_ = _loc6_.restoreActionFromTalk())
            {
               _loc10_ = Console.getConsole().timeline.getCurrentSceneWidth();
               Console.getConsole().currentScene.doUpdateTimelineLength(-1,true);
               _loc11_ = Console.getConsole().timeline.getCurrentSceneWidth();
               Console.getConsole().currentScene.updateEffectTray(_loc11_,_loc10_);
            }
         }
         var _loc7_:UtilHashArray;
         var _loc8_:int = (_loc7_ = Console.getConsole().currentScene.effects).length - 1;
         while(_loc8_ >= 0)
         {
            _loc12_ = _loc7_.getValueByIndex(_loc8_) as EffectAsset;
            if(!param1 && _loc12_.fromSpeech)
            {
               _loc12_.deleteAsset();
            }
            _loc8_--;
         }
         Console.getConsole().currentScene.refreshEffectTray();
      }
      
      public function __speechMenu_change(param1:IndexChangedEvent) : void
      {
         this.onSpeechPanelChange(param1);
      }
      
      private function saveSoundBySoundThumb(param1:SoundThumb) : void
      {
         Object(this.child).saveSoundBySoundThumb(param1);
      }
      
      private function _SpeechComponent_Parallel1_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this._SpeechComponent_Parallel1 = _loc1_;
         _loc1_.children = [this._SpeechComponent_Move1_i()];
         BindingManager.executeBindings(this,"_SpeechComponent_Parallel1",this._SpeechComponent_Parallel1);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtSpeechErr() : Text
      {
         return this._1860220302_txtSpeechErr;
      }
      
      private function onSpeechPanelChange(param1:Event) : void
      {
         this.updateTTSCredit();
      }
      
      [Bindable(event="propertyChange")]
      public function get _advPanel() : VBox
      {
         return this._644396432_advPanel;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRight() : Button
      {
         return this._2108350849_btnRight;
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxCloseBtn() : Canvas
      {
         return this._1956509072_boxCloseBtn;
      }
      
      private function enableButton(param1:Button, param2:Boolean) : void
      {
         param1.enabled = param2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _main() : VBox
      {
         return this._91078296_main;
      }
      
      public function set _dropMenu(param1:ComboBox) : void
      {
         var _loc2_:Object = this._342238643_dropMenu;
         if(_loc2_ !== param1)
         {
            this._342238643_dropMenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dropMenu",_loc2_,param1));
         }
      }
      
      public function set _speechZone(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1699525965_speechZone;
         if(_loc2_ !== param1)
         {
            this._1699525965_speechZone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_speechZone",_loc2_,param1));
         }
      }
      
      public function set _optAction(param1:CheckBox) : void
      {
         var _loc2_:Object = this._799538870_optAction;
         if(_loc2_ !== param1)
         {
            this._799538870_optAction = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_optAction",_loc2_,param1));
         }
      }
      
      private function _SpeechComponent_Move2_i() : Move
      {
         var _loc1_:Move = new Move();
         this._SpeechComponent_Move2 = _loc1_;
         _loc1_.duration = 500;
         _loc1_.yFrom = 0;
         BindingManager.executeBindings(this,"_SpeechComponent_Move2",this._SpeechComponent_Move2);
         return _loc1_;
      }
      
      public function set _btnCloseAdv(param1:TextButton) : void
      {
         var _loc2_:Object = this._2044402600_btnCloseAdv;
         if(_loc2_ !== param1)
         {
            this._2044402600_btnCloseAdv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseAdv",_loc2_,param1));
         }
      }
      
      private function onSpeechChange(param1:Event) : void
      {
         if(!this._btnSave.enabled)
         {
            this._btnSave.label = UtilDict.toDisplay("go","Update Voice");
            this._optAction.enabled = true;
            this._optZoom.enabled = true;
            this.enableButton(this._btnSave,true);
            this.showBin(true);
         }
         if(this._speechZone.selectedChild == this._micReminder)
         {
            this._speechZone.selectedChild = this._speechControl;
         }
      }
      
      public function set ttsComponent(param1:TTSComponent) : void
      {
         var _loc2_:Object = this._719389622ttsComponent;
         if(_loc2_ !== param1)
         {
            this._719389622ttsComponent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ttsComponent",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cboxImages() : ArrayCollection
      {
         return this._725271361_cboxImages;
      }
      
      public function onSentCompleteHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc6_:URLVariables = null;
         var _loc7_:URLRequest = null;
         var _loc8_:URLStream = null;
         var _loc9_:GoPopUp = null;
         var _loc2_:ByteArray = new ByteArray();
         if(param1.target is UploadHelper)
         {
            _loc3_ = DataEvent(param1).data;
         }
         else
         {
            (param1.target as URLStream).readBytes(_loc2_);
            _loc3_ = _loc2_.toString();
         }
         var _loc4_:String = _loc3_.substr(0,1);
         var _loc5_:XML = new XML(_loc3_.substr(1));
         this._uploadedAssetXML = _loc5_.name().toString() == "response"?_loc5_.asset[0]:_loc5_;
         if(_loc4_ == "0")
         {
            if(_loc5_.hasOwnProperty("tts"))
            {
               TTSManager.credit = Number(_loc5_.tts.@credit);
               this.updateTTSCredit();
            }
            this._assetId = this._uploadedAssetXML.id;
            if(!(this._assetId != null && this.trim(this._assetId).length > 0))
            {
               throw new Error("Invalid Id to get the asset");
            }
            _loc6_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc6_);
            if(_loc6_.hasOwnProperty("assetId"))
            {
               delete _loc6_["assetId"];
            }
            _loc6_["assetId"] = this._assetId;
            (_loc7_ = new URLRequest(ServerConstants.ACTION_GET_ASSET)).method = URLRequestMethod.POST;
            _loc7_.data = _loc6_;
            (_loc8_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomAssetComplete);
            _loc8_.addEventListener(IOErrorEvent.IO_ERROR,this.error);
            _loc8_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.error);
            _loc8_.load(_loc7_);
         }
         else
         {
            this.setButtonStatus(true);
            Console.getConsole().requestLoadStatus(false,true);
            _loc9_ = GoPopUp(PopUpManager.createPopUp(Console.getConsole().mainStage,GoPopUp,true));
            if(_loc5_.hasOwnProperty("code") && _loc5_.code == "BASIC_TTS_LIMIT_EXCEEDED")
            {
               _loc9_.text = UtilDict.toDisplay("go","Hey there, it looks like you have run out of Text-to-Voice credits.  Would you like to upgrade to GoPlus to get more?");
               _loc9_.addEventListener("okClick",this.onUpgradeClick);
               _loc9_.addEventListener("cancelClick",this.closePopUp);
               _loc9_.okText = UtilDict.toDisplay("go","Yes");
               _loc9_.cancelText = UtilDict.toDisplay("go","No");
               _loc9_.width = 400;
               _loc9_.x = (_loc9_.stage.width - _loc9_.width) / 2;
               _loc9_.y = 150;
            }
            else
            {
               _loc9_.text = !!_loc5_.hasOwnProperty("message")?_loc5_.message:"error";
               _loc9_.btnCancelVisible = false;
               _loc9_.addEventListener("okClick",this.closePopUp);
               _loc9_.width = 400;
               _loc9_.x = (_loc9_.stage.width - _loc9_.width) / 2;
               _loc9_.y = 150;
            }
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.TTS_ADDED,this));
      }
      
      public function set _speechVolumeControl(param1:VolumeButton) : void
      {
         var _loc2_:Object = this._1358002274_speechVolumeControl;
         if(_loc2_ !== param1)
         {
            this._1358002274_speechVolumeControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_speechVolumeControl",_loc2_,param1));
         }
      }
      
      private function _SpeechComponent_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "advanced";
         _loc1_.overrides = [this._SpeechComponent_SetProperty1_i(),this._SpeechComponent_SetProperty2_i()];
         return _loc1_;
      }
      
      private function _SpeechComponent_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._SpeechComponent_SetProperty2 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_SpeechComponent_SetProperty2",this._SpeechComponent_SetProperty2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : Button
      {
         return this._1730556742_btnSave;
      }
      
      private function showBin(param1:Boolean) : void
      {
         this._speechVolumeControl.visible = this._speechVolumeControl.includeInLayout = param1;
         this._btnDelete.visible = this._btnDelete.includeInLayout = param1;
      }
      
      public function ___btnCloseAdv_click(param1:MouseEvent) : void
      {
         this.closeAdvance();
      }
      
      public function set micRecordComponent(param1:MicRecordingComponent) : void
      {
         var _loc2_:Object = this._1496708709micRecordComponent;
         if(_loc2_ !== param1)
         {
            this._1496708709micRecordComponent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"micRecordComponent",_loc2_,param1));
         }
      }
      
      private function openAdvance() : void
      {
         this.currentState = "advanced";
      }
      
      public function set speechMenu(param1:ViewStack) : void
      {
         var _loc2_:Object = this._610816353speechMenu;
         if(_loc2_ !== param1)
         {
            this._610816353speechMenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechMenu",_loc2_,param1));
         }
      }
      
      private function _SpeechComponent_Transition2_c() : Transition
      {
         var _loc1_:Transition = new Transition();
         _loc1_.fromState = "advanced";
         _loc1_.toState = "*";
         _loc1_.effect = this._SpeechComponent_Parallel2_i();
         return _loc1_;
      }
      
      public function set _advPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._644396432_advPanel;
         if(_loc2_ !== param1)
         {
            this._644396432_advPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_advPanel",_loc2_,param1));
         }
      }
      
      public function set _txtSpeechErr(param1:Text) : void
      {
         var _loc2_:Object = this._1860220302_txtSpeechErr;
         if(_loc2_ !== param1)
         {
            this._1860220302_txtSpeechErr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtSpeechErr",_loc2_,param1));
         }
      }
      
      private function _SpeechComponent_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this._SpeechComponent_Move1 = _loc1_;
         _loc1_.duration = 500;
         _loc1_.yTo = 0;
         BindingManager.executeBindings(this,"_SpeechComponent_Move1",this._SpeechComponent_Move1);
         return _loc1_;
      }
      
      public function set _boxCloseBtn(param1:Canvas) : void
      {
         var _loc2_:Object = this._1956509072_boxCloseBtn;
         if(_loc2_ !== param1)
         {
            this._1956509072_boxCloseBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxCloseBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fileUploadComponent() : FileUploadComponent
      {
         return this._796392160fileUploadComponent;
      }
      
      public function set _btnRight(param1:Button) : void
      {
         var _loc2_:Object = this._2108350849_btnRight;
         if(_loc2_ !== param1)
         {
            this._2108350849_btnRight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRight",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxOpenBtn() : Canvas
      {
         return this._668849914_boxOpenBtn;
      }
      
      private function _SpeechComponent_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._SpeechComponent_SetProperty1 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_SpeechComponent_SetProperty1",this._SpeechComponent_SetProperty1);
         return _loc1_;
      }
      
      public function ___btnDown_click(param1:MouseEvent) : void
      {
         this.closeAdvance();
      }
      
      public function init() : void
      {
         var _loc2_:Character = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:AnimeSound = null;
         if(Util.playerIsUpdated(10,1))
         {
            this.micRecordComponent.init(this);
         }
         this.ttsComponent.init(this);
         this.fileUploadComponent.init(this);
         this._dropMenu.dataProvider = this._cboxImages;
         this._speechVolumeControl._vol.value = 1;
         var _loc1_:Asset = Console.getConsole().currentScene.selectedAsset;
         if(_loc1_ is Character)
         {
            _loc2_ = _loc1_ as Character;
            _loc3_ = getAssetSpeechId();
            if(_loc3_ != "")
            {
               _loc6_ = (_loc5_ = (_loc4_ = getAssetIdBySpeechId(_loc3_)).split(AssetLinkage.LINK))[0];
               _loc7_ = _loc5_[1];
               if(_loc2_.scene.id == _loc6_ && _loc2_.id == _loc7_)
               {
                  _loc8_ = Console.getConsole().speechManager.getValueByKey(_loc3_);
                  this._btnSave.label = UtilDict.toDisplay("go","Voice Added");
                  this._optAction.enabled = false;
                  this._optZoom.enabled = false;
                  this.enableButton(this._btnSave,false);
                  this._speechVolumeControl._vol.value = _loc8_.inner_volume;
                  this.showBin(true);
               }
            }
            else
            {
               this._btnSave.label = UtilDict.toDisplay("go","Add Voice");
               this._optAction.enabled = true;
               this._optZoom.enabled = true;
               this.enableButton(this._btnSave,true);
               this.showBin(false);
            }
         }
         UtilColor.setRGB(this._btnDown,3618615);
         UtilColor.setRGB(this._btnRight,3618615);
         this.ttsComponent.addEventListener(Event.CHANGE,this.onSpeechChange);
         this.micRecordComponent.addEventListener(Event.CHANGE,this.onSpeechChange);
         this.fileUploadComponent.addEventListener(Event.CHANGE,this.onSpeechChange);
         if(this.speechMenu.selectedChild == this.ttsComponent)
         {
            ComboBox(this._dropMenu).selectedIndex = 0;
         }
         else if(this.speechMenu.selectedChild == this.micRecordComponent || this.speechMenu.selectedChild == this.playerError)
         {
            ComboBox(this._dropMenu).selectedIndex = 1;
         }
         else if(this.speechMenu.selectedChild == this.fileUploadComponent)
         {
            ComboBox(this._dropMenu).selectedIndex = 2;
         }
         this._speechVolumeControl._vol.minimum = 0;
         this._speechVolumeControl._vol.maximum = 4;
         this._speechVolumeControl._vol.snapInterval = 0.25;
         this._speechVolumeControl.addEventListener(ExtraDataEvent.UPDATE,this.onVolumeUpdate);
      }
      
      private function get child() : Container
      {
         return this.speechMenu.selectedChild;
      }
      
      private function _SpeechComponent_Transition1_c() : Transition
      {
         var _loc1_:Transition = new Transition();
         _loc1_.fromState = "*";
         _loc1_.toState = "advanced";
         _loc1_.effect = this._SpeechComponent_Parallel1_i();
         return _loc1_;
      }
      
      public function set target(param1:Object) : void
      {
         if(param1)
         {
            if(param1 is Character)
            {
               this.banner.refresh(Character(param1));
               this.updateTTSCredit();
            }
         }
      }
      
      private function _SpeechComponent_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Please upgrade your Flash Player to enable Mic Recording");
         _loc1_ = UtilDict.toDisplay("go","Advanced");
         _loc1_ = UtilDict.toDisplay("go","Minimize");
         _loc1_ = this._boxOpenBtn.height;
         _loc1_ = -this._advPanel.height;
         _loc1_ = UtilDict.toDisplay("go","Manage the camera automatically");
         _loc1_ = UtilDict.toDisplay("go","Choose character talk action automatically");
         _loc1_ = UtilDict.toDisplay("go","Add Voice");
         _loc1_ = this._btnSave.enabled;
         _loc1_ = this._btnDelete.enabled;
         _loc1_ = UtilDict.toDisplay("go","1. Press Record");
         _loc1_ = UtilDict.toDisplay("go","2. Change your pitch");
         _loc1_ = UtilDict.toDisplay("go","3. Add your voice to the scene");
         _loc1_ = this._boxCloseBtn;
         _loc1_ = this._boxOpenBtn;
         _loc1_ = [this._advPanel];
         _loc1_ = -this._advPanel.height;
         _loc1_ = [this._advPanel];
         _loc1_ = -this._advPanel.height;
         _loc1_ = UtilDict.toDisplay("go","Text-to-Voice");
         _loc1_ = UtilDict.toDisplay("go","Mic Recording");
         _loc1_ = UtilDict.toDisplay("go","File Upload");
         _loc1_ = this._images.item;
      }
      
      public function set _images(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._1523220375_images;
         if(_loc2_ !== param1)
         {
            this._1523220375_images = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_images",_loc2_,param1));
         }
      }
      
      private function removeSpeechAndConnection() : void
      {
         var _loc1_:String = getAssetSpeechId();
         Console.getConsole().speechManager.removeSoundById(_loc1_);
      }
      
      public function set _main(param1:VBox) : void
      {
         var _loc2_:Object = this._91078296_main;
         if(_loc2_ !== param1)
         {
            this._91078296_main = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_main",_loc2_,param1));
         }
      }
      
      private function _SpeechComponent_ObjectProxy4_c() : ObjectProxy
      {
         var _loc1_:ObjectProxy = new ObjectProxy();
         _loc1_.id = 3;
         _loc1_.label = null;
         _loc1_.type = "file";
         _loc1_.subber = "";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function onCreationComplete() : void
      {
         this.openAdvance();
      }
      
      private function creationComplete() : void
      {
      }
      
      public function set __boxBtnCan(param1:Canvas) : void
      {
         var _loc2_:Object = this._132804193__boxBtnCan;
         if(_loc2_ !== param1)
         {
            this._132804193__boxBtnCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"__boxBtnCan",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _speechZone() : ViewStack
      {
         return this._1699525965_speechZone;
      }
      
      [Bindable(event="propertyChange")]
      public function get banner() : GoAdv
      {
         return this._1396342996banner;
      }
      
      public function set _btnDelete(param1:Button) : void
      {
         var _loc2_:Object = this._1338722904_btnDelete;
         if(_loc2_ !== param1)
         {
            this._1338722904_btnDelete = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelete",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _optAction() : CheckBox
      {
         return this._799538870_optAction;
      }
      
      public function ___btnOpenAdv_click(param1:MouseEvent) : void
      {
         this.openAdvance();
      }
      
      public function set playerError(param1:Canvas) : void
      {
         var _loc2_:Object = this._533064615playerError;
         if(_loc2_ !== param1)
         {
            this._533064615playerError = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerError",_loc2_,param1));
         }
      }
      
      private function setButtonStatus(param1:Boolean) : void
      {
         Object(this.child).setButtonStatus(param1);
      }
      
      public function set _btnOpenAdv(param1:TextButton) : void
      {
         var _loc2_:Object = this._1364423252_btnOpenAdv;
         if(_loc2_ !== param1)
         {
            this._1364423252_btnOpenAdv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnOpenAdv",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechMenu() : ViewStack
      {
         return this._610816353speechMenu;
      }
      
      private function closeAdvance() : void
      {
         this.currentState = "";
      }
      
      private function _SpeechComponent_ObjectProxy3_c() : ObjectProxy
      {
         var _loc1_:ObjectProxy = new ObjectProxy();
         _loc1_.id = 2;
         _loc1_.label = null;
         _loc1_.type = "mic";
         _loc1_.subber = "";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _SpeechComponent_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Please upgrade your Flash Player to enable Mic Recording");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _txtSpeechErr.text = param1;
         },"_txtSpeechErr.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Advanced");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnOpenAdv.label = param1;
         },"_btnOpenAdv.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Minimize");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCloseAdv.label = param1;
         },"_btnCloseAdv.label");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return _boxOpenBtn.height;
         },function(param1:Number):void
         {
            _boxAdv.y = param1;
         },"_boxAdv.y");
         result[3] = binding;
         binding = new Binding(this,function():Number
         {
            return -_advPanel.height;
         },function(param1:Number):void
         {
            _advPanel.y = param1;
         },"_advPanel.y");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Manage the camera automatically");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _optZoom.label = param1;
         },"_optZoom.label");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Choose character talk action automatically");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _optAction.label = param1;
         },"_optAction.label");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Voice");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.label = param1;
         },"_btnSave.label");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return _btnSave.enabled;
         },function(param1:Boolean):void
         {
            _btnSave.buttonMode = param1;
         },"_btnSave.buttonMode");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return _btnDelete.enabled;
         },function(param1:Boolean):void
         {
            _btnDelete.buttonMode = param1;
         },"_btnDelete.buttonMode");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","1. Press Record");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SpeechComponent_Label2.text = param1;
         },"_SpeechComponent_Label2.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","2. Change your pitch");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SpeechComponent_Label3.text = param1;
         },"_SpeechComponent_Label3.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","3. Add your voice to the scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SpeechComponent_Label4.text = param1;
         },"_SpeechComponent_Label4.text");
         result[12] = binding;
         binding = new Binding(this,function():Object
         {
            return _boxCloseBtn;
         },function(param1:Object):void
         {
            _SpeechComponent_SetProperty1.target = param1;
         },"_SpeechComponent_SetProperty1.target");
         result[13] = binding;
         binding = new Binding(this,function():Object
         {
            return _boxOpenBtn;
         },function(param1:Object):void
         {
            _SpeechComponent_SetProperty2.target = param1;
         },"_SpeechComponent_SetProperty2.target");
         result[14] = binding;
         binding = new Binding(this,function():Array
         {
            return [_advPanel];
         },function(param1:Array):void
         {
            _SpeechComponent_Parallel1.targets = param1;
         },"_SpeechComponent_Parallel1.targets");
         result[15] = binding;
         binding = new Binding(this,function():Number
         {
            return -_advPanel.height;
         },function(param1:Number):void
         {
            _SpeechComponent_Move1.yFrom = param1;
         },"_SpeechComponent_Move1.yFrom");
         result[16] = binding;
         binding = new Binding(this,function():Array
         {
            return [_advPanel];
         },function(param1:Array):void
         {
            _SpeechComponent_Parallel2.targets = param1;
         },"_SpeechComponent_Parallel2.targets");
         result[17] = binding;
         binding = new Binding(this,function():Number
         {
            return -_advPanel.height;
         },function(param1:Number):void
         {
            _SpeechComponent_Move2.yTo = param1;
         },"_SpeechComponent_Move2.yTo");
         result[18] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Text-to-Voice");
         },function(param1:*):void
         {
            _images.item[0].label = param1;
         },"_images.item[0].label");
         result[19] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Mic Recording");
         },function(param1:*):void
         {
            _images.item[1].label = param1;
         },"_images.item[1].label");
         result[20] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","File Upload");
         },function(param1:*):void
         {
            _images.item[2].label = param1;
         },"_images.item[2].label");
         result[21] = binding;
         binding = new Binding(this,function():Array
         {
            return _images.item;
         },function(param1:Array):void
         {
            _cboxImages.source = param1;
         },"_cboxImages.source");
         result[22] = binding;
         return result;
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
      
      public function set _cboxImages(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._725271361_cboxImages;
         if(_loc2_ !== param1)
         {
            this._725271361_cboxImages = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cboxImages",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:SpeechComponent = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SpeechComponent_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_SpeechComponentWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      public function get _images() : ObjectProxy
      {
         return this._1523220375_images;
      }
      
      private function saveSound() : void
      {
         Object(this.child).saveSound(this._soundBytes,this._uploadedAssetXML);
      }
      
      public function set btnTTSCredit(param1:Button) : void
      {
         var _loc2_:Object = this._1124607024btnTTSCredit;
         if(_loc2_ !== param1)
         {
            this._1124607024btnTTSCredit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnTTSCredit",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get __boxBtnCan() : Canvas
      {
         return this._132804193__boxBtnCan;
      }
      
      [Bindable(event="propertyChange")]
      public function get playerError() : Canvas
      {
         return this._533064615playerError;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelete() : Button
      {
         return this._1338722904_btnDelete;
      }
      
      private function _SpeechComponent_ObjectProxy2_c() : ObjectProxy
      {
         var _loc1_:ObjectProxy = new ObjectProxy();
         _loc1_.id = 1;
         _loc1_.label = null;
         _loc1_.type = "tts";
         _loc1_.subber = "";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnOpenAdv() : TextButton
      {
         return this._1364423252_btnOpenAdv;
      }
      
      private function closePopUp(param1:Event) : void
      {
         PopUpManager.removePopUp(Canvas(param1.target));
      }
      
      public function set _btnDown(param1:Button) : void
      {
         var _loc2_:Object = this._1730990113_btnDown;
         if(_loc2_ !== param1)
         {
            this._1730990113_btnDown = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDown",_loc2_,param1));
         }
      }
      
      public function set fileUploadComponent(param1:FileUploadComponent) : void
      {
         var _loc2_:Object = this._796392160fileUploadComponent;
         if(_loc2_ !== param1)
         {
            this._796392160fileUploadComponent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fileUploadComponent",_loc2_,param1));
         }
      }
      
      public function ___dropMenu_change(param1:ListEvent) : void
      {
         this.onDropMenuChange(param1);
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.onClickSave();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnTTSCredit() : Button
      {
         return this._1124607024btnTTSCredit;
      }
      
      public function set _optZoom(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1108302823_optZoom;
         if(_loc2_ !== param1)
         {
            this._1108302823_optZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_optZoom",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDown() : Button
      {
         return this._1730990113_btnDown;
      }
      
      private function onGetCustomAssetComplete(param1:Event) : void
      {
         var _loc4_:SoundThumb = null;
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:int = _loc2_.readByte();
         this._soundBytes = new ByteArray();
         _loc2_.readBytes(this._soundBytes);
         if(_loc3_ == 0 && param1.type == Event.COMPLETE)
         {
            _loc4_ = Console.getConsole().onGetCustomAssetCompleteByte(this._soundBytes,this._uploadedAssetXML,false,false);
            this.saveSoundBySoundThumb(_loc4_);
            return;
         }
         throw new Error("load asset by id failed.");
      }
      
      private function onSpeechAdded(param1:Event) : void
      {
         Console.getConsole().requestLoadStatus(false,true);
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _optZoom() : CheckBox
      {
         return this._1108302823_optZoom;
      }
      
      private function _SpeechComponent_ObjectProxy1_i() : ObjectProxy
      {
         var _loc1_:ObjectProxy = new ObjectProxy();
         this._images = _loc1_;
         _loc1_.item = [this._SpeechComponent_ObjectProxy2_c(),this._SpeechComponent_ObjectProxy3_c(),this._SpeechComponent_ObjectProxy4_c()];
         return _loc1_;
      }
      
      public function set lbTTSCredit(param1:Label) : void
      {
         var _loc2_:Object = this._1335907850lbTTSCredit;
         if(_loc2_ !== param1)
         {
            this._1335907850lbTTSCredit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbTTSCredit",_loc2_,param1));
         }
      }
      
      public function onClickDelete() : void
      {
         this.deleteSpeech();
         this.init();
      }
      
      public function ___btnRight_click(param1:MouseEvent) : void
      {
         this.openAdvance();
      }
      
      private function onDropMenuChange(param1:Event) : void
      {
         this._speechZone.includeInLayout = this._speechZone.visible = true;
         if(ComboBox(param1.target).selectedItem.type == "tts")
         {
            this.speechMenu.selectedChild = this.ttsComponent;
         }
         else if(ComboBox(param1.target).selectedItem.type == "mic")
         {
            if(Util.playerIsUpdated(10,1) && this.micRecordComponent.helper.microphone())
            {
               this.speechMenu.selectedChild = this.micRecordComponent;
            }
            else
            {
               this.speechMenu.selectedChild = this.playerError;
               this._speechZone.includeInLayout = this._speechZone.visible = false;
               if(!Util.playerIsUpdated(10,1))
               {
                  this._txtSpeechErr.text = UtilDict.toDisplay("go","Please upgrade your Flash Player to enable Mic Recording.");
               }
               else if(!this.micRecordComponent.helper.microphone())
               {
                  this._txtSpeechErr.text = UtilDict.toDisplay("go","Mic recording cannot be started. Please make sure your sound card and micophone are correctly installed.");
               }
            }
         }
         else if(ComboBox(param1.target).selectedItem.type == "file")
         {
            this.fileUploadComponent.filter = "sounds";
            this.speechMenu.selectedChild = this.fileUploadComponent;
         }
         if(!this._micReminderShown && this.speechMenu.selectedChild == this.micRecordComponent)
         {
            this._speechZone.selectedChild = this._micReminder;
            this._micReminderShown = true;
         }
         else
         {
            this._speechZone.selectedChild = this._speechControl;
         }
      }
   }
}
