package anifire.components.containers
{
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class AssetInfoWindow_inlineComponent1 extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _2929478_def:LinkButton;
      
      mx_internal var _watchers:Array;
      
      private var _88844982outerDocument:AssetInfoWindow;
      
      mx_internal var _bindings:Array;
      
      private var _2929484_del:LinkButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public var _AssetInfoWindow_inlineComponent1_Label1:Label;
      
      public function AssetInfoWindow_inlineComponent1()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"_AssetInfoWindow_inlineComponent1_Label1",
                  "stylesFactory":function():void
                  {
                     this.fontSize = 12;
                     this.textAlign = "left";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"width":180};
                  }
               }),new UIComponentDescriptor({
                  "type":LinkButton,
                  "id":"_def",
                  "events":{"click":"___def_click"},
                  "stylesFactory":function():void
                  {
                     this.color = 255;
                     this.fontSize = 11;
                  }
               }),new UIComponentDescriptor({
                  "type":LinkButton,
                  "id":"_del",
                  "events":{"click":"___del_click"},
                  "stylesFactory":function():void
                  {
                     this.color = 255;
                     this.fontSize = 11;
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
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AssetInfoWindow_inlineComponent1._watcherSetupUtil = param1;
      }
      
      public function set outerDocument(param1:AssetInfoWindow) : void
      {
         var _loc2_:Object = this._88844982outerDocument;
         if(_loc2_ !== param1)
         {
            this._88844982outerDocument = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"outerDocument",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get outerDocument() : AssetInfoWindow
      {
         return this._88844982outerDocument;
      }
      
      [Bindable(event="propertyChange")]
      public function get _def() : LinkButton
      {
         return this._2929478_def;
      }
      
      override public function initialize() : void
      {
         var target:AssetInfoWindow_inlineComponent1 = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._AssetInfoWindow_inlineComponent1_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetInfoWindow_inlineComponent1WatcherSetupUtil");
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
      
      public function set _def(param1:LinkButton) : void
      {
         var _loc2_:Object = this._2929478_def;
         if(_loc2_ !== param1)
         {
            this._2929478_def = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_def",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _del() : LinkButton
      {
         return this._2929484_del;
      }
      
      public function set _del(param1:LinkButton) : void
      {
         var _loc2_:Object = this._2929484_del;
         if(_loc2_ !== param1)
         {
            this._2929484_del = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_del",_loc2_,param1));
         }
      }
      
      private function _AssetInfoWindow_inlineComponent1_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.name;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _AssetInfoWindow_inlineComponent1_Label1.text = param1;
         },"_AssetInfoWindow_inlineComponent1_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_default");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _def.label = param1;
         },"_def.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.id;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _def.name = param1;
         },"_def.name");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return data.notDefault;
         },function(param1:Boolean):void
         {
            _def.visible = param1;
         },"_def.visible");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_delete");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _del.label = param1;
         },"_del.label");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return data.notDefault;
         },function(param1:Boolean):void
         {
            _del.visible = param1;
         },"_del.visible");
         result[5] = binding;
         return result;
      }
      
      public function ___def_click(param1:MouseEvent) : void
      {
         data.defaultFunction(data.id);
      }
      
      public function ___del_click(param1:MouseEvent) : void
      {
         data.deleteFunction(data.id);
      }
      
      private function _AssetInfoWindow_inlineComponent1_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = data.name;
         _loc1_ = UtilDict.toDisplay("go","assetinfo_default");
         _loc1_ = data.id;
         _loc1_ = data.notDefault;
         _loc1_ = UtilDict.toDisplay("go","assetinfo_delete");
         _loc1_ = data.notDefault;
      }
   }
}
