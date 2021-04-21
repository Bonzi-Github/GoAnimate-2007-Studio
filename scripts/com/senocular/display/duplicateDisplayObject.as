package com.senocular.display
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   
   public function duplicateDisplayObject(param1:DisplayObject, param2:Boolean = false) : DisplayObject
   {
      var _loc5_:Rectangle = null;
      var _loc3_:Class = Object(param1).constructor;
      var _loc4_:DisplayObject;
      (_loc4_ = new _loc3_() as DisplayObject).transform = param1.transform;
      _loc4_.filters = param1.filters;
      _loc4_.cacheAsBitmap = param1.cacheAsBitmap;
      _loc4_.opaqueBackground = param1.opaqueBackground;
      if(param1.scale9Grid)
      {
         _loc5_ = param1.scale9Grid;
         if(Capabilities.version.split(" ")[1] == "9,0,16,0")
         {
            _loc5_.x = _loc5_.x / 20;
            _loc5_.y = _loc5_.y / 20;
            _loc5_.width = _loc5_.width / 20;
            _loc5_.height = _loc5_.height / 20;
         }
         _loc4_.scale9Grid = _loc5_;
      }
      if(param2 && param1.parent)
      {
         param1.parent.addChild(_loc4_);
      }
      return _loc4_;
   }
}
