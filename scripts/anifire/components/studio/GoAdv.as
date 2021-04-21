package anifire.components.studio
{
   import anifire.component.GoActionBanner;
   import anifire.component.GoUpgradeBanner;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.managers.FeatureManager;
   import anifire.util.UtilNavigate;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class GoAdv extends Canvas
   {
       
      
      private var _657850472upgradeBanner:GoUpgradeBanner;
      
      private var _1003743490actionBanner:GoActionBanner;
      
      private var _459389001vsBanner:ViewStack;
      
      private var _character:Character;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function GoAdv()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vsBanner",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":GoActionBanner,
                           "id":"actionBanner",
                           "events":{"click":"__actionBanner_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":GoUpgradeBanner,
                           "id":"upgradeBanner",
                           "events":{"click":"__upgradeBanner_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.visible = false;
         this.includeInLayout = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get actionBanner() : GoActionBanner
      {
         return this._1003743490actionBanner;
      }
      
      public function set actionBanner(param1:GoActionBanner) : void
      {
         var _loc2_:Object = this._1003743490actionBanner;
         if(_loc2_ !== param1)
         {
            this._1003743490actionBanner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionBanner",_loc2_,param1));
         }
      }
      
      private function onActionBannerClick() : void
      {
         Console.getConsole().showActionShopWindow(this._character.thumb.id,this._character.thumb);
      }
      
      [Bindable(event="propertyChange")]
      public function get vsBanner() : ViewStack
      {
         return this._459389001vsBanner;
      }
      
      public function __upgradeBanner_click(param1:MouseEvent) : void
      {
         this.onUpgradeBannerClick();
      }
      
      public function set vsBanner(param1:ViewStack) : void
      {
         var _loc2_:Object = this._459389001vsBanner;
         if(_loc2_ !== param1)
         {
            this._459389001vsBanner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vsBanner",_loc2_,param1));
         }
      }
      
      public function set upgradeBanner(param1:GoUpgradeBanner) : void
      {
         var _loc2_:Object = this._657850472upgradeBanner;
         if(_loc2_ !== param1)
         {
            this._657850472upgradeBanner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"upgradeBanner",_loc2_,param1));
         }
      }
      
      public function refresh(param1:Character) : void
      {
         this._character = param1;
         this.includeInLayout = this.visible = false;
         if(!Console.getConsole().isTutorialOn)
         {
            if(Math.round(Math.random()) == 1)
            {
               if(this.shouldShowActionBanner)
               {
                  this.actionBanner.refresh(this._character.thumb.id);
                  this.vsBanner.selectedChild = this.actionBanner;
                  this.includeInLayout = this.visible = true;
               }
               else if(this.shouldShowUpgradeBanner)
               {
                  this.upgradeBanner.refresh();
                  this.vsBanner.selectedChild = this.upgradeBanner;
                  this.includeInLayout = this.visible = true;
               }
            }
            else if(this.shouldShowUpgradeBanner)
            {
               this.upgradeBanner.refresh();
               this.vsBanner.selectedChild = this.upgradeBanner;
               this.includeInLayout = this.visible = true;
            }
            else if(this.shouldShowActionBanner)
            {
               this.actionBanner.refresh(this._character.thumb.id);
               this.vsBanner.selectedChild = this.actionBanner;
               this.includeInLayout = this.visible = true;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get upgradeBanner() : GoUpgradeBanner
      {
         return this._657850472upgradeBanner;
      }
      
      public function __actionBanner_click(param1:MouseEvent) : void
      {
         this.onActionBannerClick();
      }
      
      private function get shouldShowActionBanner() : Boolean
      {
         if(this._character == null)
         {
            return false;
         }
         if(FeatureManager.shouldActionPackBeShown && CharThumb(this._character.thumb).ccThemeId == "cc2" && !Console.getConsole().isTutorialOn)
         {
            return true;
         }
         return false;
      }
      
      private function get shouldShowUpgradeBanner() : Boolean
      {
         return FeatureManager.shouldUpgradeBannerBeShown;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onUpgradeBannerClick() : void
      {
         UtilNavigate.toUpgradePage();
      }
   }
}
