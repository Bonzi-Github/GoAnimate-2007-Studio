package anifire.components.studio
{
   import anifire.component.DoubleStateButton;
   import anifire.core.Console;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class ControlButtonBar extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1147697068_btnCCLookAtCamera:Button;
      
      mx_internal var _watchers:Array;
      
      private var _1730971321_btnEdit:Button;
      
      private var _2112775277_btnMovie:DoubleStateButton;
      
      private var _778345880_btnForward:Button;
      
      private var _2122019898_btnColor:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _btnHash:UtilHashArray;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1730933846_btnFlip:Button;
      
      private var _1730334960_btnZoom:Button;
      
      private var _1015222112_btnBackward:Button;
      
      mx_internal var _bindings:Array;
      
      private var _1338722904_btnDelete:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ControlButtonBar()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":0,
                  "height":37,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":DoubleStateButton,
                     "id":"_btnMovie",
                     "events":{
                        "But1Click":"___btnMovie_But1Click",
                        "But2Click":"___btnMovie_But2Click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "but1StyleName":"btnFlip",
                           "but2StyleName":"btnFlip",
                           "toolTip":"play/pause movie",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnFlip",
                     "events":{"click":"___btnFlip_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnFlip",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnForward",
                     "events":{"click":"___btnForward_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnForward",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnBackward",
                     "events":{"click":"___btnBackward_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnBackward",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnDelete",
                     "events":{"click":"___btnDelete_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnDelete",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnEdit",
                     "events":{"click":"___btnEdit_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnEdit",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnZoom",
                     "events":{"click":"___btnZoom_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnZoomIn",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnColor",
                     "events":{"click":"___btnColor_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnColor",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCCLookAtCamera",
                     "events":{"click":"___btnCCLookAtCamera_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":-999,
                           "y":-999,
                           "width":28,
                           "height":28,
                           "styleName":"btnLookAtCamera",
                           "toggle":true,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  })]
               };
            }
         });
         this._btnHash = new UtilHashArray();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.width = 0;
         this.height = 37;
         this.styleName = "controlButtonBar";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ControlButtonBar._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnForward() : Button
      {
         return this._778345880_btnForward;
      }
      
      public function ___btnBackward_click(param1:MouseEvent) : void
      {
         Console.getConsole().sendBackward();
      }
      
      public function ___btnMovie_But2Click(param1:Event) : void
      {
         Console.getConsole().pauseMovie();
      }
      
      public function set _btnColor(param1:Button) : void
      {
         var _loc2_:Object = this._2122019898_btnColor;
         if(_loc2_ !== param1)
         {
            this._2122019898_btnColor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnColor",_loc2_,param1));
         }
      }
      
      public function set _btnEdit(param1:Button) : void
      {
         var _loc2_:Object = this._1730971321_btnEdit;
         if(_loc2_ !== param1)
         {
            this._1730971321_btnEdit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEdit",_loc2_,param1));
         }
      }
      
      public function ___btnForward_click(param1:MouseEvent) : void
      {
         Console.getConsole().bringForward();
      }
      
      public function ___btnFlip_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipAsset();
      }
      
      override public function initialize() : void
      {
         var target:ControlButtonBar = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._ControlButtonBar_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ControlButtonBarWatcherSetupUtil");
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
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         Console.getConsole().deleteAsset();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBackward() : Button
      {
         return this._1015222112_btnBackward;
      }
      
      public function set _btnMovie(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._2112775277_btnMovie;
         if(_loc2_ !== param1)
         {
            this._2112775277_btnMovie = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMovie",_loc2_,param1));
         }
      }
      
      public function set _btnZoom(param1:Button) : void
      {
         var _loc2_:Object = this._1730334960_btnZoom;
         if(_loc2_ !== param1)
         {
            this._1730334960_btnZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnZoom",_loc2_,param1));
         }
      }
      
      public function set _btnCCLookAtCamera(param1:Button) : void
      {
         var _loc2_:Object = this._1147697068_btnCCLookAtCamera;
         if(_loc2_ !== param1)
         {
            this._1147697068_btnCCLookAtCamera = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCCLookAtCamera",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFlip() : Button
      {
         return this._1730933846_btnFlip;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMovie() : DoubleStateButton
      {
         return this._2112775277_btnMovie;
      }
      
      public function init(param1:int = -1, param2:int = -2, param3:int = -3, param4:int = -4, param5:int = -5, param6:int = -6, param7:int = -7, param8:int = -8, param9:int = -9) : void
      {
         var _loc11_:Object = null;
         var _loc12_:int = 0;
         this._btnHash.removeAll();
         this._btnHash.push(param1.toString(),this._btnFlip);
         this._btnHash.push(param2.toString(),this._btnForward);
         this._btnHash.push(param3.toString(),this._btnBackward);
         this._btnHash.push(param4.toString(),this._btnDelete);
         this._btnHash.push(param5.toString(),this._btnEdit);
         this._btnHash.push(param6.toString(),this._btnZoom);
         this._btnHash.push(param7.toString(),this._btnColor);
         this._btnHash.push(param8.toString(),this._btnMovie);
         this._btnHash.push(param9.toString(),this._btnCCLookAtCamera);
         var _loc10_:int = 0;
         var _loc13_:int = 8;
         var _loc14_:int = 28;
         var _loc15_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < this._btnHash.length)
         {
            _loc12_ = Number(this._btnHash.getKey(_loc10_));
            _loc11_ = this._btnHash.getValueByKey(this._btnHash.getKey(_loc10_));
            Object(_loc11_).visible = _loc12_ > -1?true:false;
            Object(_loc11_).enabled = _loc12_ > -1?true:false;
            if(_loc12_ > -1)
            {
               Object(_loc11_).x = Object(_loc11_).width * _loc12_ + 8 * (_loc12_ + 1);
               Object(_loc11_).y = 5;
               _loc15_++;
            }
            _loc10_++;
         }
         this.width = _loc15_ * (_loc14_ + _loc13_) + _loc13_;
         this.scaleX = this.scaleY = 1 / Console.getConsole().stageScale;
      }
      
      private function _ControlButtonBar_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_flip");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_forward");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_backward");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_delete");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_edit");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_color");
         _loc1_ = UtilDict.toDisplay("go","Look at Camera");
      }
      
      public function ___btnCCLookAtCamera_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipCCLookAtCamera();
      }
      
      public function set _btnBackward(param1:Button) : void
      {
         var _loc2_:Object = this._1015222112_btnBackward;
         if(_loc2_ !== param1)
         {
            this._1015222112_btnBackward = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBackward",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnColor() : Button
      {
         return this._2122019898_btnColor;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEdit() : Button
      {
         return this._1730971321_btnEdit;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCCLookAtCamera() : Button
      {
         return this._1147697068_btnCCLookAtCamera;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelete() : Button
      {
         return this._1338722904_btnDelete;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnZoom() : Button
      {
         return this._1730334960_btnZoom;
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
      
      public function set _btnFlip(param1:Button) : void
      {
         var _loc2_:Object = this._1730933846_btnFlip;
         if(_loc2_ !== param1)
         {
            this._1730933846_btnFlip = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFlip",_loc2_,param1));
         }
      }
      
      public function set _btnForward(param1:Button) : void
      {
         var _loc2_:Object = this._778345880_btnForward;
         if(_loc2_ !== param1)
         {
            this._778345880_btnForward = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnForward",_loc2_,param1));
         }
      }
      
      public function ___btnMovie_But1Click(param1:Event) : void
      {
         Console.getConsole().playMovie();
      }
      
      public function ___btnColor_click(param1:MouseEvent) : void
      {
         Console.getConsole().showOverTray();
      }
      
      public function ___btnEdit_click(param1:MouseEvent) : void
      {
         Console.getConsole().editAsset();
      }
      
      private function _ControlButtonBar_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_flip");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnFlip.toolTip = param1;
         },"_btnFlip.toolTip");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_forward");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnForward.toolTip = param1;
         },"_btnForward.toolTip");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_backward");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnBackward.toolTip = param1;
         },"_btnBackward.toolTip");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_delete");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnDelete.toolTip = param1;
         },"_btnDelete.toolTip");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_edit");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnEdit.toolTip = param1;
         },"_btnEdit.toolTip");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnZoom.toolTip = param1;
         },"_btnZoom.toolTip");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_color");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnColor.toolTip = param1;
         },"_btnColor.toolTip");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Look at Camera");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCCLookAtCamera.toolTip = param1;
         },"_btnCCLookAtCamera.toolTip");
         result[7] = binding;
         return result;
      }
      
      public function ___btnZoom_click(param1:MouseEvent) : void
      {
         Console.getConsole().lookIntoAsset();
      }
   }
}
