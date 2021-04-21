package anifire.popups
{
   import anifire.component.IconTextButton;
   import anifire.util.UtilDict;
   import anifire.util.UtilNavigate;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class SchoolUpgradeOnTts extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _SchoolUpgradeOnTts_Button1:Button;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      private var _951530617content:VBox;
      
      mx_internal var _bindings:Array;
      
      public var _SchoolUpgradeOnTts_Text1:Text;
      
      public var _SchoolUpgradeOnTts_Text2:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SchoolUpgradeOnTts()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"content",
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.paddingTop = 10;
                     this.paddingBottom = 10;
                     this.paddingLeft = 10;
                     this.paddingRight = 10;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"_SchoolUpgradeOnTts_Text1",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 18;
                              this.color = 2972302;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"_SchoolUpgradeOnTts_Text2",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"height":10};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_SchoolUpgradeOnTts_Button1",
                           "events":{"click":"___SchoolUpgradeOnTts_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnUpgrade",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"height":10};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":IconTextButton,
                  "events":{"click":"___SchoolUpgradeOnTts_IconTextButton1_click"},
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
               })]};
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
            this.dropShadowEnabled = true;
         };
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___SchoolUpgradeOnTts_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SchoolUpgradeOnTts._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get content() : VBox
      {
         return this._951530617content;
      }
      
      public function set content(param1:VBox) : void
      {
         var _loc2_:Object = this._951530617content;
         if(_loc2_ !== param1)
         {
            this._951530617content = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"content",_loc2_,param1));
         }
      }
      
      private function _SchoolUpgradeOnTts_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Getting more TTS Credits");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SchoolUpgradeOnTts_Text1.text = param1;
         },"_SchoolUpgradeOnTts_Text1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your students have 50 TTS credits per month to use on GoAnimate 4 schools. To get more credits, you can upgrade your account to SchoolPlus.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SchoolUpgradeOnTts_Text2.text = param1;
         },"_SchoolUpgradeOnTts_Text2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Contact us to upgrade");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _SchoolUpgradeOnTts_Button1.label = param1;
         },"_SchoolUpgradeOnTts_Button1.label");
         result[2] = binding;
         return result;
      }
      
      private function draw() : void
      {
         this.content.graphics.beginFill(13421772);
         this.content.graphics.drawRoundRectComplex(0,0,this.content.width,this.content.height,10,10,10,10);
         this.content.graphics.endFill();
      }
      
      public function ___SchoolUpgradeOnTts_IconTextButton1_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      override public function initialize() : void
      {
         var target:SchoolUpgradeOnTts = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SchoolUpgradeOnTts_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil");
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
      
      private function onClose() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function onClick() : void
      {
      }
      
      public function ___SchoolUpgradeOnTts_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function _SchoolUpgradeOnTts_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Getting more TTS Credits");
         _loc1_ = UtilDict.toDisplay("go","Your students have 50 TTS credits per month to use on GoAnimate 4 schools. To get more credits, you can upgrade your account to SchoolPlus.");
         _loc1_ = UtilDict.toDisplay("go","Contact us to upgrade");
      }
      
      private function onUpgradeBtnClick() : void
      {
         UtilNavigate.toUpgradePage();
         this.onClose();
      }
      
      public function ___SchoolUpgradeOnTts_Button1_click(param1:MouseEvent) : void
      {
         this.onUpgradeBtnClick();
      }
   }
}
