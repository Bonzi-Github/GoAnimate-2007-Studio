package anifire.components.studio
{
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.core.Action;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.events.AssetEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilString;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ItemClickEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class CharacterActionPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1869653775boxHandheld:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _663646731btnHeadGear:Button;
      
      private var _2118535603_variationContainer:HBox;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _62698418btnAction:Button;
      
      private var _1780808384btnHandHeld:Button;
      
      private var _752492122boxHeadgear:VBox;
      
      private var _203490248btnFacial:Button;
      
      private var _702726737btnRemoveHeadGear:Button;
      
      private var _414434916btnRemoveHandHeld:Button;
      
      private var _71950923boxHead:VBox;
      
      private var _1396342996banner:GoAdv;
      
      private var _1419525765_rbgVariation:RadioButtonGroup;
      
      mx_internal var _watchers:Array;
      
      private var _1336538514btnRestoreHead:Button;
      
      private var _1570857836_variation:HBox;
      
      private var _2097113269btnSlide:Button;
      
      private var _75281834_character:Character;
      
      private var _1569328494actionPanel:VBox;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindings:Array;
      
      private var _947794573btnLookAtCamera:Button;
      
      public var _CharacterActionPanel_Label1:Label;
      
      public var _CharacterActionPanel_Label2:Label;
      
      public var _CharacterActionPanel_Label3:Label;
      
      public var _CharacterActionPanel_Label4:Label;
      
      public var _CharacterActionPanel_Label5:Label;
      
      public var _CharacterActionPanel_Label6:Label;
      
      public function CharacterActionPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"actionPanel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_CharacterActionPanel_Label1"
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"btnAction",
                                 "events":{"click":"__btnAction_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":200,
                                       "labelPlacement":"left",
                                       "styleName":"btnActionMenuSidePanel"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"btnSlide",
                                 "events":{"click":"__btnSlide_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"btnSlideChar",
                                       "focusEnabled":false,
                                       "buttonMode":true,
                                       "toggle":true
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_variation",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "visible":false,
                                 "includeInLayout":false,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CharacterActionPanel_Label2",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 10;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_variationContainer"
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_CharacterActionPanel_Label3"
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"btnFacial",
                                 "events":{"click":"__btnFacial_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "labelPlacement":"left",
                                       "width":150,
                                       "label":"Select",
                                       "styleName":"btnMenuSidePanel"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"btnLookAtCamera",
                                 "events":{"click":"__btnLookAtCamera_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "visible":false,
                                       "styleName":"btnLookAtCamera",
                                       "toggle":true,
                                       "focusEnabled":false,
                                       "buttonMode":true
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxHandheld",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_CharacterActionPanel_Label4"
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnHandHeld",
                                             "events":{"click":"__btnHandHeld_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "labelPlacement":"left",
                                                   "width":150,
                                                   "styleName":"btnMenuSidePanel"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnRemoveHandHeld",
                                             "events":{"click":"__btnRemoveHandHeld_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnDeleteSidePanel",
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxHeadgear",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"_CharacterActionPanel_Label5"
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnHeadGear",
                                          "events":{"click":"__btnHeadGear_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "labelPlacement":"left",
                                                "width":150,
                                                "styleName":"btnMenuSidePanel"
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnRemoveHeadGear",
                                          "events":{"click":"__btnRemoveHeadGear_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnDeleteSidePanel",
                                                "buttonMode":true
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxHead",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"_CharacterActionPanel_Label6"
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnRestoreHead",
                                          "events":{"click":"__btnRestoreHead_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnSidePanel"};
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"percentHeight":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":GoAdv,
                           "id":"banner",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
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
         this.verticalScrollPolicy = "off";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._CharacterActionPanel_RadioButtonGroup1_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CharacterActionPanel._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHeadGear() : Button
      {
         return this._663646731btnHeadGear;
      }
      
      private function onActionChange(param1:AssetEvent) : void
      {
         if(this._character)
         {
            this.btnSlide.selected = this._character.isSliding;
         }
         this.updateActionPanel();
      }
      
      public function __btnRemoveHandHeld_click(param1:MouseEvent) : void
      {
         this.removeHandHeld();
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHandheld() : VBox
      {
         return this._1869653775boxHandheld;
      }
      
      private function _CharacterActionPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Action");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label1.text = param1;
         },"_CharacterActionPanel_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return btnAction.enabled;
         },function(param1:Boolean):void
         {
            btnAction.buttonMode = param1;
         },"btnAction.buttonMode");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Slide");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnSlide.toolTip = param1;
         },"btnSlide.toolTip");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Variations");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label2.text = param1;
         },"_CharacterActionPanel_Label2.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Facial Expression");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label3.text = param1;
         },"_CharacterActionPanel_Label3.text");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return btnFacial.enabled;
         },function(param1:Boolean):void
         {
            btnFacial.buttonMode = param1;
         },"btnFacial.buttonMode");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Look at Camera");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnLookAtCamera.toolTip = param1;
         },"btnLookAtCamera.toolTip");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Handheld");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label4.text = param1;
         },"_CharacterActionPanel_Label4.text");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return btnHandHeld.enabled;
         },function(param1:Boolean):void
         {
            btnHandHeld.buttonMode = param1;
         },"btnHandHeld.buttonMode");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Headgear");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label5.text = param1;
         },"_CharacterActionPanel_Label5.text");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return btnHeadGear.enabled;
         },function(param1:Boolean):void
         {
            btnHeadGear.buttonMode = param1;
         },"btnHeadGear.buttonMode");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Head Prop");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _CharacterActionPanel_Label6.text = param1;
         },"_CharacterActionPanel_Label6.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Use default");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnRestoreHead.label = param1;
         },"btnRestoreHead.label");
         result[12] = binding;
         binding = new Binding(this,function():Boolean
         {
            return btnRestoreHead.enabled;
         },function(param1:Boolean):void
         {
            btnRestoreHead.buttonMode = param1;
         },"btnRestoreHead.buttonMode");
         result[13] = binding;
         return result;
      }
      
      public function set btnHeadGear(param1:Button) : void
      {
         var _loc2_:Object = this._663646731btnHeadGear;
         if(_loc2_ !== param1)
         {
            this._663646731btnHeadGear = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHeadGear",_loc2_,param1));
         }
      }
      
      public function __btnRemoveHeadGear_click(param1:MouseEvent) : void
      {
         this.removeHeadGear();
      }
      
      public function set target(param1:Object) : void
      {
         if(param1)
         {
            if(param1 is Character)
            {
               if(this._character)
               {
                  this._character.removeEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
               }
               this._character = Character(param1);
               this.updateActionPanel();
               this._character.addEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
            }
            else
            {
               this._character = null;
            }
         }
         else
         {
            this._character = null;
         }
      }
      
      public function set btnRestoreHead(param1:Button) : void
      {
         var _loc2_:Object = this._1336538514btnRestoreHead;
         if(_loc2_ !== param1)
         {
            this._1336538514btnRestoreHead = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRestoreHead",_loc2_,param1));
         }
      }
      
      public function set boxHandheld(param1:VBox) : void
      {
         var _loc2_:Object = this._1869653775boxHandheld;
         if(_loc2_ !== param1)
         {
            this._1869653775boxHandheld = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHandheld",_loc2_,param1));
         }
      }
      
      public function set _variation(param1:HBox) : void
      {
         var _loc2_:Object = this._1570857836_variation;
         if(_loc2_ !== param1)
         {
            this._1570857836_variation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_variation",_loc2_,param1));
         }
      }
      
      private function showHeadGearMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnHeadGear.localToGlobal(new Point(0,this.btnHeadGear.y + this.btnHeadGear.height));
            _loc3_ = this._character.headGearMenu;
            if(_loc3_)
            {
               _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onHeadGearMenuClick);
               _loc3_.show(_loc2_.x,_loc2_.y);
            }
         }
      }
      
      private function removeHeadGear() : void
      {
         if(this._character)
         {
            this._character.removeHeadGear();
            this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get banner() : GoAdv
      {
         return this._1396342996banner;
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHead() : VBox
      {
         return this._71950923boxHead;
      }
      
      [Bindable(event="propertyChange")]
      public function get _variationContainer() : HBox
      {
         return this._2118535603_variationContainer;
      }
      
      public function set banner(param1:GoAdv) : void
      {
         var _loc2_:Object = this._1396342996banner;
         if(_loc2_ !== param1)
         {
            this._1396342996banner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"banner",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHeadgear() : VBox
      {
         return this._752492122boxHeadgear;
      }
      
      private function set _character(param1:Character) : void
      {
         var _loc2_:Object = this._75281834_character;
         if(_loc2_ !== param1)
         {
            this._75281834_character = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_character",_loc2_,param1));
         }
      }
      
      public function __btnSlide_click(param1:MouseEvent) : void
      {
         this.onSlideBtnClick();
      }
      
      private function showHandHeldMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnHandHeld.localToGlobal(new Point(0,this.btnHandHeld.y + this.btnHandHeld.height));
            _loc3_ = this._character.handHeldMenu;
            if(_loc3_)
            {
               _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onHandHeldMenuClick);
               _loc3_.show(_loc2_.x,_loc2_.y);
            }
         }
      }
      
      public function set btnRemoveHeadGear(param1:Button) : void
      {
         var _loc2_:Object = this._702726737btnRemoveHeadGear;
         if(_loc2_ !== param1)
         {
            this._702726737btnRemoveHeadGear = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRemoveHeadGear",_loc2_,param1));
         }
      }
      
      private function onHandHeldMenuClick(param1:MenuEvent) : void
      {
         this.btnHandHeld.label = param1.item.@label;
      }
      
      public function __btnHandHeld_click(param1:MouseEvent) : void
      {
         this.showHandHeldMenu(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get actionPanel() : VBox
      {
         return this._1569328494actionPanel;
      }
      
      public function __btnFacial_click(param1:MouseEvent) : void
      {
         this.showFacialMenu(param1);
      }
      
      public function set btnAction(param1:Button) : void
      {
         var _loc2_:Object = this._62698418btnAction;
         if(_loc2_ !== param1)
         {
            this._62698418btnAction = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAction",_loc2_,param1));
         }
      }
      
      public function __btnHeadGear_click(param1:MouseEvent) : void
      {
         this.showHeadGearMenu(param1);
      }
      
      public function set btnSlide(param1:Button) : void
      {
         var _loc2_:Object = this._2097113269btnSlide;
         if(_loc2_ !== param1)
         {
            this._2097113269btnSlide = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSlide",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnLookAtCamera() : Button
      {
         return this._947794573btnLookAtCamera;
      }
      
      private function onHeadGearMenuClick(param1:MenuEvent) : void
      {
         this.btnHeadGear.label = param1.item.@label;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRemoveHandHeld() : Button
      {
         return this._414434916btnRemoveHandHeld;
      }
      
      public function set btnHandHeld(param1:Button) : void
      {
         var _loc2_:Object = this._1780808384btnHandHeld;
         if(_loc2_ !== param1)
         {
            this._1780808384btnHandHeld = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHandHeld",_loc2_,param1));
         }
      }
      
      public function __btnRestoreHead_click(param1:MouseEvent) : void
      {
         this.restoreHead();
      }
      
      [Bindable(event="propertyChange")]
      public function get _rbgVariation() : RadioButtonGroup
      {
         return this._1419525765_rbgVariation;
      }
      
      private function restoreHead() : void
      {
         if(this._character)
         {
            this._character.restoreHead();
            this.boxHead.includeInLayout = this.boxHead.visible = false;
         }
      }
      
      override public function initialize() : void
      {
         var target:CharacterActionPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._CharacterActionPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_CharacterActionPanelWatcherSetupUtil");
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
      
      public function ___rbgVariation_itemClick(param1:ItemClickEvent) : void
      {
         this.onVariationChange(param1);
      }
      
      private function showActionMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnAction.localToGlobal(new Point(0,this.btnAction.y + this.btnAction.height));
            _loc3_ = this._character.actionMenu;
            _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onActionMenuClick);
            _loc3_.show(_loc2_.x,_loc2_.y);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRestoreHead() : Button
      {
         return this._1336538514btnRestoreHead;
      }
      
      public function set _variationContainer(param1:HBox) : void
      {
         var _loc2_:Object = this._2118535603_variationContainer;
         if(_loc2_ !== param1)
         {
            this._2118535603_variationContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_variationContainer",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _variation() : HBox
      {
         return this._1570857836_variation;
      }
      
      public function set boxHead(param1:VBox) : void
      {
         var _loc2_:Object = this._71950923boxHead;
         if(_loc2_ !== param1)
         {
            this._71950923boxHead = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHead",_loc2_,param1));
         }
      }
      
      private function onFacialMenuClick(param1:MenuEvent) : void
      {
         this.btnFacial.label = param1.item.@label;
      }
      
      public function set btnFacial(param1:Button) : void
      {
         var _loc2_:Object = this._203490248btnFacial;
         if(_loc2_ !== param1)
         {
            this._203490248btnFacial = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFacial",_loc2_,param1));
         }
      }
      
      private function _CharacterActionPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","Action");
         _loc1_ = this.btnAction.enabled;
         _loc1_ = UtilDict.toDisplay("go","Slide");
         _loc1_ = UtilDict.toDisplay("go","Variations");
         _loc1_ = UtilDict.toDisplay("go","Facial Expression");
         _loc1_ = this.btnFacial.enabled;
         _loc1_ = UtilDict.toDisplay("go","Look at Camera");
         _loc1_ = UtilDict.toDisplay("go","Handheld");
         _loc1_ = this.btnHandHeld.enabled;
         _loc1_ = UtilDict.toDisplay("go","Headgear");
         _loc1_ = this.btnHeadGear.enabled;
         _loc1_ = UtilDict.toDisplay("go","Head Prop");
         _loc1_ = UtilDict.toDisplay("go","Use default");
         _loc1_ = this.btnRestoreHead.enabled;
      }
      
      [Bindable(event="propertyChange")]
      private function get _character() : Character
      {
         return this._75281834_character;
      }
      
      private function showFacialMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(Console.getConsole().isTutorialOn)
         {
            return;
         }
         if(this._character)
         {
            _loc2_ = this.btnFacial.localToGlobal(new Point(0,this.btnFacial.y + this.btnFacial.height));
            if(this._character.head && this._character.head.thumb.id != this._character.thumb.id + ".head")
            {
               _loc3_ = this._character.headMenu;
            }
            else
            {
               _loc3_ = this._character.facialMenu;
            }
            _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onFacialMenuClick);
            _loc3_.show(_loc2_.x,_loc2_.y);
         }
      }
      
      public function set boxHeadgear(param1:VBox) : void
      {
         var _loc2_:Object = this._752492122boxHeadgear;
         if(_loc2_ !== param1)
         {
            this._752492122boxHeadgear = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHeadgear",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRemoveHeadGear() : Button
      {
         return this._702726737btnRemoveHeadGear;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSlide() : Button
      {
         return this._2097113269btnSlide;
      }
      
      private function onSlideBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._character)
         {
            if(this.btnSlide.selected)
            {
               _loc1_ = new ChangeActionCommand();
               _loc1_.execute();
               this._character.startSlideMotion();
            }
            else
            {
               _loc1_ = new RemoveMotionCommand();
               _loc1_.execute();
               this._character.removeSlideMotion();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHandHeld() : Button
      {
         return this._1780808384btnHandHeld;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAction() : Button
      {
         return this._62698418btnAction;
      }
      
      private function onVariationChange(param1:ItemClickEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:Array = this._character.action.actionGroup.actions;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if((param1.index + 1).toString() == Action(_loc2_[_loc3_]).name)
            {
               _loc4_ = Action(_loc2_[_loc3_]).id;
               this._character.onVariationClick(_loc4_);
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFacial() : Button
      {
         return this._203490248btnFacial;
      }
      
      public function set btnRemoveHandHeld(param1:Button) : void
      {
         var _loc2_:Object = this._414434916btnRemoveHandHeld;
         if(_loc2_ !== param1)
         {
            this._414434916btnRemoveHandHeld = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRemoveHandHeld",_loc2_,param1));
         }
      }
      
      private function _CharacterActionPanel_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this._rbgVariation = _loc1_;
         _loc1_.addEventListener("itemClick",this.___rbgVariation_itemClick);
         _loc1_.initialized(this,"_rbgVariation");
         return _loc1_;
      }
      
      public function __btnAction_click(param1:MouseEvent) : void
      {
         this.showActionMenu(param1);
      }
      
      public function __btnLookAtCamera_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipCCLookAtCamera();
      }
      
      private function initVariation() : void
      {
         var _loc1_:RadioButton = null;
         var _loc2_:int = 0;
         if(this._character && this._character.action && this._character.action.actionGroup)
         {
            this._variationContainer.removeAllChildren();
            this._rbgVariation = new RadioButtonGroup();
            this._rbgVariation.addEventListener(ItemClickEvent.ITEM_CLICK,this.onVariationChange);
            _loc2_ = 0;
            while(_loc2_ < this._character.action.actionGroup.actions.length)
            {
               _loc1_ = new RadioButton();
               _loc1_.buttonMode = true;
               _loc1_.group = this._rbgVariation;
               _loc1_.styleName = "btnVariation" + (_loc2_ + 1);
               this._variationContainer.addChild(_loc1_);
               if((_loc2_ + 1).toString() == this._character.action.name)
               {
                  _loc1_.selected = true;
               }
               _loc2_++;
            }
            this._variation.visible = this._variation.includeInLayout = true;
         }
         else
         {
            this._variation.visible = this._variation.includeInLayout = false;
         }
      }
      
      private function updateActionPanel() : void
      {
         if(this._character)
         {
            if(this._character.action.actionGroup)
            {
               this.btnAction.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.action.actionGroup.name));
            }
            else
            {
               this.btnAction.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.action.name));
            }
            this.initVariation();
            if(this._character.head && this._character.head.state)
            {
               this.btnFacial.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.head.state.name));
            }
            else
            {
               this.btnFacial.label = UtilDict.toDisplay("go","Select");
            }
            if(this._character.prop)
            {
               if(this._character.prop.state)
               {
                  this.btnHandHeld.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.prop.state.name));
                  this.btnHandHeld.enabled = true;
               }
               else
               {
                  this.btnHandHeld.label = UtilDict.toDisplay("go","No state");
                  this.btnHandHeld.enabled = false;
               }
               this.boxHandheld.includeInLayout = this.boxHandheld.visible = true;
            }
            else
            {
               this.boxHandheld.includeInLayout = this.boxHandheld.visible = false;
            }
            if(this._character.wear)
            {
               if(this._character.wear.state)
               {
                  this.btnHeadGear.label = UtilString.firstLetterToUpperCase(this._character.wear.state.name);
                  this.btnHeadGear.enabled = true;
               }
               else
               {
                  this.btnHeadGear.label = UtilDict.toDisplay("go","No state");
                  this.btnHeadGear.enabled = false;
               }
               this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = true;
            }
            else
            {
               this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = false;
            }
            if(this._character.head && this._character.head.thumb.id != this._character.thumb.id + ".head")
            {
               this.boxHead.includeInLayout = this.boxHead.visible = true;
            }
            else
            {
               this.boxHead.includeInLayout = this.boxHead.visible = false;
            }
            if(this._character.lookAtCameraSupported)
            {
               this.btnLookAtCamera.selected = this._character.lookAtCamera;
               this.btnLookAtCamera.visible = true;
            }
            else
            {
               this.btnLookAtCamera.visible = false;
            }
            this.btnSlide.selected = this._character.isSliding;
            this.banner.refresh(this._character);
         }
      }
      
      public function set btnLookAtCamera(param1:Button) : void
      {
         var _loc2_:Object = this._947794573btnLookAtCamera;
         if(_loc2_ !== param1)
         {
            this._947794573btnLookAtCamera = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLookAtCamera",_loc2_,param1));
         }
      }
      
      public function set actionPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1569328494actionPanel;
         if(_loc2_ !== param1)
         {
            this._1569328494actionPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionPanel",_loc2_,param1));
         }
      }
      
      private function removeHandHeld() : void
      {
         if(this._character)
         {
            this._character.removeHandHeld();
            this.boxHandheld.includeInLayout = this.boxHandheld.visible = false;
         }
      }
      
      private function onActionMenuClick(param1:MenuEvent) : void
      {
         this.btnAction.label = param1.item.@label;
      }
      
      public function set _rbgVariation(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1419525765_rbgVariation;
         if(_loc2_ !== param1)
         {
            this._1419525765_rbgVariation = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rbgVariation",_loc2_,param1));
         }
      }
   }
}
