package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.command.ICommand;
   import anifire.command.MoveAssetGroupCommand;
   import anifire.command.RemoveAssetsCommand;
   import anifire.command.ResizeAssetsCommand;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.control.FixedControl;
   import anifire.control.MotionControl;
   import anifire.effect.SuperEffect;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IResize;
   import anifire.interfaces.ISlidable;
   import anifire.iterators.ArrayIterator;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.UtilPlain;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   
   public class AssetGroup extends UIComponent implements ISlidable, IResize, IDraggable, ICollection
   {
       
      
      private var _prevCenter:Point;
      
      private var _oldImageCenter:Point;
      
      private var _control:Control;
      
      private var _assets:Array;
      
      private var _oldControlPosition:Point;
      
      private var _motionData:MotionData;
      
      private const MULTI_SELECT_BORDER_COLOR:uint = 16492449;
      
      private var _isDragging:Boolean = false;
      
      private var _motionControl:MotionControl;
      
      private var _oldMousePosition:Point;
      
      private var _canvas:Canvas;
      
      private var _moveCommand:ICommand;
      
      public function AssetGroup(param1:Canvas)
      {
         this._assets = new Array();
         super();
         this._canvas = param1;
         this._canvas.addChild(this);
         this._assets = new Array();
         this._motionControl = new MotionControl();
         this.addChild(this._motionControl);
      }
      
      public function set motionData(param1:MotionData) : void
      {
      }
      
      private function showButtonBar() : void
      {
         Console.getConsole().mainStage.showAssetButtonBar();
      }
      
      public function startSlideMotion() : void
      {
         if(this.slideEnabled && !this.isSliding)
         {
            this._motionData = new MotionData();
            this._motionData.startPoint = this.imageCenter;
            this._motionData.endPoint = new Point(this.imageCenter.x + 100,this.imageCenter.y);
            this._motionControl.motionData = this._motionData;
            this._motionControl.motionImage = this.bitmap;
            this._motionControl.visible = true;
         }
      }
      
      public function deleteGroup() : void
      {
         var _loc1_:ICommand = null;
         var _loc2_:Asset = null;
         if(this._assets)
         {
            if(this._assets.length > 0)
            {
               _loc1_ = new RemoveAssetsCommand();
               _loc1_.execute();
               for each(_loc2_ in this._assets)
               {
                  if(_loc2_)
                  {
                     _loc2_.deleteAsset(false);
                     _loc2_ = null;
                  }
               }
            }
         }
         this._assets = new Array();
         this.hideControl();
      }
      
      public function get selectedAsset() : Asset
      {
         if(this._assets.length == 1)
         {
            return this._assets[0];
         }
         return null;
      }
      
      private function onAssetMouseDown(param1:MouseEvent) : void
      {
      }
      
      public function stopDraggingGroup() : void
      {
         var _loc1_:Asset = null;
         if(this._isDragging)
         {
            this._isDragging = false;
            if(!this._oldMousePosition.equals(new Point(this._canvas.mouseX,this._canvas.mouseY)))
            {
               this._moveCommand.execute();
            }
            this._canvas.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
            this._canvas.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
            for each(_loc1_ in this._assets)
            {
               if(!(_loc1_ is BubbleAsset))
               {
                  if(_loc1_ is EffectAsset)
                  {
                     EffectAsset(_loc1_).checkEffectAssetSize();
                  }
               }
            }
            this.showControl();
         }
      }
      
      public function updateOriginalAssetPosition() : void
      {
         var _loc1_:Asset = null;
         if(this._assets)
         {
            for each(_loc1_ in this._assets)
            {
               _loc1_.updateOriginalAssetPosition();
            }
         }
         if(this._control)
         {
            this._oldControlPosition = new Point(this._control.x,this._control.y);
         }
         this._oldImageCenter = this.imageCenter;
      }
      
      public function showControl() : void
      {
         var _loc1_:Rectangle = null;
         if(this._assets.length == 1)
         {
            Console.getConsole().showOverTray();
         }
         else
         {
            Console.getConsole().showOverTray(false);
         }
         if(this._assets.length < 2)
         {
            if(this._control)
            {
               this._control.visible = false;
            }
            this.hideButtonBar();
            if(this._assets.length == 1)
            {
               Asset(this._assets[0]).showControl();
               Asset(this._assets[0]).showButtonBar();
            }
            return;
         }
         if(this._control)
         {
            this._control.visible = false;
         }
         _loc1_ = this.getBounds(this._canvas);
         this._control = this.initControl();
         if(this._control)
         {
            this._control.visible = true;
            this._control.setPos(_loc1_.x,_loc1_.y);
            this._control.setSize(_loc1_.width,_loc1_.height);
            this._control.setOrigin(_loc1_.width / 2,_loc1_.height / 2);
            if(this._control is FixedControl)
            {
               FixedControl(this._control).aspectRatio = _loc1_.width / _loc1_.height;
            }
            addChild(this._control);
            this._control.showControl(Console.getConsole().stageScale);
         }
         this.showButtonBar();
         if(this.isSliding)
         {
            this._motionControl.visible = true;
         }
         this._canvas.addChild(this);
      }
      
      public function removeSlideMotion() : void
      {
         var _loc1_:Asset = null;
         this._motionData = null;
         this._motionControl.visible = false;
         for each(_loc1_ in this._assets)
         {
            if(_loc1_ is ISlidable)
            {
               ISlidable(_loc1_).removeSlideMotion();
            }
         }
      }
      
      public function get isSliding() : Boolean
      {
         return this._motionData != null;
      }
      
      public function firstAsset() : Asset
      {
         if(this._assets && this._assets.length > 0)
         {
            return this._assets[0];
         }
         return null;
      }
      
      private function get imageCenter() : Point
      {
         var _loc1_:Rectangle = this.getBounds(this._canvas);
         if(_loc1_)
         {
            return new Point(_loc1_.x + _loc1_.width / 2,_loc1_.y + _loc1_.height / 2);
         }
         return null;
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Asset = null;
         if(this._assets && param1)
         {
            _loc2_ = new Rectangle();
            for each(_loc3_ in this._assets)
            {
               _loc2_ = _loc2_.union(_loc3_.getBounds(param1));
            }
            return _loc2_;
         }
         return null;
      }
      
      public function moveGroup(param1:Number, param2:Number) : void
      {
         var _loc3_:Asset = null;
         this._moveCommand = new MoveAssetGroupCommand();
         this._moveCommand.execute();
         this.updateOriginalAssetPosition();
         this.hideControl();
         this.movingGroup(param1,param2);
         for each(_loc3_ in this._assets)
         {
            if(_loc3_ is EffectAsset)
            {
               EffectAsset(_loc3_).checkEffectAssetSize();
            }
         }
      }
      
      private function commitMotionData() : void
      {
         var _loc1_:Asset = null;
         if(this._motionData)
         {
            for each(_loc1_ in this._assets)
            {
               if(_loc1_ is ISlidable)
               {
                  ISlidable(_loc1_).motionData = this._motionData;
               }
            }
            this._motionData = null;
         }
      }
      
      public function clearGroup() : void
      {
         var _loc1_:Asset = null;
         this.commitMotionData();
         this.hideControl();
         for each(_loc1_ in this._assets)
         {
            UtilPlain.playFamily(_loc1_.movieObject);
         }
         this._assets = new Array();
      }
      
      private function initControl() : Control
      {
         var _loc5_:Asset = null;
         var _loc1_:Boolean = false;
         var _loc2_:String = ControlMgr.NORMAL;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         for each(_loc5_ in this._assets)
         {
            if(_loc5_ is EffectAsset)
            {
               _loc3_ = true;
               break;
            }
            if(_loc5_ is BubbleAsset)
            {
               _loc4_ = true;
            }
         }
         if(_loc3_)
         {
            _loc2_ = ControlMgr.FIXED;
         }
         else if(!_loc4_)
         {
         }
         var _loc6_:Control;
         (_loc6_ = ControlMgr.getControl(this._canvas,_loc2_)).target = this;
         _loc6_.asset = this._canvas;
         _loc6_.setLineColor(this.MULTI_SELECT_BORDER_COLOR);
         _loc6_.rotatable = false;
         _loc6_.buttonMode = true;
         return _loc6_;
      }
      
      public function startDraggingGroup() : void
      {
         if(!(this.selectedAsset is Background))
         {
            this._isDragging = true;
            this._moveCommand = new MoveAssetGroupCommand();
            this._oldMousePosition = new Point(this._canvas.mouseX,this._canvas.mouseY);
            this.updateOriginalAssetPosition();
            this.hideControl();
            this._canvas.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
            this._canvas.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         }
      }
      
      public function get bitmap() : Bitmap
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Point = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Matrix = null;
         var _loc5_:Asset = null;
         var _loc6_:Bitmap = null;
         if(this._assets.length > 0)
         {
            _loc1_ = this.getBounds(this._canvas);
            _loc2_ = this.imageCenter;
            _loc3_ = new BitmapData(_loc1_.width,_loc1_.height,true,16777215);
            (_loc4_ = new Matrix()).scale(1,1);
            for each(_loc5_ in this._assets)
            {
               (_loc4_ = new Matrix()).scale(_loc5_.scaleX,_loc5_.scaleY);
               _loc4_.translate(_loc5_.x - _loc1_.x,_loc5_.y - _loc1_.y);
               _loc3_.draw(_loc5_.displayElement,_loc4_);
            }
            (_loc6_ = new Bitmap(_loc3_)).alpha = 0.5;
            return _loc6_;
         }
         return null;
      }
      
      public function hideControl() : void
      {
         if(this._control)
         {
            this._control.visible = false;
         }
         if(this._assets.length == 1)
         {
            Asset(this._assets[0]).hideControl();
         }
         this.hideButtonBar();
         this._motionControl.visible = false;
      }
      
      public function startResize() : void
      {
         var _loc3_:Asset = null;
         var _loc1_:ICommand = new ResizeAssetsCommand();
         _loc1_.execute();
         this.hideButtonBar();
         var _loc2_:Object = this._control.getStuff(0,0);
         for each(_loc3_ in this._assets)
         {
            _loc3_.updateOriginalAssetScale();
            _loc3_.updateOriginalAssetPosition();
            if(_loc3_ is BubbleAsset)
            {
               BubbleAsset(_loc3_).updateOriginalBubbleSize();
               BubbleAsset(_loc3_).updateOriginalTailPosition();
            }
            else if(_loc3_ is EffectAsset)
            {
               EffectAsset(_loc3_).updateOriginalEffectSize();
            }
         }
         this._prevCenter = new Point(this._control.x + this._control.assetWidth / 2,this._control.y + this._control.assetHeight / 2);
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.stopDraggingGroup();
      }
      
      public function isGroupable(param1:Asset) : Boolean
      {
         if(param1 is ProgramEffectAsset && ProgramEffectAsset(param1).getExactType() == "zoom")
         {
            return true;
         }
         if(param1)
         {
            return param1 is Character || param1 is Prop || param1 is BubbleAsset;
         }
         return false;
      }
      
      public function get slideEnabled() : Boolean
      {
         var _loc1_:Asset = null;
         for each(_loc1_ in this._assets)
         {
            if(!(_loc1_ is ISlidable && ISlidable(_loc1_).slideEnabled))
            {
               return false;
            }
         }
         return true;
      }
      
      public function removeAsset(param1:Asset) : Boolean
      {
         if(param1 && this.isInGroup(param1))
         {
            if(this.selectedAsset)
            {
               this.selectedAsset.hideControl();
            }
            this._assets.splice(this._assets.indexOf(param1),1);
            UtilPlain.playFamily(param1.movieObject);
            return true;
         }
         return false;
      }
      
      public function addAsset(param1:Asset) : Boolean
      {
         var _loc2_:Array = null;
         if(param1)
         {
            if(!this.isGroupable(param1))
            {
               this.clearGroup();
            }
            if(this.selectedAsset && !this.isGroupable(this.selectedAsset))
            {
               this.clearGroup();
            }
            if(!this.isInGroup(param1))
            {
               if(this.selectedAsset)
               {
                  this.selectedAsset.hideControl();
               }
               if(this._assets.length > 0 && param1.scene.canvas.getChildIndex(param1.bundle) < this._assets[0].scene.canvas.getChildIndex(this._assets[0].bundle))
               {
                  _loc2_ = new Array();
                  _loc2_.push(param1);
                  this._assets = _loc2_.concat(this._assets);
               }
               else
               {
                  this._assets.push(param1);
               }
               UtilPlain.gotoAndStopFamilyAt1(param1.movieObject);
               if(this.selectedAsset)
               {
                  if(Console.getConsole().isTutorialOn && param1 is Character)
                  {
                     Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_SELECTED,param1));
                  }
               }
               return true;
            }
         }
         return false;
      }
      
      private function movingGroup(param1:Number, param2:Number) : void
      {
         var _loc3_:Asset = null;
         if(this._assets)
         {
            for each(_loc3_ in this._assets)
            {
               _loc3_.x = _loc3_.getOriginalAssetPosition().x + param1;
               _loc3_.y = _loc3_.getOriginalAssetPosition().y + param2;
            }
         }
         if(this._control)
         {
            this._control.x = this._oldControlPosition.x + param1;
            this._control.y = this._oldControlPosition.y + param2;
         }
         if(this._motionData && this._oldImageCenter)
         {
            this._motionData.startPoint = new Point(this._oldImageCenter.x + param1,this._oldImageCenter.y + param2);
         }
      }
      
      private function hideButtonBar() : void
      {
         Console.getConsole().mainStage.hideAssetButtonBar();
      }
      
      public function startDragging() : void
      {
         this.startDraggingGroup();
      }
      
      public function get length() : uint
      {
         if(this._assets)
         {
            return this._assets.length;
         }
         return 0;
      }
      
      public function isInGroup(param1:Asset) : Boolean
      {
         if(this._assets && param1)
         {
            return this._assets.indexOf(param1) != -1;
         }
         return false;
      }
      
      public function endResize() : void
      {
         var _loc1_:Asset = null;
         for each(_loc1_ in this._assets)
         {
            if(!(_loc1_ is BubbleAsset))
            {
               if(_loc1_ is EffectAsset)
               {
                  EffectAsset(_loc1_).checkEffectAssetSize();
               }
               else
               {
                  _loc1_.scaleX = _loc1_.displayElement.scaleX;
                  _loc1_.scaleY = _loc1_.displayElement.scaleY;
               }
            }
            _loc1_.addControl();
         }
         this.showControl();
      }
      
      public function resizing(param1:Control) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Asset = null;
         var _loc6_:Bubble = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:SuperEffect = null;
         var _loc2_:Object = this._control.getStuff(0,0);
         for each(_loc5_ in this._assets)
         {
            if(_loc5_ is BubbleAsset)
            {
               _loc6_ = BubbleAsset(_loc5_).bubble;
               _loc3_ = BubbleAsset(_loc5_).getOriginalBubbleSize().x;
               _loc4_ = BubbleAsset(_loc5_).getOriginalBubbleSize().y;
               _loc7_ = BubbleAsset(_loc5_).getOriginalTailPosition().x;
               _loc8_ = BubbleAsset(_loc5_).getOriginalTailPosition().y;
               _loc6_.setSize(_loc3_ * _loc2_.scaleX,_loc4_ * _loc2_.scaleY);
               _loc6_.setTail(_loc7_ * _loc2_.scaleX,_loc8_ * _loc2_.scaleY);
            }
            else if(_loc5_ is EffectAsset)
            {
               _loc9_ = EffectAsset(_loc5_).effect;
               _loc3_ = EffectAsset(_loc5_).getOriginalEffectSize().x;
               _loc4_ = EffectAsset(_loc5_).getOriginalEffectSize().y;
               _loc9_.setSize(_loc3_ * _loc2_.scaleX,_loc4_ * _loc2_.scaleY);
            }
            else
            {
               _loc5_.displayElement.scaleX = _loc2_.scaleX * _loc5_.getOriginalAssetScale().x;
               _loc5_.displayElement.scaleY = _loc2_.scaleY * _loc5_.getOriginalAssetScale().y;
            }
            _loc5_.bundle.x = (_loc5_.getOriginalAssetPosition().x - this._prevCenter.x) * _loc2_.scaleX + this._prevCenter.x;
            _loc5_.bundle.y = (_loc5_.getOriginalAssetPosition().y - this._prevCenter.y) * _loc2_.scaleY + this._prevCenter.y;
         }
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._assets);
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._isDragging)
         {
            _loc2_ = this._canvas.mouseX - this._oldMousePosition.x;
            _loc3_ = this._canvas.mouseY - this._oldMousePosition.y;
            this.movingGroup(_loc2_,_loc3_);
            param1.updateAfterEvent();
         }
      }
   }
}
