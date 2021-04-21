package anifire.playerComponent
{
   import anifire.component.DoubleStateButton;
   import anifire.playback.PlayerEvent;
   import flash.events.Event;
   import mx.containers.HBox;
   import mx.controls.HSlider;
   import mx.controls.sliderClasses.Slider;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   
   public class VolumeControl extends HBox
   {
       
      
      private var _1698099045volumeSlider:HSlider;
      
      private var _1413468584muteBut:DoubleStateButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _volume:Number = 0.5;
      
      public function VolumeControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HSlider,
                  "id":"volumeSlider",
                  "events":{"change":"__volumeSlider_change"},
                  "stylesFactory":function():void
                  {
                     this.showTrackHighlight = false;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":50,
                        "liveDragging":true,
                        "showDataTip":false,
                        "styleName":"slider"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":DoubleStateButton,
                  "id":"muteBut",
                  "events":{
                     "But1Click":"__muteBut_But1Click",
                     "But2Click":"__muteBut_But2Click"
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "but1StyleName":"btnVolume",
                        "but2StyleName":"btnMute"
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___VolumeControl_HBox1_creationComplete);
      }
      
      public function __muteBut_But1Click(param1:Event) : void
      {
         this.onMuteButClick(param1);
      }
      
      private function initVolume() : void
      {
         this.volumeSlider.maximum = 1;
         this.volumeSlider.minimum = 0;
         this.volume = this.volume;
      }
      
      private function onCreationCompleted(... rest) : void
      {
         this.initVolume();
         this.callLater(this.initVolume);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      [Bindable(event="propertyChange")]
      public function get volumeSlider() : HSlider
      {
         return this._1698099045volumeSlider;
      }
      
      public function set muteBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._1413468584muteBut;
         if(_loc2_ !== param1)
         {
            this._1413468584muteBut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"muteBut",_loc2_,param1));
         }
      }
      
      public function __muteBut_But2Click(param1:Event) : void
      {
         this.onUnMuteButClick(param1);
      }
      
      public function ___VolumeControl_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
      }
      
      [Bindable(event="propertyChange")]
      public function get muteBut() : DoubleStateButton
      {
         return this._1413468584muteBut;
      }
      
      private function onVolumeSliderChange(param1:SliderEvent) : void
      {
         var _loc2_:Slider = param1.target as Slider;
         this.volume = _loc2_.value;
         var _loc3_:PlayerEvent = new PlayerEvent(PlayerEvent.VOLUME_CHANGE,_loc2_.value);
         this.dispatchEvent(_loc3_);
      }
      
      public function set volume(param1:Number) : void
      {
         this._volume = param1;
         if(this.volumeSlider != null)
         {
            this.volumeSlider.value = this._volume;
         }
         if(this.muteBut != null)
         {
            if(this._volume > 0)
            {
               this.muteBut.setState(DoubleStateButton.STATE_BUT1);
            }
            else
            {
               this.muteBut.setState(DoubleStateButton.STATE_BUT2);
            }
         }
      }
      
      private function onUnMuteButClick(param1:Event) : void
      {
         this.volume = this.volume;
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.VOLUME_CHANGE,this.volume);
         this.dispatchEvent(_loc2_);
      }
      
      public function __volumeSlider_change(param1:SliderEvent) : void
      {
         this.onVolumeSliderChange(param1);
      }
      
      public function set volumeSlider(param1:HSlider) : void
      {
         var _loc2_:Object = this._1698099045volumeSlider;
         if(_loc2_ !== param1)
         {
            this._1698099045volumeSlider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"volumeSlider",_loc2_,param1));
         }
      }
      
      private function onMuteButClick(param1:Event) : void
      {
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.VOLUME_CHANGE,0);
         this.volumeSlider.value = 0;
         this.dispatchEvent(_loc2_);
      }
   }
}
