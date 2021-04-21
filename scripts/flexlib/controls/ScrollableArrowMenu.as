package flexlib.controls
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.controls.Button;
   import mx.controls.Menu;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.core.Application;
   import mx.core.ScrollPolicy;
   import mx.core.mx_internal;
   import mx.events.ScrollEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class ScrollableArrowMenu extends ScrollableMenu
   {
      
      private static var DEFAULT_DOWN_BUTTON:Class = ScrollableArrowMenu_DEFAULT_DOWN_BUTTON;
      
      private static var DEFAULT_UP_BUTTON:Class = ScrollableArrowMenu_DEFAULT_UP_BUTTON;
      
      {
         initializeStyles();
      }
      
      private var timer:Timer;
      
      private var _arrowScrollPolicy:String = "auto";
      
      public var scrollJump:Number = 1;
      
      private var upButton:Button;
      
      public var scrollSpeed:Number = 80;
      
      private var downButton:Button;
      
      public function ScrollableArrowMenu()
      {
         super();
      }
      
      private static function initializeStyles() : void
      {
         var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ScrollableArrowMenu");
         if(!selector)
         {
            selector = new CSSStyleDeclaration();
         }
         selector.defaultFactory = function():void
         {
            this.upButtonStyleName = "upButton";
            this.downButtonStyleName = "downButton";
         };
         StyleManager.setStyleDeclaration("ScrollableArrowMenu",selector,false);
         var upStyleName:String = selector.getStyle("upButtonStyleName");
         var upSelector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + upStyleName);
         if(!upSelector)
         {
            upSelector = new CSSStyleDeclaration();
         }
         upSelector.defaultFactory = function():void
         {
            this.icon = DEFAULT_UP_BUTTON;
            this.fillAlphas = [1,1,1,1];
            this.cornerRadius = 0;
         };
         StyleManager.setStyleDeclaration("." + upStyleName,upSelector,false);
         var downStyleName:String = selector.getStyle("downButtonStyleName");
         var downSelector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + downStyleName);
         if(!downSelector)
         {
            downSelector = new CSSStyleDeclaration();
         }
         downSelector.defaultFactory = function():void
         {
            this.icon = DEFAULT_DOWN_BUTTON;
            this.fillAlphas = [1,1,1,1];
            this.cornerRadius = 0;
         };
         StyleManager.setStyleDeclaration("." + downStyleName,downSelector,false);
      }
      
      public static function createMenu(param1:DisplayObjectContainer, param2:Object, param3:Boolean = true) : ScrollableArrowMenu
      {
         var _loc4_:ScrollableArrowMenu;
         (_loc4_ = new ScrollableArrowMenu()).tabEnabled = false;
         _loc4_.owner = DisplayObjectContainer(Application.application);
         _loc4_.showRoot = param3;
         popUpMenu(_loc4_,param1,param2);
         return _loc4_;
      }
      
      private function scrollUp(param1:TimerEvent) : void
      {
         if(this.verticalScrollPosition - scrollJump > 0)
         {
            this.verticalScrollPosition = this.verticalScrollPosition - scrollJump;
         }
         else
         {
            this.verticalScrollPosition = 0;
         }
         checkButtons(null);
      }
      
      public function get arrowScrollPolicy() : String
      {
         return _arrowScrollPolicy;
      }
      
      public function set arrowScrollPolicy(param1:String) : void
      {
         this._arrowScrollPolicy = param1;
         invalidateDisplayList();
      }
      
      private function stopScrolling(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_UP,stopScrolling);
         if(timer && timer.running)
         {
            timer.stop();
         }
      }
      
      private function scrollDown(param1:TimerEvent) : void
      {
         if(this.verticalScrollPosition + scrollJump < this.maxVerticalScrollPosition)
         {
            this.verticalScrollPosition = this.verticalScrollPosition + scrollJump;
         }
         else
         {
            this.verticalScrollPosition = this.maxVerticalScrollPosition;
         }
         checkButtons(null);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         ScrollableArrowMenu.initializeStyles();
      }
      
      private function checkButtons(param1:Event) : void
      {
         if(this.arrowScrollPolicy == ScrollPolicy.AUTO)
         {
            upButton.visible = upButton.enabled = this.verticalScrollPosition != 0;
            downButton.visible = downButton.enabled = this.verticalScrollPosition != this.maxVerticalScrollPosition;
         }
         else if(this.arrowScrollPolicy == ScrollPolicy.ON)
         {
            upButton.visible = downButton.visible = true;
            upButton.enabled = this.verticalScrollPosition != 0;
            downButton.enabled = this.verticalScrollPosition != this.maxVerticalScrollPosition;
         }
         else
         {
            upButton.visible = upButton.enabled = downButton.visible = downButton.enabled = false;
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         upButton = new Button();
         downButton = new Button();
         upButton.styleName = getStyle("upButtonStyleName");
         downButton.styleName = getStyle("downButtonStyleName");
         addChild(upButton);
         addChild(downButton);
         upButton.addEventListener(MouseEvent.ROLL_OVER,startScrollingUp);
         upButton.addEventListener(MouseEvent.ROLL_OUT,stopScrolling);
         downButton.addEventListener(MouseEvent.ROLL_OVER,startScrollingDown);
         downButton.addEventListener(MouseEvent.ROLL_OUT,stopScrolling);
         this.addEventListener(ScrollEvent.SCROLL,checkButtons);
      }
      
      override protected function createSubMenu() : Menu
      {
         var _loc1_:ScrollableArrowMenu = new ScrollableArrowMenu();
         _loc1_.arrowScrollPolicy = this.arrowScrollPolicy;
         return _loc1_;
      }
      
      private function startScrollingUp(param1:Event) : void
      {
         if(timer && timer.running)
         {
            timer.stop();
         }
         timer = new Timer(this.scrollSpeed);
         timer.addEventListener(TimerEvent.TIMER,scrollUp);
         timer.start();
      }
      
      private function startScrollingDown(param1:Event) : void
      {
         if(timer && timer.running)
         {
            timer.stop();
         }
         timer = new Timer(this.scrollSpeed);
         timer.addEventListener(TimerEvent.TIMER,scrollDown);
         timer.start();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Number = param1;
         if(verticalScrollBar && verticalScrollBar.visible)
         {
            _loc3_ = param1 - ScrollBar.THICKNESS;
         }
         upButton.setActualSize(_loc3_,15);
         downButton.setActualSize(_loc3_,15);
         upButton.move(0,0);
         downButton.move(0,measuredHeight - downButton.height);
         checkButtons(null);
      }
   }
}
