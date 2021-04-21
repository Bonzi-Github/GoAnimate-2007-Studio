package anifire.components.containers
{
   import anifire.component.DoubleStateButton;
   import anifire.core.CoreEvent;
   import anifire.core.SoundThumb;
   import anifire.core.sound.ISoundable;
   import anifire.core.sound.SoundEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   
   use namespace mx_internal;
   
   public class SoundTileCell extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const EVENT_PLAY_BUT_CLICK:String = "play_but_click";
       
      
      private var _isCanceled:Boolean = false;
      
      mx_internal var _watchers:Array;
      
      private var _sound:ISoundable;
      
      private var _572854271playPauseBut:DoubleStateButton;
      
      private var _soundThumb:SoundThumb;
      
      private var _1417497074dragSensor:HBox;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _360573147soundLabel:Label;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _embed_mxml__________styles_note_music_swf_1053227495:Class;
      
      mx_internal var _bindings:Array;
      
      private var _2017207313_soundLabelText:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SoundTileCell()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "height":30,
                  "width":295,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "id":"dragSensor",
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "middle";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":0};
                              }
                           }),new UIComponentDescriptor({
                              "type":Image,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "source":_embed_mxml__________styles_note_music_swf_1053227495,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"soundLabel",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "left";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":230,
                                    "x":28,
                                    "y":1,
                                    "buttonMode":true,
                                    "useHandCursor":true,
                                    "mouseChildren":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DoubleStateButton,
                     "id":"playPauseBut",
                     "events":{
                        "mouseOver":"__playPauseBut_mouseOver",
                        "mouseOut":"__playPauseBut_mouseOut",
                        "But1Click":"__playPauseBut_But1Click",
                        "But2Click":"__playPauseBut_But2Click"
                     },
                     "stylesFactory":function():void
                     {
                        this.left = "5";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "scaleX":0.8,
                           "scaleY":0.8,
                           "y":4,
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this._embed_mxml__________styles_note_music_swf_1053227495 = SoundTileCell__embed_mxml__________styles_note_music_swf_1053227495;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.height = 30;
         this.width = 295;
         this.buttonMode = true;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___SoundTileCell_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SoundTileCell._watcherSetupUtil = param1;
      }
      
      public function set playPauseBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._572854271playPauseBut;
         if(_loc2_ !== param1)
         {
            this._572854271playPauseBut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playPauseBut",_loc2_,param1));
         }
      }
      
      public function get soundThumb() : SoundThumb
      {
         return this._soundThumb;
      }
      
      public function getHitArea() : UIComponent
      {
         return this.dragSensor;
      }
      
      public function set soundThumb(param1:SoundThumb) : void
      {
         this._soundThumb = param1;
      }
      
      public function get sound() : ISoundable
      {
         return this._sound;
      }
      
      override public function initialize() : void
      {
         var target:SoundTileCell = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SoundTileCell_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_SoundTileCellWatcherSetupUtil");
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
      private function get _soundLabelText() : String
      {
         return this._2017207313_soundLabelText;
      }
      
      public function hideButton() : void
      {
         this.playPauseBut.enabled = false;
         this.playPauseBut.visible = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get dragSensor() : HBox
      {
         return this._1417497074dragSensor;
      }
      
      public function __playPauseBut_But1Click(param1:Event) : void
      {
         this.onPlayButClick(param1);
      }
      
      private function mouseOutSoundBtnHandler() : void
      {
         this.dispatchEvent(new Event("mouseOutSoundBtnEvent"));
      }
      
      public function set dragSensor(param1:HBox) : void
      {
         var _loc2_:Object = this._1417497074dragSensor;
         if(_loc2_ !== param1)
         {
            this._1417497074dragSensor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dragSensor",_loc2_,param1));
         }
      }
      
      private function onSoundPlayComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundPlayComplete);
         if(this.playPauseBut != null)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT1);
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.PLAY_SOUND_COMPLETE,this));
      }
      
      public function set sound(param1:ISoundable) : void
      {
         this._sound = param1;
      }
      
      private function set _soundLabelText(param1:String) : void
      {
         var _loc2_:Object = this._2017207313_soundLabelText;
         if(_loc2_ !== param1)
         {
            this._2017207313_soundLabelText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundLabelText",_loc2_,param1));
         }
      }
      
      public function stopSound() : void
      {
         if(this.soundThumb != null && this.soundThumb.isLoading)
         {
            this._isCanceled = true;
         }
         if(this.sound != null)
         {
            this.sound.stop();
            if(this.playPauseBut != null)
            {
               this.playPauseBut.setState(DoubleStateButton.STATE_BUT1);
            }
         }
      }
      
      private function doResize(param1:Event) : void
      {
         if(this.parent != null)
         {
            if(this.parent.width > 0)
            {
               this.width = this.parent.width;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundLabel() : Label
      {
         return this._360573147soundLabel;
      }
      
      public function __playPauseBut_But2Click(param1:Event) : void
      {
         this.onPauseButClick(param1);
      }
      
      private function _SoundTileCell_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._soundLabelText;
      }
      
      public function __playPauseBut_mouseOver(param1:MouseEvent) : void
      {
         this.mouseOverSoundBtnHandler();
      }
      
      public function playSound(... rest) : void
      {
         if(this._isCanceled)
         {
            this._isCanceled = false;
         }
         else
         {
            this.stopSound();
            if(this.sound != null)
            {
               if(this.playPauseBut != null)
               {
                  this.playPauseBut.setState(DoubleStateButton.STATE_BUT2);
               }
               this.sound.addEventListener(SoundEvent.PLAY_COMPLETE,this.onSoundPlayComplete);
               this.sound.play();
            }
         }
      }
      
      private function doUpdateSoundObj(param1:Event) : void
      {
         this.sound = this.soundThumb.sound;
      }
      
      public function ___SoundTileCell_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler(param1);
      }
      
      public function __playPauseBut_mouseOut(param1:MouseEvent) : void
      {
         this.mouseOutSoundBtnHandler();
      }
      
      private function _SoundTileCell_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._soundLabelText;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            soundLabel.text = param1;
         },"soundLabel.text");
         result[0] = binding;
         return result;
      }
      
      public function set tileLabel(param1:String) : void
      {
         this._soundLabelText = param1 + (!!this.soundThumb?" (" + this.soundThumb.duration / 1000 + " secs)":"");
      }
      
      public function set soundLabel(param1:Label) : void
      {
         var _loc2_:Object = this._360573147soundLabel;
         if(_loc2_ !== param1)
         {
            this._360573147soundLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundLabel",_loc2_,param1));
         }
      }
      
      private function onPlayButClick(param1:Event) : void
      {
         this.playSound();
         this.dispatchEvent(new Event(SoundTileCell.EVENT_PLAY_BUT_CLICK));
      }
      
      public function clone() : SoundTileCell
      {
         var _loc1_:SoundTileCell = new SoundTileCell();
         _loc1_.soundThumb = this.soundThumb;
         _loc1_.tileLabel = this.tileLabel;
         _loc1_.sound = this.sound;
         _loc1_.addEventListener(SoundTileCell.EVENT_PLAY_BUT_CLICK,_loc1_.soundThumb.onTilePlayButClick);
         _loc1_.soundThumb.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,_loc1_.doUpdateSoundObj);
         return _loc1_;
      }
      
      public function get tileLabel() : String
      {
         return this._soundLabelText;
      }
      
      private function mouseOverSoundBtnHandler() : void
      {
         this.dispatchEvent(new Event("mouseOverSoundBtnEvent"));
      }
      
      private function creationCompleteHandler(param1:Event) : void
      {
         this.doResize(null);
         this.addEventListener(FlexEvent.ADD,this.doResize);
         this.addEventListener(ResizeEvent.RESIZE,this.doResize);
         if(this.parent != null)
         {
            this.parent.addEventListener(ResizeEvent.RESIZE,this.doResize);
         }
      }
      
      private function onPauseButClick(param1:Event) : void
      {
         this.stopSound();
      }
      
      [Bindable(event="propertyChange")]
      public function get playPauseBut() : DoubleStateButton
      {
         return this._572854271playPauseBut;
      }
   }
}
