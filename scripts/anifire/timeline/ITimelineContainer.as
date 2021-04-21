package anifire.timeline
{
   import mx.core.IUIComponent;
   import mx.core.UIComponent;
   
   public interface ITimelineContainer extends IUIComponent
   {
       
      
      function getCurrItem() : ITimelineElement;
      
      function removeAllItems() : void;
      
      function changeProperty(param1:int, param2:String, param3:* = null) : void;
      
      function get length() : Number;
      
      function addItemAt(param1:UIComponent, param2:int) : void;
      
      function set label(param1:String) : void;
      
      function getCurrIndex() : int;
      
      function setHorizontalView(param1:Number = 0) : void;
      
      function get count() : int;
      
      function disableFocus() : void;
      
      function setTimelineReferer(param1:Timeline) : void;
      
      function addItem(param1:UIComponent) : void;
      
      function removeItem(param1:Number = -1) : Boolean;
      
      function get label() : String;
      
      function getItemAt(param1:int) : ITimelineElement;
      
      function getHorizontalView() : Number;
   }
}
