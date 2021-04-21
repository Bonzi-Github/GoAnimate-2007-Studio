package mx.core
{
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   use namespace mx_internal;
   
   public class TextFieldFactory implements ITextFieldFactory
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
      
      private static var instance:ITextFieldFactory;
       
      
      private var textFields:Dictionary;
      
      public function TextFieldFactory()
      {
         textFields = new Dictionary(true);
         super();
      }
      
      public static function getInstance() : ITextFieldFactory
      {
         if(!instance)
         {
            instance = new TextFieldFactory();
         }
         return instance;
      }
      
      public function createTextField(param1:IFlexModuleFactory) : TextField
      {
         var _loc4_:* = null;
         var _loc2_:TextField = null;
         var _loc3_:Dictionary = textFields[param1];
         if(_loc3_)
         {
            var _loc5_:int = 0;
            var _loc6_:* = _loc3_;
            for(_loc4_ in _loc6_)
            {
               _loc2_ = TextField(_loc4_);
            }
         }
         if(!_loc2_)
         {
            if(param1)
            {
               _loc2_ = TextField(param1.create("flash.text.TextField"));
            }
            else
            {
               _loc2_ = new TextField();
            }
            if(!_loc3_)
            {
               _loc3_ = new Dictionary(true);
            }
            _loc3_[_loc2_] = 1;
            textFields[param1] = _loc3_;
         }
         return _loc2_;
      }
   }
}
