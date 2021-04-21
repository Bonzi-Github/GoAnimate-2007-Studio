package anifire.components.containers
{
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.EffectThumb;
   import anifire.effect.EffectMgr;
   import anifire.effect.ZoomEffect;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flexlib.controls.HSlider;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   
   use namespace mx_internal;
   
   public class AssetTiming extends Canvas implements IBindingClient
   {
      
      public static var TYPE_ZOOM:String = "ZOOM";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _sliderStEd:HSlider;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _690965708_sliderStEd4:HSlider;
      
      private var _edtime:Number;
      
      private var _edzoom:Number = 0.5;
      
      private var _type:String = "";
      
      private var _992259101_lblEdTime:Label;
      
      private var _isPublished:Boolean;
      
      private var _992074519_lblEdZoom:Label;
      
      private var _thumbnailCanvas:ThumbnailCanvas;
      
      private var _54900241_sliderStEdGx:Canvas;
      
      private var _zMode:Boolean = false;
      
      private const MIN_INT:Number = 0;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _secondThumbId:int;
      
      private var _mode:String = "";
      
      private var _1087376665_assetTitle:String;
      
      private var _576490069_lblStZoom:Label;
      
      private var _durscene:Number;
      
      private var MIN_DIST:Number;
      
      public var INFO_MODE:String = "info_mode";
      
      mx_internal var _watchers:Array;
      
      private var _690965710_sliderStEd2:HSlider;
      
      private var _firstThumbId:int;
      
      private const _trHeight:Number = 25;
      
      public var LEN_MODE:String = "length_mode";
      
      private var _1355027053_actionList:Array;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _sttime:Number;
      
      private var _stzoom:Number = 0.5;
      
      private var _576674651_lblStTime:Label;
      
      private var _assetId:String;
      
      mx_internal var _bindings:Array;
      
      private var _2060497896subtitle:Label;
      
      private var _91286776_tags:String;
      
      public function AssetTiming()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":80,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"subtitle"
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "clipContent":false,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_sliderStEdGx",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"mouseEnabled":false};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HSlider,
                                    "id":"_sliderStEd2",
                                    "events":{
                                       "creationComplete":"___sliderStEd2_creationComplete",
                                       "thumbDrag":"___sliderStEd2_thumbDrag"
                                    },
                                    "stylesFactory":function():void
                                    {
                                       this.dataTipPlacement = "top";
                                       this.dataTipOffset = 3;
                                       this.showTrackHighlight = false;
                                       this.thumbOffset = -60;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":10,
                                          "allowTrackClick":false,
                                          "allowThumbOverlap":false,
                                          "liveDragging":true,
                                          "showDataTip":false,
                                          "thumbCount":2,
                                          "width":240,
                                          "snapInterval":0.1,
                                          "doubleClickEnabled":false,
                                          "lockRegionsWhileDragging":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HSlider,
                                    "id":"_sliderStEd4",
                                    "events":{
                                       "creationComplete":"___sliderStEd4_creationComplete",
                                       "thumbDrag":"___sliderStEd4_thumbDrag"
                                    },
                                    "stylesFactory":function():void
                                    {
                                       this.dataTipPlacement = "top";
                                       this.dataTipOffset = 3;
                                       this.showTrackHighlight = false;
                                       this.thumbOffset = -60;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":10,
                                          "allowTrackClick":false,
                                          "allowThumbOverlap":true,
                                          "liveDragging":true,
                                          "showDataTip":false,
                                          "thumbCount":4,
                                          "width":240,
                                          "snapInterval":0.1,
                                          "doubleClickEnabled":false,
                                          "lockRegionsWhileDragging":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_lblStTime",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":""};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_lblStZoom",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":""};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_lblEdTime",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":""};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_lblEdZoom",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":""};
                                    }
                                 })]
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
         this.styleName = "popupWindow";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___AssetTiming_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AssetTiming._watcherSetupUtil = param1;
      }
      
      public function flipVertical(param1:DisplayObject) : void
      {
         var _loc2_:Matrix = param1.transform.matrix;
         _loc2_.d = -1;
         _loc2_.ty = param1.height + param1.y;
         param1.transform.matrix = _loc2_;
      }
      
      public function ___sliderStEd4_creationComplete(param1:FlexEvent) : void
      {
         this.initSlider(param1);
      }
      
      private function init() : void
      {
      }
      
      private function initSlider(param1:FlexEvent) : void
      {
      }
      
      private function valueToPixel(param1:Number) : Number
      {
         return param1 * (this._sliderStEd.width - this._sliderStEd.getThumbAt(0).width) / this._sliderStEd.maximum;
      }
      
      [Bindable(event="propertyChange")]
      public function get subtitle() : Label
      {
         return this._2060497896subtitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEdGx() : Canvas
      {
         return this._54900241_sliderStEdGx;
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:BubbleAsset = null;
         var _loc3_:EffectAsset = null;
         var _loc4_:Boolean = false;
         if(param1 is BubbleAsset)
         {
            _loc2_ = BubbleAsset(param1);
            this.type = _loc2_.bubble.type;
            this.durscene = _loc2_.scene.getLength();
            this.assetId = _loc2_.id;
            this.sttime = _loc2_.sttime;
            this.edtime = _loc2_.edtime;
            this.subtitle.text = UtilDict.toDisplay("go","Control when your speech bubble appears");
            this.subtitle.setStyle("fontSize","12");
         }
         else if(param1 is EffectAsset)
         {
            _loc3_ = EffectAsset(param1);
            _loc4_ = _loc3_.effect is ZoomEffect && (ZoomEffect(_loc3_.effect).isPan || ZoomEffect(_loc3_.effect).isCut);
            this.type = !!_loc4_?"Cut/Pan":_loc3_.effect.type;
            this.durscene = _loc3_.scene.getLength();
            this.assetId = _loc3_.id;
            this.sttime = _loc3_.sttime;
            this.edtime = _loc3_.edtime;
            if((_loc3_.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase() && !_loc4_)
            {
               this.stzoom = _loc3_.stzoom;
               this.edzoom = _loc3_.edzoom;
            }
            this.updateZoomDurGx();
         }
      }
      
      public function get assetId() : String
      {
         return this._assetId;
      }
      
      private function set _actionList(param1:Array) : void
      {
         var _loc2_:Object = this._1355027053_actionList;
         if(_loc2_ !== param1)
         {
            this._1355027053_actionList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_actionList",_loc2_,param1));
         }
      }
      
      public function set subtitle(param1:Label) : void
      {
         var _loc2_:Object = this._2060497896subtitle;
         if(_loc2_ !== param1)
         {
            this._2060497896subtitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"subtitle",_loc2_,param1));
         }
      }
      
      public function set _sliderStEdGx(param1:Canvas) : void
      {
         var _loc2_:Object = this._54900241_sliderStEdGx;
         if(_loc2_ !== param1)
         {
            this._54900241_sliderStEdGx = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEdGx",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEd2() : HSlider
      {
         return this._690965710_sliderStEd2;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEd4() : HSlider
      {
         return this._690965708_sliderStEd4;
      }
      
      public function ___sliderStEd2_thumbDrag(param1:SliderEvent) : void
      {
         this.onSliding(param1);
      }
      
      private function onSliding(param1:SliderEvent) : void
      {
         if(this._zMode)
         {
            switch(param1.thumbIndex)
            {
               case this._firstThumbId:
                  if(this._sliderStEd.values[this._firstThumbId] > this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._firstThumbId).x;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._firstThumbId];
                  }
                  if(this._sliderStEd.values[this._firstThumbId] + this.MIN_INT > this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                  }
                  break;
               case this._firstThumbId + 1:
                  if(this._sliderStEd.values[this._firstThumbId + 1] < this._sliderStEd.values[this._firstThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x;
                     this._sliderStEd.values[this._firstThumbId] = this._sliderStEd.values[this._firstThumbId + 1];
                  }
                  if(this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT > this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                  }
                  if(this._sliderStEd.values[this._firstThumbId + 1] > this._sliderStEd.values[this._secondThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._secondThumbId + 1).x;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._secondThumbId + 1];
                  }
                  break;
               case this._secondThumbId:
                  if(this._sliderStEd.values[this._secondThumbId] - this.MIN_INT < this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                  }
                  if(this._sliderStEd.values[this._secondThumbId] > this._sliderStEd.values[this._secondThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x;
                     this._sliderStEd.values[this._secondThumbId + 1] = this._sliderStEd.values[this._secondThumbId];
                  }
                  if(this._sliderStEd.values[this._secondThumbId] < this._sliderStEd.values[this._firstThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId).x;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._firstThumbId];
                  }
                  break;
               case this._secondThumbId + 1:
                  if(this._sliderStEd.values[this._secondThumbId + 1] < this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._secondThumbId + 1).x;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._secondThumbId + 1];
                  }
                  if(this._sliderStEd.values[this._secondThumbId + 1] - this.MIN_INT < this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                     this._sliderStEd.getThumbAt(this._secondThumbId + 1).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId + 1] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                  }
            }
         }
         this.updateZoomDurGx();
         this.updateAsset(null);
      }
      
      public function set durscene(param1:Number) : void
      {
         var _loc2_:Number = Math.round(UtilUnitConvert.frameToSec(param1) * 10) / 10;
         this._durscene = _loc2_;
         this._sliderStEd.minimum = 0;
         this._sliderStEd.maximum = _loc2_;
         this._lblStTime.text = "0 s";
         this._lblEdTime.text = Util.roundNum(_loc2_) + " s";
         this.MIN_DIST = this.secToWidth(this.MIN_INT);
      }
      
      public function set sttime(param1:Number) : void
      {
         if(param1 < 0 || param1 > this._sliderStEd.maximum)
         {
            this._sttime = 0;
         }
         else
         {
            this._sttime = param1;
         }
         this._sliderStEd.values[this._firstThumbId] = this._sttime;
         if(this._zMode)
         {
            if(this._sttime + 0.5 > this._sliderStEd.maximum - this.MIN_INT)
            {
               this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + this.MIN_INT;
            }
            else
            {
               this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + 0.5;
            }
         }
         this.updateZoomDurGx();
      }
      
      public function set assetId(param1:String) : void
      {
         this._assetId = param1;
      }
      
      public function ___AssetTiming_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set _sliderStEd2(param1:HSlider) : void
      {
         var _loc2_:Object = this._690965710_sliderStEd2;
         if(_loc2_ !== param1)
         {
            this._690965710_sliderStEd2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEd2",_loc2_,param1));
         }
      }
      
      public function set _lblStZoom(param1:Label) : void
      {
         var _loc2_:Object = this._576490069_lblStZoom;
         if(_loc2_ !== param1)
         {
            this._576490069_lblStZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblStZoom",_loc2_,param1));
         }
      }
      
      public function set stzoom(param1:Number) : void
      {
         if(this._zMode)
         {
            if(this._sttime + param1 > this._sliderStEd.values[this._secondThumbId])
            {
               if(this._sliderStEd.values[this._secondThumbId] - this._sttime <= 0.5)
               {
                  this._stzoom = this._sliderStEd.values[this._secondThumbId] - this._sttime - this.MIN_INT;
               }
               else
               {
                  this._stzoom = this._sliderStEd.values[this._secondThumbId] - this._sttime - 0.5;
               }
            }
            else
            {
               this._stzoom = param1;
            }
            this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + this._stzoom;
            this.updateZoomDurGx();
         }
      }
      
      public function set _lblStTime(param1:Label) : void
      {
         var _loc2_:Object = this._576674651_lblStTime;
         if(_loc2_ !== param1)
         {
            this._576674651_lblStTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblStTime",_loc2_,param1));
         }
      }
      
      public function set _sliderStEd4(param1:HSlider) : void
      {
         var _loc2_:Object = this._690965708_sliderStEd4;
         if(_loc2_ !== param1)
         {
            this._690965708_sliderStEd4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEd4",_loc2_,param1));
         }
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
         this._sliderStEd2.visible = this._sliderStEd4.visible = false;
         if(this.type == TYPE_ZOOM)
         {
            this._sliderStEd4.visible = true;
            this._sliderStEd = this._sliderStEd4;
            this._sliderStEd.thumbCount = 4;
            this._firstThumbId = 0;
            this._secondThumbId = 2;
            this._zMode = true;
            this._lblStZoom.visible = this._lblEdZoom.visible = true;
            this._lblStTime.y = this._lblEdZoom.y = this._trHeight + this._sliderStEd.y;
            this._lblStZoom.y = this._lblEdTime.y = this._trHeight + this._sliderStEd.y - 14;
            this._sliderStEd.getThumbAt(0).buttonMode = true;
            this._sliderStEd.getThumbAt(1).buttonMode = true;
            this._sliderStEd.getThumbAt(2).buttonMode = true;
            this._sliderStEd.getThumbAt(3).buttonMode = true;
            this.flipVertical(this._sliderStEd.getThumbAt(1));
            this.flipVertical(this._sliderStEd.getThumbAt(2));
            this.subtitle.text = UtilDict.toDisplay("go","assetinfo_editzoomsubtitle");
            this.subtitle.setStyle("fontSize","11");
         }
         else
         {
            this._sliderStEd2.visible = true;
            this._sliderStEd = this._sliderStEd2;
            this._sliderStEd.thumbCount = 2;
            this._firstThumbId = 0;
            this._secondThumbId = 1;
            this._zMode = false;
            this._lblStZoom.visible = this._lblEdZoom.visible = false;
            this._lblStTime.y = this._lblEdTime.y = this._trHeight + this._sliderStEd.y;
            this._sliderStEd.getThumbAt(0).buttonMode = true;
            this._sliderStEd.getThumbAt(1).buttonMode = true;
            this.flipVertical(this._sliderStEd.getThumbAt(0));
            this.flipVertical(this._sliderStEd.getThumbAt(1));
            this.subtitle.text = UtilDict.toDisplay("go","Control when your effect appears");
            this.subtitle.setStyle("fontSize","12");
         }
      }
      
      private function secToWidth(param1:Number) : Number
      {
         return param1 / (this._sliderStEd.maximum / (this._sliderStEd.width - this._sliderStEd.getThumbAt(0).width));
      }
      
      override public function initialize() : void
      {
         var target:AssetTiming = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._AssetTiming_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetTimingWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      private function get _actionList() : Array
      {
         return this._1355027053_actionList;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblStTime() : Label
      {
         return this._576674651_lblStTime;
      }
      
      private function updateAsset(param1:Event) : void
      {
         if(!this._zMode)
         {
            Console.getConsole().updateAssetTime(this._assetId,this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId]);
         }
         else
         {
            Console.getConsole().updateAssetTime(this._assetId,this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId],this._sliderStEd.values[this._firstThumbId + 1] - this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId + 1] - this._sliderStEd.values[this._secondThumbId]);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblStZoom() : Label
      {
         return this._576490069_lblStZoom;
      }
      
      public function ___sliderStEd4_thumbDrag(param1:SliderEvent) : void
      {
         this.onSliding(param1);
      }
      
      public function ___sliderStEd2_creationComplete(param1:FlexEvent) : void
      {
         this.initSlider(param1);
      }
      
      public function set _lblEdTime(param1:Label) : void
      {
         var _loc2_:Object = this._992259101_lblEdTime;
         if(_loc2_ !== param1)
         {
            this._992259101_lblEdTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblEdTime",_loc2_,param1));
         }
      }
      
      private function _AssetTiming_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_editassetsubtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            subtitle.text = param1;
         },"subtitle.text");
         result[0] = binding;
         return result;
      }
      
      private function set _assetTitle(param1:String) : void
      {
         var _loc2_:Object = this._1087376665_assetTitle;
         if(_loc2_ !== param1)
         {
            this._1087376665_assetTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTitle",_loc2_,param1));
         }
      }
      
      public function set _lblEdZoom(param1:Label) : void
      {
         var _loc2_:Object = this._992074519_lblEdZoom;
         if(_loc2_ !== param1)
         {
            this._992074519_lblEdZoom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblEdZoom",_loc2_,param1));
         }
      }
      
      private function _AssetTiming_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","assetinfo_editassetsubtitle");
      }
      
      public function set edtime(param1:Number) : void
      {
         if(param1 < 0 || param1 > this._sliderStEd.maximum)
         {
            this._edtime = this._sliderStEd.maximum;
         }
         else
         {
            this._edtime = param1;
         }
         this._sliderStEd.values[this._secondThumbId] = this._edtime;
         if(this._zMode)
         {
            this._sliderStEd.values[this._secondThumbId + 1] = this._edtime;
         }
         this.updateZoomDurGx();
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblEdTime() : Label
      {
         return this._992259101_lblEdTime;
      }
      
      [Bindable(event="propertyChange")]
      private function get _assetTitle() : String
      {
         return this._1087376665_assetTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblEdZoom() : Label
      {
         return this._992074519_lblEdZoom;
      }
      
      public function set edzoom(param1:Number) : void
      {
         if(this._zMode)
         {
            if(this._edtime + param1 > this._durscene)
            {
               this._edzoom = this._durscene - this._edtime;
            }
            else
            {
               this._edzoom = param1;
            }
            this._sliderStEd.values[this._secondThumbId + 1] = this._edtime + this._edzoom;
            this.updateZoomDurGx();
         }
      }
      
      private function set _tags(param1:String) : void
      {
         var _loc2_:Object = this._91286776_tags;
         if(_loc2_ !== param1)
         {
            this._91286776_tags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tags",_loc2_,param1));
         }
      }
      
      private function updateZoomDurGx(param1:FlexEvent = null) : void
      {
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc2_:Number = this._sliderStEd.getThumbAt(this._firstThumbId).y;
         var _loc3_:Number = this._sliderStEd.getThumbAt(this._firstThumbId).width / 2;
         var _loc4_:Point = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._firstThumbId])) + _loc3_,_loc2_);
         var _loc5_:Point = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._secondThumbId])) + _loc3_,_loc2_);
         if(this._zMode)
         {
            _loc9_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._firstThumbId + 1])) + _loc3_,_loc2_);
            _loc10_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._secondThumbId + 1])) + _loc3_,_loc2_);
         }
         var _loc6_:Number = this._trHeight;
         var _loc7_:Number = 6;
         var _loc8_:Number = 0;
         this._sliderStEdGx.graphics.clear();
         this._sliderStEdGx.graphics.beginFill(16777215);
         this._sliderStEdGx.graphics.lineStyle(2,16226585,1);
         this._sliderStEdGx.graphics.drawRect(this._sliderStEd.x + _loc7_,this._sliderStEd.y,this._sliderStEd.width - _loc7_ * 2,_loc6_);
         this._sliderStEdGx.graphics.beginFill(16226585);
         this._sliderStEdGx.graphics.lineStyle(0,0,0);
         if(this._zMode)
         {
            this._sliderStEdGx.graphics.moveTo(_loc4_.x,this._sliderStEd.y + _loc6_);
            this._sliderStEdGx.graphics.lineTo(_loc9_.x,this._sliderStEd.y);
            this._sliderStEdGx.graphics.lineTo(_loc9_.x,this._sliderStEd.y + _loc6_);
            this._sliderStEdGx.graphics.lineTo(_loc4_.x,this._sliderStEd.y + _loc6_);
            this._sliderStEdGx.graphics.drawRect(_loc9_.x,this._sliderStEd.y,_loc5_.x - _loc9_.x,_loc6_);
            this._sliderStEdGx.graphics.moveTo(_loc5_.x,this._sliderStEd.y);
            this._sliderStEdGx.graphics.lineTo(_loc10_.x,this._sliderStEd.y + _loc6_);
            this._sliderStEdGx.graphics.lineTo(_loc5_.x,this._sliderStEd.y + _loc6_);
            this._sliderStEdGx.graphics.lineTo(_loc5_.x,this._sliderStEd.y);
            this._sliderStEdGx.graphics.lineStyle(2,16226585,1);
            UtilDraw.dashTo(this._sliderStEdGx,new Point(_loc4_.x,this._sliderStEd.y),new Point(_loc4_.x,this._sliderStEd.y + _loc6_));
            UtilDraw.dashTo(this._sliderStEdGx,new Point(_loc10_.x,this._sliderStEd.y),new Point(_loc10_.x,_loc6_ + this._sliderStEd.y));
         }
         else
         {
            this._sliderStEdGx.graphics.drawRect(_loc4_.x,this._sliderStEd.y,_loc5_.x - _loc4_.x,_loc6_);
         }
         this._sliderStEdGx.graphics.endFill();
         this._lblStTime.text = Util.roundNum(this._sliderStEd.values[this._firstThumbId]) + " s";
         this._lblEdTime.text = Util.roundNum(this._sliderStEd.values[this._secondThumbId]) + " s";
         this._lblStTime.x = _loc4_.x - this._lblStTime.width / 2;
         this._lblEdTime.x = _loc5_.x - this._lblEdTime.width / 2;
         if(this._zMode)
         {
            this._lblStZoom.text = Util.roundNum(this._sliderStEd.values[this._firstThumbId + 1]) + " s";
            this._lblEdZoom.text = Util.roundNum(this._sliderStEd.values[this._secondThumbId + 1]) + " s";
            this._lblStZoom.x = _loc9_.x - this._lblStZoom.width / 2;
            this._lblEdZoom.x = _loc10_.x - this._lblEdZoom.width / 2;
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _tags() : String
      {
         return this._91286776_tags;
      }
   }
}
