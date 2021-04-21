package sandy.util
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class DistortImage
   {
       
      
      private var _container:Object;
      
      private var _yMax:Number;
      
      private var _hsLen:Number;
      
      private var _hseg:Number;
      
      public var target:Object;
      
      private var offsetRect:Rectangle;
      
      private var _xMin:Number;
      
      public var texture:BitmapData;
      
      private var _vsLen:Number;
      
      public var points:Array;
      
      private var _h:Number;
      
      private var _aMcs:Array;
      
      private var _xMax:Number;
      
      private var _tri:Array;
      
      public var smooth:Boolean;
      
      private var _w:Number;
      
      private var _vseg:Number;
      
      private var _yMin:Number;
      
      public function DistortImage()
      {
         super();
         smooth = true;
      }
      
      private function renderVector(param1:Rectangle = null) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Matrix = null;
         _loc2_ = target as DisplayObject;
         if(param1 != null)
         {
            texture = new BitmapData(param1.width,param1.height,true,0);
         }
         else
         {
            texture = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            param1 = new Rectangle(0,0,texture.width,texture.height);
         }
         _loc3_ = new Matrix();
         _loc3_.translate(param1.x * -1,param1.y * -1);
         texture.draw(_loc2_,_loc3_);
         container.transform.matrix.translate(_loc2_.transform.matrix.tx,_loc2_.transform.matrix.ty);
         _w = param1.width;
         _h = param1.height;
      }
      
      private function __render() : void
      {
         var _loc1_:Array = null;
         var _loc2_:SandyPoint = null;
         var _loc3_:SandyPoint = null;
         var _loc4_:SandyPoint = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Object = null;
         var _loc10_:Triangle = null;
         var _loc11_:Matrix = null;
         var _loc12_:Matrix = null;
         var _loc13_:int = 0;
         _loc7_ = 1 / _h;
         _loc8_ = 1 / _w;
         (_loc9_ = container).graphics.clear();
         _loc11_ = new Matrix();
         _loc12_ = new Matrix();
         _loc13_ = _tri.length;
         while(--_loc13_ > -1)
         {
            _loc2_ = (_loc10_ = _tri[_loc13_]).p0;
            _loc3_ = _loc10_.p1;
            _loc4_ = _loc10_.p2;
            _loc12_ = _loc10_.tMat;
            _loc11_.a = (_loc3_.sx - (_loc5_ = _loc2_.sx)) * _loc8_;
            _loc11_.b = (_loc3_.sy - (_loc6_ = _loc2_.sy)) * _loc8_;
            _loc11_.c = (_loc4_.sx - _loc5_) * _loc7_;
            _loc11_.d = (_loc4_.sy - _loc6_) * _loc7_;
            _loc11_.tx = _loc5_;
            _loc11_.ty = _loc6_;
            _loc11_ = __concat(_loc11_,_loc12_);
            _loc9_.graphics.beginBitmapFill(texture,_loc11_,false,smooth);
            _loc9_.graphics.moveTo(_loc5_,_loc6_);
            _loc9_.graphics.lineTo(_loc3_.sx,_loc3_.sy);
            _loc9_.graphics.lineTo(_loc4_.sx,_loc4_.sy);
            _loc9_.graphics.endFill();
         }
      }
      
      public function get container() : Object
      {
         return _container;
      }
      
      public function set container(param1:Object) : void
      {
         if(param1 is Shape || param1 is Sprite)
         {
            _container = param1;
            return;
         }
         throw new Error("container must be flash.display.Shape or flash.display.Sprite");
      }
      
      public function initialize(param1:Number, param2:Number, param3:Rectangle = null) : void
      {
         if(target is BitmapData)
         {
            texture = target as BitmapData;
            _w = texture.width;
            _h = texture.height;
         }
         else
         {
            if(!(target is DisplayObject))
            {
               throw new Error("target must be flash.display.BitmapData or flash.display.DisplayObject");
            }
            renderVector(param3);
         }
         _vseg = Number(param1) || Number(0);
         _hseg = Number(param2) || Number(0);
         _aMcs = new Array();
         points = new Array();
         _tri = new Array();
         __init();
      }
      
      private function __init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:SandyPoint = null;
         var _loc8_:SandyPoint = null;
         var _loc9_:SandyPoint = null;
         points = new Array();
         _tri = new Array();
         _loc3_ = _w / 2;
         _loc4_ = _h / 2;
         _xMin = _yMin = 0;
         _xMax = _w;
         _yMax = _h;
         _hsLen = _w / (_hseg + 1);
         _vsLen = _h / (_vseg + 1);
         _loc1_ = 0;
         while(_loc1_ < _hseg + 2)
         {
            _loc2_ = 0;
            while(_loc2_ < _vseg + 2)
            {
               _loc5_ = _loc1_ * _hsLen;
               _loc6_ = _loc2_ * _vsLen;
               points.push(new SandyPoint(_loc5_,_loc6_,_loc5_,_loc6_));
               _loc2_++;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _vseg + 1)
         {
            _loc2_ = 0;
            while(_loc2_ < _hseg + 1)
            {
               _loc7_ = points[_loc2_ + _loc1_ * (_hseg + 2)];
               _loc8_ = points[_loc2_ + _loc1_ * (_hseg + 2) + 1];
               _loc9_ = points[_loc2_ + (_loc1_ + 1) * (_hseg + 2)];
               __addTriangle(_loc7_,_loc8_,_loc9_);
               _loc7_ = points[_loc2_ + (_loc1_ + 1) * (_vseg + 2) + 1];
               _loc8_ = points[_loc2_ + (_loc1_ + 1) * (_vseg + 2)];
               _loc9_ = points[_loc2_ + _loc1_ * (_vseg + 2) + 1];
               __addTriangle(_loc7_,_loc8_,_loc9_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function render() : void
      {
         __render();
      }
      
      private function __addTriangle(param1:SandyPoint, param2:SandyPoint, param3:SandyPoint) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Matrix = null;
         _loc10_ = new Matrix();
         _loc4_ = param1.x;
         _loc5_ = param1.y;
         _loc6_ = param2.x;
         _loc7_ = param2.y;
         _loc8_ = param3.x;
         _loc9_ = param3.y;
         _loc10_.tx = -_loc5_ * (_w / (_loc7_ - _loc5_));
         _loc10_.ty = -_loc4_ * (_h / (_loc8_ - _loc4_));
         _loc10_.a = _loc10_.d = 0;
         _loc10_.b = _h / (_loc8_ - _loc4_);
         _loc10_.c = _w / (_loc7_ - _loc5_);
         _tri.push(new Triangle(param1,param2,param3,_loc10_));
      }
      
      public function setTransform(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:SandyPoint = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         _loc9_ = _w;
         _loc10_ = _h;
         _loc11_ = param7 - param1;
         _loc12_ = param8 - param2;
         _loc13_ = param5 - param3;
         _loc14_ = param6 - param4;
         _loc15_ = points.length;
         while(--_loc15_ > -1)
         {
            _loc17_ = ((_loc16_ = points[_loc15_]).x - _xMin) / _loc9_;
            _loc18_ = (_loc16_.y - _yMin) / _loc10_;
            _loc19_ = param1 + _loc18_ * _loc11_;
            _loc20_ = param2 + _loc18_ * _loc12_;
            _loc16_.sx = _loc19_ + _loc17_ * (param3 + _loc18_ * _loc13_ - _loc19_);
            _loc16_.sy = _loc20_ + _loc17_ * (param4 + _loc18_ * _loc14_ - _loc20_);
         }
         __render();
      }
      
      private function __concat(param1:Matrix, param2:Matrix) : Matrix
      {
         var _loc3_:Matrix = null;
         _loc3_ = new Matrix();
         _loc3_.a = param1.c * param2.b;
         _loc3_.b = param1.d * param2.b;
         _loc3_.c = param1.a * param2.c;
         _loc3_.d = param1.b * param2.c;
         _loc3_.tx = param1.a * param2.tx + param1.c * param2.ty + param1.tx;
         _loc3_.ty = param1.b * param2.tx + param1.d * param2.ty + param1.ty;
         return _loc3_;
      }
   }
}
