package anifire.control
{
   import anifire.bubble.Bubble;
   import anifire.components.containers.HyperLinkWindow;
   import anifire.constant.ServerConstants;
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   import anifire.util.FontManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BitmapFilterType;
   import flash.text.Font;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ColorPicker;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.controls.TextArea;
   import mx.controls.ToggleButtonBar;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.DropdownEvent;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class FontChooser extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1478577702_embed:Boolean = true;
      
      private var _fontMgr:FontManager;
      
      private const SIZE_LIST:Array = [6,8,10,12,14,16,18,20,22,24,26,28,30,32,36,40,44,50,76];
      
      private var _1330229675_bubble:Bubble;
      
      private var _103471630bgcolor_cp:ColorPicker;
      
      mx_internal var _bindingsByDestination:Object;
      
      public var _FontChooser_Label1:Label;
      
      public var _FontChooser_Label2:Label;
      
      public var _FontChooser_Label3:Label;
      
      private var _1482294778_align:String = "center";
      
      private var _628825399color_cp:ColorPicker;
      
      private var _1529689935_italic:Boolean = false;
      
      private var _click:Boolean = false;
      
      private const FONT_LIST:Array = [{
         "label":"Accidental Presidency",
         "data":"Accidental Presidency",
         "source":"go"
      },{
         "label":"BodoniXT",
         "data":"BodoniXT",
         "source":"go"
      },{
         "label":"Boom",
         "data":"BadaBoom BB",
         "source":"go"
      },{
         "label":"Budmo Jiggler",
         "data":"Budmo Jiggler",
         "source":"go"
      },{
         "label":"Budmo Jigglish",
         "data":"Budmo Jigglish",
         "source":"go"
      },{
         "label":"Casual",
         "data":"Blambot Casual",
         "source":"go"
      },{
         "label":"Comic Book",
         "data":"Comic Book",
         "source":"go"
      },{
         "label":"Entrails",
         "data":"Entrails BB",
         "source":"go"
      },{
         "label":"Existence Light",
         "data":"Existence Light",
         "source":"go"
      },{
         "label":"HeartlandRegular",
         "data":"HeartlandRegular",
         "source":"go"
      },{
         "label":"Honey Script",
         "data":"Honey Script",
         "source":"go"
      },{
         "label":"I hate Comic Sans",
         "data":"I hate Comic Sans",
         "source":"go"
      },{
         "label":"Impact Label",
         "data":"Impact Label",
         "source":"go"
      },{
         "label":"loco tv",
         "data":"loco tv",
         "source":"go"
      },{
         "label":"Mail Ray Stuff",
         "data":"Mail Ray Stuff",
         "source":"go"
      },{
         "label":"Shanghai",
         "data":"Shanghai",
         "source":"go"
      },{
         "label":"Tokyo",
         "data":"Tokyo Robot Intl BB",
         "source":"go"
      },{
         "label":"Wood Stamp",
         "data":"Wood Stamp",
         "source":"go"
      }];
      
      mx_internal var _watchers:Array;
      
      private var _90883374_font:String = "Entrails BB";
      
      private var _2080489993btnAlign:ToggleButtonBar;
      
      private var _1912610210bold_btn:Button;
      
      private var _721006521_embedcb:CheckBox;
      
      private const ALIGN_LIST:Array = [{"data":"left"},{"data":"center"},{"data":"right"}];
      
      private var _2946224_url:String = "";
      
      private var _91265248_size:Number = 12;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _90764132_bold:Boolean = false;
      
      private var _2141602593_bgColor:Number = 16777215;
      
      private var _365952328font_cmb:ComboBox;
      
      private var _949923891italic_btn:Button;
      
      private var _1480355228_color:Number = 0;
      
      private var _163334105bubbleText:TextArea;
      
      mx_internal var _bindings:Array;
      
      private var _asset:Object;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function FontChooser()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 20;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"fontChooser",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextArea,
                           "id":"bubbleText",
                           "events":{
                              "change":"__bubbleText_change",
                              "focusIn":"__bubbleText_focusIn"
                           },
                           "stylesFactory":function():void
                           {
                              this.color = 2500134;
                              this.fontSize = 16;
                              this.fontFamily = "arial";
                              this.backgroundColor = 16777215;
                              this.borderColor = 13421772;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":100,
                                 "width":245
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"font_cmb",
                                    "events":{
                                       "change":"__font_cmb_change",
                                       "open":"__font_cmb_open",
                                       "close":"__font_cmb_close"
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "styleName":"cbSidePanel",
                                          "focusEnabled":false,
                                          "buttonMode":true,
                                          "itemRenderer":_FontChooser_ClassFactory1_c()
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"bold_btn",
                                    "events":{"click":"__bold_btn_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "toggle":true,
                                          "styleName":"btnBold",
                                          "focusEnabled":false,
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_FontChooser_Label1",
                                 "stylesFactory":function():void
                                 {
                                    this.fontWeight = "bold";
                                 }
                              }),new UIComponentDescriptor({
                                 "type":ToggleButtonBar,
                                 "id":"btnAlign",
                                 "events":{"itemClick":"__btnAlign_itemClick"},
                                 "stylesFactory":function():void
                                 {
                                    this.horizontalGap = 10;
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"btnAlign",
                                       "selectedIndex":1,
                                       "buttonMode":true
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_FontChooser_Label2",
                                 "stylesFactory":function():void
                                 {
                                    this.fontWeight = "bold";
                                 }
                              }),new UIComponentDescriptor({
                                 "type":ColorPicker,
                                 "id":"color_cp",
                                 "events":{
                                    "change":"__color_cp_change",
                                    "open":"__color_cp_open",
                                    "close":"__color_cp_close"
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "focusEnabled":false,
                                       "buttonMode":true
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_FontChooser_Label3",
                                 "stylesFactory":function():void
                                 {
                                    this.fontWeight = "bold";
                                 }
                              }),new UIComponentDescriptor({
                                 "type":ColorPicker,
                                 "id":"bgcolor_cp",
                                 "events":{
                                    "change":"__bgcolor_cp_change",
                                    "open":"__bgcolor_cp_open",
                                    "close":"__bgcolor_cp_close"
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "focusEnabled":false,
                                       "buttonMode":true
                                    };
                                 }
                              })]};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"italic_btn",
                  "events":{"click":"__italic_btn_click"},
                  "stylesFactory":function():void
                  {
                     this.fontStyle = "italic";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"I",
                        "toggle":true,
                        "width":27,
                        "visible":false,
                        "focusEnabled":false,
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CheckBox,
                  "id":"_embedcb",
                  "events":{"click":"___embedcb_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"EB",
                        "selected":true,
                        "visible":false
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
         this.focusEnabled = false;
         this.addEventListener("initialize",this.___FontChooser_Canvas1_initialize);
         this.addEventListener("mouseDown",this.___FontChooser_Canvas1_mouseDown);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         FontChooser._watcherSetupUtil = param1;
      }
      
      public function getChooser(param1:Object, param2:Object = null) : FontChooser
      {
         var _loc3_:FontChooser = new FontChooser();
         _loc3_.asset = param1;
         _loc3_.initParameters(param2);
         return _loc3_;
      }
      
      public function listFonts() : Array
      {
         var _loc4_:Font = null;
         var _loc1_:Array = Font.enumerateFonts(true);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(UtilLicense.isBubbleI18NPermitted() || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
            {
               if(_loc4_.fontName == "Arial" || _loc4_.fontName == "Courier New" || _loc4_.fontName == "Tahoma" || _loc4_.fontName == "Times New Roman" || _loc4_.fontName == "新細明體")
               {
                  _loc2_.push({
                     "label":_loc4_.fontName,
                     "data":_loc4_.fontName,
                     "source":"system"
                  });
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onBubbleTextFocusIn() : void
      {
         if(this.bubbleText.text == UtilDict.toDisplay("go","Click here to edit"))
         {
            this.bubbleText.text = "";
         }
      }
      
      private function setupBgcolor() : void
      {
         this.bgcolor_cp.selectedColor = this._bgColor;
      }
      
      private function set _align(param1:String) : void
      {
         var _loc2_:Object = this._1482294778_align;
         if(_loc2_ !== param1)
         {
            this._1482294778_align = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_align",_loc2_,param1));
         }
      }
      
      private function setupItalic() : void
      {
         this.italic_btn.selected = this._italic;
      }
      
      [Bindable(event="propertyChange")]
      public function get bgcolor_cp() : ColorPicker
      {
         return this._103471630bgcolor_cp;
      }
      
      public function ___FontChooser_Canvas1_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function __font_cmb_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __bgcolor_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __color_cp_change(param1:ColorPickerEvent) : void
      {
         this.onRgbChange();
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAlign() : ToggleButtonBar
      {
         return this._2080489993btnAlign;
      }
      
      private function onAlignBtnClick(param1:ItemClickEvent) : void
      {
         if(param1.index >= 0)
         {
            this._asset.textAlign = this.ALIGN_LIST[param1.index].data;
            dispatchEvent(new ControlEvent(Event.CHANGE));
         }
      }
      
      public function initParameters(param1:Object = null) : void
      {
         if(param1 != null)
         {
            if(param1.font != null)
            {
               this._font = param1.font;
            }
            if(param1.size != null)
            {
               this._size = param1.size;
            }
            if(param1.color != null)
            {
               this._color = param1.color;
            }
            if(param1.align != null)
            {
               this._align = param1.align;
            }
            if(param1.bold != null)
            {
               this._bold = param1.bold;
            }
            if(param1.italic != null)
            {
               this._italic = param1.italic;
            }
            if(param1.embed != null)
            {
               this._embed = param1.embed;
            }
            if(param1.fillRgb != null)
            {
               this._bgColor = param1.fillRgb;
            }
            if(param1.bubble != null)
            {
               this._bubble = param1.bubble;
            }
            if(param1.url != null)
            {
               this._url = param1.url;
            }
         }
      }
      
      private function onFontChange() : void
      {
         var _loc1_:String = this.font_cmb.selectedItem.data as String;
         this._fontMgr = FontManager.getFontManager();
         if(this._fontMgr.isFontLoaded(_loc1_) || this.font_cmb.selectedItem.source == "system")
         {
            this._asset.textFont = _loc1_;
            switch(this.font_cmb.selectedItem.source)
            {
               case "go":
                  this._asset.textEmbed = true;
                  break;
               case "system":
                  this._asset.textEmbed = false;
            }
         }
         else
         {
            this._fontMgr.loadFont(_loc1_,this.onFontLoaded);
         }
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function __color_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __font_cmb_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:BubbleAsset = null;
         if(param1 is BubbleAsset)
         {
            _loc2_ = BubbleAsset(param1);
            this._asset = _loc2_.bubble;
            this.initParameters(_loc2_.bubbleObject);
            this.initApp();
            this.bubbleText.text = _loc2_.bubble.bubbleText == ""?UtilDict.toDisplay("go","Click here to edit"):_loc2_.bubble.bubbleText;
         }
      }
      
      public function __bgcolor_cp_change(param1:ColorPickerEvent) : void
      {
         this.onFillRgbChange();
      }
      
      private function setupFontList() : void
      {
         var _loc1_:Array = null;
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            _loc1_ = this.listFonts();
         }
         else
         {
            _loc1_ = this.FONT_LIST.concat(this.listFonts());
         }
         this.font_cmb.dataProvider = _loc1_;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].data == this._font)
            {
               this.font_cmb.selectedIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
      }
      
      public function set bgcolor_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._103471630bgcolor_cp;
         if(_loc2_ !== param1)
         {
            this._103471630bgcolor_cp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgcolor_cp",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _font() : String
      {
         return this._90883374_font;
      }
      
      public function set btnAlign(param1:ToggleButtonBar) : void
      {
         var _loc2_:Object = this._2080489993btnAlign;
         if(_loc2_ !== param1)
         {
            this._2080489993btnAlign = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAlign",_loc2_,param1));
         }
      }
      
      private function onOpenHandler(param1:DropdownEvent) : void
      {
         this._click = true;
      }
      
      public function set bold_btn(param1:Button) : void
      {
         var _loc2_:Object = this._1912610210bold_btn;
         if(_loc2_ !== param1)
         {
            this._1912610210bold_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bold_btn",_loc2_,param1));
         }
      }
      
      private function setupAlignList() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.ALIGN_LIST.length)
         {
            if(this.ALIGN_LIST[_loc1_].data == this._align)
            {
               this.btnAlign.selectedIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      [Bindable(event="propertyChange")]
      private function get _italic() : Boolean
      {
         return this._1529689935_italic;
      }
      
      private function onSizeChange(param1:ListEvent) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      private function get _align() : String
      {
         return this._1482294778_align;
      }
      
      private function set _bubble(param1:Bubble) : void
      {
         var _loc2_:Object = this._1330229675_bubble;
         if(_loc2_ !== param1)
         {
            this._1330229675_bubble = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bubble",_loc2_,param1));
         }
      }
      
      public function __btnAlign_itemClick(param1:ItemClickEvent) : void
      {
         this.onAlignBtnClick(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get font_cmb() : ComboBox
      {
         return this._365952328font_cmb;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
      }
      
      private function setupEmbed() : void
      {
         this._embedcb.selected = this._embed;
      }
      
      public function __bgcolor_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function ___FontChooser_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function ___embedcb_click(param1:MouseEvent) : void
      {
         this.onEmbedChange();
      }
      
      private function set _font(param1:String) : void
      {
         var _loc2_:Object = this._90883374_font;
         if(_loc2_ !== param1)
         {
            this._90883374_font = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_font",_loc2_,param1));
         }
      }
      
      private function set _url(param1:String) : void
      {
         var _loc2_:Object = this._2946224_url;
         if(_loc2_ !== param1)
         {
            this._2946224_url = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_url",_loc2_,param1));
         }
      }
      
      public function set _embedcb(param1:CheckBox) : void
      {
         var _loc2_:Object = this._721006521_embedcb;
         if(_loc2_ !== param1)
         {
            this._721006521_embedcb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_embedcb",_loc2_,param1));
         }
      }
      
      private function onFontLoaded(param1:Event = null, param2:String = "") : void
      {
         if(param2 != "")
         {
            this._asset.textFont = param2;
            this._asset.textEmbed = true;
         }
      }
      
      public function __italic_btn_click(param1:MouseEvent) : void
      {
         this.onItalicChange();
      }
      
      [Bindable(event="propertyChange")]
      private function get _color() : Number
      {
         return this._1480355228_color;
      }
      
      private function onItalicChange() : void
      {
         var _loc1_:Boolean = this.italic_btn.selected;
         this._asset.textItalic = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      [Bindable(event="propertyChange")]
      private function get _bold() : Boolean
      {
         return this._90764132_bold;
      }
      
      private function onEmbedChange() : void
      {
         var _loc1_:Boolean = this._embedcb.selected;
         this._asset.textEmbed = _loc1_;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      public function __bold_btn_click(param1:MouseEvent) : void
      {
         this.onBoldChange();
      }
      
      public function get click() : Boolean
      {
         return this._click;
      }
      
      private function _FontChooser_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._bold;
         _loc1_ = UtilDict.toDisplay("go","fontchooser_align");
         _loc1_ = this.ALIGN_LIST;
         _loc1_ = UtilDict.toDisplay("go","Font") + ":";
         _loc1_ = this._color;
         _loc1_ = UtilDict.toDisplay("go","Background") + ":";
         _loc1_ = this._bgColor;
         _loc1_ = this._italic;
      }
      
      override public function initialize() : void
      {
         var target:FontChooser = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._FontChooser_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_control_FontChooserWatcherSetupUtil");
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
      
      public function set color_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._628825399color_cp;
         if(_loc2_ !== param1)
         {
            this._628825399color_cp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"color_cp",_loc2_,param1));
         }
      }
      
      public function set italic_btn(param1:Button) : void
      {
         var _loc2_:Object = this._949923891italic_btn;
         if(_loc2_ !== param1)
         {
            this._949923891italic_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"italic_btn",_loc2_,param1));
         }
      }
      
      private function set _italic(param1:Boolean) : void
      {
         var _loc2_:Object = this._1529689935_italic;
         if(_loc2_ !== param1)
         {
            this._1529689935_italic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_italic",_loc2_,param1));
         }
      }
      
      public function __font_cmb_change(param1:ListEvent) : void
      {
         this.onFontChange();
      }
      
      public function set font_cmb(param1:ComboBox) : void
      {
         var _loc2_:Object = this._365952328font_cmb;
         if(_loc2_ !== param1)
         {
            this._365952328font_cmb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"font_cmb",_loc2_,param1));
         }
      }
      
      private function onCallLaterHandler() : void
      {
         dispatchEvent(new ControlEvent(ControlEvent.CALL_LATER));
      }
      
      [Bindable(event="propertyChange")]
      private function get _bubble() : Bubble
      {
         return this._1330229675_bubble;
      }
      
      public function __bubbleText_focusIn(param1:FocusEvent) : void
      {
         this.onBubbleTextFocusIn();
      }
      
      [Bindable(event="propertyChange")]
      private function get _url() : String
      {
         return this._2946224_url;
      }
      
      private function setupBold() : void
      {
         this.bold_btn.selected = this._bold;
      }
      
      public function set bubbleText(param1:TextArea) : void
      {
         var _loc2_:Object = this._163334105bubbleText;
         if(_loc2_ !== param1)
         {
            this._163334105bubbleText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bubbleText",_loc2_,param1));
         }
      }
      
      private function applyFilters() : void
      {
         var _loc1_:BevelFilter = new BevelFilter(5,45,0,0.8,3355443,0.8,5,5,1,BitmapFilterQuality.HIGH,BitmapFilterType.OUTER,false);
         var _loc2_:Array = [_loc1_];
         filters = _loc2_;
      }
      
      private function onAlignChange(param1:ListEvent) : void
      {
      }
      
      private function onCloseHandler(param1:DropdownEvent) : void
      {
         this._click = false;
         callLater(this.onCallLaterHandler);
         dispatchEvent(new ControlEvent(DropdownEvent.CLOSE));
      }
      
      [Bindable(event="propertyChange")]
      public function get _embedcb() : CheckBox
      {
         return this._721006521_embedcb;
      }
      
      [Bindable(event="propertyChange")]
      public function get bold_btn() : Button
      {
         return this._1912610210bold_btn;
      }
      
      private function set _embed(param1:Boolean) : void
      {
         var _loc2_:Object = this._1478577702_embed;
         if(_loc2_ !== param1)
         {
            this._1478577702_embed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_embed",_loc2_,param1));
         }
      }
      
      private function onRgbChange() : void
      {
         this._asset.textRgb = this.color_cp.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function set _size(param1:Number) : void
      {
         var _loc2_:Object = this._91265248_size;
         if(_loc2_ !== param1)
         {
            this._91265248_size = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_size",_loc2_,param1));
         }
      }
      
      private function set _bgColor(param1:Number) : void
      {
         var _loc2_:Object = this._2141602593_bgColor;
         if(_loc2_ !== param1)
         {
            this._2141602593_bgColor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bgColor",_loc2_,param1));
         }
      }
      
      private function set _color(param1:Number) : void
      {
         var _loc2_:Object = this._1480355228_color;
         if(_loc2_ !== param1)
         {
            this._1480355228_color = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_color",_loc2_,param1));
         }
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this.stopDrag();
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      [Bindable(event="propertyChange")]
      public function get italic_btn() : Button
      {
         return this._949923891italic_btn;
      }
      
      private function set _bold(param1:Boolean) : void
      {
         var _loc2_:Object = this._90764132_bold;
         if(_loc2_ !== param1)
         {
            this._90764132_bold = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bold",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get color_cp() : ColorPicker
      {
         return this._628825399color_cp;
      }
      
      private function _FontChooser_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = FontChooser_inlineComponent1;
         _loc1_.properties = {"outerDocument":this};
         return _loc1_;
      }
      
      private function setupFontSizeList() : void
      {
      }
      
      private function onConvertHandler() : void
      {
         this.visible = false;
         Console.getConsole().showImporterWindow("",this._bubble.text);
      }
      
      [Bindable(event="propertyChange")]
      public function get bubbleText() : TextArea
      {
         return this._163334105bubbleText;
      }
      
      private function onBoldChange() : void
      {
         this._asset.textBold = this.bold_btn.selected;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function _FontChooser_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return _bold;
         },function(param1:Boolean):void
         {
            bold_btn.selected = param1;
         },"bold_btn.selected");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","fontchooser_align");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label1.text = param1;
         },"_FontChooser_Label1.text");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return ALIGN_LIST;
         },function(param1:Object):void
         {
            btnAlign.dataProvider = param1;
         },"btnAlign.dataProvider");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Font") + ":";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label2.text = param1;
         },"_FontChooser_Label2.text");
         result[3] = binding;
         binding = new Binding(this,function():uint
         {
            return _color;
         },function(param1:uint):void
         {
            color_cp.selectedColor = param1;
         },"color_cp.selectedColor");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Background") + ":";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _FontChooser_Label3.text = param1;
         },"_FontChooser_Label3.text");
         result[5] = binding;
         binding = new Binding(this,function():uint
         {
            return _bgColor;
         },function(param1:uint):void
         {
            bgcolor_cp.selectedColor = param1;
         },"bgcolor_cp.selectedColor");
         result[6] = binding;
         binding = new Binding(this,function():Boolean
         {
            return _italic;
         },function(param1:Boolean):void
         {
            italic_btn.selected = param1;
         },"italic_btn.selected");
         result[7] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      private function get _bgColor() : Number
      {
         return this._2141602593_bgColor;
      }
      
      public function set asset(param1:Object) : void
      {
         this._asset = param1;
      }
      
      public function set url(param1:String) : void
      {
         this._url = param1;
         if(this._bubble != null)
         {
            this._bubble.textURL = param1;
         }
      }
      
      private function setupColor() : void
      {
         this.color_cp.selectedColor = this._color;
      }
      
      [Bindable(event="propertyChange")]
      private function get _size() : Number
      {
         return this._91265248_size;
      }
      
      private function onBubbleTextChange() : void
      {
         if(this._asset is Bubble)
         {
            Bubble(this._asset).bubbleText = this.bubbleText.text;
            if(UtilLicense.isBubbleI18NPermitted() && Bubble(this._asset).textEmbed && !Bubble(this._asset).checkCharacterSupport())
            {
               Bubble(this._asset).textFont = this.listFonts()[0].data;
               Bubble(this._asset).textEmbed = false;
            }
         }
      }
      
      public function get asset() : Object
      {
         return this._asset;
      }
      
      private function initApp() : void
      {
         this.setupFontList();
         this.setupFontSizeList();
         this.setupAlignList();
         this.setupBold();
         this.setupItalic();
         this.setupEmbed();
         this.setupColor();
         this.setupBgcolor();
         this.url = this._url;
      }
      
      [Bindable(event="propertyChange")]
      private function get _embed() : Boolean
      {
         return this._1478577702_embed;
      }
      
      private function onBubbleLink(param1:Event) : void
      {
         var _loc2_:HyperLinkWindow = HyperLinkWindow(PopUpManager.createPopUp(Console.getConsole().mainStage,HyperLinkWindow,true));
         PopUpManager.centerPopUp(_loc2_);
         _loc2_.url = this._url;
         _loc2_.fontchooser = this;
      }
      
      public function __bubbleText_change(param1:Event) : void
      {
         this.onBubbleTextChange();
      }
      
      public function __color_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      private function onFillRgbChange() : void
      {
         this._asset.fillRgb = this.bgcolor_cp.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
   }
}
