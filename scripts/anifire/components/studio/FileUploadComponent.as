package anifire.components.studio
{
   import anifire.command.AddSpeechCommand;
   import anifire.component.UploadHelper;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.SoundThumb;
   import anifire.core.SpeechData;
   import anifire.core.sound.SoundEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUnitConvert;
   import flash.errors.IOError;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class FileUploadComponent extends Canvas implements IBindingClient
   {
      
      private static var FILTER_FLVMOVIE:FileFilter;
      
      private static var FILTER_FLASH:FileFilter;
      
      private static var FILTER_SOUND:FileFilter;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static var FILTER_IMAGE:FileFilter;
      
      private static var MAX_FILE_SIZE:Number = 4 * 1024 * 1024;
       
      
      mx_internal var _watchers:Array;
      
      private var _isActionSelected:Boolean;
      
      private var _1077796736_sizeRemark:Label;
      
      private var _filter:FileFilter;
      
      private var _1383868793_btnBrowse:Button;
      
      private var _1479285453_txtFile:TextArea;
      
      private var _910560372_progress:Canvas;
      
      private var _bottom:SpeechComponent;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _file:FileReference;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _isZoomSelected:Boolean;
      
      public function FileUploadComponent()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 4473924;
                     this.paddingLeft = 10;
                     this.paddingRight = 10;
                     this.paddingTop = 10;
                     this.paddingBottom = 10;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Canvas,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":TextArea,
                                       "id":"_txtFile",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 2500134;
                                          this.fontSize = 16;
                                          this.backgroundColor = 16777215;
                                          this.borderColor = 13421772;
                                          this.backgroundAlpha = 1;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "height":28,
                                             "maxChars":140,
                                             "wordWrap":true,
                                             "editable":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_progress"
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnBrowse",
                                 "events":{"click":"___btnBrowse_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "buttonMode":true,
                                       "styleName":"btnSidePanel"
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_sizeRemark",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 16;
                              this.color = 16777215;
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._filter = FILTER_IMAGE;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         FileUploadComponent._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _sizeRemark() : Label
      {
         return this._1077796736_sizeRemark;
      }
      
      public function upload() : void
      {
         var request:URLRequest = null;
         var variables:URLVariables = null;
         var fileUploadHelper:UploadHelper = null;
         if(this._file)
         {
            request = new URLRequest(ServerConstants.ACTION_SAVE_SOUND);
            variables = new URLVariables();
            Util.addFlashVarsToURLvar(variables);
            variables["title"] = this._file.name;
            variables["keywords"] = "voice";
            variables["subtype"] = AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER;
            variables["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            variables["is_published"] = "0";
            request.data = variables;
            request.method = URLRequestMethod.POST;
            try
            {
               fileUploadHelper = new UploadHelper();
               fileUploadHelper.init(this._file,request);
               fileUploadHelper.addEventListener(ProgressEvent.PROGRESS,this.onUploadProgress);
               fileUploadHelper.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this._bottom.onSentCompleteHandler);
               fileUploadHelper.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,function():void
               {
                  _progress.graphics.clear();
               });
               fileUploadHelper.addEventListener(IOErrorEvent.IO_ERROR,this.error);
               fileUploadHelper.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.error);
               fileUploadHelper.upload();
            }
            catch(e:Error)
            {
               return;
            }
         }
         else
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBrowse() : Button
      {
         return this._1383868793_btnBrowse;
      }
      
      private function error(param1:Event) : void
      {
         this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         this.setButtonStatus(true);
      }
      
      private function browse() : void
      {
         if(this._file == null)
         {
            this._file = new FileReference();
            this._file.addEventListener(Event.CANCEL,this.onCancel);
            this._file.addEventListener(Event.SELECT,this.onSelect);
         }
         try
         {
            this._file.browse([this._filter]);
         }
         catch(e:IOError)
         {
            throw new Error("IOError:" + e.getStackTrace());
         }
         catch(e:Error)
         {
            throw new Error("error: " + e.getStackTrace());
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _progress() : Canvas
      {
         return this._910560372_progress;
      }
      
      private function onUploadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         this._progress.graphics.clear();
         this._progress.graphics.beginFill(0,0.2);
         this._progress.graphics.drawRect(0,0,_loc2_ * this._progress.width,this._progress.height);
         this._progress.graphics.endFill();
      }
      
      public function set _btnBrowse(param1:Button) : void
      {
         var _loc2_:Object = this._1383868793_btnBrowse;
         if(_loc2_ !== param1)
         {
            this._1383868793_btnBrowse = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBrowse",_loc2_,param1));
         }
      }
      
      public function set _sizeRemark(param1:Label) : void
      {
         var _loc2_:Object = this._1077796736_sizeRemark;
         if(_loc2_ !== param1)
         {
            this._1077796736_sizeRemark = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sizeRemark",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:FileUploadComponent = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._FileUploadComponent_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_FileUploadComponentWatcherSetupUtil");
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
      
      public function saveSound(param1:ByteArray, param2:XML) : void
      {
         var _loc3_:SoundThumb = Console.getConsole().speechManager.createSoundThumbByByte(param1,param2);
         this.saveSoundBySoundThumb(_loc3_);
      }
      
      public function init(param1:SpeechComponent = null) : void
      {
         FILTER_FLVMOVIE = new FileFilter(UtilDict.toDisplay("go","Video File(*.3g2;*.3gp;*.asf;*.asx;*.avi;*.flv;*.mov;*.mp4;*.mpg;*.mpeg;*.ogg;*.rm;*.wmv)"),"*.3g2;*.3gp;*.asf;*.asx;*.avi;*.flv;*.mov;*.mp4;*.mpg;*.mpeg;*.ogg;*.rm;*.wmv");
         FILTER_FLASH = new FileFilter(UtilDict.toDisplay("go","Flash File(*.swf)"),"*.swf");
         FILTER_IMAGE = new FileFilter(UtilDict.toDisplay("go","Image File(*.jpg;*.jpeg;*.gif;*.png)"),"*.jpg;*.jpeg;*.gif;*.png");
         FILTER_SOUND = new FileFilter(UtilDict.toDisplay("go","Sound File(*.mp3;*.wav;*.m4a)"),"*.mp3;*.wav;*.m4a");
         if(param1)
         {
            this._bottom = param1;
         }
      }
      
      private function _FileUploadComponent_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.width - this._btnBrowse.width - 30;
         _loc1_ = this._txtFile.x;
         _loc1_ = this._txtFile.y;
         _loc1_ = this._txtFile.width;
         _loc1_ = this._txtFile.height;
         _loc1_ = UtilDict.toDisplay("go","Browse");
         _loc1_ = UtilDict.toDisplay("go","Max. size 4MB");
      }
      
      public function set _progress(param1:Canvas) : void
      {
         var _loc2_:Object = this._910560372_progress;
         if(_loc2_ !== param1)
         {
            this._910560372_progress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_progress",_loc2_,param1));
         }
      }
      
      public function set _txtFile(param1:TextArea) : void
      {
         var _loc2_:Object = this._1479285453_txtFile;
         if(_loc2_ !== param1)
         {
            this._1479285453_txtFile = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtFile",_loc2_,param1));
         }
      }
      
      public function ___btnBrowse_click(param1:MouseEvent) : void
      {
         this.browse();
      }
      
      private function onCancel(param1:Event) : void
      {
         this.clearFileReference();
      }
      
      private function onSelect(param1:Event) : void
      {
         var _loc2_:String = null;
         this._txtFile.text = this._file.name;
         this._progress.graphics.clear();
         if(this._file.size > MAX_FILE_SIZE)
         {
            this.clearFileReference();
         }
         else
         {
            this.onFileChangeHandler();
         }
      }
      
      private function onFileChangeHandler() : void
      {
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function setButtonStatus(param1:Boolean) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtFile() : TextArea
      {
         return this._1479285453_txtFile;
      }
      
      private function _FileUploadComponent_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return this.width - _btnBrowse.width - 30;
         },function(param1:Number):void
         {
            _txtFile.width = param1;
         },"_txtFile.width");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return _txtFile.x;
         },function(param1:Number):void
         {
            _progress.x = param1;
         },"_progress.x");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return _txtFile.y;
         },function(param1:Number):void
         {
            _progress.y = param1;
         },"_progress.y");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return _txtFile.width;
         },function(param1:Number):void
         {
            _progress.width = param1;
         },"_progress.width");
         result[3] = binding;
         binding = new Binding(this,function():Number
         {
            return _txtFile.height;
         },function(param1:Number):void
         {
            _progress.height = param1;
         },"_progress.height");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Browse");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnBrowse.label = param1;
         },"_btnBrowse.label");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Max. size 4MB");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _sizeRemark.text = param1;
         },"_sizeRemark.text");
         result[6] = binding;
         return result;
      }
      
      public function onClickUpload(param1:Object) : void
      {
         this._isZoomSelected = param1["zoom"];
         this._isActionSelected = param1["action"];
         this.upload();
      }
      
      public function clearFileReference() : void
      {
         if(this._file != null)
         {
            this._txtFile.text = "";
            this._file.cancel();
            this._file = null;
         }
      }
      
      public function saveSoundBySoundThumb(param1:SoundThumb) : void
      {
         Console.getConsole().speechManager.voiceFileManager.addEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:SpeechData = new SpeechData();
         _loc2_.type = "file";
         _loc2_.text = this._file.name;
         param1.ttsData = _loc2_;
         Console.getConsole().speechManager.addSoundByThumb(param1);
      }
      
      private function onSoundAdded(param1:SoundEvent) : void
      {
         var _loc15_:EffectAsset = null;
         Console.getConsole().speechManager.voiceFileManager.removeEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:AssetLinkage = new AssetLinkage();
         var _loc3_:Object = param1.getData();
         var _loc4_:String = _loc3_["id"];
         _loc2_.addLinkage(_loc4_);
         var _loc5_:Asset;
         var _loc6_:String = (_loc5_ = Console.getConsole().currentScene.selectedAsset).scene.id + AssetLinkage.LINK + _loc5_.id;
         _loc2_.addLinkage(_loc6_);
         Console.getConsole().linkageController.addLinkage(_loc2_);
         var _loc7_:AddSpeechCommand;
         (_loc7_ = new AddSpeechCommand(Console.getConsole().speechManager.voiceFileManager.sounds.getValueByKey(_loc4_) as AnimeSound,_loc6_)).execute();
         var _loc8_:Boolean = false;
         var _loc9_:UtilHashArray;
         var _loc10_:int = (_loc9_ = Console.getConsole().currentScene.effects).length - 1;
         while(_loc10_ >= 0)
         {
            if((_loc15_ = _loc9_.getValueByIndex(_loc10_) as EffectAsset).fromSpeech)
            {
               _loc8_ = true;
            }
            _loc10_--;
         }
         if(this._isZoomSelected && !_loc8_)
         {
            Console.getConsole().addCutEffectonChar(Character(_loc5_));
         }
         Character(_loc5_).demoSpeech = true;
         var _loc11_:Boolean = false;
         if(this._isActionSelected)
         {
            _loc11_ = Character(_loc5_).changeActionAsTalk();
         }
         if(!_loc11_)
         {
            Character(_loc5_).reloadAssetImage();
         }
         var _loc12_:Number = Util.roundNum(_loc3_["duration"] as Number);
         var _loc13_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.doUpdateTimelineLength(UtilUnitConvert.secToPixel(_loc12_),true);
         var _loc14_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.updateEffectTray(_loc14_,_loc13_);
         Console.getConsole().currentScene.refreshEffectTray();
         Character(_loc5_).speechVoice = AnimeSound(Console.getConsole().speechManager.voiceFileManager.sounds.getValueByKey(_loc4_)).soundThumb.ttsData.voice;
         this.dispatchEvent(new Event(Event.COMPLETE));
         this.init();
      }
      
      public function set filter(param1:String) : void
      {
         var _loc2_:String = null;
         if(param1 == "images")
         {
            this._filter = FILTER_IMAGE;
         }
         else if(param1 == "sounds")
         {
            this._filter = FILTER_SOUND;
         }
         else if(param1 == "flash")
         {
            this._filter = FILTER_FLASH;
         }
         else if(param1 == "video")
         {
            this._filter = FILTER_FLVMOVIE;
         }
      }
   }
}
