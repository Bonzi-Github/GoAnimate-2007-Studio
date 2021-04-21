package anifire.components.containers
{
   import anifire.component.GoAlert;
   import anifire.components.studio.ILock;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.CharThumb;
   import anifire.core.CoreEvent;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.events.AssetPurchasedEvent;
   import anifire.events.CopyThumbEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.MovieClipLoaderAsset;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.FlexEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class ThumbnailCanvas extends Canvas
   {
       
      
      private var BuyPointsIcon:Class;
      
      public var closeWindow:Function;
      
      private var _maskCanvas:Canvas = null;
      
      private var _colorSetId:String;
      
      private var _playButtonShowable:Boolean = true;
      
      private var _premIcon:UIComponent;
      
      private var _locked:ILock;
      
      private var BuyBucksIcon:Class;
      
      private var _allowPremium:Boolean;
      
      private var _btnDelete:Button;
      
      private var _btnBuy:Canvas;
      
      private var _useSmallButton:Boolean = false;
      
      private var _copyable:Boolean = false;
      
      private var _btnCopy:Button;
      
      private var _btnStop:Button;
      
      private var _editable:Boolean;
      
      private const BUTTON_HEIGHT:Number = 20;
      
      private var _thumb:Thumb;
      
      private const BUTTON_WIDTH:Number = 20;
      
      private var _buyButtonShowable:Boolean = true;
      
      private var _btnInfo:Button;
      
      private var _idDisplay:Canvas = null;
      
      private var _soundButtonStyle:Number = 0;
      
      private var _btnPlay:Button;
      
      private var PremiumIconB:Class;
      
      private var _displayObj:DisplayObject;
      
      private var SmallBuyPointsIcon:Class;
      
      private var PremiumIcon:Class;
      
      private var _displayId:Boolean = false;
      
      public function ThumbnailCanvas(param1:Number, param2:Number, param3:DisplayObject, param4:Thumb, param5:Boolean, param6:Boolean, param7:Boolean, param8:String = "", param9:Boolean = true, param10:Number = 0, param11:Boolean = false, param12:Boolean = false)
      {
         var _loc13_:DropShadowFilter = null;
         var _loc14_:Array = null;
         var _loc15_:MovieClipLoaderAsset = null;
         this.PremiumIcon = ThumbnailCanvas_PremiumIcon;
         this.PremiumIconB = ThumbnailCanvas_PremiumIconB;
         this.BuyBucksIcon = ThumbnailCanvas_BuyBucksIcon;
         this.BuyPointsIcon = ThumbnailCanvas_BuyPointsIcon;
         this.SmallBuyPointsIcon = ThumbnailCanvas_SmallBuyPointsIcon;
         super();
         this.buttonMode = true;
         this._allowPremium = param7;
         this._buyButtonShowable = param7 && param4.premium;
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.verticalScrollPolicy = ScrollPolicy.OFF;
         this.width = param1;
         this.height = param2;
         this.scrollRect = new Rectangle(0,0,this.width,this.height);
         this._useSmallButton = param11;
         this._thumb = param4;
         this.colorSetId = param8;
         if(param4 is VideoPropThumb)
         {
            this.styleName = "tileBackground";
            this.name = "cellUserBackground";
         }
         else if(param4 is PropThumb)
         {
            this.styleName = "tileProp";
            this.name = "cellUserProp";
            if(PropThumb(param4).getStateNum() > 0)
            {
               _loc13_ = new DropShadowFilter(2,45,6710886,1,0,0);
               (_loc14_ = new Array()).push(_loc13_);
               filters = _loc14_;
            }
         }
         else if(param4 is BackgroundThumb)
         {
            this.styleName = "tileBackground";
            this.name = "cellUserBackground";
         }
         else if(param4 is CharThumb)
         {
            this.styleName = "tileChar";
            this.name = "cellUserCharacter";
         }
         else if(param4 is SoundThumb)
         {
            this.name = "cellUserSound";
         }
         else if(param4 is EffectThumb)
         {
            this.styleName = "tileBubble";
            this.name = "cellUserEffect";
         }
         this._editable = param5;
         this._copyable = param6;
         this._soundButtonStyle = param10;
         this.updateDisplayObject(param3,param12);
         if(param9)
         {
            this.addButtons();
         }
         if(param7 && param4.premium)
         {
            if(Number(param4.cost[0]) > 0)
            {
               _loc15_ = new this.PremiumIcon();
            }
            else
            {
               _loc15_ = new this.PremiumIconB();
            }
            _loc15_.y = param2 - _loc15_.height * 0.85;
            _loc15_.width = _loc15_.width * 0.85;
            _loc15_.height = _loc15_.height * 0.85;
            this._premIcon = new UIComponent();
            this._premIcon.addChild(_loc15_);
            if(param4.purchased)
            {
               this.addToPremiumThumbTray();
               this.addSelfListeners();
               this.addChild(this._premIcon);
            }
         }
         else
         {
            this.addSelfListeners();
         }
      }
      
      public function deleteThumbnail(param1:Boolean = true) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(this._displayObj is SoundTileCell)
         {
            (this._displayObj as SoundTileCell).stopSound();
         }
         this.parent.removeChild(this);
         if(param1)
         {
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            _loc2_["assetId"] = this.thumb.id;
            _loc3_ = new URLRequest(ServerConstants.ACTION_DELETE_ASSET);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).load(_loc3_);
         }
      }
      
      public function set colorSetId(param1:String) : void
      {
         this._colorSetId = param1;
      }
      
      private function set playButtonShowable(param1:Boolean) : void
      {
         this._playButtonShowable = param1;
      }
      
      public function get locked() : ILock
      {
         return this._locked;
      }
      
      private function get playButtonShowable() : Boolean
      {
         return this._playButtonShowable;
      }
      
      public function get editable() : Boolean
      {
         return this._editable;
      }
      
      public function set locked(param1:ILock) : void
      {
         var _loc2_:* = this._locked != param1;
         this._locked = param1;
         if(_loc2_)
         {
            invalidateDisplayList();
         }
      }
      
      private function isAllowPublish() : Boolean
      {
         if(this.thumb is VideoPropThumb)
         {
            return false;
         }
         return true;
      }
      
      private function doDispatchAssetPurchasedEvent(param1:AssetPurchasedEvent) : void
      {
         this.dispatchEvent(param1.clone());
      }
      
      private function showEditPanel(param1:MouseEvent) : void
      {
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = _loc2_.getValueByKey("uplp");
         var _loc4_:AssetInfoWindow;
         (_loc4_ = AssetInfoWindow(PopUpManager.createPopUp(this,AssetInfoWindow,true))).thumb = this.thumb;
         _loc4_.thumbnailCanvas = this;
         _loc4_.x = (_loc4_.stage.width - _loc4_.width) / 2;
         _loc4_.y = 100;
         _loc4_.assetId = this.thumb.id;
         _loc4_.assetTitle = this.thumb.name;
         _loc4_.tags = this.thumb.tags;
         _loc4_.isPublished = this.thumb.isPublished;
         _loc4_.allowPublish = this.isAllowPublish();
         if(UtilLicense.isSchoolEnvironment())
         {
            _loc4_.allowPublish = _loc3_ && _loc3_ == "1";
         }
      }
      
      private function doDispatchUserWantToCopyThumbEvent(param1:Event) : void
      {
         var _loc2_:CopyThumbEvent = new CopyThumbEvent(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this);
         _loc2_.thumb = this.thumb;
         this.dispatchEvent(_loc2_);
      }
      
      public function clickStop(param1:MouseEvent = null) : void
      {
         if(this._displayObj != null && this._displayObj is SoundTileCell)
         {
            SoundTileCell(this._displayObj).stopSound();
         }
         this._btnStop.visible = false;
         if(this._btnPlay != null)
         {
            this._btnPlay.visible = true;
         }
         this.playButtonShowable = true;
      }
      
      public function hideStopButton(param1:Event) : void
      {
         if(this._btnStop != null)
         {
            this._btnStop.visible = false;
         }
         this.playButtonShowable = true;
      }
      
      private function showDeleteConfirmWindow(param1:Event) : void
      {
         var _loc2_:GoAlert = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
         if(this.thumb is PropThumb)
         {
            _loc2_.assetType = "Prop";
         }
         else if(this.thumb is BackgroundThumb)
         {
            _loc2_.assetType = "Background";
         }
         else if(this.thumb is SoundThumb)
         {
            _loc2_.assetType = "Sound";
         }
         else if(this.thumb is CharThumb)
         {
            _loc2_.assetType = "Character";
         }
         else if(this.thumb is EffectThumb)
         {
            _loc2_.assetType = "Effect";
         }
         _loc2_.thumbnailCanvas = this;
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      private function showBuyPanel(param1:MouseEvent) : void
      {
         var buyWindow:AssetPurchaseWindow = null;
         var event:MouseEvent = param1;
         buyWindow = AssetPurchaseWindow(PopUpManager.createPopUp(this,AssetPurchaseWindow,true));
         buyWindow.loggedIn = UtilUser.loggedIn;
         buyWindow.addEventListener(AssetPurchasedEvent.ASSET_PURCHASED,this.doDispatchAssetPurchasedEvent);
         var buyButton:Button = new Button();
         buyWindow.thumbnailCanvas = this;
         buyWindow.x = (buyWindow.stage.width - buyWindow.width) / 2;
         buyWindow.y = 200;
         buyWindow.aid = this.thumb.aid;
         buyWindow.theme_id = this.thumb.theme.id;
         trace("theme=" + this.thumb.theme.id);
         buyWindow.assetTitle = UtilDict.toDisplay("store",this.thumb.name);
         if(!UtilUser.loggedIn)
         {
            buyWindow.switchBuyButtonToNonLogin();
         }
         else if(Number(this.thumb.cost[0]) > 0)
         {
            buyWindow.switchBuyButtonToBuyMe();
         }
         else
         {
            buyWindow.switchBuyButtonToAddMe();
         }
         this.closeWindow = function():void
         {
            PopUpManager.removePopUp(buyWindow);
         };
         buyWindow.thumb = this.thumb;
      }
      
      public function set thumbnailName(param1:String) : void
      {
         this.thumb.name = param1;
         if(this._displayObj is Image)
         {
            Image(this._displayObj).toolTip = param1;
         }
         else if(this._displayObj is SoundTileCell)
         {
            SoundTileCell(this._displayObj).tileLabel = param1;
         }
      }
      
      private function addToPremiumThumbTray() : void
      {
      }
      
      private function addButtons() : void
      {
         var btnPlayX:Number = NaN;
         var btnPlayY:Number = NaN;
         var temp:Image = null;
         var costLabel:Label = null;
         var iconCls:Class = null;
         var panelHeight:int = 0;
         var cssRule:CSSStyleDeclaration = null;
         if(this.thumb is SoundThumb)
         {
            btnPlayX = this.width - this.BUTTON_WIDTH * 2;
            btnPlayY = (this.height - this.BUTTON_HEIGHT) / 2;
            this._btnPlay = new Button();
            this._btnPlay.styleName = "btnPlaySmall";
            this._btnPlay.x = btnPlayX;
            this._btnPlay.y = btnPlayY;
            this._btnStop = new Button();
            this._btnStop.styleName = "btnStopSmall";
            this._btnStop.x = btnPlayX;
            this._btnStop.y = btnPlayY;
            if(this._soundButtonStyle != 0)
            {
               if(this._soundButtonStyle == 1)
               {
                  this._btnPlay.alpha = 0;
                  this._btnStop.alpha = 0;
               }
            }
            this._btnPlay.visible = false;
            this._btnPlay.addEventListener(MouseEvent.CLICK,this.clickPlay);
            this.addChild(this._btnPlay);
            this._btnStop.visible = false;
            this._btnStop.addEventListener(MouseEvent.CLICK,this.clickStop);
            this.addChild(this._btnStop);
         }
         trace("this.thumb.id=" + this.thumb.id + " this.buyButtonShowable=" + this.buyButtonShowable + " this.thumb.purchased=" + this.thumb.purchased);
         if(this.buyButtonShowable && !this.thumb.purchased)
         {
            temp = new Image();
            costLabel = new Label();
            if(Number(this.thumb.cost[0]) > 0)
            {
               cssRule = StyleManager.getStyleDeclaration(".thumbTrayBuyBucksIcon" + this.width);
               iconCls = Class(cssRule.getStyle("source"));
               panelHeight = int(cssRule.getStyle("panelHeight"));
               costLabel.text = this.thumb.cost[0];
            }
            else
            {
               cssRule = StyleManager.getStyleDeclaration(".thumbTrayBuyPointsIcon" + this.width);
               iconCls = Class(cssRule.getStyle("source"));
               panelHeight = int(cssRule.getStyle("panelHeight"));
               costLabel.text = this.thumb.cost[1];
            }
            temp.source = new iconCls();
            temp.autoLoad = true;
            temp.visible = true;
            this._btnBuy = new Canvas();
            this._btnBuy.clipContent = false;
            this._btnBuy.height = this.height;
            this._btnBuy.addChild(temp);
            this._btnBuy.addChild(costLabel);
            this.addChild(this._btnBuy);
            temp.setStyle("bottom",0);
            costLabel.styleName = "thumbTrayPremiumCost";
            costLabel.x = this.width / 2;
            temp.addEventListener(FlexEvent.UPDATE_COMPLETE,function(param1:Event):void
            {
               costLabel.setStyle("bottom",(panelHeight - costLabel.height) / 2);
            });
            this._btnBuy.graphics.beginFill(16711680,0);
            this._btnBuy.graphics.drawRect(0,0,this.width,this.height);
            this._btnBuy.graphics.endFill();
            this._btnBuy.addEventListener(MouseEvent.MOUSE_DOWN,this.showBuyPanel);
            this._btnBuy.addEventListener(MouseEvent.ROLL_OVER,function():void
            {
               _displayObj.filters = null;
            });
         }
         var btnCopyX:Number = 0;
         var btnCopyY:Number = 0;
         var btnDeleteX:Number = 0;
         var btnDeleteY:Number = 0;
         if(this.copyable)
         {
            btnDeleteX = btnCopyX + this.BUTTON_WIDTH;
            this._btnCopy = new Button();
            this._btnCopy.styleName = "btnCopySmall";
            this._btnCopy.visible = false;
            this._btnCopy.addEventListener(MouseEvent.CLICK,this.doDispatchUserWantToCopyThumbEvent);
            this.addChild(this._btnCopy);
            this._btnCopy.toolTip = UtilDict.toDisplay("go","copy_char_tooltip");
         }
         var btnInfoX:Number = btnDeleteX + this.BUTTON_WIDTH;
         var btnInfoY:Number = 0;
         if(this.editable)
         {
            if(this.thumb is SoundThumb)
            {
               btnDeleteX = this.width - this.BUTTON_WIDTH * 3;
               btnInfoX = btnDeleteX - this.BUTTON_WIDTH;
               btnDeleteY = btnInfoY = Number((this.height - this.BUTTON_HEIGHT) / 2);
            }
            this._btnDelete = new Button();
            this._btnDelete.styleName = "btnDeleteSmall";
            this._btnDelete.x = btnDeleteX;
            this._btnDelete.y = btnDeleteY;
            this._btnDelete.visible = false;
            this._btnDelete.addEventListener(MouseEvent.CLICK,this.showDeleteConfirmWindow);
            this.addChild(this._btnDelete);
            this._btnInfo = new Button();
            this._btnInfo.styleName = "btnInfoSmall";
            this._btnInfo.x = btnInfoX;
            this._btnInfo.y = btnInfoY;
            this._btnInfo.visible = false;
            this._btnInfo.addEventListener(MouseEvent.CLICK,this.showEditPanel);
            this.addChild(this._btnInfo);
         }
      }
      
      private function addSelfListeners() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.showButtons);
         this.addEventListener(MouseEvent.ROLL_OUT,this.hideButtons);
      }
      
      private function showButtons(param1:MouseEvent) : void
      {
         if(this._btnCopy != null)
         {
            this._btnCopy.visible = true;
         }
         if(this._btnDelete != null)
         {
            this._btnDelete.visible = true;
         }
         if(this._btnInfo != null)
         {
            this._btnInfo.visible = true;
         }
         if(this._btnPlay != null && this.playButtonShowable)
         {
            this._btnPlay.visible = true;
         }
         if(this._btnBuy != null && this.buyButtonShowable)
         {
         }
      }
      
      public function get copyable() : Boolean
      {
         return this._copyable;
      }
      
      public function get displayObj() : DisplayObject
      {
         return this._displayObj;
      }
      
      public function updateDisplayObject(param1:DisplayObject, param2:Boolean = false) : void
      {
         var _loc3_:DisplayObject = this.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME);
         if(_loc3_ != null)
         {
            this.removeChild(_loc3_);
         }
         this._displayObj = param1;
         this._displayObj.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.addChildAt(this._displayObj,0);
      }
      
      public function clickPlay(param1:MouseEvent = null) : void
      {
         if(this._displayObj != null && this._displayObj is SoundTileCell)
         {
            this._displayObj.addEventListener(CoreEvent.PLAY_SOUND_COMPLETE,this.hideStopButton);
            SoundTileCell(this._displayObj).playSound();
            this._displayObj.dispatchEvent(new Event(SoundTileCell.EVENT_PLAY_BUT_CLICK));
         }
         if(this._btnStop != null)
         {
            this._btnStop.visible = true;
            this.playButtonShowable = false;
         }
      }
      
      public function get thumb() : Thumb
      {
         return this._thumb;
      }
      
      private function hideButtons(param1:MouseEvent) : void
      {
         if(this._btnCopy != null)
         {
            this._btnCopy.visible = false;
         }
         if(this._btnDelete != null)
         {
            this._btnDelete.visible = false;
         }
         if(this._btnInfo != null)
         {
            this._btnInfo.visible = false;
         }
         if(this._btnPlay != null)
         {
            this._btnPlay.visible = false;
         }
         if(this._btnBuy != null)
         {
         }
      }
      
      private function get buyButtonShowable() : Boolean
      {
         return this._buyButtonShowable;
      }
      
      public function set showId(param1:Boolean) : void
      {
         this._displayId = param1;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Array = null;
         var _loc4_:ColorMatrixFilter = null;
         var _loc5_:Canvas = null;
         var _loc6_:Image = null;
         var _loc7_:Label = null;
         super.updateDisplayList(param1,param2);
         if(this.locked)
         {
            _loc3_ = [0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0,0,0,1,0];
            _loc4_ = new ColorMatrixFilter(_loc3_);
            this._displayObj.filters = [_loc4_];
            if(!this._maskCanvas)
            {
               this._maskCanvas = new Canvas();
               this._maskCanvas.clipContent = false;
               this._maskCanvas.height = param2;
               this._maskCanvas.width = param1;
               this._maskCanvas.toolTip = UtilDict.toDisplay("go",this.locked.hint);
               (_loc5_ = new Canvas()).styleName = "thumbBlurCanvas";
               _loc5_.width = param1;
               _loc5_.height = param2;
               (_loc6_ = new Image()).source = Class(StyleManager.getStyleDeclaration(".thumbIconLocked").getStyle("upIcon"));
               _loc6_.styleName = "thumbIconLocked";
               this._maskCanvas.addChild(_loc5_);
               this._maskCanvas.addChild(_loc6_);
               addChild(this._maskCanvas);
            }
         }
         else
         {
            this._displayObj.filters = [];
         }
         if(this._maskCanvas)
         {
            this._maskCanvas.visible = this.locked != null;
         }
         if(this.showId)
         {
            if(!this._idDisplay)
            {
               this._idDisplay = new Canvas();
               this._idDisplay.styleName = "thumbnailIdBackdrop";
               this._idDisplay.width = param1;
               this._idDisplay.horizontalScrollPolicy = ScrollPolicy.OFF;
               this._idDisplay.x = this._idDisplay.y = 0;
               (_loc7_ = new Label()).text = this._thumb.id;
               _loc7_.toolTip = _loc7_.text;
               _loc7_.percentHeight = _loc7_.percentWidth = 100;
               _loc7_.styleName = "thumbnailId";
               this._idDisplay.addChild(_loc7_);
               addChild(this._idDisplay);
            }
         }
      }
      
      public function get showId() : Boolean
      {
         return this._displayId;
      }
      
      public function get colorSetId() : String
      {
         return this._colorSetId;
      }
      
      public function changeToPurchased() : void
      {
         this._buyButtonShowable = false;
         this._btnBuy.visible = false;
         this.addToPremiumThumbTray();
         this._displayObj.filters = null;
         this.addSelfListeners();
         this._thumb.purchase();
         this.addChild(this._premIcon);
      }
   }
}
