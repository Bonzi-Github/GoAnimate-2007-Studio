package anifire.popups
{
   import anifire.util.UtilDict;
   import anifire.util.UtilNavigate;
   import flash.events.Event;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   
   public class SchoolUpgrade extends GoPopUp
   {
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SchoolUpgrade()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({"type":GoPopUp});
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___SchoolUpgrade_GoPopUp1_creationComplete);
         this.addEventListener("okClick",this.___SchoolUpgrade_GoPopUp1_okClick);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function redirectToUpgradePage() : void
      {
         UtilNavigate.toUpgradePage();
      }
      
      private function init() : void
      {
         this.text = UtilDict.toDisplay("go","Hey there, looks like you need to upgrade to GoPlus!  Want to do that now?");
         this.okText = UtilDict.toDisplay("go","Yes");
         this.cancelText = UtilDict.toDisplay("go","No");
      }
      
      public function ___SchoolUpgrade_GoPopUp1_okClick(param1:Event) : void
      {
         this.redirectToUpgradePage();
      }
      
      public function ___SchoolUpgrade_GoPopUp1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
   }
}
