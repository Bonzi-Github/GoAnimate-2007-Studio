package anifire.control
{
   import anifire.event.ExtraDataEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class FixedControl extends Control
   {
      
      private static var _instance:FixedControl;
      
      private static var _instance2:FixedControl;
       
      
      private var _assetAspectRatio:Number = 0;
      
      public function FixedControl()
      {
         super();
      }
      
      public static function getInstance2() : FixedControl
      {
         if(!_instance2)
         {
            _instance2 = new FixedControl();
         }
         return _instance2;
      }
      
      public static function getInstance() : FixedControl
      {
         if(!_instance)
         {
            _instance = new FixedControl();
         }
         return _instance;
      }
      
      public function set aspectRatio(param1:Number) : void
      {
         this._assetAspectRatio = param1;
         this.maintanceAspectRatio();
      }
      
      private function maintanceAspectRatio() : void
      {
         assetHeight = assetWidth / this._assetAspectRatio;
      }
      
      public function get aspectRatio() : Number
      {
         return this._assetAspectRatio;
      }
      
      override protected function onControlMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = 1;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:String = currController.name;
         var _loc6_:Point = _controlPad.globalToLocal(new Point(param1.stageX,param1.stageY));
         switch(_loc5_)
         {
            case "leftTop":
               slope_new = getSlope(new Point(_loc6_.x,_loc6_.y),new Point(_rightBottomController_sp.x,_rightBottomController_sp.y));
               if(_loc6_.x < _rightBottomController_sp.x && _loc6_.y < _rightBottomController_sp.y)
               {
                  if(slope_old <= slope_new)
                  {
                     tSize = _prevW - _loc6_.x - _offset / 2;
                     if(_originX != 0)
                     {
                        _loc2_ = (tSize - _prevW + _originX) / _originX;
                     }
                     _assetWidth = _loc2_ * _prevW;
                     _assetHeight = _assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     tSize = _prevH - _loc6_.y - _offset / 2;
                     if(_originY != 0)
                     {
                        _loc2_ = (tSize - _prevH + _originY) / _originY;
                     }
                     _assetHeight = _loc2_ * _prevH;
                     _assetWidth = _assetHeight * this._assetAspectRatio;
                  }
                  checkAndKeepMinSize();
               }
               break;
            case "middleTop":
               tSize = _prevH - _loc6_.y - _offset / 2;
               if(_originY != 0)
               {
                  _loc2_ = (tSize - _prevH + _originY) / _originY;
               }
               _assetHeight = _loc2_ * _prevH;
               _assetWidth = _assetHeight * this._assetAspectRatio;
               checkAndKeepMinSize();
               break;
            case "rightTop":
               slope_new = getSlope(new Point(_loc6_.x,_loc6_.y),new Point(_leftBottomController_sp.x + _offset,_leftBottomController_sp.y));
               if(_loc6_.x > _leftBottomController_sp.x + _offset && _loc6_.y < _leftBottomController_sp.y)
               {
                  if(slope_old >= slope_new)
                  {
                     tSize = _loc6_.x - _offset / 2;
                     if(_prevW != _originX)
                     {
                        _loc2_ = (tSize - _originX) / (_prevW - _originX);
                     }
                     _assetWidth = _loc2_ * _prevW;
                     _assetHeight = _assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     tSize = _prevH - _loc6_.y - _offset / 2;
                     if(_originY != 0)
                     {
                        _loc2_ = (tSize - _prevH + _originY) / _originY;
                     }
                     _assetHeight = _loc2_ * _prevH;
                     _assetWidth = _assetHeight * this._assetAspectRatio;
                  }
                  checkAndKeepMinSize();
               }
               break;
            case "leftMiddle":
               tSize = _prevW - _loc6_.x - _offset / 2;
               if(_originX != 0)
               {
                  _loc2_ = (tSize - _prevW + _originX) / _originX;
               }
               _assetWidth = _loc2_ * _prevW;
               _assetHeight = _assetWidth / this._assetAspectRatio;
               checkAndKeepMinSize();
               break;
            case "rightMiddle":
               tSize = _loc6_.x - _offset / 2;
               if(_prevW != _originX)
               {
                  _loc2_ = (tSize - _originX) / (_prevW - _originX);
               }
               _assetWidth = _loc2_ * _prevW;
               _assetHeight = _assetWidth / this._assetAspectRatio;
               checkAndKeepMinSize();
               break;
            case "leftBottom":
               slope_new = getSlope(new Point(_loc6_.x,_loc6_.y),new Point(_rightTopController_sp.x,_rightTopController_sp.y + _offset));
               if(_loc6_.x < _rightTopController_sp.x && _loc6_.y > _rightTopController_sp.y + _offset)
               {
                  if(slope_old >= slope_new)
                  {
                     tSize = _prevW - _loc6_.x - _offset / 2;
                     if(_originX != 0)
                     {
                        _loc2_ = (tSize - _prevW + _originX) / _originX;
                     }
                     _assetWidth = _loc2_ * _prevW;
                     _assetHeight = _assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     tSize = _loc6_.y - _offset / 2;
                     if(_prevH != _originY)
                     {
                        _loc2_ = (tSize - _originY) / (_prevH - _originY);
                     }
                     _assetHeight = _loc2_ * _prevH;
                     _assetWidth = _assetHeight * this._assetAspectRatio;
                  }
                  checkAndKeepMinSize();
               }
               break;
            case "middleBottom":
               tSize = _loc6_.y - _offset / 2;
               if(_prevH != _originY)
               {
                  _loc2_ = (tSize - _originY) / (_prevH - _originY);
               }
               _assetHeight = _loc2_ * _prevH;
               _assetWidth = _assetHeight * this._assetAspectRatio;
               checkAndKeepMinSize();
               break;
            case "rightBottom":
               slope_new = getSlope(new Point(_loc6_.x,_loc6_.y),new Point(_leftTopController_sp.x + _offset,_leftTopController_sp.y + _offset));
               if(_loc6_.x > _leftTopController_sp.x + _offset && _loc6_.y > _leftTopController_sp.y + _offset)
               {
                  if(slope_old <= slope_new)
                  {
                     tSize = _loc6_.x - _offset / 2;
                     if(_prevW != _originX)
                     {
                        _loc2_ = (tSize - _originX) / (_prevW - _originX);
                     }
                     _assetWidth = _loc2_ * _prevW;
                     _assetHeight = _assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     tSize = _loc6_.y - _offset / 2;
                     if(_prevH != _originY)
                     {
                        _loc2_ = (tSize - _originY) / (_prevH - _originY);
                     }
                     _assetHeight = _loc2_ * _prevH;
                     _assetWidth = _assetHeight * this._assetAspectRatio;
                  }
                  checkAndKeepMinSize();
               }
         }
         _loc3_ = 0 - _originX / _prevW * (_assetWidth - _prevW);
         _loc4_ = 0 - _originY / _prevH * (_assetHeight - _prevH);
         drawOutline(_loc3_,_loc4_);
         drawControlPoint(_loc3_,_loc4_);
         _relx = currController.x - _prevX;
         _rely = currController.y - _prevY;
         dispatchEvent(new ControlEvent(ControlEvent.RESIZE));
         dispatchEvent(new ExtraDataEvent("CtrlPointMove",this,{
            "globalPt":this.localToGlobal(new Point(_currController.x,_currController.y)),
            "controlName":_loc5_,
            "assetWidth":this._assetWidth,
            "assetHeight":this._assetHeight
         }));
         param1.updateAfterEvent();
      }
   }
}
