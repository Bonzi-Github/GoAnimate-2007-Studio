package anifire.bubble
{
   public class HeartBubble extends ImageBubble
   {
       
      
      private var heartSymbol:Class;
      
      public function HeartBubble()
      {
         this.heartSymbol = HeartBubble_heartSymbol;
         super();
         height = 160;
         taily = 210;
         type = BubbleMgr.HEART;
         redraw();
      }
      
      override protected function drawLabel() : void
      {
         leftMargin = 25;
         rightMargin = 25;
         super.drawLabel();
      }
      
      override protected function drawTail() : void
      {
         tailImage = this.heartSymbol;
         super.drawTail();
      }
      
      override protected function drawBody() : void
      {
         image = this.heartSymbol;
         super.drawBody();
      }
   }
}
