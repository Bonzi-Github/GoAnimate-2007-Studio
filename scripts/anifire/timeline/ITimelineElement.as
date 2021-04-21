package anifire.timeline
{
   public interface ITimelineElement
   {
       
      
      function get width() : Number;
      
      function get height() : Number;
      
      function setTimelineReferer(param1:Timeline) : void;
      
      function set width(param1:Number) : void;
      
      function set height(param1:Number) : void;
      
      function set focus(param1:Boolean) : void;
      
      function set y(param1:Number) : void;
      
      function set x(param1:Number) : void;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function get focus() : Boolean;
   }
}
