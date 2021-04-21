package anifire.util
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class BitmapManager
   {
       
      
      public function BitmapManager()
      {
         super();
      }
      
      public static function resampleDisplayObject(param1:DisplayObject, param2:Number, param3:Boolean = true) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,16711680);
         var _loc5_:Matrix = new Matrix();
         _loc4_.draw(param1,_loc5_,null,null,null,true);
         return resampleBitmapData(_loc4_,param2,param3);
      }
      
      public static function resizeBitmapData(param1:BitmapData, param2:Number, param3:Boolean = true) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(Math.round(param1.width * param2),Math.round(param1.height * param2),param3,16777215);
         var _loc5_:Matrix = new Matrix(_loc4_.width / param1.width,0,0,_loc4_.height / param1.height,0,0);
         var _loc6_:ColorTransform = new ColorTransform();
         _loc4_.draw(param1,_loc5_,_loc6_,null,null,true);
         return _loc4_;
      }
      
      public static function resampleBitmapData(param1:BitmapData, param2:Number, param3:Boolean = true) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Number = NaN;
         if(param2 >= 1)
         {
            return BitmapManager.resizeBitmapData(param1,param2,param3);
         }
         _loc4_ = param1.clone();
         _loc5_ = 1;
         do
         {
            if(param2 < 0.5 * _loc5_)
            {
               _loc4_ = BitmapManager.resizeBitmapData(_loc4_,0.5,param3);
               _loc5_ = 0.5 * _loc5_;
            }
            else
            {
               _loc4_ = BitmapManager.resizeBitmapData(_loc4_,param2 / _loc5_,param3);
               _loc5_ = param2;
            }
         }
         while(_loc5_ != param2);
         
         return _loc4_;
      }
      
      public static function reduceBitmapData(param1:BitmapData, param2:Number, param3:Boolean = true) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(Math.round(param1.width * param2),Math.round(param1.height * param2),param3,16777215);
         var _loc5_:Matrix = new Matrix(_loc4_.width / param1.width,0,0,_loc4_.height / param1.height,0,0);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
   }
}
