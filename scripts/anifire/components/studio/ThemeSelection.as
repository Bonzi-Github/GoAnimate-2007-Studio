package anifire.components.studio
{
   import anifire.constant.AnimeConstants;
   import anifire.events.ThemeChosenEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUser;
   import caurina.transitions.Tweener;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class ThemeSelection extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _297949182_iconsel:Canvas;
      
      private var _490429024_submenu:Canvas;
      
      public var currentThemeId:String;
      
      private var _1731027309_btnChar:Button;
      
      private var _1997701254_subVideo:Canvas;
      
      private var _1381505911_btnBubble:Button;
      
      private var _typeIntoTheme:UtilHashArray;
      
      private var _489577604_subProp:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _2006363762_subEffect:Canvas;
      
      private var _1245262219_mouseOutArea:Canvas;
      
      private var _2000276466_subSound:Canvas;
      
      private var _489180279_subChar:Canvas;
      
      private var _1588530801_subBackground:Canvas;
      
      private var _1113309525_btnBackground:Button;
      
      private var _themeList:Object;
      
      mx_internal var _watchers:Array;
      
      private var _1730987476_btnDrop:Button;
      
      private var _1309349490_btnEffect:Button;
      
      private var _1934207341_subBubble:Canvas;
      
      private var _2104659746_btnVideo:Button;
      
      private var _837788416_assetTypeBox:VBox;
      
      private var _1008523141_themeId:Label;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1730629984_btnProp:Button;
      
      private var _2107234958_btnSound:Button;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _91082302_menu:VBox;
      
      private var _typeOutOfTheme:UtilHashArray;
      
      public function ThemeSelection()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":310,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_mouseOutArea",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 65280;
                        this.backgroundAlpha = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "id":"_menu",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":3,
                           "width":187,
                           "percentHeight":20,
                           "styleName":"themeDropDownList"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnDrop",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnThemeDropDown",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_themeId",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 13;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnThemeDropDown",
                           "x":35,
                           "y":8,
                           "mouseEnabled":false,
                           "mouseChildren":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_iconsel",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":10,
                           "y":4,
                           "width":23,
                           "height":23
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_submenu",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":0,
                           "styleName":"themeDropDownList",
                           "scaleX":0.9,
                           "scaleY":0.9,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "id":"_assetTypeBox",
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subChar",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnChar",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnCharSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subBubble",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnBubble",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnBubbleMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subBackground",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnBackground",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnBackgroundSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subProp",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnProp",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnPropSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subSound",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnSound",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnSoundSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subEffect",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnEffect",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnEffectSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_subVideo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":50,
                                          "height":35,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_btnVideo",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"btnVideoSubMenu"};
                                             }
                                          })]
                                       };
                                    }
                                 })]};
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._themeList = {};
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.width = 310;
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___ThemeSelection_Canvas1_creationComplete);
         this.addEventListener("rollOut",this.___ThemeSelection_Canvas1_rollOut);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ThemeSelection._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _iconsel() : Canvas
      {
         return this._297949182_iconsel;
      }
      
      public function set _iconsel(param1:Canvas) : void
      {
         var _loc2_:Object = this._297949182_iconsel;
         if(_loc2_ !== param1)
         {
            this._297949182_iconsel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_iconsel",_loc2_,param1));
         }
      }
      
      public function set _subProp(param1:Canvas) : void
      {
         var _loc2_:Object = this._489577604_subProp;
         if(_loc2_ !== param1)
         {
            this._489577604_subProp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subProp",_loc2_,param1));
         }
      }
      
      public function set _themeId(param1:Label) : void
      {
         var _loc2_:Object = this._1008523141_themeId;
         if(_loc2_ !== param1)
         {
            this._1008523141_themeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_themeId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subSound() : Canvas
      {
         return this._2000276466_subSound;
      }
      
      [Bindable(event="propertyChange")]
      public function get _assetTypeBox() : VBox
      {
         return this._837788416_assetTypeBox;
      }
      
      private function _ThemeSelection_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return this._btnDrop.height;
         },function(param1:Number):void
         {
            _menu.y = param1;
         },"_menu.y");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return this._menu.width + this._menu.x;
         },function(param1:Number):void
         {
            _submenu.x = param1;
         },"_submenu.x");
         result[1] = binding;
         return result;
      }
      
      private function showMenu() : void
      {
         this._mouseOutArea.visible = true;
         Tweener.addTween(this._menu,{
            "y":this._btnDrop.height,
            "time":0.5
         });
      }
      
      public function set _assetTypeBox(param1:VBox) : void
      {
         var _loc2_:Object = this._837788416_assetTypeBox;
         if(_loc2_ !== param1)
         {
            this._837788416_assetTypeBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTypeBox",_loc2_,param1));
         }
      }
      
      public function set _btnBubble(param1:Button) : void
      {
         var _loc2_:Object = this._1381505911_btnBubble;
         if(_loc2_ !== param1)
         {
            this._1381505911_btnBubble = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBubble",_loc2_,param1));
         }
      }
      
      public function set _btnEffect(param1:Button) : void
      {
         var _loc2_:Object = this._1309349490_btnEffect;
         if(_loc2_ !== param1)
         {
            this._1309349490_btnEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEffect",_loc2_,param1));
         }
      }
      
      private function init() : void
      {
         this._menu.y = -1000;
         this._submenu.y = -1000;
         var _loc1_:DropShadowFilter = new DropShadowFilter(2,45,3355443,0.8,2,2);
         var _loc2_:Array = new Array();
         _loc2_.push(_loc1_);
         this._menu.filters = _loc2_;
         this._submenu.filters = _loc2_;
         this._themeId.text = "";
         this._iconsel.removeAllChildren();
         this._typeOutOfTheme = new UtilHashArray();
         this._typeIntoTheme = new UtilHashArray();
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            this._typeOutOfTheme.push("User",[0,1,5,6]);
            this._typeOutOfTheme.push("Comm",[1,4,5]);
         }
         else if(UtilUser.userType == UtilUser.PLUS_USER)
         {
            this._typeOutOfTheme.push("User",[1,5]);
            this._typeOutOfTheme.push("Comm",[1,4,5]);
         }
         else
         {
            this._typeOutOfTheme.push("User",[1]);
            this._typeOutOfTheme.push("Comm",[1,4]);
         }
         this._typeIntoTheme.push("6","User");
         this._mouseOutArea.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverOutside);
         this._btnDrop.addEventListener(MouseEvent.MOUSE_OVER,this.onDropButtonClick);
      }
      
      public function set _subSound(param1:Canvas) : void
      {
         var _loc2_:Object = this._2000276466_subSound;
         if(_loc2_ !== param1)
         {
            this._2000276466_subSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subSound",_loc2_,param1));
         }
      }
      
      public function set _subBackground(param1:Canvas) : void
      {
         var _loc2_:Object = this._1588530801_subBackground;
         if(_loc2_ !== param1)
         {
            this._1588530801_subBackground = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subBackground",_loc2_,param1));
         }
      }
      
      public function set _btnChar(param1:Button) : void
      {
         var _loc2_:Object = this._1731027309_btnChar;
         if(_loc2_ !== param1)
         {
            this._1731027309_btnChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnChar",_loc2_,param1));
         }
      }
      
      private function onDropButtonClick(param1:Event) : void
      {
         var _loc2_:Timer = null;
         if(this._menu.y < 0)
         {
            _loc2_ = new Timer(300,1);
            _loc2_.addEventListener(TimerEvent.TIMER_COMPLETE,this.checkCursorPosition);
            _loc2_.start();
         }
      }
      
      private function onMouseDownType(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc2_:Object = Button(param1.currentTarget).data;
         this._iconsel.styleName = _loc2_["icon"];
         this._themeId.text = _loc2_["name"];
         this.currentThemeId = _loc2_["id"];
         this.hideMenu();
         var _loc3_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc3_.themeId = _loc2_["id"];
         switch(param1.currentTarget)
         {
            case this._btnChar:
               _loc4_ = AnimeConstants.ASSET_TYPE_CHAR;
               break;
            case this._btnBubble:
               _loc4_ = AnimeConstants.ASSET_TYPE_BUBBLE;
               break;
            case this._btnBackground:
               _loc4_ = AnimeConstants.ASSET_TYPE_BG;
               break;
            case this._btnProp:
               _loc4_ = AnimeConstants.ASSET_TYPE_PROP;
               break;
            case this._btnSound:
               _loc4_ = AnimeConstants.ASSET_TYPE_SOUND;
               break;
            case this._btnEffect:
               _loc4_ = AnimeConstants.ASSET_TYPE_FX;
               break;
            case this._btnVideo:
               _loc4_ = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         }
         _loc3_.assetType = _loc4_;
         dispatchEvent(_loc3_);
      }
      
      private function highlightThemeItem(param1:String) : void
      {
         var _loc4_:Canvas = null;
         var _loc5_:Canvas = null;
         var _loc6_:Object = null;
         var _loc2_:Number = this._menu.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._menu.getChildAt(_loc3_) is Canvas)
            {
               _loc4_ = Canvas(this._menu.getChildAt(_loc3_));
               (_loc5_ = Canvas(_loc4_.getChildByName("bg"))).visible = false;
               if((_loc6_ = Canvas(_loc4_).data)["id"] == param1)
               {
                  _loc5_.visible = true;
               }
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDrop() : Button
      {
         return this._1730987476_btnDrop;
      }
      
      [Bindable(event="propertyChange")]
      public function get _menu() : VBox
      {
         return this._91082302_menu;
      }
      
      public function set _btnProp(param1:Button) : void
      {
         var _loc2_:Object = this._1730629984_btnProp;
         if(_loc2_ !== param1)
         {
            this._1730629984_btnProp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnProp",_loc2_,param1));
         }
      }
      
      private function onMouseOutTheme(param1:Event) : void
      {
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc3_:Canvas = Canvas(_loc2_.getChildByName("bg"));
         _loc3_.visible = false;
      }
      
      private function onMouseOverOutside(param1:Event) : void
      {
         var _loc2_:Timer = new Timer(300,1);
         _loc2_.addEventListener(TimerEvent.TIMER_COMPLETE,this.checkCursorPosition);
         _loc2_.start();
      }
      
      private function onMouseOverType(param1:Event) : void
      {
         var _loc2_:Object = Button(param1.currentTarget).data;
         var _loc3_:String = _loc2_["id"];
         var _loc4_:Canvas;
         (_loc4_ = Canvas(Button(param1.currentTarget).parent)).graphics.beginFill(StyleManager.getStyleDeclaration(".themeDropDownList").getStyle("highlightColor"));
         _loc4_.graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         _loc4_.graphics.endFill();
         this.highlightThemeItem(_loc3_);
      }
      
      public function set _btnBackground(param1:Button) : void
      {
         var _loc2_:Object = this._1113309525_btnBackground;
         if(_loc2_ !== param1)
         {
            this._1113309525_btnBackground = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBackground",_loc2_,param1));
         }
      }
      
      public function set _btnDrop(param1:Button) : void
      {
         var _loc2_:Object = this._1730987476_btnDrop;
         if(_loc2_ !== param1)
         {
            this._1730987476_btnDrop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDrop",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subBubble() : Canvas
      {
         return this._1934207341_subBubble;
      }
      
      [Bindable(event="propertyChange")]
      public function get _submenu() : Canvas
      {
         return this._490429024_submenu;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSound() : Button
      {
         return this._2107234958_btnSound;
      }
      
      [Bindable(event="propertyChange")]
      public function get _mouseOutArea() : Canvas
      {
         return this._1245262219_mouseOutArea;
      }
      
      [Bindable(event="propertyChange")]
      public function get _subChar() : Canvas
      {
         return this._489180279_subChar;
      }
      
      public function ___ThemeSelection_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set _menu(param1:VBox) : void
      {
         var _loc2_:Object = this._91082302_menu;
         if(_loc2_ !== param1)
         {
            this._91082302_menu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_menu",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subEffect() : Canvas
      {
         return this._2006363762_subEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _subProp() : Canvas
      {
         return this._489577604_subProp;
      }
      
      [Bindable(event="propertyChange")]
      public function get _themeId() : Label
      {
         return this._1008523141_themeId;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBubble() : Button
      {
         return this._1381505911_btnBubble;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEffect() : Button
      {
         return this._1309349490_btnEffect;
      }
      
      override public function initialize() : void
      {
         var target:ThemeSelection = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._ThemeSelection_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ThemeSelectionWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      public function get _subVideo() : Canvas
      {
         return this._1997701254_subVideo;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnChar() : Button
      {
         return this._1731027309_btnChar;
      }
      
      [Bindable(event="propertyChange")]
      public function get _subBackground() : Canvas
      {
         return this._1588530801_subBackground;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnProp() : Button
      {
         return this._1730629984_btnProp;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         this.hideMenu();
      }
      
      private function _ThemeSelection_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._btnDrop.height;
         _loc1_ = this._menu.width + this._menu.x;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBackground() : Button
      {
         return this._1113309525_btnBackground;
      }
      
      public function set _btnVideo(param1:Button) : void
      {
         var _loc2_:Object = this._2104659746_btnVideo;
         if(_loc2_ !== param1)
         {
            this._2104659746_btnVideo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnVideo",_loc2_,param1));
         }
      }
      
      public function set _submenu(param1:Canvas) : void
      {
         var _loc2_:Object = this._490429024_submenu;
         if(_loc2_ !== param1)
         {
            this._490429024_submenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_submenu",_loc2_,param1));
         }
      }
      
      private function onMouseOutType(param1:Event) : void
      {
         var _loc2_:Object = Button(param1.currentTarget).data;
         var _loc3_:String = _loc2_["id"];
         var _loc4_:Canvas;
         (_loc4_ = Canvas(Button(param1.currentTarget).parent)).graphics.clear();
         this.highlightThemeItem(_loc3_);
      }
      
      private function onMouseClickTheme(param1:Event) : void
      {
         var _loc2_:Object = null;
         trace(Canvas(param1.currentTarget).data);
         _loc2_ = Canvas(param1.currentTarget).data;
         this._iconsel.styleName = _loc2_["icon"];
         this._themeId.text = _loc2_["name"];
         this.currentThemeId = _loc2_["id"];
         this.hideMenu();
         var _loc3_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc3_.themeId = _loc2_["id"];
         _loc3_.assetType = AnimeConstants.ASSET_TYPE_CHAR;
         dispatchEvent(_loc3_);
      }
      
      private function checkCursorPosition(param1:Event) : void
      {
         if(stage.mouseX < this._btnDrop.width && stage.mouseY < this._btnDrop.height)
         {
            this.showMenu();
         }
         else if(!this._menu.hitTestPoint(stage.mouseX,stage.mouseY) && !this._submenu.hitTestPoint(stage.mouseX,stage.mouseY) && !this._btnDrop.hitTestPoint(stage.mouseX,stage.mouseY))
         {
            this.hideMenu();
         }
      }
      
      private function hideMenu() : void
      {
         this._mouseOutArea.visible = false;
         Tweener.addTween(this._menu,{
            "y":-this._menu.height - 10,
            "time":0.5
         });
         Tweener.addTween(this._submenu,{
            "y":-1000,
            "time":0.5
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnVideo() : Button
      {
         return this._2104659746_btnVideo;
      }
      
      public function set _subBubble(param1:Canvas) : void
      {
         var _loc2_:Object = this._1934207341_subBubble;
         if(_loc2_ !== param1)
         {
            this._1934207341_subBubble = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subBubble",_loc2_,param1));
         }
      }
      
      public function set _mouseOutArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._1245262219_mouseOutArea;
         if(_loc2_ !== param1)
         {
            this._1245262219_mouseOutArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mouseOutArea",_loc2_,param1));
         }
      }
      
      public function set _btnSound(param1:Button) : void
      {
         var _loc2_:Object = this._2107234958_btnSound;
         if(_loc2_ !== param1)
         {
            this._2107234958_btnSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSound",_loc2_,param1));
         }
      }
      
      public function buildMenu(param1:UtilHashArray, param2:int = 0, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc9_:Canvas = null;
         var _loc10_:Label = null;
         var _loc11_:Canvas = null;
         var _loc12_:Canvas = null;
         var _loc13_:HRule = null;
         var _loc5_:Array = new Array();
         var _loc6_:UtilHashArray = new UtilHashArray();
         this._themeId.text = param1.getValueByIndex(param2);
         this._iconsel.styleName = "iconTheme" + param1.getKey(param2);
         this.currentThemeId = param1.getKey(param2);
         if(!param3 && !param4)
         {
            this._typeOutOfTheme.push("ben10",[2]);
            this._typeOutOfTheme.push("chowder",[2]);
         }
         if(param4 || param3)
         {
            _loc6_.push("HRule",UtilDict.toDisplay("go","HRule"));
            param1.insert(0,_loc6_);
         }
         if(param4)
         {
            _loc6_.push("Comm",UtilDict.toDisplay("go","Community Stuff"));
            param1.insert(0,_loc6_);
         }
         if(param3)
         {
            _loc6_.push("User",UtilDict.toDisplay("go","Your Stuff"));
            param1.insert(0,_loc6_);
         }
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            if(param1.getKey(_loc7_) == "HRule")
            {
               (_loc13_ = new HRule()).percentWidth = 100;
               _loc13_.height = 16;
               _loc5_.push(_loc13_);
            }
            else
            {
               _loc9_ = new Canvas();
               _loc10_ = new Label();
               _loc11_ = new Canvas();
               _loc12_ = new Canvas();
               _loc9_.data = {
                  "id":param1.getKey(_loc7_),
                  "name":UtilDict.toDisplay("store",param1.getValueByIndex(_loc7_))
               };
               _loc11_.width = _loc11_.height = 23;
               _loc11_.x = 10;
               _loc11_.styleName = "iconTheme" + param1.getKey(_loc7_);
               if(this._themeList[_loc9_.data.id] == null)
               {
                  this._themeList[_loc9_.data.id] = {
                     "text":_loc9_.data.name,
                     "iconStyle":_loc11_.styleName
                  };
               }
               _loc9_.data.icon = _loc11_.styleName;
               if(this._themeList[_loc9_.data.id] == null)
               {
                  this._themeList[_loc9_.data.id] = {
                     "text":_loc9_.data.name,
                     "iconStyle":_loc11_.styleName
                  };
               }
               _loc9_.data.icon = _loc11_.styleName;
               _loc10_.mouseChildren = false;
               _loc10_.text = UtilDict.toDisplay("store",param1.getValueByIndex(_loc7_));
               _loc10_.setStyle("fontSize","14");
               _loc10_.setStyle("paddingTop","3");
               _loc10_.x = 33;
               _loc10_.height = 28;
               _loc9_.percentWidth = 100;
               _loc9_.height = 28;
               _loc9_.addChild(_loc12_);
               _loc9_.addChild(_loc11_);
               _loc9_.addChild(_loc10_);
               _loc9_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverTheme);
               _loc9_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutTheme);
               _loc9_.addEventListener(MouseEvent.CLICK,this.onMouseClickTheme);
               _loc9_.buttonMode = true;
               _loc5_.push(_loc9_);
               _loc12_.name = "bg";
               _loc12_.clipContent = true;
               _loc12_.percentHeight = _loc12_.percentWidth = 100;
               _loc12_.graphics.beginFill(StyleManager.getStyleDeclaration(".themeDropDownList").getStyle("highlightColor"),1);
               _loc12_.graphics.drawRect(0,0,187,28);
               _loc12_.graphics.endFill();
               _loc12_.visible = false;
            }
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.length)
         {
            this._menu.addChild(_loc5_[_loc8_]);
            _loc8_++;
         }
      }
      
      public function ___ThemeSelection_Canvas1_rollOut(param1:MouseEvent) : void
      {
         this.onRollOut(param1);
      }
      
      private function onMouseOverTheme(param1:Event) : void
      {
         var _loc7_:Button = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc3_:Canvas = Canvas(_loc2_.getChildByName("bg"));
         var _loc4_:Object = Canvas(param1.currentTarget).data;
         this.highlightThemeItem(_loc4_["id"]);
         this._submenu.visible = true;
         this._submenu.x = this._menu.width;
         this._submenu.y = _loc2_.y + this._menu.y;
         if(this._submenu.y + this._submenu.height >= this.height)
         {
            this._submenu.y = this._menu.y + this._menu.height - this._submenu.height;
         }
         if(this._submenu.y < 0)
         {
            this._submenu.y = 0;
         }
         var _loc5_:Number = this._assetTypeBox.numChildren;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = Button(Canvas(this._assetTypeBox.getChildAt(_loc6_)).getChildAt(0));
            Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 5;
            _loc8_ = this._typeOutOfTheme.getValueByKey(String(_loc4_["id"]));
            _loc9_ = this._typeIntoTheme.getValueByKey(String(_loc6_));
            if(_loc8_ != null && (_loc8_ as Array).indexOf(_loc6_) > -1 || _loc9_ != null && _loc9_ != String(_loc4_["id"]))
            {
               Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 0;
            }
            else
            {
               Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 35;
               _loc7_.x = (_loc7_.parent.width - _loc7_.width) / 2;
               _loc7_.y = (_loc7_.parent.height - _loc7_.height) / 2;
               _loc7_.buttonMode = true;
               _loc7_.data = _loc4_;
               _loc7_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverType);
               _loc7_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutType);
               _loc7_.addEventListener(MouseEvent.CLICK,this.onMouseDownType);
            }
            _loc6_++;
         }
      }
      
      public function set _subEffect(param1:Canvas) : void
      {
         var _loc2_:Object = this._2006363762_subEffect;
         if(_loc2_ !== param1)
         {
            this._2006363762_subEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subEffect",_loc2_,param1));
         }
      }
      
      public function set _subChar(param1:Canvas) : void
      {
         var _loc2_:Object = this._489180279_subChar;
         if(_loc2_ !== param1)
         {
            this._489180279_subChar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subChar",_loc2_,param1));
         }
      }
      
      public function setThemeById(param1:String) : void
      {
         if(this._themeList[param1] != null)
         {
            this._themeId.text = this._themeList[param1].text;
            this._iconsel.styleName = this._themeList[param1].iconStyle;
            this.currentThemeId = param1;
         }
      }
      
      public function set _subVideo(param1:Canvas) : void
      {
         var _loc2_:Object = this._1997701254_subVideo;
         if(_loc2_ !== param1)
         {
            this._1997701254_subVideo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subVideo",_loc2_,param1));
         }
      }
   }
}
