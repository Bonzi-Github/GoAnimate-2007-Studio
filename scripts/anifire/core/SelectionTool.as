package anifire.core
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   
   public class SelectionTool extends UIComponent
   {
       
      
      private const BORDER_ALPHA:Number = 0.5;
      
      private var _box:Sprite;
      
      private var _scene:AnimeScene;
      
      private const BORDER_COLOR:uint = 0;
      
      private const BORDER_WIDTH:uint = 2;
      
      private var _mousePos:Point;
      
      private var _canvas:Canvas;
      
      private var _selectedAssets:Array;
      
      public function SelectionTool(param1:Canvas)
      {
         super();
         this._canvas = param1;
         this._canvas.addChild(this);
         this.width = this._canvas.width;
         this.height = this._canvas.height;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._mousePos = new Point();
         this._box = new UIComponent();
         addChild(this._box);
         this._selectedAssets = new Array();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Asset = null;
         var _loc4_:Number = NaN;
         var _loc5_:AssetGroup = null;
         this._canvas.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._canvas.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._canvas.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseUp);
         this._selectedAssets = new Array();
         this._scene = Console.getConsole().currentScene;
         if(this._scene)
         {
            _loc2_ = this._canvas.globalToContent(new Point(param1.stageX,param1.stageY));
            if(Math.abs((this._mousePos.x - _loc2_.x) * (this._mousePos.y - _loc2_.y)) > 1000)
            {
               _loc4_ = 0;
               _loc4_ = 0;
               while(_loc4_ < this._scene.characters.length)
               {
                  _loc3_ = this._scene.characters.getValueByIndex(_loc4_) as Asset;
                  if(_loc3_ && this.isCollided(this._box,_loc3_.movieObject))
                  {
                     this._selectedAssets.push(_loc3_);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < this._scene.props.length)
               {
                  _loc3_ = this._scene.props.getValueByIndex(_loc4_) as Asset;
                  if(_loc3_ && this.isCollided(this._box,_loc3_.imageObject))
                  {
                     this._selectedAssets.push(_loc3_);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < this._scene.bubbles.length)
               {
                  _loc3_ = this._scene.bubbles.getValueByIndex(_loc4_) as Asset;
                  if(_loc3_ && this.isCollided(this._box,BubbleAsset(_loc3_).bubble))
                  {
                     this._selectedAssets.push(_loc3_);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < this._scene.effects.length)
               {
                  _loc3_ = this._scene.effects.getValueByIndex(_loc4_) as Asset;
                  if(_loc3_ && _loc3_.bundle.visible && this.isCollided(this._box,EffectAsset(_loc3_).effect))
                  {
                     this._selectedAssets.push(_loc3_);
                  }
                  _loc4_++;
               }
               if(_loc5_ = this._scene.assetGroup)
               {
                  _loc5_.clearGroup();
                  for each(_loc3_ in this._selectedAssets)
                  {
                     if(_loc5_.isGroupable(_loc3_))
                     {
                        _loc5_.addAsset(_loc3_);
                     }
                  }
                  _loc5_.showControl();
               }
            }
            this._scene.setFocus();
         }
         this._box.graphics.clear();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(Console.getConsole().isTutorialOn)
         {
            return;
         }
         this._canvas.addChild(this);
         this._mousePos = this._canvas.globalToContent(new Point(param1.stageX,param1.stageY));
         this._canvas.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._canvas.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this._canvas.addEventListener(MouseEvent.ROLL_OUT,this.onMouseUp);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = this._canvas.globalToContent(new Point(param1.stageX,param1.stageY));
         var _loc3_:Number = Math.min(_loc2_.x,this._mousePos.x);
         var _loc4_:Number = Math.min(_loc2_.y,this._mousePos.y);
         var _loc5_:Number = Math.abs(_loc2_.x - this._mousePos.x);
         var _loc6_:Number = Math.abs(_loc2_.y - this._mousePos.y);
         this._box.graphics.clear();
         this._box.graphics.lineStyle(this.BORDER_WIDTH,this.BORDER_COLOR,this.BORDER_ALPHA);
         this._box.graphics.drawRect(_loc3_,_loc4_,_loc5_,_loc6_);
         this._box.graphics.endFill();
         param1.updateAfterEvent();
      }
      
      public function deactivate() : void
      {
         this._canvas.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      public function activate() : void
      {
         if(Console.getConsole().currentScene)
         {
            this._canvas.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         else
         {
            trace("selection tool can\'t be activated!");
         }
      }
      
      public function get selectedAssets() : Array
      {
         return this._selectedAssets;
      }
      
      private function isCollided(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         if(param1 && param2)
         {
            return param1.hitTestObject(param2);
         }
         return false;
      }
   }
}
