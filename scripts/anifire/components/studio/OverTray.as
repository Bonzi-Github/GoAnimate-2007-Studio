package anifire.components.studio
{
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class OverTray extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      private var _1491038559_effectMove:Move;
      
      private var _94886_pw:PropertiesWindow;
      
      mx_internal var _bindings:Array;
      
      private var _1468764923_panel:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function OverTray()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":310,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_panel",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":-320,
                                    "percentHeight":100,
                                    "width":310,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":PropertiesWindow,
                                       "id":"_pw",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"width":310};
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
         this.width = 310;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.cacheAsBitmap = true;
         this._OverTray_Move1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         OverTray._watcherSetupUtil = param1;
      }
      
      public function set _effectMove(param1:Move) : void
      {
         var _loc2_:Object = this._1491038559_effectMove;
         if(_loc2_ !== param1)
         {
            this._1491038559_effectMove = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectMove",_loc2_,param1));
         }
      }
      
      public function get propertiesWindow() : PropertiesWindow
      {
         return this._pw;
      }
      
      [Bindable(event="propertyChange")]
      public function get _panel() : Canvas
      {
         return this._1468764923_panel;
      }
      
      override public function initialize() : void
      {
         var target:OverTray = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._OverTray_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_OverTrayWatcherSetupUtil");
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
      
      public function open() : void
      {
         this._effectMove.stop();
         this._effectMove.xTo = 0;
         this._effectMove.play();
         this._pw.show();
         this._pw.active = true;
      }
      
      public function set _pw(param1:PropertiesWindow) : void
      {
         var _loc2_:Object = this._94886_pw;
         if(_loc2_ !== param1)
         {
            this._94886_pw = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pw",_loc2_,param1));
         }
      }
      
      public function set _panel(param1:Canvas) : void
      {
         var _loc2_:Object = this._1468764923_panel;
         if(_loc2_ !== param1)
         {
            this._1468764923_panel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_panel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectMove() : Move
      {
         return this._1491038559_effectMove;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pw() : PropertiesWindow
      {
         return this._94886_pw;
      }
      
      private function _OverTray_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._panel;
      }
      
      private function _OverTray_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         this._effectMove = _loc1_;
         _loc1_.duration = 500;
         BindingManager.executeBindings(this,"_effectMove",this._effectMove);
         return _loc1_;
      }
      
      public function close(param1:Event = null) : void
      {
         this._effectMove.stop();
         this._effectMove.xTo = -320;
         this._effectMove.play();
         this._pw.hide();
         this._pw.active = false;
      }
      
      private function _OverTray_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return _panel;
         },function(param1:Object):void
         {
            _effectMove.target = param1;
         },"_effectMove.target");
         result[0] = binding;
         return result;
      }
   }
}
