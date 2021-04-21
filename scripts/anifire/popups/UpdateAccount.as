package anifire.popups
{
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class UpdateAccount extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal static var _UpdateAccount_StylesInit_done:Boolean = false;
       
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      public var _UpdateAccount_Text1:Text;
      
      public var _UpdateAccount_Text2:Text;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1370988937_btnCancel:Button;
      
      private var _1481128871_btnOk:Button;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function UpdateAccount()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                     this.verticalGap = 20;
                     this.paddingTop = 30;
                     this.paddingBottom = 40;
                     this.paddingLeft = 20;
                     this.paddingRight = 20;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"_UpdateAccount_Text1",
                           "stylesFactory":function():void
                           {
                              this.color = 7829367;
                              this.textAlign = "center";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"_UpdateAccount_Text2",
                           "stylesFactory":function():void
                           {
                              this.color = 0;
                              this.textAlign = "center";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 20;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnOk",
                                 "events":{"click":"___btnOk_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "buttonMode":true,
                                       "styleName":"btnOk"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnCancel",
                                 "events":{"click":"___btnCancel_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "buttonMode":true,
                                       "styleName":"btnCancel"
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
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         mx_internal::_UpdateAccount_StylesInit();
         this.minWidth = 500;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._UpdateAccount_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___UpdateAccount_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         UpdateAccount._watcherSetupUtil = param1;
      }
      
      public function ___btnOk_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      private function draw() : void
      {
         var _loc1_:Number = 10;
         this.graphics.beginFill(14540253,0.5);
         this.graphics.drawRoundRectComplex(0,0,this.width,this.height,20,20,20,20);
         this.graphics.beginFill(14540253,1);
         this.graphics.drawRoundRectComplex(_loc1_,_loc1_,this.width - _loc1_ * 2,this.height - _loc1_ * 2,20,20,20,20);
         this.graphics.endFill();
      }
      
      private function onCancelClick() : void
      {
         PopUpManager.removePopUp(this);
         this.dispatchEvent(new Event("cancelClick"));
      }
      
      override public function initialize() : void
      {
         var target:UpdateAccount = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._UpdateAccount_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_UpdateAccountWatcherSetupUtil");
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
      
      private function _UpdateAccount_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = [this._filterShadow];
         _loc1_ = UtilDict.toDisplay("go","Make animated videos exactly the way you want!");
         _loc1_ = UtilDict.toDisplay("go","Complete the transaction in the browser window that just opened and confirm here to update your account.");
         _loc1_ = UtilDict.toDisplay("go","Confirm");
         _loc1_ = UtilDict.toDisplay("go","Cancel");
      }
      
      public function ___UpdateAccount_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnOk() : Button
      {
         return this._1481128871_btnOk;
      }
      
      private function _UpdateAccount_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         this._filterShadow = _loc1_;
         _loc1_.distance = 0;
         _loc1_.blurX = 5;
         _loc1_.blurY = 5;
         _loc1_.angle = 45;
         _loc1_.color = 0;
         _loc1_.alpha = 0.75;
         return _loc1_;
      }
      
      private function _UpdateAccount_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Array
         {
            return [_filterShadow];
         },function(param1:Array):void
         {
            this.filters = param1;
         },"this.filters");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Make animated videos exactly the way you want!");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _UpdateAccount_Text1.text = param1;
         },"_UpdateAccount_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Complete the transaction in the browser window that just opened and confirm here to update your account.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _UpdateAccount_Text2.text = param1;
         },"_UpdateAccount_Text2.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Confirm");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnOk.label = param1;
         },"_btnOk.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Cancel");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCancel.label = param1;
         },"_btnCancel.label");
         result[4] = binding;
         return result;
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.onCancelClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get _filterShadow() : DropShadowFilter
      {
         return this._18423959_filterShadow;
      }
      
      private function onOkClick() : void
      {
         PopUpManager.removePopUp(this);
         this.dispatchEvent(new Event("okClick"));
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
         }
      }
      
      public function set _btnOk(param1:Button) : void
      {
         var _loc2_:Object = this._1481128871_btnOk;
         if(_loc2_ !== param1)
         {
            this._1481128871_btnOk = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnOk",_loc2_,param1));
         }
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
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      mx_internal function _UpdateAccount_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_UpdateAccount_StylesInit_done)
         {
            return;
         }
         mx_internal::_UpdateAccount_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".btnCancel");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnCancel",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 8947848;
               this.color = 16777215;
               this.cornerRadius = 18;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [8947848,8947848,8947848,8947848];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 8947848;
               this.textSelectedColor = 16777215;
            };
         }
         style = StyleManager.getStyleDeclaration(".btnOk");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnOk",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 13395456;
               this.color = 16777215;
               this.cornerRadius = 18;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [16737792,16737792,16737792,16737792];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 16737792;
               this.textSelectedColor = 16777215;
            };
         }
      }
   }
}
