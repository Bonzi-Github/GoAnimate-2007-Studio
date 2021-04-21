package anifire.component
{
   import flash.display.MovieClip;
   import mochi.as3.MochiAd;
   
   public class MochiAdDisplay
   {
       
      
      private var _clip:MovieClip;
      
      public function MochiAdDisplay()
      {
         super();
      }
      
      public function get movieClip() : MovieClip
      {
         if(!this._clip)
         {
            this._clip = new MovieClip();
         }
         return this._clip;
      }
      
      public function hide() : void
      {
         this._clip.stop();
         this._clip.visible = false;
      }
      
      public function showPreloader(param1:Function) : void
      {
         MochiAd.showPreGameAd({
            "clip":this._clip,
            "id":"4522499aa62b38be",
            "res":"954x629",
            "background":16777161,
            "color":16747008,
            "outline":13994812,
            "no_bg":false,
            "ad_finished":param1
         });
      }
      
      public function show(param1:Function) : void
      {
         MochiAd.showInterLevelAd({
            "clip":this._clip,
            "id":"4522499aa62b38be",
            "res":"550x354",
            "no_bg":false,
            "ad_finished":param1
         });
      }
   }
}
