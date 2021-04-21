package anifire.components.studio
{
   import anifire.core.Console;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class noSaveAlertWindow extends VBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindings:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public var _noSaveAlertWindow_Button2:Button;
      
      public var _noSaveAlertWindow_Button3:Button;
      
      public var _noSaveAlertWindow_Button4:Button;
      
      mx_internal var _watchers:Array;
      
      public var _noSaveAlertWindow_Label1:Label;
      
      public var _noSaveAlertWindow_Label2:Label;
      
      public var _noSaveAlertWindow_Label3:Label;
      
      public var _noSaveAlertWindow_Text1:Text;
      
      public var _noSaveAlertWindow_Text2:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _2044384006_btnCloseTop:Button;
      
      public function noSaveAlertWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":700,
                  "height":480,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnCloseTop",
                              "events":{
                                 "click":"___btnCloseTop_click",
                                 "creationComplete":"___btnCloseTop_creationComplete"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnClose",
                                    "buttonMode":true
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_noSaveAlertWindow_Label1",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 38;
                        this.color = 16777215;
                        this.textAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"percentWidth":100};
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                        this.horizontalGap = 20;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":200,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentHeight":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_noSaveAlertWindow_Text1",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "styleName":"textBig",
                                    "selectable":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_noSaveAlertWindow_Text2",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "styleName":"textBig",
                                    "selectable":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentHeight":100};
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
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_noSaveAlertWindow_Button2",
                              "events":{"click":"___noSaveAlertWindow_Button2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnNoSaveTryOut",
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
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
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_noSaveAlertWindow_Button3",
                              "events":{"click":"___noSaveAlertWindow_Button3_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnBlue",
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_noSaveAlertWindow_Label2",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"textNormal"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_noSaveAlertWindow_Button4",
                              "events":{"click":"___noSaveAlertWindow_Button4_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnBlue",
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_noSaveAlertWindow_Label3",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"textNormal",
                                    "percentWidth":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Spacer,
                     "propertiesFactory":function():Object
                     {
                        return {"height":20};
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
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.horizontalGap = 20;
         };
         this.styleName = "vboxNoSave";
         this.width = 700;
         this.height = 480;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         noSaveAlertWindow._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : Button
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnCloseTop(param1:Button) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      private function closeWindow(param1:Event) : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      override public function initialize() : void
      {
         var target:noSaveAlertWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._noSaveAlertWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_noSaveAlertWindowWatcherSetupUtil");
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
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      private function _noSaveAlertWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","nsawin_warning");
         _loc1_ = UtilDict.toDisplay("go","nsawin_title1");
         _loc1_ = UtilDict.toDisplay("go","nsawin_title2");
         _loc1_ = UtilDict.toDisplay("go","nsawin_tryout");
         _loc1_ = UtilDict.toDisplay("go","nsawin_login");
         _loc1_ = UtilDict.toDisplay("go","nsawin_or");
         _loc1_ = UtilDict.toDisplay("go","nsawin_signup");
         _loc1_ = UtilDict.toDisplay("go","nsawin_enable");
      }
      
      public function ___noSaveAlertWindow_Button2_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      public function ___noSaveAlertWindow_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().showLogin();
      }
      
      public function ___noSaveAlertWindow_Button4_click(param1:MouseEvent) : void
      {
         Console.getConsole().showSignup();
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      private function _noSaveAlertWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_warning");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Label1.text = param1;
         },"_noSaveAlertWindow_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_title1");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Text1.text = param1;
         },"_noSaveAlertWindow_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_title2");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Text2.text = param1;
         },"_noSaveAlertWindow_Text2.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_tryout");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Button2.label = param1;
         },"_noSaveAlertWindow_Button2.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_login");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Button3.label = param1;
         },"_noSaveAlertWindow_Button3.label");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_or");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Label2.text = param1;
         },"_noSaveAlertWindow_Label2.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_signup");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Button4.label = param1;
         },"_noSaveAlertWindow_Button4.label");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","nsawin_enable");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _noSaveAlertWindow_Label3.text = param1;
         },"_noSaveAlertWindow_Label3.text");
         result[7] = binding;
         return result;
      }
   }
}
