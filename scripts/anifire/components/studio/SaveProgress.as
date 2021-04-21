package anifire.components.studio
{
   import anifire.core.CoreEvent;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class SaveProgress extends Canvas
   {
       
      
      private var _dotTimerTicker:int;
      
      private var _1365915504saveMsgLabel:Label;
      
      private var _msgTimerTicker:int;
      
      private const MSG_TIME_INTERVAL:int = 5000;
      
      private var _curentDot:String;
      
      private const DOT_TIME_INTERVAL:int = 300;
      
      private var _messageToDisplay:Array;
      
      private var _currentMsgIndex:int;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SaveProgress()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":284,
                  "height":26,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Label,
                     "id":"saveMsgLabel",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 14;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "text":"",
                           "width":252
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 284;
         this.height = 26;
      }
      
      public function startSavingProgress() : void
      {
         this.init();
         this.doUpdateDot();
      }
      
      private function init() : void
      {
         this._messageToDisplay = new Array();
         this._messageToDisplay.push(UtilDict.toDisplay("go","Serializing"));
         this._messageToDisplay.push(UtilDict.toDisplay("go","saveprogress_upload"));
         this._messageToDisplay.push(UtilDict.toDisplay("go","saveprogress_analysis"));
         this._messageToDisplay.push(UtilDict.toDisplay("go","saveprogress_saving"));
         this._messageToDisplay.push(UtilDict.toDisplay("go","saveprogress_render"));
         this._currentMsgIndex = 0;
         this._msgTimerTicker = -1;
         this._dotTimerTicker = -1;
         this.saveMsgLabel.text = "";
         this._curentDot = "";
         addEventListener(CoreEvent.SERIALIZE_COMPLETE,function(param1:Event):void
         {
            doUpdateMsg();
         });
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set saveMsgLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1365915504saveMsgLabel;
         if(_loc2_ !== param1)
         {
            this._1365915504saveMsgLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"saveMsgLabel",_loc2_,param1));
         }
      }
      
      public function stopSavingProgress() : void
      {
         clearTimeout(this._dotTimerTicker);
         clearTimeout(this._msgTimerTicker);
      }
      
      private function doUpdateMsg() : void
      {
         if(this._currentMsgIndex < this._messageToDisplay.length - 1)
         {
            ++this._currentMsgIndex;
         }
         this.updateMsg();
         this._msgTimerTicker = setTimeout(this.doUpdateMsg,this.MSG_TIME_INTERVAL + Math.round(this.MSG_TIME_INTERVAL * 0.3 * (Math.random() - 0.5)));
      }
      
      private function doUpdateDot() : void
      {
         var _loc1_:int = this._curentDot.length + 1;
         _loc1_ = _loc1_ % 4;
         this._curentDot = "";
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._curentDot = this._curentDot + ".";
            _loc2_++;
         }
         this.updateMsg();
         this._dotTimerTicker = setTimeout(this.doUpdateDot,this.DOT_TIME_INTERVAL);
      }
      
      private function updateMsg() : void
      {
         this.saveMsgLabel.text = (this._messageToDisplay[this._currentMsgIndex] as String) + this._curentDot;
         this.saveMsgLabel.x = this.saveMsgLabel.x - (this.saveMsgLabel.width / 2 + this.saveMsgLabel.x - (this.saveMsgLabel.parent.x + this.saveMsgLabel.parent.width / 2));
      }
      
      [Bindable(event="propertyChange")]
      public function get saveMsgLabel() : Label
      {
         return this._1365915504saveMsgLabel;
      }
   }
}
