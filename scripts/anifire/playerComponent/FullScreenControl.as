package anifire.playerComponent
{
   import anifire.component.DoubleStateButton;
   import anifire.playback.PlayerEvent;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import mx.containers.HBox;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class FullScreenControl extends HBox
   {
       
      
      private var _511269518fullBut:DoubleStateButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function FullScreenControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":DoubleStateButton,
                  "id":"fullBut",
                  "events":{
                     "But1Click":"__fullBut_But1Click",
                     "But2Click":"__fullBut_But2Click"
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "but1StyleName":"btnFull",
                        "but2StyleName":"btnNor"
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___FullScreenControl_HBox1_creationComplete);
      }
      
      private function switchToNor(param1:Event = null) : void
      {
         this.fullBut.setState(DoubleStateButton.STATE_BUT1);
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.NOR_SCREEN);
         this.dispatchEvent(_loc2_);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.isEscUp);
      }
      
      public function set fullBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._511269518fullBut;
         if(_loc2_ !== param1)
         {
            this._511269518fullBut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fullBut",_loc2_,param1));
         }
      }
      
      public function ___FullScreenControl_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
      }
      
      private function isEscUp(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen == false)
         {
            this.switchToNor();
         }
      }
      
      public function __fullBut_But1Click(param1:Event) : void
      {
         this.switchToFull(param1);
      }
      
      private function onCreationCompleted(... rest) : void
      {
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function __fullBut_But2Click(param1:Event) : void
      {
         this.switchToNor(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get fullBut() : DoubleStateButton
      {
         return this._511269518fullBut;
      }
      
      private function switchToFull(param1:Event = null) : void
      {
         this.fullBut.setState(DoubleStateButton.STATE_BUT2);
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.FULL_SCREEN);
         this.dispatchEvent(_loc2_);
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.isEscUp);
      }
   }
}
