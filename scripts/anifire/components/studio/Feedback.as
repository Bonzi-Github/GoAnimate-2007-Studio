package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.util.Crypto.RC4;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.states.SetEventHandler;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   import mx.utils.Base64Encoder;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class Feedback extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _331114063headingText:Text;
      
      public var _Feedback_Text4:Text;
      
      private var _102977213line1:Text;
      
      private var _1167802954commandButtons:Canvas;
      
      mx_internal var _watchers:Array;
      
      public var _Feedback_SetEventHandler1:SetEventHandler;
      
      public var _Feedback_SetEventHandler2:SetEventHandler;
      
      private var _2122106277_btnClose:IconTextButton;
      
      private var _3773vs:ViewStack;
      
      private var _102977214line2:Text;
      
      public var _Feedback_SetProperty1:SetProperty;
      
      public var _Feedback_SetProperty2:SetProperty;
      
      public var _Feedback_SetProperty3:SetProperty;
      
      public var _Feedback_SetProperty4:SetProperty;
      
      public var _Feedback_SetProperty5:SetProperty;
      
      public var _Feedback_SetProperty6:SetProperty;
      
      public var _Feedback_SetProperty7:SetProperty;
      
      private var _599445191complete:VBox;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var err:Error;
      
      public var _Feedback_Button2:Button;
      
      mx_internal var _bindings:Array;
      
      private var _1022398728actionButton:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _3148996form:VBox;
      
      public function Feedback()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnClose",
                     "events":{
                        "click":"___btnClose_click",
                        "creationComplete":"___btnClose_creationComplete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnCloseTop",
                           "buttonMode":true,
                           "labelPlacement":"left"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"vs",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "selectedIndex":0,
                           "resizeToContent":true,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "id":"form",
                              "stylesFactory":function():void
                              {
                                 this.paddingTop = 30;
                                 this.paddingBottom = 20;
                                 this.paddingLeft = 20;
                                 this.paddingRight = 20;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"headingText",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 16;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"line1",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"line2",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"commandButtons",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.horizontalCenter = "0";
                                                   this.paddingTop = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"actionButton",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.fontSize = 20;
                                                      }
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"complete",
                              "stylesFactory":function():void
                              {
                                 this.paddingTop = 30;
                                 this.paddingBottom = 20;
                                 this.paddingLeft = 20;
                                 this.paddingRight = 20;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"_Feedback_Text4",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 16;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.horizontalCenter = "0";
                                                   this.paddingTop = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"_Feedback_Button2",
                                                      "events":{"click":"___Feedback_Button2_click"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.fontSize = 20;
                                                      }
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
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
         this.width = 500;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.states = [this._Feedback_State1_c(),this._Feedback_State2_c()];
         this.addEventListener("creationComplete",this.___Feedback_TitleWindow1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Feedback._watcherSetupUtil = param1;
      }
      
      private function _Feedback_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.actionButton;
         _loc1_ = this.actionButton;
         _loc1_ = UtilDict.toDisplay("go","Send bug report");
         _loc1_ = this.actionButton;
         _loc1_ = this.actionButton;
         _loc1_ = this.actionButton;
         _loc1_ = UtilDict.toDisplay("go","Copy bug report to clipboard");
         _loc1_ = this.headingText;
         _loc1_ = UtilDict.toDisplay("go","We are experiencing some technical difficulties here.");
         _loc1_ = this.line1;
         _loc1_ = UtilDict.toDisplay("go","Please copy your report to clipboard by clicking the button below, and email us at support@goanimate.com with the copied data.");
         _loc1_ = this.line2;
         _loc1_ = UtilDict.toDisplay("go","Thank you for helping us build a better place for all.");
         _loc1_ = this.actionButton;
         _loc1_ = UtilDict.toDisplay("go","Close");
         _loc1_ = UtilDict.toDisplay("go","Oops. Your animation could not be saved.");
         _loc1_ = UtilDict.toDisplay("go","To avoid further data loss, you are advised not to continue editing this animation for the time being.");
         _loc1_ = UtilDict.toDisplay("go","To help us diagnose the problem, please consider reporting the issue.");
         _loc1_ = UtilDict.toDisplay("go","Thank you. Your report has been submitted.");
         _loc1_ = UtilDict.toDisplay("go","Close");
      }
      
      private function _Feedback_SetProperty7_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty7 = _loc1_;
         _loc1_.name = "text";
         BindingManager.executeBindings(this,"_Feedback_SetProperty7",this._Feedback_SetProperty7);
         return _loc1_;
      }
      
      public function set line1(param1:Text) : void
      {
         var _loc2_:Object = this._102977213line1;
         if(_loc2_ !== param1)
         {
            this._102977213line1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"line1",_loc2_,param1));
         }
      }
      
      public function set complete(param1:VBox) : void
      {
         var _loc2_:Object = this._599445191complete;
         if(_loc2_ !== param1)
         {
            this._599445191complete = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"complete",_loc2_,param1));
         }
      }
      
      private function _Feedback_SetEventHandler1_i() : SetEventHandler
      {
         var _loc1_:SetEventHandler = new SetEventHandler();
         this._Feedback_SetEventHandler1 = _loc1_;
         _loc1_.name = "click";
         _loc1_.handlerFunction = this.sendBug;
         BindingManager.executeBindings(this,"_Feedback_SetEventHandler1",this._Feedback_SetEventHandler1);
         return _loc1_;
      }
      
      private function getFlashVars() : String
      {
         var _loc1_:URLVariables = new URLVariables();
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_[_loc2_.getKey(_loc3_)] = _loc2_.getValueByIndex(_loc3_);
            _loc3_++;
         }
         return _loc1_.toString();
      }
      
      public function get error() : Error
      {
         return this.err;
      }
      
      public function set error(param1:Error) : void
      {
         this.err = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get vs() : ViewStack
      {
         return this._3773vs;
      }
      
      public function set vs(param1:ViewStack) : void
      {
         var _loc2_:Object = this._3773vs;
         if(_loc2_ !== param1)
         {
            this._3773vs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vs",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:Feedback = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._Feedback_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_FeedbackWatcherSetupUtil");
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
      
      public function set commandButtons(param1:Canvas) : void
      {
         var _loc2_:Object = this._1167802954commandButtons;
         if(_loc2_ !== param1)
         {
            this._1167802954commandButtons = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"commandButtons",_loc2_,param1));
         }
      }
      
      public function set headingText(param1:Text) : void
      {
         var _loc2_:Object = this._331114063headingText;
         if(_loc2_ !== param1)
         {
            this._331114063headingText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"headingText",_loc2_,param1));
         }
      }
      
      private function closeWindow(param1:Event) : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function _Feedback_SetProperty6_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty6 = _loc1_;
         _loc1_.name = "text";
         BindingManager.executeBindings(this,"_Feedback_SetProperty6",this._Feedback_SetProperty6);
         return _loc1_;
      }
      
      private function _Feedback_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "sendForm";
         _loc1_.overrides = [this._Feedback_SetProperty1_i(),this._Feedback_SetProperty2_i(),this._Feedback_SetEventHandler1_i()];
         return _loc1_;
      }
      
      private function _Feedback_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty2 = _loc1_;
         _loc1_.name = "label";
         BindingManager.executeBindings(this,"_Feedback_SetProperty2",this._Feedback_SetProperty2);
         return _loc1_;
      }
      
      private function _Feedback_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty4 = _loc1_;
         _loc1_.name = "label";
         BindingManager.executeBindings(this,"_Feedback_SetProperty4",this._Feedback_SetProperty4);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get actionButton() : Button
      {
         return this._1022398728actionButton;
      }
      
      private function _Feedback_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return actionButton;
         },function(param1:Object):void
         {
            _Feedback_SetProperty1.target = param1;
         },"_Feedback_SetProperty1.target");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return actionButton;
         },function(param1:Object):void
         {
            _Feedback_SetProperty2.target = param1;
         },"_Feedback_SetProperty2.target");
         result[1] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Send bug report");
         },function(param1:*):void
         {
            _Feedback_SetProperty2.value = param1;
         },"_Feedback_SetProperty2.value");
         result[2] = binding;
         binding = new Binding(this,function():EventDispatcher
         {
            return actionButton;
         },function(param1:EventDispatcher):void
         {
            _Feedback_SetEventHandler1.target = param1;
         },"_Feedback_SetEventHandler1.target");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return actionButton;
         },function(param1:Object):void
         {
            _Feedback_SetProperty3.target = param1;
         },"_Feedback_SetProperty3.target");
         result[4] = binding;
         binding = new Binding(this,function():Object
         {
            return actionButton;
         },function(param1:Object):void
         {
            _Feedback_SetProperty4.target = param1;
         },"_Feedback_SetProperty4.target");
         result[5] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Copy bug report to clipboard");
         },function(param1:*):void
         {
            _Feedback_SetProperty4.value = param1;
         },"_Feedback_SetProperty4.value");
         result[6] = binding;
         binding = new Binding(this,function():Object
         {
            return headingText;
         },function(param1:Object):void
         {
            _Feedback_SetProperty5.target = param1;
         },"_Feedback_SetProperty5.target");
         result[7] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","We are experiencing some technical difficulties here.");
         },function(param1:*):void
         {
            _Feedback_SetProperty5.value = param1;
         },"_Feedback_SetProperty5.value");
         result[8] = binding;
         binding = new Binding(this,function():Object
         {
            return line1;
         },function(param1:Object):void
         {
            _Feedback_SetProperty6.target = param1;
         },"_Feedback_SetProperty6.target");
         result[9] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Please copy your report to clipboard by clicking the button below, and email us at support@goanimate.com with the copied data.");
         },function(param1:*):void
         {
            _Feedback_SetProperty6.value = param1;
         },"_Feedback_SetProperty6.value");
         result[10] = binding;
         binding = new Binding(this,function():Object
         {
            return line2;
         },function(param1:Object):void
         {
            _Feedback_SetProperty7.target = param1;
         },"_Feedback_SetProperty7.target");
         result[11] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Thank you for helping us build a better place for all.");
         },function(param1:*):void
         {
            _Feedback_SetProperty7.value = param1;
         },"_Feedback_SetProperty7.value");
         result[12] = binding;
         binding = new Binding(this,function():EventDispatcher
         {
            return actionButton;
         },function(param1:EventDispatcher):void
         {
            _Feedback_SetEventHandler2.target = param1;
         },"_Feedback_SetEventHandler2.target");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnClose.label = param1;
         },"_btnClose.label");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops. Your animation could not be saved.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            headingText.text = param1;
         },"headingText.text");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","To avoid further data loss, you are advised not to continue editing this animation for the time being.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            line1.text = param1;
         },"line1.text");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","To help us diagnose the problem, please consider reporting the issue.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            line2.text = param1;
         },"line2.text");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Thank you. Your report has been submitted.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _Feedback_Text4.text = param1;
         },"_Feedback_Text4.text");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _Feedback_Button2.label = param1;
         },"_Feedback_Button2.label");
         result[19] = binding;
         return result;
      }
      
      public function set actionButton(param1:Button) : void
      {
         var _loc2_:Object = this._1022398728actionButton;
         if(_loc2_ !== param1)
         {
            this._1022398728actionButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionButton",_loc2_,param1));
         }
      }
      
      private function onCreationComplete(param1:Event) : void
      {
         currentState = "sendForm";
      }
      
      [Bindable(event="propertyChange")]
      public function get complete() : VBox
      {
         return this._599445191complete;
      }
      
      public function set line2(param1:Text) : void
      {
         var _loc2_:Object = this._102977214line2;
         if(_loc2_ !== param1)
         {
            this._102977214line2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"line2",_loc2_,param1));
         }
      }
      
      private function _Feedback_SetEventHandler2_i() : SetEventHandler
      {
         var _loc1_:SetEventHandler = new SetEventHandler();
         this._Feedback_SetEventHandler2 = _loc1_;
         _loc1_.name = "click";
         _loc1_.handlerFunction = this.copyBug;
         BindingManager.executeBindings(this,"_Feedback_SetEventHandler2",this._Feedback_SetEventHandler2);
         return _loc1_;
      }
      
      private function copyBug(param1:Event) : void
      {
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,ObjectUtil.toString(this.prepareModel()));
      }
      
      private function initClose() : void
      {
         this._btnClose.x = this.width - this._btnClose.width - 20;
         this._btnClose.y = 0;
         var _loc1_:ColorTransform = new ColorTransform(0,0,0);
         this._btnClose.transform.colorTransform = _loc1_;
      }
      
      public function ___btnClose_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      private function sendBug(param1:Event) : void
      {
         var rc4:RC4 = null;
         var loader:URLLoader = null;
         var self:Feedback = null;
         var e:Event = param1;
         var out_ba:ByteArray = new ByteArray();
         var b64Encoder:Base64Encoder = new Base64Encoder();
         loader = new URLLoader();
         var encryptionKey:ByteArray = new ByteArray();
         encryptionKey.writeUTFBytes("i32b7!2qM*s82@pT");
         rc4 = new RC4(encryptionKey);
         out_ba.writeUTFBytes(ObjectUtil.toString(this.prepareModel()));
         rc4.encrypt(out_ba);
         b64Encoder.encodeBytes(out_ba);
         var request:URLRequest = UtilNetwork.getSendBugReportRequest();
         request.data["rpt"] = b64Encoder.toString();
         this.actionButton.enabled = false;
         self = this;
         var okHandler:Function = function(param1:Event):void
         {
            removeEventListener(Event.COMPLETE,arguments.callee);
            var _loc3_:String = "1";
            if(loader.bytesTotal >= 1)
            {
               _loc3_ = String(loader.data).charAt(0);
            }
            if(_loc3_ == "0")
            {
               vs.selectedChild = complete;
            }
            else
            {
               self.currentState = "copyForm";
            }
         };
         var errHandler:Function = function(param1:Event):void
         {
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR,arguments.callee);
            removeEventListener(IOErrorEvent.IO_ERROR,arguments.callee);
            self.currentState = "copyForm";
         };
         var _loc3_:*;
         with(_loc3_ = loader)
         {
            
            addEventListener(Event.COMPLETE,okHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR,errHandler);
            addEventListener(IOErrorEvent.IO_ERROR,errHandler);
            load(request);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get line2() : Text
      {
         return this._102977214line2;
      }
      
      public function ___Feedback_Button2_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get headingText() : Text
      {
         return this._331114063headingText;
      }
      
      [Bindable(event="propertyChange")]
      public function get line1() : Text
      {
         return this._102977213line1;
      }
      
      public function set _btnClose(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2122106277_btnClose;
         if(_loc2_ !== param1)
         {
            this._2122106277_btnClose = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose() : IconTextButton
      {
         return this._2122106277_btnClose;
      }
      
      private function _Feedback_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty1 = _loc1_;
         _loc1_.name = "enabled";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_Feedback_SetProperty1",this._Feedback_SetProperty1);
         return _loc1_;
      }
      
      private function _Feedback_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "copyForm";
         _loc1_.overrides = [this._Feedback_SetProperty3_i(),this._Feedback_SetProperty4_i(),this._Feedback_SetProperty5_i(),this._Feedback_SetProperty6_i(),this._Feedback_SetProperty7_i(),this._Feedback_SetEventHandler2_i()];
         return _loc1_;
      }
      
      private function _Feedback_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty3 = _loc1_;
         _loc1_.name = "enabled";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_Feedback_SetProperty3",this._Feedback_SetProperty3);
         return _loc1_;
      }
      
      private function _Feedback_SetProperty5_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._Feedback_SetProperty5 = _loc1_;
         _loc1_.name = "text";
         BindingManager.executeBindings(this,"_Feedback_SetProperty5",this._Feedback_SetProperty5);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get form() : VBox
      {
         return this._3148996form;
      }
      
      private function prepareModel() : Object
      {
         return {
            "env":this.getFlashVars(),
            "err":this.err,
            "st":this.err.getStackTrace()
         };
      }
      
      public function set form(param1:VBox) : void
      {
         var _loc2_:Object = this._3148996form;
         if(_loc2_ !== param1)
         {
            this._3148996form = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"form",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get commandButtons() : Canvas
      {
         return this._1167802954commandButtons;
      }
      
      public function ___Feedback_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function ___btnClose_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
   }
}
