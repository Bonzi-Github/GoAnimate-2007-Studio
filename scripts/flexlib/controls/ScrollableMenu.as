package flexlib.controls
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import mx.collections.ICollectionView;
   import mx.controls.Menu;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.menuClasses.IMenuItemRenderer;
   import mx.core.Application;
   import mx.core.EdgeMetrics;
   import mx.core.ScrollPolicy;
   import mx.core.mx_internal;
   import mx.events.ScrollEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class ScrollableMenu extends Menu
   {
       
      
      private var xShow:Object = 0;
      
      private var yShow:Object = 0;
      
      private var bBlockHideEvent:Boolean = false;
      
      public var hideOnActivity:Boolean = true;
      
      private var subMenu:Menu = null;
      
      public function ScrollableMenu()
      {
         super();
      }
      
      public static function createMenu(param1:DisplayObjectContainer, param2:Object, param3:Boolean = true) : ScrollableMenu
      {
         var _loc4_:ScrollableMenu;
         (_loc4_ = new ScrollableMenu()).tabEnabled = false;
         _loc4_.owner = DisplayObjectContainer(Application.application);
         _loc4_.showRoot = param3;
         popUpMenu(_loc4_,param1,param2);
         return _loc4_;
      }
      
      override public function hide() : void
      {
         if(verticalScrollBar)
         {
            verticalScrollBar.removeEventListener(ScrollEvent.SCROLL,onScroll);
         }
         super.hide();
      }
      
      override protected function mouseUpHandler(param1:MouseEvent) : void
      {
         if(hideOnActivity == false)
         {
            bBlockHideEvent = true;
         }
         super.mouseUpHandler(param1);
         if(hideOnActivity == false)
         {
            bBlockHideEvent = false;
         }
      }
      
      protected function onScroll(param1:ScrollEvent) : void
      {
         if(subMenu)
         {
            subMenu.hide();
         }
      }
      
      override public function move(param1:Number, param2:Number) : void
      {
         invalidateSize();
         super.move(param1,param2);
      }
      
      protected function clearMenu(param1:IMenuItemRenderer) : void
      {
         var _loc2_:Menu = param1.menu;
         _loc2_.hide();
         clearInterval(_loc2_.closeTimer);
         _loc2_.closeTimer = 0;
         param1.menu = null;
      }
      
      override mx_internal function openSubMenu(param1:IListItemRenderer) : void
      {
         var _loc3_:Menu = null;
         var _loc4_:Menu = null;
         var _loc5_:ICollectionView = null;
         var _loc6_:ICollectionView = null;
         supposedToLoseFocus = true;
         var _loc2_:Menu = getRootMenu();
         if(param1.data)
         {
            if(IMenuItemRenderer(param1).menu)
            {
               _loc4_ = IMenuItemRenderer(param1).menu;
               _loc5_ = mx_internal::_dataDescriptor.getChildren(param1.data);
               _loc6_ = _loc4_.dataProvider as ICollectionView;
               if(_loc5_ != _loc6_)
               {
                  clearMenu(param1 as IMenuItemRenderer);
               }
            }
         }
         else
         {
            clearMenu(param1 as IMenuItemRenderer);
         }
         if(!IMenuItemRenderer(param1).menu)
         {
            _loc3_ = createSubMenu();
            subMenu = _loc3_;
            _loc3_.maxHeight = this.maxHeight;
            _loc3_.maxWidth = this.maxWidth;
            _loc3_.verticalScrollPolicy = this.verticalScrollPolicy;
            _loc3_.variableRowHeight = this.variableRowHeight;
            _loc3_.parentMenu = this;
            _loc3_.owner = this;
            _loc3_.showRoot = showRoot;
            _loc3_.dataDescriptor = _loc2_.dataDescriptor;
            _loc3_.styleName = _loc2_;
            _loc3_.labelField = _loc2_.labelField;
            _loc3_.labelFunction = _loc2_.labelFunction;
            _loc3_.iconField = _loc2_.iconField;
            _loc3_.iconFunction = _loc2_.iconFunction;
            _loc3_.itemRenderer = _loc2_.itemRenderer;
            _loc3_.rowHeight = _loc2_.rowHeight;
            _loc3_.scaleY = _loc2_.scaleY;
            _loc3_.scaleX = _loc2_.scaleX;
            ScrollableMenu(_loc3_).hideOnActivity = hideOnActivity;
            if(param1.data && mx_internal::_dataDescriptor.isBranch(param1.data) && mx_internal::_dataDescriptor.hasChildren(param1.data))
            {
               _loc3_.dataProvider = mx_internal::_dataDescriptor.getChildren(param1.data);
            }
            _loc3_.sourceMenuBar = mx_internal::sourceMenuBar;
            _loc3_.sourceMenuBarItem = mx_internal::sourceMenuBarItem;
            IMenuItemRenderer(param1).menu = _loc3_;
            PopUpManager.addPopUp(_loc3_,_loc2_,false);
         }
         super.openSubMenu(param1);
      }
      
      override protected function measure() : void
      {
         var _loc3_:EdgeMetrics = null;
         var _loc4_:int = 0;
         super.measure();
         if(explicitRowCount < 1)
         {
            if(measuredHeight > this.maxHeight)
            {
               measuredHeight = this.maxHeight;
            }
         }
         else
         {
            _loc3_ = viewMetrics;
            _loc4_ = 0;
            if(!isNaN(explicitRowHeight))
            {
               _loc4_ = Math.min(int(maxHeight / explicitRowHeight),explicitRowCount,dataProvider.length);
               measuredHeight = explicitRowHeight * _loc4_ + _loc3_.top + _loc3_.bottom;
               measuredMinHeight = explicitRowHeight * Math.min(_loc4_,2) + _loc3_.top + _loc3_.bottom;
            }
            else
            {
               _loc4_ = Math.min(int(maxHeight / rowHeight),explicitRowCount,dataProvider.length);
               measuredHeight = rowHeight * _loc4_ + _loc3_.top + _loc3_.bottom;
               measuredMinHeight = rowHeight * Math.min(_loc4_,2) + _loc3_.top + _loc3_.bottom;
            }
         }
         if(verticalScrollPolicy == ScrollPolicy.ON || verticalScrollPolicy == ScrollPolicy.AUTO)
         {
            if(verticalScrollBar && verticalScrollBar.visible)
            {
               measuredWidth = measuredWidth + verticalScrollBar.minWidth;
               measuredMinWidth = measuredMinWidth + verticalScrollBar.minWidth;
            }
         }
         var _loc1_:Point = new Point(0,0);
         _loc1_ = this.localToGlobal(_loc1_);
         var _loc2_:Number = screen.y + screen.height - _loc1_.y - 10;
         if(_loc2_ < measuredHeight)
         {
            measuredHeight = measuredMinHeight = _loc2_;
         }
      }
      
      protected function createSubMenu() : Menu
      {
         return new ScrollableMenu();
      }
      
      override public function set verticalScrollPolicy(param1:String) : void
      {
         var _loc2_:String = param1.toLowerCase();
         itemsSizeChanged = true;
         if(mx_internal::_verticalScrollPolicy != _loc2_)
         {
            _verticalScrollPolicy = _loc2_;
            dispatchEvent(new Event("verticalScrollPolicyChanged"));
         }
         invalidateDisplayList();
      }
      
      override public function set rowCount(param1:int) : void
      {
         if(param1 < 0)
         {
            verticalScrollPosition = 0;
         }
         super.rowCount = param1;
      }
      
      override protected function configureScrollBars() : void
      {
         var _loc1_:int = listItems.length;
         if(_loc1_ == 0)
         {
            return;
         }
         if(_loc1_ > 1 && rowInfo[_loc1_ - 1].y + rowInfo[_loc1_ - 1].height > listContent.height)
         {
            _loc1_--;
         }
         var _loc2_:int = verticalScrollPosition - lockedRowCount - 1;
         var _loc3_:int = 0;
         while(_loc1_ && listItems[_loc1_ - 1].length == 0)
         {
            if(!(collection && _loc1_ + _loc2_ >= collection.length))
            {
               break;
            }
            _loc1_--;
            _loc3_++;
         }
         var _loc4_:int = listItems[0].length;
         var _loc5_:Object = horizontalScrollBar;
         var _loc6_:Object = verticalScrollBar;
         var _loc7_:int = Math.round(unscaledWidth);
         var _loc8_:int = !!collection?int(collection.length - lockedRowCount):0;
         var _loc9_:int = _loc1_ - lockedRowCount;
         setScrollBarProperties(Math.round(listContent.width),_loc7_,_loc8_,_loc9_);
         maxVerticalScrollPosition = Math.max(_loc8_ - _loc9_,0);
         if(verticalScrollBar)
         {
            verticalScrollBar.removeEventListener(ScrollEvent.SCROLL,onScroll);
            verticalScrollBar.addEventListener(ScrollEvent.SCROLL,onScroll,false,0,true);
         }
      }
      
      override mx_internal function hideAllMenus() : void
      {
         if(bBlockHideEvent == false)
         {
            super.hideAllMenus();
         }
      }
      
      override public function set dataProvider(param1:Object) : void
      {
         super.dataProvider = param1;
         invalidateSize();
         invalidateDisplayList();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var unscaledWidth:Number = param1;
         var unscaledHeight:Number = param2;
         var cornerRadius:Number = !!getStyle("cornerRadius")?Number(getStyle("cornerRadius")):Number(0);
         var _loc4_:*;
         with(_loc4_ = maskShape)
         {
            
            graphics.clear();
            graphics.beginFill(16777215);
            if(verticalScrollBar && verticalScrollBar.visible)
            {
               graphics.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,cornerRadius,0,cornerRadius,0);
            }
            else
            {
               graphics.drawRoundRect(0,0,unscaledWidth,unscaledHeight,2 * cornerRadius,2 * cornerRadius);
            }
            graphics.endFill();
         }
         var hadVertScroll:Boolean = verticalScrollBar != null && verticalScrollBar.visible;
         super.updateDisplayList(unscaledWidth,unscaledHeight);
      }
      
      override public function get verticalScrollPolicy() : String
      {
         return this._verticalScrollPolicy;
      }
      
      override public function show(param1:Object = null, param2:Object = null) : void
      {
         var xShow:Object = param1;
         var yShow:Object = param2;
         if(parentMenu != null)
         {
            var _loc4_:*;
            with(_loc4_ = parentMenu)
            {
               
               if((verticalScrollPolicy == ScrollPolicy.ON || verticalScrollPolicy == ScrollPolicy.AUTO) && verticalScrollBar && verticalScrollBar.visible)
               {
                  xShow = xShow + verticalScrollBar.width;
               }
            }
         }
         this.xShow = xShow;
         this.yShow = yShow;
         super.show(xShow,yShow);
         if(x + width >= screen.width - 12)
         {
            x = screen.width - width - 12;
         }
      }
   }
}
