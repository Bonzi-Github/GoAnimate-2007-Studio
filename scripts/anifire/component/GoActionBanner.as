package anifire.component
{
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class GoActionBanner extends Canvas implements IBindingClient
   {
      
      mx_internal static var _GoActionBanner_StylesInit_done:Boolean = false;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1282133823fadeIn:Fade;
      
      private var _1312128075_banner:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _94436_bg:Image;
      
      public var _GoActionBanner_Button1:Button;
      
      private var _91078603_mask:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _xml:XML;
      
      private var _1290634255_actionNum:Label;
      
      mx_internal var _bindings:Array;
      
      private var _840813987_packName:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function GoActionBanner()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_banner",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "mouseChildren":false,
                        "buttonMode":true,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_mask"
                        }),new UIComponentDescriptor({
                           "type":Image,
                           "id":"_bg",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_packName",
                           "stylesFactory":function():void
                           {
                              this.right = "5";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                              this.color = 16777215;
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_actionNum",
                           "stylesFactory":function():void
                           {
                              this.top = "20";
                              this.right = "5";
                              this.fontSize = 12;
                              this.color = 16777215;
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoActionBanner_Button1",
                           "stylesFactory":function():void
                           {
                              this.top = "65";
                              this.right = "5";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnAddAction"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         mx_internal::_GoActionBanner_StylesInit();
         this._GoActionBanner_Fade1_i();
         this.addEventListener("creationComplete",this.___GoActionBanner_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         GoActionBanner._watcherSetupUtil = param1;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:GoActionBanner = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._GoActionBanner_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_GoActionBannerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      private function init() : void
      {
      }
      
      private function loadActionPacksXml(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onXmlLoaded);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadXmlFail);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadXmlFail);
         _loc2_.load(UtilNetwork.getActionPacksRequest(param1));
      }
      
      public function ___GoActionBanner_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set _banner(param1:Canvas) : void
      {
         var _loc2_:Object = this._1312128075_banner;
         if(_loc2_ !== param1)
         {
            this._1312128075_banner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_banner",_loc2_,param1));
         }
      }
      
      private function _GoActionBanner_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return fadeIn;
         },function(param1:*):void
         {
            _banner.setStyle("showEffect",param1);
         },"_banner.showEffect");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add more actions");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _GoActionBanner_Button1.label = param1;
         },"_GoActionBanner_Button1.label");
         result[1] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _packName() : Label
      {
         return this._840813987_packName;
      }
      
      public function set _mask(param1:Canvas) : void
      {
         var _loc2_:Object = this._91078603_mask;
         if(_loc2_ !== param1)
         {
            this._91078603_mask = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mask",_loc2_,param1));
         }
      }
      
      private function onLoadXmlFail(param1:Event) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set _bg(param1:Image) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      private function _GoActionBanner_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeIn = _loc1_;
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _mask() : Canvas
      {
         return this._91078603_mask;
      }
      
      public function set _packName(param1:Label) : void
      {
         var _loc2_:Object = this._840813987_packName;
         if(_loc2_ !== param1)
         {
            this._840813987_packName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_packName",_loc2_,param1));
         }
      }
      
      private function _GoActionBanner_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.fadeIn;
         _loc1_ = UtilDict.toDisplay("go","Add more actions");
      }
      
      [Bindable(event="propertyChange")]
      public function get _banner() : Canvas
      {
         return this._1312128075_banner;
      }
      
      public function refresh(param1:String) : void
      {
         this._banner.includeInLayout = this._banner.visible = false;
         this.loadActionPacksXml(param1);
      }
      
      private function onXmlLoaded(param1:Event) : void
      {
         var packs:XMLList = null;
         var myPack:XML = null;
         var url:String = null;
         var regularExp:RegExp = null;
         var e:Event = param1;
         var checkCode:String = String(e.target.data).charAt();
         if(checkCode == "0")
         {
            this._xml = new XML(String(e.target.data).substring(1));
            packs = this._xml.pack.(@sold == "0");
            if(packs.length() > 0)
            {
               myPack = packs[UtilPlain.randomNumberRange(0,packs.length() - 1)];
               url = myPack.image;
               regularExp = /.jpg/g;
               url = url.replace(regularExp,"_studio.jpg");
               this._bg.source = url;
               this._packName.text = myPack.title;
               this._actionNum.text = "x" + myPack..action.length() + " " + UtilDict.toDisplay("go","Actions");
               this._banner.includeInLayout = this._banner.visible = true;
            }
         }
      }
      
      public function set _actionNum(param1:Label) : void
      {
         var _loc2_:Object = this._1290634255_actionNum;
         if(_loc2_ !== param1)
         {
            this._1290634255_actionNum = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_actionNum",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Image
      {
         return this._94436_bg;
      }
      
      mx_internal function _GoActionBanner_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_GoActionBanner_StylesInit_done)
         {
            return;
         }
         mx_internal::_GoActionBanner_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".btnAddAction");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".btnAddAction",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 13395456;
               this.color = 16777215;
               this.cornerRadius = 5;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 15;
               this.fillColors = [16737792,16737792,16737792,16737792];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 16737792;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _actionNum() : Label
      {
         return this._1290634255_actionNum;
      }
   }
}
