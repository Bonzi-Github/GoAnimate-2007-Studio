package anifire.components.studio
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.TitleWindow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.List;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class BubbleMsgChooser extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var bubbleMsgChooserItems:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1065050336msgArr:ArrayCollection;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindings:Array;
      
      private var _1283634532msg_list:List;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _2044384006_btnCloseTop:Button;
      
      public function BubbleMsgChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":434,
                  "height":316,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"bubbleMsgWindowBackground",
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"Pick a Happy Bunny Quote",
                                    "styleName":"bubbleMsgWindowTitle",
                                    "x":31,
                                    "y":27
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":List,
                              "id":"msg_list",
                              "events":{"change":"__msg_list_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":370,
                                    "height":230,
                                    "styleName":"bubbleMsgWindowList",
                                    "variableRowHeight":true,
                                    "wordWrap":true,
                                    "x":31,
                                    "y":52,
                                    "itemRenderer":_BubbleMsgChooser_ClassFactory1_c()
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnCloseTop",
                              "events":{"click":"___btnCloseTop_click"},
                              "stylesFactory":function():void
                              {
                                 this.right = "22";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":14,
                                    "styleName":"btnbubbleMsgWindowClose",
                                    "buttonMode":true
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
         this.layout = "absolute";
         this.width = 434;
         this.height = 316;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "bubbleMsgWindow";
         this._BubbleMsgChooser_ArrayCollection1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         BubbleMsgChooser._watcherSetupUtil = param1;
      }
      
      public function set msgArr(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1065050336msgArr;
         if(_loc2_ !== param1)
         {
            this._1065050336msgArr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msgArr",_loc2_,param1));
         }
      }
      
      public function set _btnCloseTop(param1:Button) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      public function closeWindow() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : Button
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function __msg_list_change(param1:ListEvent) : void
      {
         this.onListChanged(param1);
      }
      
      private function onListChanged(param1:Event) : void
      {
         var _loc2_:BubbleMsgChooserItem = this.msg_list.selectedItem as BubbleMsgChooserItem;
         var _loc3_:BubbleMsgEvent = new BubbleMsgEvent(BubbleMsgEvent.ITEM_CHOOSEN,this);
         _loc3_.bubbleMsgItem = _loc2_;
         this.dispatchEvent(_loc3_);
      }
      
      [Bindable(event="propertyChange")]
      public function get msg_list() : List
      {
         return this._1283634532msg_list;
      }
      
      private function _BubbleMsgChooser_ArrayCollection1_i() : ArrayCollection
      {
         var _loc1_:ArrayCollection = new ArrayCollection();
         this.msgArr = _loc1_;
         _loc1_.initialized(this,"msgArr");
         return _loc1_;
      }
      
      public function init(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:BubbleMsgChooserItem = null;
         this.bubbleMsgChooserItems = param1;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = _loc3_.msg;
            this.msgArr.addItem(_loc3_);
            _loc4_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get msgArr() : ArrayCollection
      {
         return this._1065050336msgArr;
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closeWindow();
      }
      
      private function _BubbleMsgChooser_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = BubbleMsgItemRenderer;
         return _loc1_;
      }
      
      private function _BubbleMsgChooser_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.msgArr;
      }
      
      private function _BubbleMsgChooser_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return msgArr;
         },function(param1:Object):void
         {
            msg_list.dataProvider = param1;
         },"msg_list.dataProvider");
         result[0] = binding;
         return result;
      }
      
      public function set msg_list(param1:List) : void
      {
         var _loc2_:Object = this._1283634532msg_list;
         if(_loc2_ !== param1)
         {
            this._1283634532msg_list = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msg_list",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:BubbleMsgChooser = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._BubbleMsgChooser_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_BubbleMsgChooserWatcherSetupUtil");
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
   }
}
