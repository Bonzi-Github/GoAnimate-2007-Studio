package anifire.component
{
   import mx.controls.LinkButton;
   import mx.skins.ProgrammaticSkin;
   import mx.styles.CSSStyleDeclaration;
   
   public class IconTextButton extends LinkButton
   {
       
      
      public function IconTextButton()
      {
         super();
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.upSkin = ProgrammaticSkin;
            this.downSkin = ProgrammaticSkin;
            this.overSkin = ProgrammaticSkin;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
   }
}
