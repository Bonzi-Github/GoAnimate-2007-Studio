package anifire.component
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilPlain;
   import anifire.util.UtilSite;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class GoUpgradeBanner extends Canvas
   {
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _3141bg:Image;
      
      public function GoUpgradeBanner()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Image,
                  "id":"bg",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "buttonMode":true
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get bg() : Image
      {
         return this._3141bg;
      }
      
      public function set bg(param1:Image) : void
      {
         var _loc2_:Object = this._3141bg;
         if(_loc2_ !== param1)
         {
            this._3141bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bg",_loc2_,param1));
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:* = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         _loc1_ = _loc1_ + "static/go/img/ad/upgrade_";
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc1_ = _loc1_ + (UtilPlain.randomNumberRange(1,4) + ".jpg");
         }
         else
         {
            _loc1_ = _loc1_ + (UtilPlain.randomNumberRange(1,5) + ".jpg");
         }
         this.bg.source = _loc1_;
      }
   }
}
