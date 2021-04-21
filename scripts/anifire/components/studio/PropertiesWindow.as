package anifire.components.studio
{
   import anifire.component.TextButton;
   import anifire.components.containers.AssetEffectControl;
   import anifire.components.containers.AssetHyperLink;
   import anifire.components.containers.AssetTiming;
   import anifire.control.FontChooser;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.Prop;
   import anifire.managers.FeatureManager;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilUser;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TabNavigator;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.Container;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Blur;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class PropertiesWindow extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1758088770speechPanel:VBox;
      
      public var _PropertiesWindow_AssetThumbnail1:AssetThumbnail;
      
      private var _241989645statePanel:PropStatePanel;
      
      private var _11548545buttonBar:AssetButtonBar;
      
      private var _94436_bg:VBox;
      
      private var _active:Boolean = false;
      
      private var _1202262587speechComponent:SpeechComponent;
      
      public var _PropertiesWindow_VBox5:VBox;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _1336746749_maskCanvas:Canvas;
      
      public var _PropertiesWindow_Button1:Button;
      
      private var _1646834419effectPanel:AssetTiming;
      
      private var _713047211_txtWarning:Text;
      
      private var _2079239841navPanel:TabNavigator;
      
      private var _1918169430speechBlocked:VBox;
      
      private var _1275269217colorPanel:AssetColorPanel;
      
      public var _PropertiesWindow_Text1:Text;
      
      private var _1827565232_target:Object;
      
      private var _actionXml:XML = null;
      
      mx_internal var _watchers:Array;
      
      public var _PropertiesWindow_AssetHyperLink1:AssetHyperLink;
      
      private var _1480441607_close:Canvas;
      
      public var _PropertiesWindow_HRule1:HRule;
      
      public var _PropertiesWindow_HRule2:HRule;
      
      private var _1569328494actionPanel:CharacterActionPanel;
      
      private var _611009540speechStop:VBox;
      
      private var _2131205345speechVS:ViewStack;
      
      private var _764566744bubblePanel:FontChooser;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public var _PropertiesWindow_AssetTiming2:AssetTiming;
      
      public var _PropertiesWindow_AssetEffectControl1:AssetEffectControl;
      
      private var _lastSelectedIndex_bubble:int = -1;
      
      mx_internal var _bindings:Array;
      
      private var _1795707688blurEffect:Sequence;
      
      private var _lastSelectedIndex_char:int = -1;
      
      public var _PropertiesWindow_TextButton1:TextButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function PropertiesWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":VBox,
                     "id":"_bg",
                     "stylesFactory":function():void
                     {
                        this.verticalGap = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"sidePanel",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":AssetThumbnail,
                                       "id":"_PropertiesWindow_AssetThumbnail1"
                                    }),new UIComponentDescriptor({
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":AssetButtonBar,
                                       "id":"buttonBar"
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TabNavigator,
                                       "id":"navPanel",
                                       "events":{"change":"__navPanel_change"},
                                       "stylesFactory":function():void
                                       {
                                          this.tabWidth = 85;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "styleName":"vsSidePanel",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":CharacterActionPanel,
                                                "id":"actionPanel"
                                             }),new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"speechVS",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechPanel",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "label":"Speech",
                                                               "percentWidth":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":SpeechComponent,
                                                                  "id":"speechComponent",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechBlocked",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 10;
                                                            this.top = "12";
                                                            this.horizontalAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Text,
                                                                  "id":"_PropertiesWindow_Text1",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.textAlign = "center";
                                                                     this.fontSize = 14;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_PropertiesWindow_Button1",
                                                                  "events":{"click":"___PropertiesWindow_Button1_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 12;
                                                                     this.paddingRight = 12;
                                                                     this.paddingTop = 12;
                                                                     this.paddingBottom = 12;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnAddVoice"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":TextButton,
                                                                  "id":"_PropertiesWindow_TextButton1",
                                                                  "events":{"click":"___PropertiesWindow_TextButton1_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "buttonMode":true,
                                                                        "txtAlign":"center",
                                                                        "txtSize":10,
                                                                        "textDecoration":"underline",
                                                                        "color":0
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechStop",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 10;
                                                            this.verticalAlign = "middle";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Text,
                                                                  "id":"_txtWarning",
                                                                  "events":{"link":"___txtWarning_link"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.textAlign = "center";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":AssetColorPanel,
                                                "id":"colorPanel"
                                             }),new UIComponentDescriptor({
                                                "type":PropStatePanel,
                                                "id":"statePanel"
                                             }),new UIComponentDescriptor({
                                                "type":FontChooser,
                                                "id":"bubblePanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"percentWidth":100};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":AssetTiming,
                                                "id":"effectPanel"
                                             }),new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"_PropertiesWindow_VBox5",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":AssetTiming,
                                                      "id":"_PropertiesWindow_AssetTiming2"
                                                   }),new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "id":"_PropertiesWindow_HRule1",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":AssetHyperLink,
                                                      "id":"_PropertiesWindow_AssetHyperLink1"
                                                   }),new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "id":"_PropertiesWindow_HRule2",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":AssetEffectControl,
                                                      "id":"_PropertiesWindow_AssetEffectControl1"
                                                   })]};
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"width":10};
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_close",
                     "stylesFactory":function():void
                     {
                        this.right = "12";
                        this.verticalCenter = "0";
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "alpha":0,
                           "visible":false
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
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._PropertiesWindow_Sequence1_i();
         this.addEventListener("resize",this.___PropertiesWindow_Canvas1_resize);
         this.addEventListener("initialize",this.___PropertiesWindow_Canvas1_initialize);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PropertiesWindow._watcherSetupUtil = param1;
      }
      
      public function set buttonBar(param1:AssetButtonBar) : void
      {
         var _loc2_:Object = this._11548545buttonBar;
         if(_loc2_ !== param1)
         {
            this._11548545buttonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBar",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvas() : Canvas
      {
         return this._1336746749_maskCanvas;
      }
      
      public function showSpeechPanel() : void
      {
         this.navPanel.selectedChild = this.speechVS;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set effectPanel(param1:AssetTiming) : void
      {
         var _loc2_:Object = this._1646834419effectPanel;
         if(_loc2_ !== param1)
         {
            this._1646834419effectPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effectPanel",_loc2_,param1));
         }
      }
      
      public function set _close(param1:Canvas) : void
      {
         var _loc2_:Object = this._1480441607_close;
         if(_loc2_ !== param1)
         {
            this._1480441607_close = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_close",_loc2_,param1));
         }
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      private function set statePanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(3).visible = this.navPanel.getTabAt(3).includeInLayout = param1;
      }
      
      public function set speechStop(param1:VBox) : void
      {
         var _loc2_:Object = this._611009540speechStop;
         if(_loc2_ !== param1)
         {
            this._611009540speechStop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechStop",_loc2_,param1));
         }
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this._maskCanvas.visible = param1;
      }
      
      public function set _maskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1336746749_maskCanvas;
         if(_loc2_ !== param1)
         {
            this._1336746749_maskCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvas",_loc2_,param1));
         }
      }
      
      private function set effectPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(5).visible = this.navPanel.getTabAt(5).includeInLayout = param1;
      }
      
      private function init() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get speechStop() : VBox
      {
         return this._611009540speechStop;
      }
      
      private function _PropertiesWindow_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         this.blurEffect = _loc1_;
         _loc1_.children = [this._PropertiesWindow_Blur1_c(),this._PropertiesWindow_Blur2_c()];
         BindingManager.executeBindings(this,"blurEffect",this.blurEffect);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get speechVS() : ViewStack
      {
         return this._2131205345speechVS;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
         this.actionPanelVisible = false;
         this.speechPanelVisible = false;
         this.colorPanelVisible = false;
         this.statePanelVisible = false;
         this.bubblePanelVisible = false;
         this.effectPanelVisible = false;
         this.advPanelVisible = false;
         this.navPanel.visible = false;
         if(param1)
         {
            if(param1 is Background)
            {
               if(Background(param1).isColorable())
               {
                  this.colorPanelVisible = true;
                  this.navPanel.selectedChild = this.colorPanel;
               }
            }
            else if(param1 is Prop)
            {
               if(Prop(param1).isColorable())
               {
                  this.colorPanelVisible = true;
                  this.navPanel.selectedChild = this.colorPanel;
               }
               if(Prop(param1).state)
               {
                  this.statePanelVisible = true;
                  this.navPanel.selectedChild = this.statePanel;
               }
            }
            else if(param1 is Character)
            {
               this.updateSpeechPanel();
               this.actionPanelVisible = true;
               this.speechPanelVisible = true;
               if(Character(param1).isColorable())
               {
                  this.colorPanelVisible = true;
               }
               if(this._lastSelectedIndex_char >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_char).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_char;
               }
               else
               {
                  this.navPanel.selectedChild = !!UtilUser.loggedIn?this.speechVS:this.actionPanel;
               }
            }
            else if(param1 is BubbleAsset)
            {
               this.bubblePanelVisible = true;
               this.advPanelVisible = true;
               if(this._lastSelectedIndex_bubble >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_bubble).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_bubble;
               }
               else
               {
                  this.navPanel.selectedChild = this.bubblePanel;
               }
            }
            else if(param1 is EffectAsset)
            {
               this.effectPanelVisible = true;
               this.navPanel.selectedChild = this.effectPanel;
            }
            else
            {
               this._target = null;
            }
         }
         else
         {
            this._target = null;
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _target() : Object
      {
         return this._1827565232_target;
      }
      
      public function __navPanel_change(param1:IndexChangedEvent) : void
      {
         this.onNavChange();
      }
      
      private function _PropertiesWindow_Blur1_c() : Blur
      {
         var _loc1_:Blur = new Blur();
         _loc1_.duration = 200;
         _loc1_.blurXFrom = 1;
         _loc1_.blurXTo = 20;
         return _loc1_;
      }
      
      private function _PropertiesWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._target;
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Actions");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Voice");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Another character is already talking in this scene");
         _loc1_ = UtilDict.toDisplay("go","Add Scene");
         _loc1_ = UtilDict.toDisplay("go","Overwrite the speech that already exists in this scene");
         _loc1_ = UtilDict.toDisplay("go","Colors");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","States");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Text");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Effect");
         _loc1_ = this._target;
         _loc1_ = UtilDict.toDisplay("go","Advanced");
         _loc1_ = this._target;
         _loc1_ = FeatureManager.shouldBubbleUrlBeEditable;
         _loc1_ = this._target;
         _loc1_ = FeatureManager.shouldBubbleUrlBeEditable;
         _loc1_ = UtilUser.hasAdminFeatures;
         _loc1_ = this._target;
         _loc1_ = UtilUser.hasAdminFeatures;
         _loc1_ = this;
      }
      
      public function ___PropertiesWindow_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.redraw();
      }
      
      [Bindable(event="propertyChange")]
      public function get effectPanel() : AssetTiming
      {
         return this._1646834419effectPanel;
      }
      
      public function hide() : void
      {
         this.target = null;
      }
      
      [Bindable(event="propertyChange")]
      public function get statePanel() : PropStatePanel
      {
         return this._241989645statePanel;
      }
      
      private function set actionPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(0).visible = this.navPanel.getTabAt(0).includeInLayout = param1;
      }
      
      private function set advPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(6).visible = this.navPanel.getTabAt(6).includeInLayout = param1;
      }
      
      public function set speechVS(param1:ViewStack) : void
      {
         var _loc2_:Object = this._2131205345speechVS;
         if(_loc2_ !== param1)
         {
            this._2131205345speechVS = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechVS",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechComponent() : SpeechComponent
      {
         return this._1202262587speechComponent;
      }
      
      public function set navPanel(param1:TabNavigator) : void
      {
         var _loc2_:Object = this._2079239841navPanel;
         if(_loc2_ !== param1)
         {
            this._2079239841navPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"navPanel",_loc2_,param1));
         }
      }
      
      public function set speechBlocked(param1:VBox) : void
      {
         var _loc2_:Object = this._1918169430speechBlocked;
         if(_loc2_ !== param1)
         {
            this._1918169430speechBlocked = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechBlocked",_loc2_,param1));
         }
      }
      
      public function set _txtWarning(param1:Text) : void
      {
         var _loc2_:Object = this._713047211_txtWarning;
         if(_loc2_ !== param1)
         {
            this._713047211_txtWarning = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWarning",_loc2_,param1));
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
      
      [Bindable(event="propertyChange")]
      public function get colorPanel() : AssetColorPanel
      {
         return this._1275269217colorPanel;
      }
      
      private function addScene() : void
      {
         Console.getConsole().currentScene.preselectAssetId = Console.getConsole().currentScene.selectedAsset.id;
         Console.getConsole().addNextScene();
      }
      
      public function showLogin() : void
      {
         Console.getConsole().showLogin();
      }
      
      [Bindable(event="propertyChange")]
      public function get actionPanel() : CharacterActionPanel
      {
         return this._1569328494actionPanel;
      }
      
      [Bindable(event="propertyChange")]
      public function get speechPanel() : VBox
      {
         return this._1758088770speechPanel;
      }
      
      public function showSignup() : void
      {
         Console.getConsole().showSignup();
      }
      
      public function set speechComponent(param1:SpeechComponent) : void
      {
         var _loc2_:Object = this._1202262587speechComponent;
         if(_loc2_ !== param1)
         {
            this._1202262587speechComponent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechComponent",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBar() : AssetButtonBar
      {
         return this._11548545buttonBar;
      }
      
      public function set speechPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1758088770speechPanel;
         if(_loc2_ !== param1)
         {
            this._1758088770speechPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechPanel",_loc2_,param1));
         }
      }
      
      public function ___PropertiesWindow_Button1_click(param1:MouseEvent) : void
      {
         this.addScene();
      }
      
      private function onDeleteHandler() : void
      {
         this.speechComponent.onClickDelete();
         this.updateSpeechPanel();
      }
      
      override public function initialize() : void
      {
         var target:PropertiesWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._PropertiesWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PropertiesWindowWatcherSetupUtil");
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
      
      private function _PropertiesWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            _PropertiesWindow_AssetThumbnail1.target = param1;
         },"_PropertiesWindow_AssetThumbnail1.target");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            buttonBar.target = param1;
         },"buttonBar.target");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Actions");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            actionPanel.label = param1;
         },"actionPanel.label");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            actionPanel.target = param1;
         },"actionPanel.target");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Voice");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            speechVS.label = param1;
         },"speechVS.label");
         result[4] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            speechComponent.target = param1;
         },"speechComponent.target");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Another character is already talking in this scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PropertiesWindow_Text1.text = param1;
         },"_PropertiesWindow_Text1.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PropertiesWindow_Button1.label = param1;
         },"_PropertiesWindow_Button1.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Overwrite the speech that already exists in this scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PropertiesWindow_TextButton1.label = param1;
         },"_PropertiesWindow_TextButton1.label");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Colors");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            colorPanel.label = param1;
         },"colorPanel.label");
         result[9] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            colorPanel.target = param1;
         },"colorPanel.target");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","States");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            statePanel.label = param1;
         },"statePanel.label");
         result[11] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            statePanel.target = param1;
         },"statePanel.target");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Text");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            bubblePanel.label = param1;
         },"bubblePanel.label");
         result[13] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            bubblePanel.target = param1;
         },"bubblePanel.target");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Effect");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            effectPanel.label = param1;
         },"effectPanel.label");
         result[15] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            effectPanel.target = param1;
         },"effectPanel.target");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Advanced");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PropertiesWindow_VBox5.label = param1;
         },"_PropertiesWindow_VBox5.label");
         result[17] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            _PropertiesWindow_AssetTiming2.target = param1;
         },"_PropertiesWindow_AssetTiming2.target");
         result[18] = binding;
         binding = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldBubbleUrlBeEditable;
         },function(param1:Boolean):void
         {
            _PropertiesWindow_HRule1.visible = param1;
         },"_PropertiesWindow_HRule1.visible");
         result[19] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            _PropertiesWindow_AssetHyperLink1.target = param1;
         },"_PropertiesWindow_AssetHyperLink1.target");
         result[20] = binding;
         binding = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldBubbleUrlBeEditable;
         },function(param1:Boolean):void
         {
            _PropertiesWindow_AssetHyperLink1.visible = param1;
         },"_PropertiesWindow_AssetHyperLink1.visible");
         result[21] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.hasAdminFeatures;
         },function(param1:Boolean):void
         {
            _PropertiesWindow_HRule2.visible = param1;
         },"_PropertiesWindow_HRule2.visible");
         result[22] = binding;
         binding = new Binding(this,function():Object
         {
            return _target;
         },function(param1:Object):void
         {
            _PropertiesWindow_AssetEffectControl1.target = param1;
         },"_PropertiesWindow_AssetEffectControl1.target");
         result[23] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.hasAdminFeatures;
         },function(param1:Boolean):void
         {
            _PropertiesWindow_AssetEffectControl1.visible = param1;
         },"_PropertiesWindow_AssetEffectControl1.visible");
         result[24] = binding;
         binding = new Binding(this,function():Object
         {
            return this;
         },function(param1:Object):void
         {
            blurEffect.target = param1;
         },"blurEffect.target");
         result[25] = binding;
         return result;
      }
      
      public function ___PropertiesWindow_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function onNavChange() : void
      {
         if(this.navPanel.selectedChild == this.speechVS)
         {
            this.updateSpeechPanel();
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.VOICE_TAB_SELECTED,this));
         }
         else if(this.navPanel.selectedChild == this.colorPanel)
         {
            this.colorPanel.target = this._target;
         }
         else if(this.navPanel.selectedChild == this.actionPanel)
         {
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.ACTION_TAB_SELECTED,this));
         }
         if(this._target is Character)
         {
            this._lastSelectedIndex_char = this.navPanel.selectedIndex;
         }
         else if(this._target is BubbleAsset)
         {
            this._lastSelectedIndex_bubble = this.navPanel.selectedIndex;
         }
      }
      
      private function set speechPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(1).visible = this.navPanel.getTabAt(1).includeInLayout = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get navPanel() : TabNavigator
      {
         return this._2079239841navPanel;
      }
      
      private function set colorPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(2).visible = this.navPanel.getTabAt(2).includeInLayout = param1;
      }
      
      public function set statePanel(param1:PropStatePanel) : void
      {
         var _loc2_:Object = this._241989645statePanel;
         if(_loc2_ !== param1)
         {
            this._241989645statePanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statePanel",_loc2_,param1));
         }
      }
      
      public function set blurEffect(param1:Sequence) : void
      {
         var _loc2_:Object = this._1795707688blurEffect;
         if(_loc2_ !== param1)
         {
            this._1795707688blurEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blurEffect",_loc2_,param1));
         }
      }
      
      private function updateSpeechPanel() : void
      {
         var _loc2_:Character = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:AnimeSound = null;
         if(!UtilUser.loggedIn)
         {
            this.speechVS.selectedChild = this.speechStop;
            this._txtWarning.htmlText = "<font size=\'16\'>" + UtilDict.toDisplay("go","Please") + " <a href=\'event:signup\'><font color=\'#ff7800\'><b>" + UtilDict.toDisplay("go","Sign Up") + " " + UtilDict.toDisplay("go","or") + " " + UtilDict.toDisplay("go","Login") + "</b></font></a> " + UtilDict.toDisplay("go","to enable the Text-to-Speech function") + "</font>";
            return;
         }
         var _loc1_:Asset = Console.getConsole().currentScene.selectedAsset;
         if(_loc1_ is Character)
         {
            _loc2_ = _loc1_ as Character;
            _loc3_ = this.getAssetSpeechId();
            if(_loc3_ != "")
            {
               _loc6_ = (_loc5_ = (_loc4_ = this.getAssetIdBySpeechId(_loc3_)).split(AssetLinkage.LINK))[0];
               _loc7_ = _loc5_[1];
               if(_loc2_.scene.id == _loc6_ && _loc2_.id == _loc7_)
               {
                  this.speechVS.selectedChild = this.speechPanel;
                  if((_loc8_ = Console.getConsole().speechManager.getValueByKey(_loc3_) as AnimeSound).soundThumb.ttsData.type == "mic")
                  {
                  }
               }
               else
               {
                  this.speechVS.selectedChild = this.speechBlocked;
               }
            }
            else
            {
               this.speechVS.selectedChild = this.speechPanel;
            }
            this.speechComponent.init();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtWarning() : Text
      {
         return this._713047211_txtWarning;
      }
      
      public function set colorPanel(param1:AssetColorPanel) : void
      {
         var _loc2_:Object = this._1275269217colorPanel;
         if(_loc2_ !== param1)
         {
            this._1275269217colorPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPanel",_loc2_,param1));
         }
      }
      
      public function set _bg(param1:VBox) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechBlocked() : VBox
      {
         return this._1918169430speechBlocked;
      }
      
      public function refresh() : void
      {
         if(Console.getConsole().currentScene.assetGroup.length > 1)
         {
            this.target = Console.getConsole().currentScene.assetGroup;
         }
         else
         {
            this.target = Console.getConsole().currentScene.selectedAsset;
            this.updateSpeechPanel();
         }
      }
      
      public function set actionPanel(param1:CharacterActionPanel) : void
      {
         var _loc2_:Object = this._1569328494actionPanel;
         if(_loc2_ !== param1)
         {
            this._1569328494actionPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionPanel",_loc2_,param1));
         }
      }
      
      public function set bubblePanel(param1:FontChooser) : void
      {
         var _loc2_:Object = this._764566744bubblePanel;
         if(_loc2_ !== param1)
         {
            this._764566744bubblePanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bubblePanel",_loc2_,param1));
         }
      }
      
      public function ___PropertiesWindow_TextButton1_click(param1:MouseEvent) : void
      {
         this.onDeleteHandler();
      }
      
      [Bindable(event="propertyChange")]
      public function get blurEffect() : Sequence
      {
         return this._1795707688blurEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get bubblePanel() : FontChooser
      {
         return this._764566744bubblePanel;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : VBox
      {
         return this._94436_bg;
      }
      
      public function ___txtWarning_link(param1:TextEvent) : void
      {
         this.linkHandler(param1);
      }
      
      public function linkHandler(param1:TextEvent) : void
      {
         switch(param1.text)
         {
            case "signup":
               this.showSignup();
               break;
            case "login":
               this.showLogin();
         }
      }
      
      private function _PropertiesWindow_Blur2_c() : Blur
      {
         var _loc1_:Blur = new Blur();
         _loc1_.duration = 200;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 1;
         return _loc1_;
      }
      
      private function redraw() : void
      {
         var _loc1_:Number = 1;
         this._bg.graphics.clear();
         this._bg.graphics.lineStyle(_loc1_,6052956);
         this._bg.graphics.beginFill(StyleManager.getStyleDeclaration(".sidePanel").getStyle("bg"));
         this._bg.graphics.drawRoundRectComplex(0,0,this.width,this.height,0,15,0,15);
         this._bg.graphics.endFill();
         this._close.graphics.clear();
         this._close.graphics.lineStyle(0,0);
         this._close.graphics.beginFill(15000804);
         UtilDraw.drawPoly(this._close,4,0,3,10,180);
         this._close.graphics.endFill();
         this._close.buttonMode = true;
         this._close.scaleY = 1.5;
      }
      
      private function getAssetIdBySpeechId(param1:String) : String
      {
         var _loc4_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Array = Console.getConsole().linkageController.isLinkageExist(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.concat();
            _loc4_.splice(_loc4_.indexOf(param1),1);
            _loc2_ = _loc4_.join("");
         }
         return _loc2_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _close() : Canvas
      {
         return this._1480441607_close;
      }
      
      private function set bubblePanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(4).visible = this.navPanel.getTabAt(4).includeInLayout = param1;
      }
      
      public function show() : void
      {
         this.redraw();
         this.refresh();
      }
      
      private function getAssetSpeechId() : String
      {
         var _loc1_:Asset = Console.getConsole().currentScene.selectedAsset;
         return Console.getConsole().linkageController.getSpeechIdOfAsset(_loc1_);
      }
   }
}
