package anifire.component
{
   import flash.text.TextFieldAutoSize;
   import mx.controls.Button;
   import mx.core.UITextField;
   
   public class MultilineButton extends Button
   {
       
      
      public function MultilineButton()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         if(!textField)
         {
            textField = new UITextField();
            textField.styleName = this;
            addChild(UITextField(textField));
         }
         super.createChildren();
         UITextField(textField).multiline = true;
         UITextField(textField).wordWrap = true;
         UITextField(textField).autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
   }
}
