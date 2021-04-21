package mx.utils
{
   import mx.core.ISWFBridgeProvider;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class SecurityUtil
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      public function SecurityUtil()
      {
         super();
      }
      
      public static function hasMutualTrustBetweenParentAndChild(param1:ISWFBridgeProvider) : Boolean
      {
         if(param1 && param1.childAllowsParent && param1.parentAllowsChild)
         {
            return true;
         }
         return false;
      }
   }
}
