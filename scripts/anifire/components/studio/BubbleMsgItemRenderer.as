package anifire.components.studio
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class BubbleMsgItemRenderer extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _697995159bubbleImg:Image;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495:Class;
      
      private var _1301516301msgLabel:Label;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1742637108soundImg:Image;
      
      mx_internal var _watchers:Array;
      
      private var _1401521777iconStack:Canvas;
      
      private var _embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255:Class;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function BubbleMsgItemRenderer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"msgLabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"bubbleMsgWindowListItem",
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"iconStack",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Image,
                           "id":"bubbleImg",
                           "propertiesFactory":function():Object
                           {
                              return {"source":_embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255};
                           }
                        }),new UIComponentDescriptor({
                           "type":Image,
                           "id":"soundImg",
                           "propertiesFactory":function():Object
                           {
                              return {"source":_embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495 = BubbleMsgItemRenderer__embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495;
         this._embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255 = BubbleMsgItemRenderer__embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255;
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
            this.paddingRight = 5;
         };
         this.percentWidth = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("mouseOver",this.___BubbleMsgItemRenderer_HBox1_mouseOver);
         this.addEventListener("mouseOut",this.___BubbleMsgItemRenderer_HBox1_mouseOut);
         this.addEventListener("creationComplete",this.___BubbleMsgItemRenderer_HBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         BubbleMsgItemRenderer._watcherSetupUtil = param1;
      }
      
      private function onMouseOver(param1:Event) : void
      {
         var _loc2_:BubbleMsgChooserItem = data as BubbleMsgChooserItem;
         this.iconStack.visible = true;
         if(_loc2_.isSound)
         {
            this.bubbleImg.visible = false;
            this.soundImg.visible = true;
         }
         else if(_loc2_.isBubble)
         {
            this.bubbleImg.visible = true;
            this.soundImg.visible = false;
         }
         this.msgLabel.setStyle("color",this.getStyle("textRollOverColor"));
      }
      
      [Bindable(event="propertyChange")]
      public function get msgLabel() : Label
      {
         return this._1301516301msgLabel;
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOut(param1);
      }
      
      override public function initialize() : void
      {
         var target:BubbleMsgItemRenderer = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._BubbleMsgItemRenderer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_BubbleMsgItemRendererWatcherSetupUtil");
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
      
      private function _BubbleMsgItemRenderer_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = (data as BubbleMsgChooserItem).displayText;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            msgLabel.text = param1;
         },"msgLabel.text");
         result[0] = binding;
         return result;
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set iconStack(param1:Canvas) : void
      {
         var _loc2_:Object = this._1401521777iconStack;
         if(_loc2_ !== param1)
         {
            this._1401521777iconStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bubbleImg() : Image
      {
         return this._697995159bubbleImg;
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.iconStack.visible = false;
         this.msgLabel.setStyle("color",this.getStyle("color"));
      }
      
      public function set bubbleImg(param1:Image) : void
      {
         var _loc2_:Object = this._697995159bubbleImg;
         if(_loc2_ !== param1)
         {
            this._697995159bubbleImg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bubbleImg",_loc2_,param1));
         }
      }
      
      public function set soundImg(param1:Image) : void
      {
         var _loc2_:Object = this._1742637108soundImg;
         if(_loc2_ !== param1)
         {
            this._1742637108soundImg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundImg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconStack() : Canvas
      {
         return this._1401521777iconStack;
      }
      
      private function init() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get soundImg() : Image
      {
         return this._1742637108soundImg;
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOver(param1);
      }
      
      private function _BubbleMsgItemRenderer_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = (data as BubbleMsgChooserItem).displayText;
      }
      
      public function set msgLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1301516301msgLabel;
         if(_loc2_ !== param1)
         {
            this._1301516301msgLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msgLabel",_loc2_,param1));
         }
      }
   }
}
