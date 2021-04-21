package anifire.components.studio
{
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class PublishPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal static var _PublishPanel_StylesInit_done:Boolean = false;
       
      
      public var _PublishPanel_Image1:Image;
      
      public var _PublishPanel_Label1:Label;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public var _PublishPanel_Button1:Button;
      
      public var _PublishPanel_Button2:Button;
      
      mx_internal var _watchers:Array;
      
      private var _3327403logo:Class;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public var _PublishPanel_Text1:Text;
      
      public function PublishPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_PublishPanel_Label1",
                        "stylesFactory":function():void
                        {
                           this.paddingTop = 3;
                        },
                        "propertiesFactory":function():Object
                        {
                           return {"styleName":"title"};
                        }
                     }),new UIComponentDescriptor({
                        "type":Image,
                        "id":"_PublishPanel_Image1"
                     })]};
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                     this.verticalGap = 20;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"_PublishPanel_Text1",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 16;
                              this.textAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"selectable":false};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_PublishPanel_Button1",
                           "events":{"click":"___PublishPanel_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnPublic"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_PublishPanel_Button2",
                           "events":{"click":"___PublishPanel_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnPrivate"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._3327403logo = PublishPanel_logo;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         mx_internal::_PublishPanel_StylesInit();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PublishPanel._watcherSetupUtil = param1;
      }
      
      private function _PublishPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Publish your animation to");
         _loc1_ = this.logo;
         _loc1_ = UtilDict.toDisplay("go","Your project is ready!\nIt is time to publish it to your YouTube channel and get those views coming!");
         _loc1_ = UtilDict.toDisplay("go","Publish as Public");
         _loc1_ = UtilDict.toDisplay("go","Publish as Private");
      }
      
      private function _PublishPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish your animation to");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishPanel_Label1.text = param1;
         },"_PublishPanel_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return logo;
         },function(param1:Object):void
         {
            _PublishPanel_Image1.source = param1;
         },"_PublishPanel_Image1.source");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your project is ready!\nIt is time to publish it to your YouTube channel and get those views coming!");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishPanel_Text1.text = param1;
         },"_PublishPanel_Text1.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish as Public");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishPanel_Button1.label = param1;
         },"_PublishPanel_Button1.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish as Private");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishPanel_Button2.label = param1;
         },"_PublishPanel_Button2.label");
         result[4] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var target:PublishPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._PublishPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PublishPanelWatcherSetupUtil");
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
      
      private function onPublicBtnClick() : void
      {
         this.dispatchEvent(new Event("saveAsPublic"));
      }
      
      mx_internal function _PublishPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_PublishPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_PublishPanel_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".btnPublic");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnPublic",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.paddingTop = 16;
               this.textRollOverColor = 16777215;
               this.fontSize = 26;
               this.fillAlphas = [1,1,1,1];
               this.paddingLeft = 40;
               this.themeColor = 16755261;
               this.paddingRight = 40;
               this.fontWeight = "bold";
               this.color = 16777215;
               this.highlightAlphas = [0,0];
               this.fillColors = [16755261,16739840,16755261,16755261];
               this.paddingBottom = 16;
               this.textSelectedColor = 16777215;
            };
         }
         style = StyleManager.getStyleDeclaration(".btnPrivate");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnPrivate",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.paddingTop = 16;
               this.textRollOverColor = 16777215;
               this.fontSize = 16;
               this.fillAlphas = [1,1,1,1];
               this.paddingLeft = 20;
               this.themeColor = 7829367;
               this.paddingRight = 20;
               this.fontWeight = "bold";
               this.color = 16777215;
               this.highlightAlphas = [0,0];
               this.fillColors = [7829367,3355443,7829367,7829367];
               this.paddingBottom = 16;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      private function onPrivateBtnClick() : void
      {
         this.dispatchEvent(new Event("saveAsPrivate"));
      }
      
      private function set logo(param1:Class) : void
      {
         var _loc2_:Object = this._3327403logo;
         if(_loc2_ !== param1)
         {
            this._3327403logo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get logo() : Class
      {
         return this._3327403logo;
      }
      
      public function ___PublishPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onPublicBtnClick();
      }
      
      public function ___PublishPanel_Button2_click(param1:MouseEvent) : void
      {
         this.onPrivateBtnClick();
      }
   }
}
