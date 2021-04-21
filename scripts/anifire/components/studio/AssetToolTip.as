package anifire.components.studio
{
   import anifire.util.UtilDict;
   import mx.containers.Box;
   import mx.controls.Label;
   
   public class AssetToolTip extends Box
   {
      
      private static var _instance:AssetToolTip;
       
      
      private var _assetToolTipLabel:Label;
      
      public function AssetToolTip(param1:SingletonEnforcer)
      {
         super();
         this.name = "AssetToolTip";
         this.height = 22;
         this.width = 150;
         this.setStyle("borderStyle","solid");
         this.setStyle("cornerRadius",8);
         this.setStyle("backgroundColor","white");
         this.setStyle("horizontalAlign","center");
         this.setStyle("verticalAlign","middle");
         this.horizontalScrollPolicy = "none";
         this.verticalScrollPolicy = "none";
         this._assetToolTipLabel = new Label();
         this.addChild(this._assetToolTipLabel);
      }
      
      public static function getInstance() : AssetToolTip
      {
         if(!_instance)
         {
            _instance = new AssetToolTip(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function setToolTipContent(param1:Number, param2:Number, param3:Number) : void
      {
         this.scaleX = this.scaleY = param3;
         this._assetToolTipLabel.text = UtilDict.toDisplay("go","assettool_width") + ": " + int(param1) + ", " + UtilDict.toDisplay("go","assettool_height") + ": " + int(param2);
      }
   }
}

class SingletonEnforcer
{
    
   
   function SingletonEnforcer()
   {
      super();
   }
}
