package anifire.components.containers
{
   import anifire.core.BubbleAsset;
   import anifire.util.UtilEffect;
   import flash.events.Event;
   import mx.containers.VBox;
   import mx.controls.ComboBox;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   
   public class AssetEffectControl extends VBox
   {
       
      
      private var _1860476315_txtDuration:TextInput;
      
      private var _fxName:String;
      
      private var _316153809_cbEffect:ComboBox;
      
      private var _fxDuration:Number;
      
      private var _target:Object;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function AssetEffectControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ComboBox,
                  "id":"_cbEffect",
                  "events":{"change":"___cbEffect_change"}
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"_txtDuration",
                  "events":{"change":"___txtDuration_change"}
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___AssetEffectControl_VBox1_creationComplete);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set _txtDuration(param1:TextInput) : void
      {
         var _loc2_:Object = this._1860476315_txtDuration;
         if(_loc2_ !== param1)
         {
            this._1860476315_txtDuration = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDuration",_loc2_,param1));
         }
      }
      
      public function set _cbEffect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._316153809_cbEffect;
         if(_loc2_ !== param1)
         {
            this._316153809_cbEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbEffect",_loc2_,param1));
         }
      }
      
      private function init() : void
      {
         this._cbEffect.dataProvider = UtilEffect.getEffects();
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:BubbleAsset = null;
         if(param1 is BubbleAsset)
         {
            _loc2_ = BubbleAsset(param1);
            this._target = param1;
            this._fxName = _loc2_.fxName;
            this._fxDuration = _loc2_.fxDuration;
         }
      }
      
      public function ___cbEffect_change(param1:ListEvent) : void
      {
         this.updateTarget();
      }
      
      public function ___txtDuration_change(param1:Event) : void
      {
         this.updateTarget();
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbEffect() : ComboBox
      {
         return this._316153809_cbEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDuration() : TextInput
      {
         return this._1860476315_txtDuration;
      }
      
      private function updateTarget() : void
      {
         var _loc1_:BubbleAsset = null;
         if(this._target is BubbleAsset)
         {
            _loc1_ = BubbleAsset(this._target);
            _loc1_.fxName = this._cbEffect.selectedLabel;
            _loc1_.fxDuration = Number(this._txtDuration.text);
         }
      }
      
      public function ___AssetEffectControl_VBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
   }
}
