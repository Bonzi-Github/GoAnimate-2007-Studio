package anifire.components.containers
{
   import anifire.events.InputWindowEvent;
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HSlider;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class InputWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const MAX_SCENE_DUR:Number = 20;
       
      
      private var _78294167sliderInput:HSlider;
      
      private var _842110778_btnUpdate:Button;
      
      private var _defaultValue:Object = null;
      
      private var _1684008345sliderCanvas:HBox;
      
      mx_internal var _watchers:Array;
      
      private var _1370988937_btnCancel:Button;
      
      private var _minValue:Number;
      
      private var _dataObject:Object;
      
      private var _1376145637textCanvas:Canvas;
      
      private var _1822921585txtSlider:Label;
      
      private var _maxValue:Number;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1706976804inputType:ViewStack;
      
      private var _1598053662_labels:Label;
      
      private var _sliderInterval:Number;
      
      mx_internal var _bindings:Array;
      
      private var _1474385094txtInput:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function InputWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.backgroundSize = "100%";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":0,
                        "y":0,
                        "percentWidth":100,
                        "percentHeight":100,
                        "styleName":"popupAssetInfoWindow"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.left = "15";
                     this.right = "15";
                     this.top = "10";
                     this.bottom = "10";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_labels",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 22;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"text":""};
                           }
                        }),new UIComponentDescriptor({
                           "type":ViewStack,
                           "id":"inputType",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"textCanvas",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":TextInput,
                                          "id":"txtInput",
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "width":100,
                                                "height":25
                                             };
                                          }
                                       })]};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"sliderCanvas",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":HSlider,
                                          "id":"sliderInput",
                                          "events":{"change":"__sliderInput_change"},
                                          "stylesFactory":function():void
                                          {
                                             this.showTrackHighlight = false;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"goslider",
                                                "percentWidth":100,
                                                "showDataTip":false,
                                                "allowTrackClick":true,
                                                "liveDragging":true,
                                                "visible":true,
                                                "useHandCursor":true,
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"txtSlider",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"width":32};
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.horizontalGap = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnUpdate",
                                    "events":{"click":"___btnUpdate_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnBlack",
                                          "buttonMode":true,
                                          "width":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnCancel",
                                    "events":{"click":"___btnCancel_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnBlack",
                                          "buttonMode":true,
                                          "width":100
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
         this.layout = "absolute";
         this.addEventListener("creationComplete",this.___InputWindow_TitleWindow1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         InputWindow._watcherSetupUtil = param1;
      }
      
      private function updateSliderValue() : void
      {
         this.txtSlider.text = this.sliderInput.value.toString();
      }
      
      public function get dataObject() : Object
      {
         return this._dataObject;
      }
      
      public function set _btnUpdate(param1:Button) : void
      {
         var _loc2_:Object = this._842110778_btnUpdate;
         if(_loc2_ !== param1)
         {
            this._842110778_btnUpdate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnUpdate",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:InputWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._InputWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_InputWindowWatcherSetupUtil");
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
      
      public function set dataObject(param1:Object) : void
      {
         this._dataObject = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get sliderCanvas() : HBox
      {
         return this._1684008345sliderCanvas;
      }
      
      public function init(param1:String, param2:String = "", param3:String = "slider", param4:Object = null, param5:Number = 0, param6:Number = 0, param7:Number = 0.1) : void
      {
         this._labels.text = param1;
         this.x = (this.parent.width - this.width) / 2;
         this.y = (this.parent.height - this.height) / 2;
         this.styleName = param2;
         if(param3 == "slider")
         {
            this.inputType.selectedChild = this.sliderCanvas;
            this._defaultValue = param4;
            this._maxValue = param6;
            this._minValue = param5;
            this._sliderInterval = param7;
         }
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.onClickCancel();
      }
      
      [Bindable(event="propertyChange")]
      public function get inputType() : ViewStack
      {
         return this._1706976804inputType;
      }
      
      public function __sliderInput_change(param1:SliderEvent) : void
      {
         this.updateSliderValue();
      }
      
      public function ___btnUpdate_click(param1:MouseEvent) : void
      {
         this.onClickSubmit();
      }
      
      public function set sliderCanvas(param1:HBox) : void
      {
         var _loc2_:Object = this._1684008345sliderCanvas;
         if(_loc2_ !== param1)
         {
            this._1684008345sliderCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderCanvas",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labels() : Label
      {
         return this._1598053662_labels;
      }
      
      [Bindable(event="propertyChange")]
      public function get txtInput() : TextInput
      {
         return this._1474385094txtInput;
      }
      
      private function onClickCancel() : void
      {
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnUpdate() : Button
      {
         return this._842110778_btnUpdate;
      }
      
      public function set inputType(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1706976804inputType;
         if(_loc2_ !== param1)
         {
            this._1706976804inputType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inputType",_loc2_,param1));
         }
      }
      
      private function _InputWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_update");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnUpdate.label = param1;
         },"_btnUpdate.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_cancel");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCancel.label = param1;
         },"_btnCancel.label");
         result[1] = binding;
         return result;
      }
      
      private function reset() : void
      {
         var _loc1_:Number = NaN;
         if(this.inputType.selectedChild == this.sliderCanvas)
         {
            _loc1_ = this._defaultValue as Number;
            if(_loc1_ >= this._minValue && _loc1_ <= this._maxValue)
            {
               this.sliderInput.value = _loc1_;
               this.txtSlider.text = _loc1_.toString();
            }
            else
            {
               this.sliderInput.value = this._maxValue;
               this.txtSlider.text = this._maxValue.toString();
            }
         }
         this.sliderInput.snapInterval = this._sliderInterval;
         this.sliderInput.minimum = this._minValue;
         this.sliderInput.maximum = this._maxValue;
      }
      
      public function set sliderInput(param1:HSlider) : void
      {
         var _loc2_:Object = this._78294167sliderInput;
         if(_loc2_ !== param1)
         {
            this._78294167sliderInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderInput",_loc2_,param1));
         }
      }
      
      public function set _labels(param1:Label) : void
      {
         var _loc2_:Object = this._1598053662_labels;
         if(_loc2_ !== param1)
         {
            this._1598053662_labels = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labels",_loc2_,param1));
         }
      }
      
      public function set textCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1376145637textCanvas;
         if(_loc2_ !== param1)
         {
            this._1376145637textCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textCanvas",_loc2_,param1));
         }
      }
      
      private function _InputWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","assetinfo_update");
         _loc1_ = UtilDict.toDisplay("go","assetinfo_cancel");
      }
      
      private function onClickSubmit() : void
      {
         var _loc1_:Object = this.sliderInput.value;
         var _loc2_:InputWindowEvent = new InputWindowEvent(InputWindowEvent.INPUT_SUBMIT);
         _loc2_.inputValue = _loc1_;
         _loc2_.dataObject = this.dataObject;
         this.dispatchEvent(_loc2_);
         this.close();
      }
      
      public function ___InputWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.reset();
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
      
      [Bindable(event="propertyChange")]
      public function get sliderInput() : HSlider
      {
         return this._78294167sliderInput;
      }
      
      [Bindable(event="propertyChange")]
      public function get txtSlider() : Label
      {
         return this._1822921585txtSlider;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      public function set txtSlider(param1:Label) : void
      {
         var _loc2_:Object = this._1822921585txtSlider;
         if(_loc2_ !== param1)
         {
            this._1822921585txtSlider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtSlider",_loc2_,param1));
         }
      }
      
      public function set txtInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1474385094txtInput;
         if(_loc2_ !== param1)
         {
            this._1474385094txtInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtInput",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textCanvas() : Canvas
      {
         return this._1376145637textCanvas;
      }
   }
}
