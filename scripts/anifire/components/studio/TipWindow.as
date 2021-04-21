package anifire.components.studio
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class TipWindow extends Canvas
   {
       
      
      private var _1480441607_close:Canvas;
      
      private var _94436_bg:Canvas;
      
      private var _985212102_content:Canvas;
      
      private var _1464826535_title:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function TipWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":200,
                  "height":200,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_bg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "propertiesFactory":function():Object
                     {
                        return {"childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_title",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":25,
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_content",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_close",
                           "stylesFactory":function():void
                           {
                              this.horizontalCenter = "1";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        })]};
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 200;
         this.height = 200;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___TipWindow_Canvas1_creationComplete);
      }
      
      public function set _title(param1:Canvas) : void
      {
         var _loc2_:Object = this._1464826535_title;
         if(_loc2_ !== param1)
         {
            this._1464826535_title = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_title",_loc2_,param1));
         }
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      public function onCreatDone() : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function setTitle(param1:DisplayObject) : void
      {
         this._title.addChild(param1);
      }
      
      public function init(param1:uint = 13421772, param2:Number = 10) : void
      {
         this._bg.graphics.beginFill(param1);
         this._bg.graphics.drawRoundRect(0,0,this._bg.width,this._bg.height,param2,param2);
         this._bg.graphics.endFill();
      }
      
      [Bindable(event="propertyChange")]
      public function get _title() : Canvas
      {
         return this._1464826535_title;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
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
      
      public function set _content(param1:Canvas) : void
      {
         var _loc2_:Object = this._985212102_content;
         if(_loc2_ !== param1)
         {
            this._985212102_content = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_content",_loc2_,param1));
         }
      }
      
      public function setClose(param1:DisplayObject) : void
      {
         this._close.addChild(param1);
      }
      
      public function setContent(param1:DisplayObject) : void
      {
         this._content.addChild(param1);
      }
      
      public function ___TipWindow_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreatDone();
      }
      
      [Bindable(event="propertyChange")]
      public function get _close() : Canvas
      {
         return this._1480441607_close;
      }
      
      [Bindable(event="propertyChange")]
      public function get _content() : Canvas
      {
         return this._985212102_content;
      }
   }
}
