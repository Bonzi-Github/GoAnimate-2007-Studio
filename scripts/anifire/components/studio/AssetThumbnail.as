package anifire.components.studio
{
   import anifire.core.Asset;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.EffectAsset;
   import anifire.core.Prop;
   import anifire.events.AssetEvent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class AssetThumbnail extends Canvas
   {
       
      
      private const BG_COLOR:uint = 14540253;
      
      private var _625717802photoCanvas:Canvas;
      
      private var _1482076687_asset:Asset;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function AssetThumbnail()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"photoCanvas",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":80,
                        "height":80
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
      }
      
      private function onAssetChange(param1:AssetEvent) : void
      {
         this.updateThumbnail();
      }
      
      public function set target(param1:Object) : void
      {
         if(this._asset)
         {
            this._asset.removeEventListener(AssetEvent.COLOR_CHANGE,this.onAssetChange);
         }
         if(param1)
         {
            if(param1 is Asset)
            {
               this._asset = Asset(param1);
               this._asset.addEventListener(AssetEvent.COLOR_CHANGE,this.onAssetChange);
            }
            else
            {
               this._asset = null;
            }
         }
         else
         {
            this._asset = null;
         }
         this.updateThumbnail();
      }
      
      private function updateThumbnail() : void
      {
         var _loc1_:Image = null;
         var _loc2_:BitmapData = null;
         var _loc3_:Matrix = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Character = null;
         var _loc8_:Background = null;
         var _loc9_:Prop = null;
         var _loc10_:BubbleAsset = null;
         var _loc11_:EffectAsset = null;
         this.photoCanvas.removeAllChildren();
         this.photoCanvas.graphics.clear();
         if(this._asset)
         {
            this.photoCanvas.scrollRect = new Rectangle(0,0,this.photoCanvas.width,this.photoCanvas.height);
            _loc1_ = new Image();
            _loc2_ = null;
            _loc3_ = new Matrix();
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 1;
            if(this._asset is Character)
            {
               _loc7_ = Character(this._asset);
               _loc2_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height,false,this.BG_COLOR);
               _loc6_ = 0.9 * Math.min(this.photoCanvas.width / _loc7_.imageObject.width,this.photoCanvas.height / _loc7_.imageObject.height);
               _loc4_ = this.photoCanvas.width / 2;
               _loc5_ = this.photoCanvas.height / 2;
               _loc3_.scale(_loc6_,_loc6_);
               _loc3_.translate(_loc4_,_loc5_);
               _loc2_.draw(_loc7_.imageObject,_loc3_);
            }
            else if(this._asset is Background)
            {
               _loc8_ = Background(this._asset);
               _loc2_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height,false,this.BG_COLOR);
               _loc6_ = 0.9 * Math.min(this.photoCanvas.width / _loc8_.imageObject.width,this.photoCanvas.height / _loc8_.imageObject.height);
               _loc4_ = (this.photoCanvas.width - _loc6_ * _loc8_.imageObject.width) / 2;
               _loc5_ = (this.photoCanvas.height - _loc6_ * _loc8_.imageObject.height) / 2;
               _loc3_.scale(_loc6_,_loc6_);
               _loc3_.translate(_loc4_,_loc5_);
               _loc2_.draw(_loc8_.imageObject,_loc3_);
            }
            else if(this._asset is Prop)
            {
               _loc9_ = Prop(this._asset);
               _loc2_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height,false,this.BG_COLOR);
               _loc6_ = 0.9 * Math.min(this.photoCanvas.width / _loc9_.imageObject.width,this.photoCanvas.height / _loc9_.imageObject.height);
               _loc4_ = this.photoCanvas.width / 2;
               _loc5_ = this.photoCanvas.height / 2;
               _loc3_.scale(_loc6_,_loc6_);
               _loc3_.translate(_loc4_,_loc5_);
               _loc2_.draw(_loc9_.imageObject,_loc3_);
            }
            else if(this._asset is BubbleAsset)
            {
               _loc10_ = BubbleAsset(this._asset);
               _loc2_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height,false,this.BG_COLOR);
               _loc6_ = 0.9 * Math.min(this.photoCanvas.width / _loc10_.bubble.width,this.photoCanvas.height / _loc10_.bubble.height);
               _loc4_ = (this.photoCanvas.width - _loc6_ * _loc10_.bubble.width) / 2 - _loc6_ * _loc10_.bubble.x;
               _loc5_ = (this.photoCanvas.height - _loc6_ * _loc10_.bubble.height) / 2 - _loc6_ * _loc10_.bubble.y;
               _loc3_.scale(_loc6_,_loc6_);
               _loc3_.translate(_loc4_,_loc5_);
               _loc2_.draw(_loc10_.bubble,_loc3_);
            }
            else if(this._asset is EffectAsset)
            {
               _loc11_ = EffectAsset(this._asset);
               _loc2_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height,false,this.BG_COLOR);
               _loc6_ = 0.9 * Math.min(this.photoCanvas.width / _loc11_.thumb.imageObject.width,this.photoCanvas.height / _loc11_.thumb.imageObject.height);
               _loc4_ = (this.photoCanvas.width - _loc6_ * _loc11_.thumb.imageObject.width) / 2;
               _loc5_ = (this.photoCanvas.height - _loc6_ * _loc11_.thumb.imageObject.height) / 2;
               _loc3_.scale(_loc6_,_loc6_);
               _loc3_.translate(_loc4_,_loc5_);
               _loc2_.draw(_loc11_.thumb.imageObject,_loc3_);
            }
            if(_loc2_)
            {
               this.photoCanvas.graphics.clear();
               this.photoCanvas.graphics.beginBitmapFill(_loc2_,new Matrix(),false,true);
               this.photoCanvas.graphics.drawRoundRect(0,0,this.photoCanvas.width,this.photoCanvas.height,10,10);
               this.photoCanvas.graphics.endFill();
            }
            this.photoCanvas.addChild(_loc1_);
         }
      }
      
      private function set _asset(param1:Asset) : void
      {
         var _loc2_:Object = this._1482076687_asset;
         if(_loc2_ !== param1)
         {
            this._1482076687_asset = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_asset",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get photoCanvas() : Canvas
      {
         return this._625717802photoCanvas;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      private function get _asset() : Asset
      {
         return this._1482076687_asset;
      }
      
      public function set photoCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._625717802photoCanvas;
         if(_loc2_ !== param1)
         {
            this._625717802photoCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"photoCanvas",_loc2_,param1));
         }
      }
   }
}
