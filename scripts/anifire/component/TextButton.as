package anifire.component
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class TextButton extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1041423681_txtDecoration:String;
      
      mx_internal var _watchers:Array;
      
      private var _1389382606_txtColor:uint;
      
      private var _115312txt:Text;
      
      private var _widthOverride:Boolean = false;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _442062729_txtWeight:String;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _txtSize:Number = 15;
      
      private var _txtAlign:String = "left";
      
      private var _clickFunc:Function;
      
      private var _label:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function TextButton()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Text,
                  "id":"txt",
                  "stylesFactory":function():void
                  {
                     this.fontSize = 15;
                     this.textAlign = "left";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":0,
                        "y":0
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"hitArea",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":0,
                        "y":0,
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               })]};
            }
         });
         this._clickFunc = new Function();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.autoLayout = true;
         this.addEventListener("creationComplete",this.___TextButton_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TextButton._watcherSetupUtil = param1;
      }
      
      override public function set percentWidth(param1:Number) : void
      {
         this._widthOverride = true;
         super.percentWidth = param1;
         invalidateSize();
         invalidateProperties();
      }
      
      private function doRollOut(param1:Event) : void
      {
         this.txt.setStyle("textDecoration",this._txtDecoration);
      }
      
      override public function set width(param1:Number) : void
      {
         this._widthOverride = true;
         super.width = param1;
         invalidateSize();
         invalidateProperties();
      }
      
      private function _TextButton_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _txtDecoration;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            txt.setStyle("textDecoration",param1);
         },"txt.textDecoration");
         result[0] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var target:TextButton = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._TextButton_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_TextButtonWatcherSetupUtil");
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
      
      private function set _txtDecoration(param1:String) : void
      {
         var _loc2_:Object = this._1041423681_txtDecoration;
         if(_loc2_ !== param1)
         {
            this._1041423681_txtDecoration = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDecoration",_loc2_,param1));
         }
      }
      
      private function set _txtWeight(param1:String) : void
      {
         var _loc2_:Object = this._442062729_txtWeight;
         if(_loc2_ !== param1)
         {
            this._442062729_txtWeight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWeight",_loc2_,param1));
         }
      }
      
      public function set txtWeight(param1:String) : void
      {
         this._txtWeight = param1;
         invalidateSize();
         invalidateProperties();
      }
      
      public function set txtSize(param1:Number) : void
      {
         this._txtSize = param1;
         invalidateSize();
         invalidateProperties();
      }
      
      private function doRollOver(param1:Event) : void
      {
         this.txt.setStyle("textDecoration","none");
      }
      
      [Bindable(event="propertyChange")]
      private function get _txtWeight() : String
      {
         return this._442062729_txtWeight;
      }
      
      private function _clickFunc_in(param1:Event) : void
      {
         this._clickFunc(param1);
      }
      
      [Bindable(event="propertyChange")]
      private function get _txtColor() : uint
      {
         return this._1389382606_txtColor;
      }
      
      private function _TextButton_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._txtDecoration;
      }
      
      public function init() : void
      {
         this.txt.selectable = false;
         hitArea.addEventListener(MouseEvent.ROLL_OVER,this.doRollOver);
         hitArea.addEventListener(MouseEvent.ROLL_OUT,this.doRollOut);
         hitArea.addEventListener(MouseEvent.CLICK,this._clickFunc_in);
         hitArea.buttonMode = true;
         hitArea.useHandCursor = true;
      }
      
      [Bindable(event="propertyChange")]
      private function get _txtDecoration() : String
      {
         return this._1041423681_txtDecoration;
      }
      
      override public function styleChanged(param1:String) : void
      {
         var _loc2_:* = undefined;
         super.styleChanged(param1);
         if(param1 == "color" || param1 == null)
         {
            _loc2_ = getStyle("color");
            if(_loc2_ != undefined)
            {
               this.color = uint(_loc2_);
               invalidateDisplayList();
            }
         }
      }
      
      public function set color(param1:uint) : void
      {
         this._txtColor = param1;
         invalidateProperties();
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         this.txt.text = this._label;
      }
      
      public function set clickFunc(param1:Function) : void
      {
         this._clickFunc = param1;
      }
      
      override protected function measure() : void
      {
         if(!this._widthOverride)
         {
            this.measuredWidth = this.txt.getExplicitOrMeasuredWidth();
         }
         else
         {
            this.measuredWidth = this.getExplicitOrMeasuredWidth();
         }
         this.measuredHeight = this.txt.getExplicitOrMeasuredHeight();
      }
      
      public function set txt(param1:Text) : void
      {
         var _loc2_:Object = this._115312txt;
         if(_loc2_ !== param1)
         {
            this._115312txt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txt",_loc2_,param1));
         }
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         invalidateProperties();
         invalidateSize();
      }
      
      private function set _txtColor(param1:uint) : void
      {
         var _loc2_:Object = this._1389382606_txtColor;
         if(_loc2_ !== param1)
         {
            this._1389382606_txtColor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtColor",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txt() : Text
      {
         return this._115312txt;
      }
      
      public function set txtAlign(param1:String) : void
      {
         this._txtAlign = param1;
         invalidateProperties();
      }
      
      override public function get label() : String
      {
         return this._label;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this._widthOverride)
         {
            this.txt.width = param1;
         }
         this.txt.setStyle("color",this._txtColor);
         if(this._txtWeight)
         {
            this.txt.setStyle("fontWeight",this._txtWeight);
         }
         this.txt.setStyle("fontSize",this._txtSize);
         this.txt.setStyle("textAlign",this._txtAlign);
      }
      
      public function set textDecoration(param1:String) : void
      {
         this._txtDecoration = param1;
         invalidateProperties();
      }
      
      public function ___TextButton_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
   }
}
