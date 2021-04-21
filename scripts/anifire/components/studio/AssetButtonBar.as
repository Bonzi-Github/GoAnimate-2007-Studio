package anifire.components.studio
{
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.component.DoubleStateButton;
   import anifire.core.AssetGroup;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.Prop;
   import anifire.core.VideoProp;
   import anifire.effect.ZoomEffect;
   import anifire.events.AssetEvent;
   import anifire.interfaces.ISlidable;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class AssetButtonBar extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1282133823fadeIn:Fade;
      
      private var _1827565232_target:Object = null;
      
      private var _1147697068_btnCCLookAtCamera:Button;
      
      mx_internal var _watchers:Array;
      
      private var _2107336172_btnSlide:Button;
      
      private var _2091909055isFullVersion:Boolean = true;
      
      private var _1091436750fadeOut:Fade;
      
      private var _1730971321_btnEdit:Button;
      
      private var _778345880_btnForward:Button;
      
      private var _2112775277_btnMovie:DoubleStateButton;
      
      private var _2122019898_btnColor:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1730933846_btnFlip:Button;
      
      private var _1730334960_btnZoom:Button;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1015222112_btnBackward:Button;
      
      mx_internal var _bindings:Array;
      
      private var _1338722904_btnDelete:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function AssetButtonBar()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {
                  "height":34,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnSlide",
                     "events":{"click":"___btnSlide_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnSlide",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCCLookAtCamera",
                     "events":{"click":"___btnCCLookAtCamera_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnLookAtCamera",
                           "toggle":true,
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
                           "visible":false,
                           "includeInLayout":false,
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
                           "visible":false,
                           "includeInLayout":false,
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
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnBackward",
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
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnZoomIn",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnEdit",
                     "events":{"click":"___btnEdit_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnEdit",
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
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnColor",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DoubleStateButton,
                     "id":"_btnMovie",
                     "events":{
                        "But1Click":"___btnMovie_But1Click",
                        "But2Click":"___btnMovie_But2Click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
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
                     "id":"_btnDelete",
                     "events":{"click":"___btnDelete_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnDelete",
                           "focusEnabled":false,
                           "buttonMode":true
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
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.verticalAlign = "middle";
         };
         this.height = 34;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._AssetButtonBar_Fade1_i();
         this._AssetButtonBar_Fade2_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AssetButtonBar._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnForward() : Button
      {
         return this._778345880_btnForward;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
         }
      }
      
      public function set isFullVersion(param1:Boolean) : void
      {
         var _loc2_:Object = this._2091909055isFullVersion;
         if(_loc2_ !== param1)
         {
            this._2091909055isFullVersion = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isFullVersion",_loc2_,param1));
         }
      }
      
      public function ___btnBackward_click(param1:MouseEvent) : void
      {
         Console.getConsole().sendBackward();
      }
      
      public function ___btnMovie_But2Click(param1:Event) : void
      {
         Console.getConsole().pauseMovie();
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
      
      override public function initialize() : void
      {
         var target:AssetButtonBar = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._AssetButtonBar_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_AssetButtonBarWatcherSetupUtil");
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
      
      public function ___btnForward_click(param1:MouseEvent) : void
      {
         Console.getConsole().bringForward();
      }
      
      public function ___btnFlip_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipAsset();
      }
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         Console.getConsole().deleteAsset();
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
      
      [Bindable(event="propertyChange")]
      public function get _btnBackward() : Button
      {
         return this._1015222112_btnBackward;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSlide() : Button
      {
         return this._2107336172_btnSlide;
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
      
      public function set target(param1:Object) : void
      {
         if(this._target && this._target is Character)
         {
            Character(this._target).removeEventListener(AssetEvent.ACTION_CHANGE,this.onCharActionChange);
         }
         this._target = param1;
         this._btnBackward.visible = this._btnBackward.includeInLayout = false;
         this._btnCCLookAtCamera.visible = this._btnCCLookAtCamera.includeInLayout = false;
         this._btnColor.visible = this._btnColor.includeInLayout = false;
         this._btnDelete.visible = this._btnDelete.includeInLayout = false;
         this._btnEdit.visible = this._btnEdit.includeInLayout = false;
         this._btnFlip.visible = this._btnFlip.includeInLayout = false;
         this._btnForward.visible = this._btnForward.includeInLayout = false;
         this._btnMovie.visible = this._btnMovie.includeInLayout = false;
         this._btnSlide.visible = this._btnSlide.includeInLayout = false;
         this._btnZoom.visible = this._btnZoom.includeInLayout = false;
         if(param1)
         {
            if(param1 is Background)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
            }
            else if(param1 is AssetGroup)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               if(param1 is ISlidable && ISlidable(param1).slideEnabled)
               {
                  this._btnSlide.includeInLayout = this._btnSlide.visible = true;
                  this._btnSlide.selected = ISlidable(param1).isSliding;
               }
            }
            else if(param1 is VideoProp)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               this._btnBackward.visible = this._btnBackward.includeInLayout = true;
               this._btnForward.visible = this._btnForward.includeInLayout = true;
               this._btnFlip.visible = this._btnFlip.includeInLayout = true;
            }
            else if(param1 is Prop)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               this._btnBackward.visible = this._btnBackward.includeInLayout = true;
               this._btnForward.visible = this._btnForward.includeInLayout = true;
               this._btnFlip.visible = this._btnFlip.includeInLayout = true;
               if(param1 is ISlidable && ISlidable(param1).slideEnabled && this.isFullVersion)
               {
                  this._btnSlide.includeInLayout = this._btnSlide.visible = true;
                  this._btnSlide.selected = ISlidable(param1).isSliding;
               }
            }
            else if(param1 is Character)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               this._btnBackward.visible = this._btnBackward.includeInLayout = true;
               this._btnForward.visible = this._btnForward.includeInLayout = true;
               this._btnFlip.visible = this._btnFlip.includeInLayout = true;
               Character(param1).addEventListener(AssetEvent.ACTION_CHANGE,this.onCharActionChange);
            }
            else if(param1 is BubbleAsset)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               this._btnBackward.visible = this._btnBackward.includeInLayout = true;
               this._btnForward.visible = this._btnForward.includeInLayout = true;
            }
            else if(param1 is EffectAsset)
            {
               this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               if(EffectAsset(param1).effect is ZoomEffect && this.isFullVersion)
               {
                  this._btnZoom.visible = this._btnZoom.includeInLayout = true;
                  this._btnZoom.selected = Console.getConsole().mainStage.isCameraMode;
               }
            }
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
      
      public function set _btnCCLookAtCamera(param1:Button) : void
      {
         var _loc2_:Object = this._1147697068_btnCCLookAtCamera;
         if(_loc2_ !== param1)
         {
            this._1147697068_btnCCLookAtCamera = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCCLookAtCamera",_loc2_,param1));
         }
      }
      
      private function _AssetButtonBar_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeIn = _loc1_;
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function ___btnSlide_click(param1:MouseEvent) : void
      {
         this.onSlideBtnClick();
      }
      
      private function onSlideBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._target is ISlidable)
         {
            if(this._btnSlide.selected)
            {
               _loc1_ = new ChangeActionCommand();
               _loc1_.execute();
               ISlidable(this._target).startSlideMotion();
            }
            else
            {
               _loc1_ = new RemoveMotionCommand();
               _loc1_.execute();
               ISlidable(this._target).removeSlideMotion();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _target() : Object
      {
         return this._1827565232_target;
      }
      
      private function _AssetButtonBar_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return fadeIn;
         },function(param1:*):void
         {
            this.setStyle("showEffect",param1);
         },"this.showEffect");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Slide");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSlide.toolTip = param1;
         },"_btnSlide.toolTip");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Look at Camera");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCCLookAtCamera.toolTip = param1;
         },"_btnCCLookAtCamera.toolTip");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_flip");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnFlip.toolTip = param1;
         },"_btnFlip.toolTip");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_forward");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnForward.toolTip = param1;
         },"_btnForward.toolTip");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_backward");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnBackward.toolTip = param1;
         },"_btnBackward.toolTip");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnZoom.toolTip = param1;
         },"_btnZoom.toolTip");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_edit");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnEdit.toolTip = param1;
         },"_btnEdit.toolTip");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_color");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnColor.toolTip = param1;
         },"_btnColor.toolTip");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_delete");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnDelete.toolTip = param1;
         },"_btnDelete.toolTip");
         result[9] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnColor() : Button
      {
         return this._2122019898_btnColor;
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
      
      private function _AssetButtonBar_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.fadeIn;
         _loc1_ = UtilDict.toDisplay("go","Slide");
         _loc1_ = UtilDict.toDisplay("go","Look at Camera");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_flip");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_forward");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_backward");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_edit");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_color");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_delete");
      }
      
      public function ___btnCCLookAtCamera_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipCCLookAtCamera();
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
      
      public function set _btnZoom(param1:Button) : void
      {
         var _loc2_:Object = this._1730334960_btnZoom;
         if(_loc2_ !== param1)
         {
            this._1730334960_btnZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnZoom",_loc2_,param1));
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
      
      private function set _target(param1:Object) : void
      {
         var _loc2_:Object = this._1827565232_target;
         if(_loc2_ !== param1)
         {
            this._1827565232_target = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_target",_loc2_,param1));
         }
      }
      
      public function set _btnSlide(param1:Button) : void
      {
         var _loc2_:Object = this._2107336172_btnSlide;
         if(_loc2_ !== param1)
         {
            this._2107336172_btnSlide = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSlide",_loc2_,param1));
         }
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
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
      
      private function _AssetButtonBar_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeOut = _loc1_;
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get isFullVersion() : Boolean
      {
         return this._2091909055isFullVersion;
      }
      
      public function ___btnZoom_click(param1:MouseEvent) : void
      {
         this.onZoomBtnClick();
      }
      
      private function onCharActionChange(param1:AssetEvent) : void
      {
         this._btnSlide.selected = Character(this._target).isSliding;
      }
      
      private function onZoomBtnClick() : void
      {
         var _loc1_:MainStage = Console.getConsole().mainStage;
         if(_loc1_)
         {
            if(this._btnZoom.selected)
            {
               _loc1_.showCameraView();
               this._btnZoom.toolTip = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
            }
            else
            {
               _loc1_.hideCameraView();
               this._btnZoom.toolTip = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
            }
         }
      }
   }
}
