package anifire.components.studio
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class EffectTray extends VBox
   {
      
      private static const BUT_HEIGHT:Number = 19;
      
      private static const BUT_STYLE_FX:String = "btnEffectMenu";
      
      private static const BUT_STYLE_BUBBLE:String = "btnBubbleMenu";
      
      private static const BUT_STYLE_SPEECH:String = "btnSpeechMenu";
      
      private static const BUT_WIDTH:Number = 23;
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _butListeners:Array;
      
      private var _idToIndexMap:UtilHashArray;
      
      public function EffectTray()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({"type":VBox});
         this._butListeners = new Array();
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.horizontalAlign = "right";
         };
         this.addEventListener("creationComplete",this.___EffectTray_VBox1_creationComplete);
      }
      
      public function sendEffectToTop(param1:String) : void
      {
         var _loc2_:Button = this._idToIndexMap.getValueByKey(param1) as Button;
         this._idToIndexMap.removeByKey(param1);
         this._idToIndexMap.unShift(param1,_loc2_);
         this.removeChild(_loc2_);
         this.addChildAt(_loc2_,0);
      }
      
      private function initButton(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onButClick);
         _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onButOver);
         _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onButOut);
         _loc2_.width = BUT_WIDTH;
         _loc2_.height = BUT_HEIGHT;
      }
      
      public function addSpeech(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:Button = new Button();
         _loc2_.addEventListener(FlexEvent.CREATION_COMPLETE,this.initButton);
         var _loc3_:AnimeSound = Console.getConsole().speechManager.getValueByKey(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.soundThumb.ttsData.type != "mic")
            {
               _loc4_ = _loc3_.soundThumb.ttsData.voice;
               _loc2_.toolTip = _loc4_;
            }
         }
         _loc2_.buttonMode = true;
         _loc2_.styleName = BUT_STYLE_SPEECH;
         this._idToIndexMap.push(param1,_loc2_);
         this.addChild(_loc2_);
      }
      
      private function onButOver(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         var _loc3_:String = this._idToIndexMap.getKey(_loc2_.parent.getChildIndex(_loc2_));
         var _loc4_:EffectTrayEvent = new EffectTrayEvent(EffectTrayEvent.EFFECT_OVER,this,_loc3_);
         this.dispatchEvent(_loc4_);
      }
      
      public function sendEffectToBottom(param1:String) : void
      {
         var _loc2_:Button = this._idToIndexMap.getValueByKey(param1) as Button;
         this._idToIndexMap.removeByKey(param1);
         this._idToIndexMap.push(param1,_loc2_);
         this.removeChild(_loc2_);
         this.addChildAt(_loc2_,this.numChildren);
      }
      
      public function ___EffectTray_VBox1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function addBubble(param1:String, param2:String) : void
      {
         var _loc3_:Button = new Button();
         _loc3_.addEventListener(FlexEvent.CREATION_COMPLETE,this.initButton);
         _loc3_.toolTip = param2;
         _loc3_.buttonMode = true;
         _loc3_.styleName = BUT_STYLE_BUBBLE;
         this._idToIndexMap.push(param1,_loc3_);
         this.addChild(_loc3_);
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         this._idToIndexMap.removeAll();
         this.removeAllChildren();
         _loc1_ = 0;
         while(_loc1_ < this._butListeners.length)
         {
            this.removeEventListener(EffectTrayEvent.EFFECT_PRESS,this._butListeners[_loc1_] as Function);
            _loc1_++;
         }
         this._butListeners.splice(0,this._butListeners.length);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function initApp() : void
      {
         this._idToIndexMap = new UtilHashArray();
      }
      
      public function addEffect(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Button;
         (_loc4_ = new Button()).addEventListener(FlexEvent.CREATION_COMPLETE,this.initButton);
         _loc4_.toolTip = param3;
         _loc4_.buttonMode = true;
         _loc4_.styleName = BUT_STYLE_FX;
         this._idToIndexMap.push(param1,_loc4_);
         this.addChild(_loc4_);
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0.0, param5:Boolean = false) : void
      {
         if(param1 == EffectTrayEvent.EFFECT_PRESS)
         {
            this._butListeners.push(param2);
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      private function onButClick(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         var _loc3_:String = this._idToIndexMap.getKey(_loc2_.parent.getChildIndex(_loc2_));
         var _loc4_:EffectTrayEvent = new EffectTrayEvent(EffectTrayEvent.EFFECT_PRESS,this,_loc3_);
         this.dispatchEvent(_loc4_);
      }
      
      private function onButOut(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:EffectTrayEvent = null;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_.parent != null)
         {
            _loc3_ = this._idToIndexMap.getKey(_loc2_.parent.getChildIndex(_loc2_));
            _loc4_ = new EffectTrayEvent(EffectTrayEvent.EFFECT_OUT,this,_loc3_);
            this.dispatchEvent(_loc4_);
         }
      }
   }
}
