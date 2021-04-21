package anifire.components.containers
{
   import anifire.component.IconTextButton;
   import anifire.constant.ServerConstants;
   import anifire.core.BubbleAsset;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   
   use namespace mx_internal;
   
   public class AssetHyperLink extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _937875327_btnRemove:Button;
      
      private var _bubbleAsset:BubbleAsset;
      
      mx_internal var _watchers:Array;
      
      private var _1855272044txtURLBox:TextInput;
      
      public var _AssetHyperLink_SetProperty1:SetProperty;
      
      public var _AssetHyperLink_SetProperty2:SetProperty;
      
      public var _AssetHyperLink_SetProperty3:SetProperty;
      
      public var _AssetHyperLink_Label1:Label;
      
      public var _AssetHyperLink_SetProperty4:SetProperty;
      
      private var DEFAULT_URL:String;
      
      private var _66491520mainContent:VBox;
      
      private var _205984886btnLink:IconTextButton;
      
      private var _1098683047hostURL:Label;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _859623201txtURL:TextInput;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function AssetHyperLink()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":IconTextButton,
                  "id":"btnLink",
                  "events":{"click":"__btnLink_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "labelPlacement":"right",
                        "styleName":"btnBubbleLink",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "id":"mainContent",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "includeInLayout":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_AssetHyperLink_Label1",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 10;
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":HBox,
                                 "stylesFactory":function():void
                                 {
                                    this.horizontalGap = 0;
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"hostURL",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"text":"http://goanimate.com/"};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":TextInput,
                                       "id":"txtURL",
                                       "events":{
                                          "focusIn":"__txtURL_focusIn",
                                          "focusOut":"__txtURL_focusOut",
                                          "textInput":"__txtURL_textInput",
                                          "change":"__txtURL_change"
                                       },
                                       "stylesFactory":function():void
                                       {
                                          this.color = 0;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":120,
                                             "maxChars":99,
                                             "restrict":"a-z A-Z 0-9 _~\\-/"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnRemove",
                                 "events":{"click":"___btnRemove_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"btnLinkRemove",
                                       "y":4,
                                       "buttonMode":true
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"txtURLBox",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "x":10,
                                       "width":400,
                                       "height":32,
                                       "maxChars":256,
                                       "visible":false,
                                       "includeInLayout":false
                                    };
                                 }
                              })]};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this.DEFAULT_URL = UtilDict.toDisplay("go","hlwin_default");
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.states = [this._AssetHyperLink_State1_c()];
         this.addEventListener("creationComplete",this.___AssetHyperLink_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AssetHyperLink._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get mainContent() : VBox
      {
         return this._66491520mainContent;
      }
      
      private function onUrlFocusOut(param1:Event) : void
      {
         if(this.txtURL.text == "")
         {
            this.txtURL.text = this.DEFAULT_URL;
         }
      }
      
      public function set mainContent(param1:VBox) : void
      {
         var _loc2_:Object = this._66491520mainContent;
         if(_loc2_ !== param1)
         {
            this._66491520mainContent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainContent",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRemove() : Button
      {
         return this._937875327_btnRemove;
      }
      
      public function set _btnRemove(param1:Button) : void
      {
         var _loc2_:Object = this._937875327_btnRemove;
         if(_loc2_ !== param1)
         {
            this._937875327_btnRemove = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRemove",_loc2_,param1));
         }
      }
      
      private function _AssetHyperLink_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add link");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnLink.label = param1;
         },"btnLink.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_subtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _AssetHyperLink_Label1.text = param1;
         },"_AssetHyperLink_Label1.text");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return txtURL.x + txtURL.width - _btnRemove.width - 4;
         },function(param1:Number):void
         {
            _btnRemove.x = param1;
         },"_btnRemove.x");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return mainContent;
         },function(param1:Object):void
         {
            _AssetHyperLink_SetProperty1.target = param1;
         },"_AssetHyperLink_SetProperty1.target");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return mainContent;
         },function(param1:Object):void
         {
            _AssetHyperLink_SetProperty2.target = param1;
         },"_AssetHyperLink_SetProperty2.target");
         result[4] = binding;
         binding = new Binding(this,function():Object
         {
            return btnLink;
         },function(param1:Object):void
         {
            _AssetHyperLink_SetProperty3.target = param1;
         },"_AssetHyperLink_SetProperty3.target");
         result[5] = binding;
         binding = new Binding(this,function():Object
         {
            return btnLink;
         },function(param1:Object):void
         {
            _AssetHyperLink_SetProperty4.target = param1;
         },"_AssetHyperLink_SetProperty4.target");
         result[6] = binding;
         return result;
      }
      
      private function _AssetHyperLink_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "expand";
         _loc1_.overrides = [this._AssetHyperLink_SetProperty1_i(),this._AssetHyperLink_SetProperty2_i(),this._AssetHyperLink_SetProperty3_i(),this._AssetHyperLink_SetProperty4_i()];
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._AssetHyperLink_SetProperty3 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty3",this._AssetHyperLink_SetProperty3);
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._AssetHyperLink_SetProperty1 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty1",this._AssetHyperLink_SetProperty1);
         return _loc1_;
      }
      
      private function onUrlInput(param1:TextEvent) : void
      {
         if(param1.text.indexOf(this.hostURL.text) == 0)
         {
            this.txtURL.text = param1.text.substr(this.hostURL.text.length);
            param1.preventDefault();
            this.saveURL();
         }
      }
      
      public function __txtURL_focusIn(param1:FocusEvent) : void
      {
         this.onUrlFocusIn(param1);
      }
      
      override public function initialize() : void
      {
         var target:AssetHyperLink = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._AssetHyperLink_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetHyperLinkWatcherSetupUtil");
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
      
      public function set target(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1 is BubbleAsset)
         {
            this._bubbleAsset = BubbleAsset(param1);
            _loc2_ = this._bubbleAsset.bubble.textURL;
            if(_loc2_ && _loc2_ != "")
            {
               this.currentState = "expand";
               this.txtURL.text = _loc2_;
            }
            else
            {
               this.currentState = "";
               this.txtURL.text = this.DEFAULT_URL;
            }
         }
      }
      
      public function ___btnRemove_click(param1:MouseEvent) : void
      {
         this.reset();
      }
      
      public function __txtURL_textInput(param1:TextEvent) : void
      {
         this.onUrlInput(param1);
      }
      
      public function ___AssetHyperLink_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __txtURL_change(param1:Event) : void
      {
         this.onUrlChange(param1);
      }
      
      private function init() : void
      {
         this.hostURL.text = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         this.txtURL.visible = !(this.txtURLBox.visible = UtilLicense.isBoxEnvironment());
      }
      
      [Bindable(event="propertyChange")]
      public function get hostURL() : Label
      {
         return this._1098683047hostURL;
      }
      
      private function saveURL() : void
      {
         var _loc1_:String = this.txtURL.text;
         if(UtilLicense.isBoxEnvironment())
         {
            _loc1_ = this.txtURLBox.text;
            if(_loc1_.indexOf(UtilLicense.boxParentSiteBaseURL) < 0)
            {
               Alert.show("You are not allowed to embed external links");
               return;
            }
         }
         if(_loc1_ != this.DEFAULT_URL && this._bubbleAsset)
         {
            this._bubbleAsset.bubble.textURL = _loc1_;
         }
      }
      
      public function set txtURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._859623201txtURL;
         if(_loc2_ !== param1)
         {
            this._859623201txtURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtURL",_loc2_,param1));
         }
      }
      
      public function __btnLink_click(param1:MouseEvent) : void
      {
         this.currentState = "expand";
      }
      
      private function _AssetHyperLink_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._AssetHyperLink_SetProperty4 = _loc1_;
         _loc1_.name = "includeInLayout";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty4",this._AssetHyperLink_SetProperty4);
         return _loc1_;
      }
      
      private function reset() : void
      {
         if(this._bubbleAsset)
         {
            this._bubbleAsset.bubble.textURL = "";
         }
         this.txtURL.text = this.DEFAULT_URL;
         this.currentState = "";
      }
      
      public function __txtURL_focusOut(param1:FocusEvent) : void
      {
         this.onUrlFocusOut(param1);
      }
      
      private function _AssetHyperLink_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._AssetHyperLink_SetProperty2 = _loc1_;
         _loc1_.name = "includeInLayout";
         _loc1_.value = true;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty2",this._AssetHyperLink_SetProperty2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get txtURL() : TextInput
      {
         return this._859623201txtURL;
      }
      
      private function onUrlChange(param1:Event) : void
      {
         this.saveURL();
      }
      
      private function _AssetHyperLink_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Add link");
         _loc1_ = UtilDict.toDisplay("go","hlwin_subtitle");
         _loc1_ = this.txtURL.x + this.txtURL.width - this._btnRemove.width - 4;
         _loc1_ = this.mainContent;
         _loc1_ = this.mainContent;
         _loc1_ = this.btnLink;
         _loc1_ = this.btnLink;
      }
      
      public function set hostURL(param1:Label) : void
      {
         var _loc2_:Object = this._1098683047hostURL;
         if(_loc2_ !== param1)
         {
            this._1098683047hostURL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hostURL",_loc2_,param1));
         }
      }
      
      public function set txtURLBox(param1:TextInput) : void
      {
         var _loc2_:Object = this._1855272044txtURLBox;
         if(_loc2_ !== param1)
         {
            this._1855272044txtURLBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtURLBox",_loc2_,param1));
         }
      }
      
      private function onUrlFocusIn(param1:Event) : void
      {
         if(this.txtURL.text == this.DEFAULT_URL)
         {
            this.txtURL.text = "";
         }
      }
      
      public function set btnLink(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._205984886btnLink;
         if(_loc2_ !== param1)
         {
            this._205984886btnLink = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLink",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtURLBox() : TextInput
      {
         return this._1855272044txtURLBox;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnLink() : IconTextButton
      {
         return this._205984886btnLink;
      }
   }
}
