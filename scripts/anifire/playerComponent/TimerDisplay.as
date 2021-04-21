package anifire.playerComponent
{
   import anifire.util.UtilHashArray;
   import anifire.util.UtilString;
   import mx.containers.Canvas;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class TimerDisplay extends Canvas
   {
       
      
      private var _838772035totalTimeLabel:Text;
      
      private var _177936123infoText:Text;
      
      private var _total:Number;
      
      private var _cur:Number;
      
      private var _textsPendingToBeShow:UtilHashArray;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function TimerDisplay()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":112,
                  "height":26,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Text,
                     "id":"infoText",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":100,
                           "x":8,
                           "y":4,
                           "selectable":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"totalTimeLabel",
                     "stylesFactory":function():void
                     {
                        this.textAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "text":"--:-- / --:--",
                           "x":4,
                           "y":4,
                           "selectable":false,
                           "width":104
                        };
                     }
                  })]
               };
            }
         });
         this._textsPendingToBeShow = new UtilHashArray();
         super();
         mx_internal::_document = this;
         this.width = 112;
         this.height = 26;
      }
      
      public function set totalTimeLabel(param1:Text) : void
      {
         var _loc2_:Object = this._838772035totalTimeLabel;
         if(_loc2_ !== param1)
         {
            this._838772035totalTimeLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"totalTimeLabel",_loc2_,param1));
         }
      }
      
      public function set infoText(param1:Text) : void
      {
         var _loc2_:Object = this._177936123infoText;
         if(_loc2_ !== param1)
         {
            this._177936123infoText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"infoText",_loc2_,param1));
         }
      }
      
      public function setTotalTime(param1:Number) : void
      {
         this._total = param1;
         this.totalTimeLabel.text = UtilString.convertSecToTimeString(this._cur) + " / " + UtilString.convertSecToTimeString(this._total);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function setCurTime(param1:Number) : void
      {
         this._cur = param1;
         this.totalTimeLabel.text = UtilString.convertSecToTimeString(this._cur) + " / " + UtilString.convertSecToTimeString(this._total);
      }
      
      public function clearText(param1:String) : void
      {
         this._textsPendingToBeShow.removeByKey(param1);
         if(this._textsPendingToBeShow.length <= 0)
         {
            this.totalTimeLabel.visible = true;
            this.infoText.text = "";
         }
         else
         {
            this.totalTimeLabel.visible = false;
            this.infoText.text = this._textsPendingToBeShow.getValueByIndex(this._textsPendingToBeShow.length - 1) as String;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get infoText() : Text
      {
         return this._177936123infoText;
      }
      
      [Bindable(event="propertyChange")]
      public function get totalTimeLabel() : Text
      {
         return this._838772035totalTimeLabel;
      }
      
      public function setText(param1:String, param2:String) : void
      {
         this._textsPendingToBeShow.push(param1,param2);
         this.totalTimeLabel.visible = false;
         this.infoText.text = param2;
      }
   }
}
