package anifire.component
{
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class GoAlert extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1370988937_btnCancel:Button;
      
      mx_internal var _watchers:Array;
      
      private var _2122106277_btnClose:IconTextButton;
      
      private var _thumbnailCanvas:Object;
      
      private var _1508736480_ans2Box:VBox;
      
      private var _1296992261_alertTitle:Text;
      
      private var _2131428919_lblConfirm:Label;
      
      private var _assetType:String;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1508706689_ans1Box:VBox;
      
      mx_internal var _bindings:Array;
      
      private var _1338722904_btnDelete:Button;
      
      private var _101803332_txtDelete:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function GoAlert()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":328,
                  "height":202,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":VBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "middle";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_lblConfirm",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 18;
                                          this.textAlign = "left";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"text":""};
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_alertTitle",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 18;
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "visible":false,
                                    "includeInLayout":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_txtDelete",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"",
                                    "percentWidth":100,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalAlign = "center";
                                 this.horizontalGap = 20;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"_ans1Box",
                                       "stylesFactory":function():void
                                       {
                                          this.verticalCenter = "0";
                                          this.horizontalAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnDelete",
                                                "events":{"click":"___btnDelete_click"},
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 12;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"btnBlack",
                                                      "width":108,
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"_ans2Box",
                                       "stylesFactory":function():void
                                       {
                                          this.verticalCenter = "0";
                                          this.horizontalAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnCancel",
                                                "events":{"click":"___btnCancel_click"},
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 12;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"btnBlack",
                                                      "width":108,
                                                      "buttonMode":true
                                                   };
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
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnClose",
                     "events":{
                        "click":"___btnClose_click",
                        "creationComplete":"___btnClose_creationComplete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnCloseTop",
                           "buttonMode":true,
                           "labelPlacement":"left"
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
         this.width = 328;
         this.height = 202;
         this.styleName = "previewWindow";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = true;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         GoAlert._watcherSetupUtil = param1;
      }
      
      public function set _ans1Box(param1:VBox) : void
      {
         var _loc2_:Object = this._1508706689_ans1Box;
         if(_loc2_ !== param1)
         {
            this._1508706689_ans1Box = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ans1Box",_loc2_,param1));
         }
      }
      
      private function closeWindow(param1:Event) : void
      {
         PopUpManager.removePopUp(this);
      }
      
      public function showButton(param1:Boolean, param2:Boolean) : void
      {
         this._ans1Box.visible = param1;
         this._ans2Box.visible = param2;
         this._ans1Box.includeInLayout = param1;
         this._ans2Box.includeInLayout = param2;
      }
      
      override public function initialize() : void
      {
         var target:GoAlert = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._GoAlert_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_GoAlertWatcherSetupUtil");
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
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         this.onOkClick(param1);
      }
      
      public function set _lblConfirm(param1:Label) : void
      {
         var _loc2_:Object = this._2131428919_lblConfirm;
         if(_loc2_ !== param1)
         {
            this._2131428919_lblConfirm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblConfirm",_loc2_,param1));
         }
      }
      
      public function set assetType(param1:String) : void
      {
         this._assetType = param1;
         this._lblConfirm.text = UtilDict.toDisplay("go","goalert_del" + param1.toLowerCase());
         this._txtDelete.text = UtilDict.toDisplay("go","goalert_del" + param1.toLowerCase() + "text");
      }
      
      public function set cancelButton(param1:String) : void
      {
         this._btnCancel.label = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ans1Box() : VBox
      {
         return this._1508706689_ans1Box;
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      private function _GoAlert_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","goalert_delete");
         _loc1_ = UtilDict.toDisplay("go","goalert_cancel");
         _loc1_ = UtilDict.toDisplay("go","Close");
      }
      
      public function hideCloseBtn() : void
      {
         this._btnClose.visible = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelete() : Button
      {
         return this._1338722904_btnDelete;
      }
      
      private function onOkClick(param1:Event) : void
      {
         if(this.thumbnailCanvas != null)
         {
            this.thumbnailCanvas.deleteThumbnail();
         }
         this.closeWindow(param1);
      }
      
      public function set _btnClose(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2122106277_btnClose;
         if(_loc2_ !== param1)
         {
            this._2122106277_btnClose = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose",_loc2_,param1));
         }
      }
      
      public function set alertTitle(param1:String) : void
      {
         this._alertTitle.includeInLayout = true;
         this._alertTitle.visible = true;
         this._alertTitle.text = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDelete() : Text
      {
         return this._101803332_txtDelete;
      }
      
      public function set _ans2Box(param1:VBox) : void
      {
         var _loc2_:Object = this._1508736480_ans2Box;
         if(_loc2_ !== param1)
         {
            this._1508736480_ans2Box = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ans2Box",_loc2_,param1));
         }
      }
      
      private function _GoAlert_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","goalert_delete");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnDelete.label = param1;
         },"_btnDelete.label");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","goalert_cancel");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCancel.label = param1;
         },"_btnCancel.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnClose.label = param1;
         },"_btnClose.label");
         result[2] = binding;
         return result;
      }
      
      public function set thumbnailCanvas(param1:Object) : void
      {
         this._thumbnailCanvas = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblConfirm() : Label
      {
         return this._2131428919_lblConfirm;
      }
      
      private function initClose() : void
      {
         this._btnClose.x = this.width - this._btnClose.width - 20;
         this._btnClose.y = 0;
         var _loc1_:ColorTransform = new ColorTransform(0,0,0);
         this._btnClose.transform.colorTransform = _loc1_;
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
      
      public function get assetType() : String
      {
         return this._assetType;
      }
      
      public function set okButton(param1:String) : void
      {
         this._btnDelete.label = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _ans2Box() : VBox
      {
         return this._1508736480_ans2Box;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose() : IconTextButton
      {
         return this._2122106277_btnClose;
      }
      
      public function get thumbnailCanvas() : Object
      {
         return this._thumbnailCanvas;
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
         }
      }
      
      public function ___btnClose_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      public function set _txtDelete(param1:Text) : void
      {
         var _loc2_:Object = this._101803332_txtDelete;
         if(_loc2_ !== param1)
         {
            this._101803332_txtDelete = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDelete",_loc2_,param1));
         }
      }
      
      public function set alertContent(param1:String) : void
      {
         this._txtDelete.includeInLayout = true;
         this._txtDelete.visible = true;
         this._txtDelete.htmlText = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _alertTitle() : Text
      {
         return this._1296992261_alertTitle;
      }
      
      public function ___btnClose_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      public function set _alertTitle(param1:Text) : void
      {
         var _loc2_:Object = this._1296992261_alertTitle;
         if(_loc2_ !== param1)
         {
            this._1296992261_alertTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_alertTitle",_loc2_,param1));
         }
      }
   }
}
