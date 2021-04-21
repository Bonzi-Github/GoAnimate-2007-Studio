package anifire.components.studio
{
   import anifire.color.SelectedColor;
   import anifire.command.ColorAssetCommand;
   import anifire.command.ICommand;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.events.AssetEvent;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.ColorPicker;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.DropdownEvent;
   import mx.events.PropertyChangeEvent;
   
   public class AssetColorPanel extends Canvas
   {
       
      
      private var _1275269217colorPanel:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1482076687_asset:Asset;
      
      public function AssetColorPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"colorPanel",
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 15;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      private function updateColor(param1:ColorPickerEvent) : void
      {
         var _loc2_:ICommand = null;
         if(this._asset)
         {
            _loc2_ = new ColorAssetCommand(this._asset.id,ColorPicker(param1.currentTarget).id);
            _loc2_.execute();
            this._asset.doChangeColor(ColorPicker(param1.currentTarget).id,param1.color);
         }
      }
      
      private function startPick(param1:Event) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get colorPanel() : VBox
      {
         return this._1275269217colorPanel;
      }
      
      public function set target(param1:Object) : void
      {
         if(this._asset is Asset)
         {
            this._asset.removeEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
         }
         if(param1)
         {
            if(param1 is Asset)
            {
               this._asset = Asset(param1);
               this._asset.addEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
            }
            else
            {
               this._asset = null;
            }
         }
         else
         {
            this._asset = null;
         }
         this.updateColorPanel();
      }
      
      private function updateColorPanel() : void
      {
         var _loc1_:int = 0;
         var _loc2_:HBox = null;
         var _loc3_:Label = null;
         var _loc4_:Array = null;
         var _loc5_:Spacer = null;
         var _loc6_:Button = null;
         var _loc7_:ColorPicker = null;
         var _loc8_:Array = null;
         this.colorPanel.removeAllChildren();
         if(this._asset && this._asset.isColorable())
         {
            if((_loc4_ = this._asset.getColorArea()) != null)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc4_.length)
               {
                  _loc2_ = new HBox();
                  _loc3_ = new Label();
                  _loc3_.text = UtilDict.toDisplay("store",_loc4_[_loc1_]) + ":";
                  (_loc7_ = new ColorPicker()).id = _loc4_[_loc1_];
                  _loc7_.buttonMode = true;
                  _loc7_.addEventListener(DropdownEvent.OPEN,this.startPick);
                  _loc7_.addEventListener(DropdownEvent.CLOSE,this.endPick);
                  if(this._asset.customColor.getValueByKey(_loc4_[_loc1_]) != null)
                  {
                     _loc7_.selectedColor = SelectedColor(this._asset.customColor.getValueByKey(_loc4_[_loc1_])).dstColor;
                  }
                  else
                  {
                     _loc7_.selectedColor = 0;
                  }
                  if(this._asset.thumb.colorRef.getValueByKey(_loc4_[_loc1_]) != null)
                  {
                     _loc8_ = String(this._asset.thumb.colorRef.getValueByKey(_loc4_[_loc1_])).split(",");
                     _loc7_.dataProvider = _loc8_;
                  }
                  _loc7_.addEventListener(ColorPickerEvent.CHANGE,this.updateColor);
                  _loc2_.addChild(_loc3_);
                  _loc2_.addChild(_loc7_);
                  this.colorPanel.addChild(_loc2_);
                  _loc1_++;
               }
            }
            (_loc5_ = new Spacer()).percentHeight = 100;
            this.colorPanel.addChild(_loc5_);
            (_loc6_ = new Button()).label = UtilDict.toDisplay("go","propwin_restore");
            _loc6_.styleName = "btnSidePanel";
            _loc6_.buttonMode = true;
            _loc6_.addEventListener(MouseEvent.CLICK,this.restoreColor);
            this.colorPanel.addChild(_loc6_);
         }
      }
      
      private function set _asset(param1:Asset) : void
      {
         var _loc2_:Object = this._1482076687_asset;
         if(_loc2_ !== param1)
         {
            this._1482076687_asset = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_asset",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set colorPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1275269217colorPanel;
         if(_loc2_ !== param1)
         {
            this._1275269217colorPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPanel",_loc2_,param1));
         }
      }
      
      private function restoreColor(param1:MouseEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:Array = null;
         if(this._asset)
         {
            _loc2_ = new ColorAssetCommand(this._asset.id);
            _loc2_.execute();
            this._asset.restoreColor();
            this.updateColorPanel();
         }
         if(this._asset is Character)
         {
            _loc3_ = this._asset.getColorArea();
            Character(this._asset).restoreColorById(_loc3_);
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _asset() : Asset
      {
         return this._1482076687_asset;
      }
      
      private function endPick(param1:Event) : void
      {
      }
      
      private function onAssetStateChange(param1:AssetEvent) : void
      {
         this.updateColorPanel();
      }
   }
}
