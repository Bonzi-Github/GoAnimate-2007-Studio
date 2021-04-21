package anifire.bubble
{
   import anifire.event.AddedToStage;
   import anifire.util.Util;
   import anifire.util.UtilColor;
   import anifire.util.UtilLicense;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   
   public class Bubble extends Sprite
   {
       
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      protected var label:TextField = null;
      
      private var _fillRgb:Number = 16777215;
      
      private var _text:String = "";
      
      private var _type:String = "";
      
      private var _fillAlpha:Number = 1;
      
      private var _gradientMatrix_h:Number = 0;
      
      private var _textRgb:Number = 0;
      
      private var _gradientMatrix_r:Number = 0;
      
      private var _gradientMatrix_w:Number = 0;
      
      private var _tailx:Number = 200;
      
      private var _taily:Number = 150;
      
      private var _textSize:Number = 12;
      
      private var _gradientMatrix_x:Number = 0;
      
      private var _gradientMatrix_y:Number = 0;
      
      private var _visible:Boolean = true;
      
      private var _textEmbed:Boolean = true;
      
      private var _gradientRatios:Array = null;
      
      private var addedToStage:AddedToStage;
      
      private var _gradientRotation:Number = 0;
      
      private const MIN_FONTSIZE:Number = 1;
      
      private var _gradientAlphas:Array = null;
      
      protected var boundHeight:Number = 100;
      
      private var _height:Number = 100;
      
      private var _lineAlpha:Number = 1.0;
      
      protected var tail:Sprite = null;
      
      private var _stopAfterRedraw:Boolean = false;
      
      private var _prevText:String = "";
      
      private var _textAlign:String = "center";
      
      private var _textItalic:Boolean = false;
      
      private const MAX_FONTSIZE:Number = 127;
      
      private var _outlineEnable:Boolean = true;
      
      private var _gradientType:String = null;
      
      private var _lineSize:Number = 0;
      
      private var _gradientWidth:Number = 0;
      
      protected var content:Sprite = null;
      
      private var _textFont:String = "Blambot Casual";
      
      private var _tailEnable:Boolean = true;
      
      private var effectIntervalInt:Number;
      
      private var _gradientHeight:Number = 0;
      
      protected var body:Sprite = null;
      
      private var _gradientX:Number = 0;
      
      private var _gradientY:Number = 0;
      
      private var _useDeviceFont:Boolean = false;
      
      private var _backupText:String = "";
      
      private var _textBold:Boolean = false;
      
      private var _textURL:String = "";
      
      private var _width:Number = 200;
      
      private var _editEnable:Boolean = false;
      
      private var _rotation:Number = 0;
      
      private var _gradientColors:Array = null;
      
      private var _autoResize:Boolean = true;
      
      protected var boundWidth:Number = 100;
      
      private var _mver:Number;
      
      private var _lineRgb:Number = 0;
      
      public function Bubble()
      {
         super();
         this.content = new Sprite();
         this.content.name = "content";
         addChild(this.content);
         try
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         }
         catch(e:Error)
         {
            addedToStage = new AddedToStage(this);
            addedToStage.addEventListener("AddedToStageEv",addedToStageHandler);
         }
      }
      
      public function get textURL() : String
      {
         return this._textURL;
      }
      
      public function set textURL(param1:String) : void
      {
         this._textURL = param1;
      }
      
      protected function drawBody() : void
      {
      }
      
      override public function set y(param1:Number) : void
      {
         this._y = param1;
      }
      
      public function get backupText() : String
      {
         return this._backupText;
      }
      
      protected function drawLabel() : void
      {
         this.updateTextSize();
      }
      
      public function get mver() : Number
      {
         return this._mver;
      }
      
      public function set backupText(param1:String) : void
      {
         this._backupText = param1;
      }
      
      public function set stopAfterRedraw(param1:Boolean) : void
      {
         this._stopAfterRedraw = param1;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      public function get textFont() : String
      {
         return this._textFont;
      }
      
      public function stopBubble() : void
      {
         UtilPlain.stopFamily(this.content);
      }
      
      public function get tailx() : Number
      {
         return this._tailx;
      }
      
      private function onTextChangeHandler(param1:Event) : void
      {
         trace("onTextChange");
         this._text = this._backupText = param1.currentTarget.text;
         this.updateTextSize();
      }
      
      public function set fillAlpha(param1:Number) : void
      {
         this._fillAlpha = param1;
         this.drawOutline();
      }
      
      public function getLabel() : TextField
      {
         return this.label;
      }
      
      public function set textFont(param1:String) : void
      {
         this._textFont = param1;
         this.drawLabel();
         this.updateTextSize();
      }
      
      public function get lineRgb() : Number
      {
         return this._lineRgb;
      }
      
      public function get autoResize() : Boolean
      {
         return this._autoResize;
      }
      
      public function hideEditMode() : void
      {
         this.label.selectable = this._editEnable = false;
         this.label.type = TextFieldType.DYNAMIC;
         this.label.mouseEnabled = false;
      }
      
      private function onTextFocusInHandler(param1:FocusEvent = null) : void
      {
         trace("onTextFocus in");
         this._prevText = this.label.text;
         if(UtilLicense.isBubbleI18NPermitted())
         {
            this.label.embedFonts = false;
            this.updateTextSize();
         }
      }
      
      public function isMouseOnLabel() : Boolean
      {
         if(this.label.mouseX > 0 && this.label.mouseX < this.label.width && this.label.mouseY > 0 && this.label.mouseY < this.label.height)
         {
            return true;
         }
         return false;
      }
      
      public function get fillRgb() : Number
      {
         return this._fillRgb;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
         this.redraw();
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get taily() : Number
      {
         return this._taily;
      }
      
      public function set textEmbed(param1:Boolean) : void
      {
         this._textEmbed = param1;
         this.drawLabel();
      }
      
      private function createTextField(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false, param6:TextFormat = null) : TextField
      {
         var _loc8_:TextFormat = null;
         var _loc7_:TextField;
         (_loc7_ = new TextField()).x = param1;
         _loc7_.y = param2;
         _loc7_.width = param3;
         _loc7_.height = param4;
         _loc7_.background = false;
         _loc7_.border = false;
         _loc7_.multiline = true;
         _loc7_.wordWrap = true;
         _loc7_.embedFonts = this.textEmbed;
         _loc7_.antiAliasType = AntiAliasType.ADVANCED;
         if(param6 == null)
         {
            (_loc8_ = new TextFormat()).font = this._textFont;
            _loc8_.color = this._textRgb;
            _loc8_.size = this._textSize;
            _loc8_.align = this._textAlign;
            _loc8_.bold = this._textBold;
            _loc8_.italic = this._textItalic;
            _loc7_.defaultTextFormat = _loc8_;
         }
         else
         {
            _loc7_.defaultTextFormat = param6;
         }
         return _loc7_;
      }
      
      protected function get outlineEnable() : Boolean
      {
         return this._outlineEnable;
      }
      
      public function get textRgb() : Number
      {
         return this._textRgb;
      }
      
      public function set tailx(param1:Number) : void
      {
         this._tailx = param1;
         this.drawTail();
      }
      
      public function get editEnable() : Boolean
      {
         return this._editEnable;
      }
      
      protected function drawOutline(param1:Sprite = null) : void
      {
         var _loc2_:GlowFilter = null;
         var _loc3_:DropShadowFilter = null;
         var _loc4_:Array = null;
         if(this._outlineEnable)
         {
            param1 = param1 == null?this:param1;
            _loc2_ = new GlowFilter(this.lineRgb,1,1.5,3,3,1,false,false);
            _loc3_ = new DropShadowFilter(4,45,this.lineRgb,1,4,4,1,1,false,false,false);
            (_loc4_ = []).push(_loc2_);
            _loc4_.push(_loc3_);
            param1.filters = _loc4_;
            param1.alpha = this._fillAlpha;
         }
      }
      
      override public function get x() : Number
      {
         return this._x;
      }
      
      public function getSize() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = Math.min(this._x,this._tailx);
         _loc1_.y = Math.min(this._y,this._taily);
         _loc1_.width = Math.max(this._x + this._width,this._tailx) - _loc1_.x;
         _loc1_.height = Math.max(this._y + this._height,this._taily) - _loc1_.y;
         return _loc1_;
      }
      
      public function get textBold() : Boolean
      {
         return this._textBold;
      }
      
      override public function get y() : Number
      {
         return this._y;
      }
      
      public function set lineRgb(param1:Number) : void
      {
         this._lineRgb = param1;
         this.drawOutline(this.content);
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function set useDeviceFont(param1:Boolean) : void
      {
         this._useDeviceFont = param1;
         this.drawLabel();
      }
      
      public function set editEnable(param1:Boolean) : void
      {
         this._editEnable = param1;
      }
      
      public function set textItalic(param1:Boolean) : void
      {
         this._textItalic = param1;
         this.drawLabel();
      }
      
      public function set taily(param1:Number) : void
      {
         this._taily = param1;
         this.drawTail();
      }
      
      public function set autoResize(param1:Boolean) : void
      {
         this._autoResize = param1;
      }
      
      public function get stopAfterRedraw() : Boolean
      {
         return this._stopAfterRedraw;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this.redraw();
      }
      
      public function set fillRgb(param1:Number) : void
      {
         this._fillRgb = param1;
         if(this.body != null)
         {
            UtilColor.setRGB(this.body,param1);
         }
         if(this.tail != null)
         {
            UtilColor.setRGB(this.tail,param1);
         }
      }
      
      public function checkCharacterSupport(param1:String = "", param2:String = "") : Boolean
      {
         var _loc5_:Font = null;
         if(param1 == "")
         {
            param1 = this.label.defaultTextFormat.font;
         }
         if(param2 == "")
         {
            param2 = this._text;
         }
         var _loc3_:Array = Font.enumerateFonts(true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if((_loc5_ = _loc3_[_loc4_]).fontName == param1)
            {
               param2 = param2.replace(/\r/g," ");
               if(_loc5_.hasGlyphs(param2))
               {
                  return true;
               }
               return false;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function get fillAlpha() : Number
      {
         return this._fillAlpha;
      }
      
      public function set textSize(param1:Number) : void
      {
         this._textSize = param1;
         this.drawLabel();
      }
      
      public function setTextFormat(param1:TextFormat) : void
      {
         if(param1.font != null)
         {
            this._textFont = param1.font;
         }
         if(param1.color != null)
         {
            this._textRgb = param1.color as Number;
         }
         if(param1.size != null)
         {
            this._textSize = param1.size as Number;
         }
         if(param1.align != null)
         {
            this._textAlign = param1.align;
         }
         if(param1.bold != null)
         {
            this._textBold = param1.bold;
         }
         if(param1.italic != null)
         {
            this._textItalic = param1.italic;
         }
         this.drawLabel();
      }
      
      public function getLabelType() : String
      {
         return this.label.type;
      }
      
      public function set scale(param1:Number) : void
      {
         this._width = this._width * param1;
         this._height = this._height * param1;
         this._tailx = (this._tailx + this._x) * param1;
         this._taily = (this._taily + this._y) * param1;
         this.redraw();
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         this.redraw();
      }
      
      protected function returnTail() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "tail";
         var _loc2_:Number = this.x + this.width / 2;
         var _loc3_:Number = this.y + this.height / 2;
         var _loc4_:Number;
         var _loc5_:Number = (_loc4_ = Math.min(this.height,this.width)) / 4;
         var _loc6_:Point = new Point(this._tailx,this._taily);
         var _loc7_:Circle = new Circle(_loc2_,_loc3_,_loc5_);
         var _loc8_:Object = GMath.getRegPoints(_loc7_,_loc6_);
         _loc1_.graphics.beginFill(this.fillRgb,1);
         _loc1_.graphics.moveTo(_loc8_["p1"]["x"],_loc8_["p1"]["y"]);
         _loc1_.graphics.lineTo(this._tailx,this._taily);
         _loc1_.graphics.lineTo(_loc8_["p2"]["x"],_loc8_["p2"]["y"]);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      public function set textBold(param1:Boolean) : void
      {
         this._textBold = param1;
         this.drawLabel();
      }
      
      public function get textEmbed() : Boolean
      {
         return this._textEmbed;
      }
      
      public function set textAlign(param1:String) : void
      {
         this._textAlign = param1;
         this.drawLabel();
      }
      
      public function get useDeviceFont() : Boolean
      {
         return this._useDeviceFont;
      }
      
      protected function drawTail() : void
      {
      }
      
      private function myActualTextHeight(param1:TextField) : Number
      {
         var _loc2_:Number = NaN;
         return Number(this.label.textHeight + 4);
      }
      
      public function addedToStageHandler(param1:Event, param2:String = null) : void
      {
         var _loc3_:AddedToStage = null;
         if(param1.target is AddedToStage)
         {
            _loc3_ = param1.target as AddedToStage;
            if(_loc3_ != null && _loc3_.hasEventListener("AddedToStageEv"))
            {
               _loc3_.removeEventListener("AddedToStageEv",this.addedToStageHandler);
            }
         }
         this.redraw();
      }
      
      public function reUpdateTextHeight() : void
      {
         trace("reupdatetextheight");
         this.updateTextSize(-1,0.8);
      }
      
      public function set bubbleText(param1:String) : void
      {
         this.label.text = this._text = this._backupText = param1;
         this.updateTextSize();
         dispatchEvent(new BubbleEvent(BubbleEvent.TEXT_CHANGED));
      }
      
      public function set labelVisible(param1:Boolean) : void
      {
         this.label.visible = param1;
      }
      
      public function get textItalic() : Boolean
      {
         return this._textItalic;
      }
      
      public function set textRgb(param1:Number) : void
      {
         this._textRgb = param1;
         this.drawLabel();
      }
      
      public function deSerialize(param1:XML, param2:Number = -1) : void
      {
         this._x = param1.@x;
         this._y = param1.@y;
         this._width = param1.@w;
         this._height = param1.@h;
         this._rotation = param1.@rotate;
         this._fillRgb = param1.body.@rgb;
         this._lineRgb = param1.body.@linergb;
         this._tailx = param1.body.@tailx;
         this._taily = param1.body.@taily;
         this._textRgb = param1.text.@rgb;
         this._textFont = param1.text.@font;
         this._textSize = param1.text.@size;
         this._textAlign = param1.text.@align;
         this._textBold = param1.text.@bold == "true"?true:false;
         this._textItalic = param1.text.@italic == "true"?true:false;
         this._textItalic = false;
         this._textEmbed = param1.text.@embed == "false"?false:true;
         if(param1.text.@badword == "1")
         {
            this._text = param1.text.text();
            this._backupText = param1.backupText.text();
         }
         else
         {
            this._text = this._backupText = param1.text.text();
         }
         if(param2 != -1)
         {
            this._mver = param2;
         }
         if(param1.url != null)
         {
            this._textURL = param1.url.text();
         }
         this.redraw();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      private function onTextFocusOutHandler(param1:FocusEvent) : void
      {
         trace("onTextFocus out:" + [this._prevText,param1.currentTarget.text]);
         if(this._prevText != param1.currentTarget.text)
         {
            dispatchEvent(new BubbleEvent(BubbleEvent.TEXT_CHANGED));
         }
         if(UtilLicense.isBubbleI18NPermitted())
         {
            this.label.embedFonts = this.textEmbed;
         }
      }
      
      protected function set outlineEnable(param1:Boolean) : void
      {
         this._outlineEnable = param1;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         this.label.text = param1;
         this.updateTextSize();
      }
      
      public function get textSize() : Number
      {
         return this._textSize;
      }
      
      protected function updateTextSize(param1:Number = -1, param2:Number = 1) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:TextFormat = null;
         var _loc6_:* = undefined;
         if(param1 < 0)
         {
            param1 = Math.min(this.boundHeight,this._height);
         }
         param1 = param1 * param2;
         if(this.label != null && this.label.text != "" && this._autoResize && (this.label.textHeight > 1 && this.label.textWidth > 1))
         {
            _loc3_ = this.MIN_FONTSIZE;
            _loc4_ = 1;
            _loc5_ = new TextFormat();
            do
            {
               _loc3_ = _loc3_ + _loc4_;
               _loc5_.size = this._textSize = _loc3_;
               this.label.setTextFormat(_loc5_);
               _loc6_ = this.myActualTextHeight(this.label);
            }
            while(Math.floor(_loc6_) < Math.floor(param1) && this._textSize <= this.MAX_FONTSIZE);
            
            do
            {
               _loc3_ = _loc3_ - _loc4_;
               _loc5_.size = this._textSize = _loc3_;
               this.label.setTextFormat(_loc5_);
               _loc6_ = this.myActualTextHeight(this.label);
            }
            while(Math.floor(_loc6_) > Math.floor(param1) && this._textSize >= this.MIN_FONTSIZE);
            
         }
         this.updateVerticalAlign();
      }
      
      protected function returnLabel(param1:String = null) : TextField
      {
         var _loc2_:TextField = this.createTextField(0,0,this._width,this._height,this._useDeviceFont);
         _loc2_.name = "label";
         _loc2_.type = TextFieldType.INPUT;
         _loc2_.selectable = this._editEnable;
         _loc2_.text = this._prevText = param1 == null?this._text:param1;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         if(this._editEnable)
         {
            _loc2_.addEventListener(Event.CHANGE,this.onTextChangeHandler);
            _loc2_.addEventListener(FocusEvent.FOCUS_IN,this.onTextFocusInHandler);
            _loc2_.addEventListener(FocusEvent.FOCUS_OUT,this.onTextFocusOutHandler);
         }
         else
         {
            _loc2_.removeEventListener(Event.CHANGE,this.onTextChangeHandler);
            _loc2_.removeEventListener(FocusEvent.FOCUS_IN,this.onTextFocusInHandler);
            _loc2_.removeEventListener(FocusEvent.FOCUS_OUT,this.onTextFocusOutHandler);
         }
         _loc2_.mouseEnabled = false;
         return _loc2_;
      }
      
      public function isTailEnable() : Boolean
      {
         return this._tailEnable;
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function get bubbleText() : String
      {
         return this.label.text;
      }
      
      public function serialize() : XML
      {
         var _loc1_:XML = null;
         if(this._text != this._backupText)
         {
            _loc1_ = <bubble x="{Util.roundNum(this._x)}" y="{Util.roundNum(this._y)}" w="{Util.roundNum(this._width)}" h="{Util.roundNum(this._height)}" rotate='0' type="{this._type}">
												<body rgb="{this._fillRgb}" alpha="{this._fillAlpha}" linergb="{this._lineRgb}" tailx="{Util.roundNum(this._tailx)}" taily="{Util.roundNum(this._taily)}"/>
												<text rgb="{this._textRgb}" font="{this._textFont}" size="{this._textSize}" align="{this._textAlign}" bold="{this._textBold}" italic="{this._textItalic}" embed="{this._textEmbed}" badword='1'>
													{UtilXmlInfo.cdata(this._text)}
												</text>
												<backupText>
													{UtilXmlInfo.cdata(this._backupText)}
												</backupText>
												<url>
													{UtilXmlInfo.cdata(this._textURL)}
												</url>
											 </bubble>;
         }
         else
         {
            _loc1_ = <bubble x="{Util.roundNum(this._x)}" y="{Util.roundNum(this._y)}" w="{Util.roundNum(this._width)}" h="{Util.roundNum(this._height)}" rotate='0' type="{this._type}">
												<body rgb="{this._fillRgb}" alpha="{this._fillAlpha}" linergb="{this._lineRgb}" tailx="{Util.roundNum(this._tailx)}" taily="{Util.roundNum(this._taily)}"/>
												<text rgb="{this._textRgb}" font="{this._textFont}" size="{this._textSize}" align="{this._textAlign}" bold="{this._textBold}" italic="{this._textItalic}" embed="{this._textEmbed}">
													{UtilXmlInfo.cdata(this._text)}
												</text>
												<url>
													{UtilXmlInfo.cdata(this._textURL)}
												</url>
											 </bubble>;
         }
         return _loc1_;
      }
      
      public function setTail(param1:Number, param2:Number) : void
      {
         this._tailx = param1;
         this._taily = param2;
         this.redraw();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      protected function set tailEnable(param1:Boolean) : void
      {
         this._tailEnable = param1;
      }
      
      public function playBubble() : void
      {
         UtilPlain.playFamily(this.content);
      }
      
      public function get bubbleObject() : Object
      {
         return {
            "font":this._textFont,
            "size":this._textSize,
            "color":this._textRgb,
            "align":this._textAlign,
            "bold":this._textBold,
            "italic":this._textItalic,
            "fillRgb":this._fillRgb,
            "embed":this._textEmbed,
            "bubble":this,
            "url":this._textURL
         };
      }
      
      protected function updateVerticalAlign() : void
      {
         var _loc1_:Number = NaN;
         if(this.label != null && (this.label.textHeight > 1 && this.label.textWidth > 1))
         {
            _loc1_ = this.myActualTextHeight(this.label);
            this.label.y = this.y + (this.height - _loc1_) / 2;
            this.label.y = this.label.y < this.y?Number(this.y):Number(this.label.y);
         }
      }
      
      override public function set x(param1:Number) : void
      {
         this._x = param1;
      }
      
      public function showEditMode() : Object
      {
         this.label.mouseEnabled = true;
         var _loc1_:Class = Class(getDefinitionByName("anifire.control.FontChooser"));
         this.label.selectable = this._editEnable = true;
         this.label.type = TextFieldType.INPUT;
         this.label.setSelection(0,this.label.text.length);
         if(stage != null)
         {
            stage.focus = this.label;
         }
         var _loc2_:Object = {
            "font":this._textFont,
            "size":this._textSize,
            "color":this._textRgb,
            "align":this._textAlign,
            "bold":this._textBold,
            "italic":this._textItalic,
            "fillRgb":this._fillRgb,
            "embed":this._textEmbed,
            "bubble":this,
            "url":this._textURL
         };
         this.label.addEventListener(FocusEvent.FOCUS_IN,this.onTextFocusInHandler);
         this.label.addEventListener(FocusEvent.FOCUS_OUT,this.onTextFocusOutHandler);
         this.label.addEventListener(Event.CHANGE,this.onTextChangeHandler);
         this.onTextFocusInHandler();
         return {
            "fontChooser":_loc1_,
            "paras":_loc2_
         };
      }
      
      protected function get tailEnable() : Boolean
      {
         return this._tailEnable;
      }
      
      public function redraw() : void
      {
      }
   }
}
