package anifire.timeline
{
   import mx.containers.Canvas;
   import mx.controls.ButtonBar;
   import mx.controls.buttonBarClasses.ButtonBarButton;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class BottomBarContainer extends Canvas implements ITimelineContainer
   {
       
      
      private var _11548545buttonBar:ButtonBar;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function BottomBarContainer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "height":25,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ButtonBar,
                     "id":"buttonBar",
                     "events":{"itemClick":"__buttonBar_itemClick"},
                     "stylesFactory":function():void
                     {
                        this.right = "5";
                        this.verticalCenter = "0";
                        this.horizontalGap = 6;
                        this.fontSize = 8;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"dataProvider":[{
                           "label":"",
                           "data":"prev"
                        },{
                           "label":"",
                           "data":"next"
                        }]};
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 16777215;
         };
         this.percentWidth = 100;
         this.height = 25;
      }
      
      public function getHorizontalView() : Number
      {
         return 0;
      }
      
      public function set buttonBar(param1:ButtonBar) : void
      {
         var _loc2_:Object = this._11548545buttonBar;
         if(_loc2_ !== param1)
         {
            this._11548545buttonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBar",_loc2_,param1));
         }
      }
      
      public function removeAllItems() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBar() : ButtonBar
      {
         return this._11548545buttonBar;
      }
      
      public function get count() : int
      {
         return width;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function getCurrIndex() : int
      {
         return 0;
      }
      
      public function getItemAt(param1:int) : ITimelineElement
      {
         return null;
      }
      
      public function setTitle(param1:String) : void
      {
      }
      
      public function __buttonBar_itemClick(param1:ItemClickEvent) : void
      {
         this.buttonClickHandler(param1);
      }
      
      public function getCurrItem() : ITimelineElement
      {
         return null;
      }
      
      public function addItem(param1:UIComponent) : void
      {
      }
      
      public function get length() : Number
      {
         return width;
      }
      
      public function addItemAt(param1:UIComponent, param2:int) : void
      {
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
      }
      
      public function disableFocus() : void
      {
      }
      
      public function toggleButton(param1:uint, param2:Boolean) : void
      {
         var _loc3_:ButtonBarButton = this.buttonBar.getChildAt(param1) as ButtonBarButton;
         _loc3_.enabled = param2;
      }
      
      public function removeItem(param1:Number = -1) : Boolean
      {
         return true;
      }
      
      private function initApp() : void
      {
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
      }
      
      private function buttonClickHandler(param1:ItemClickEvent) : void
      {
         switch(param1.item.data)
         {
            case "next":
               dispatchEvent(new TimelineEvent(TimelineEvent.NEXT_CLICK));
               break;
            case "prev":
               dispatchEvent(new TimelineEvent(TimelineEvent.PREV_CLICK));
         }
      }
      
      public function changeProperty(param1:int, param2:String, param3:* = null) : void
      {
      }
   }
}
