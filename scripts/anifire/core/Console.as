package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.command.*;
   import anifire.component.*;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.BubbleMsgChooser;
   import anifire.components.studio.BubbleMsgChooserItem;
   import anifire.components.studio.BubbleMsgEvent;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.ExternalPreviewWindowController;
   import anifire.components.studio.Feedback;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.PropertiesWindow;
   import anifire.components.studio.PublishWindow;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TipWindow;
   import anifire.components.studio.TopButtonBar;
   import anifire.components.studio.ViewStackWindow;
   import anifire.components.studio.noSaveAlertWindow;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.constant.ThemeEmbedConstant;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.SpeechManager;
   import anifire.core.sound.TTSManager;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.event.LoadMgrEvent;
   import anifire.events.*;
   import anifire.interfaces.IConsoleImportable;
   import anifire.interfaces.IIterator;
   import anifire.managers.*;
   import anifire.playback.PlayerConstant;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.popups.GoPopUp;
   import anifire.timeline.ElementInfo;
   import anifire.timeline.SoundContainer;
   import anifire.timeline.Timeline;
   import anifire.timeline.TimelineEvent;
   import anifire.tutorial.*;
   import anifire.util.*;
   import com.adobe.images.JPGEncoder;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.StyleSheet;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.ProgressBar;
   import mx.controls.SWFLoader;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.Application;
   import mx.core.DragSource;
   import mx.core.IFlexDisplayObject;
   import mx.effects.Blur;
   import mx.effects.Fade;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ScrollEvent;
   import mx.graphics.codec.PNGEncoder;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   import mx.managers.SystemManager;
   import mx.utils.Base64Encoder;
   import mx.utils.StringUtil;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   import nochump.util.zip.ZipOutput;
   import template.templateApp.classes.Global;
   
   public class Console implements IConsoleImportable, IEventDispatcher
   {
      
      public static const FULL_STUDIO:String = "Full_Studio";
      
      public static const BOX_STUDIO:String = "box_studio";
      
      public static const MESSAGE_STUDIO:String = "message_studio";
      
      private static var _logger:ILogger = Log.getLogger("core.Console");
      
      public static const TINY_STUDIO:String = "tiny_studio";
      
      private static var _console:Console;
       
      
      private var _defaultUpdateAllTimelineImage:Boolean = false;
      
      private var _prevSceneLength:Number;
      
      private var _movieXML:XML;
      
      private var _studioProgress:Canvas;
      
      private var unlockedAssets:Array = null;
      
      private var _importerOpenedBefore:Boolean = false;
      
      private var _nextCommunityCharPage:int = 0;
      
      private var _currDragSource:DragSource;
      
      private var _shouldUseExternalPreviewPlayer:Number = -1;
      
      private var _originalId:String;
      
      private var _importer:Application;
      
      public var flickrToken:String = null;
      
      private var _whiteTerms:Array = null;
      
      private var _screenCapTool:ScreenCapTool;
      
      public var excludedIds:UtilHashArray;
      
      private var _isLoaddingCommonTheme:Boolean = false;
      
      private var _headable:Boolean;
      
      private var _goWalker:TutorialManager;
      
      private var _thumbTray:ThumbTray;
      
      private var _metaData:MetaData;
      
      private var _isAutoSave:Boolean = false;
      
      private var _isLoaddingCommonThemeBg:Boolean = false;
      
      private var _externalPreviewPlayerController:ExternalPreviewWindowController;
      
      private var _uploadedAssetsEnabled:Boolean;
      
      private var _purchaseEnabled:Boolean;
      
      private var _curTheme:Theme;
      
      private var _boxMode:Boolean = false;
      
      private var _byteArrayReturnFromLoadCcChar:UtilHashArray;
      
      private var _isCopy:Boolean = false;
      
      private var _themes:UtilHashArray;
      
      private var _nextUserCharPage:int = 0;
      
      private var _nextCommunitySoundEffectPage:int = 0;
      
      private var _nextCommunitySoundTTSPage:int = 0;
      
      private var _needGuideBubbles:Boolean = true;
      
      private var _initialized:Boolean = false;
      
      private var _myAnimatedMask:AnimatedMask;
      
      private var _inspirationLoader:SWFLoader;
      
      private var _addBlankScene:Boolean = false;
      
      private var _tempMetaData:MetaData;
      
      private var _isMovieNew:Boolean = false;
      
      private var _redirect:Boolean = false;
      
      private var _groupController:GroupController;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      private var _guideMode:String = "";
      
      private var _loaddingAssetType:String = "prop";
      
      private var _pptPanel:PropertiesWindow;
      
      private var _placeable:Boolean;
      
      private var _thumbSO:SharedObject;
      
      private var _changed:Boolean;
      
      private var _communityTheme:Theme;
      
      private var _nextUserBgPage:int = 0;
      
      private var _loadRequestCounter:int = 0;
      
      private const MAX_SCENE_NUMBER:uint = 99999;
      
      private var _timeline:Timeline;
      
      private var _nextUserSoundEffectPage:int = 0;
      
      private var _linkageController:LinkageController;
      
      private var _blacklistEnabled:Boolean;
      
      private var _nextCommunitySoundPage:int = 0;
      
      private var _previewData:UtilHashArray;
      
      private var _tempPrivateShared:Boolean = false;
      
      private var _bubbleSceneGuide:Image;
      
      private var _selectedThumbnailIndex:int = 0;
      
      private var _badTerms:Array = null;
      
      private var _nextCommunityPropPage:int = 0;
      
      private var _prevAllSoundInfo:Array;
      
      private var _nextUserSoundPage:int = 0;
      
      private var _tempAsset:Asset;
      
      private var _effectTray:EffectTray;
      
      private var _currentLicensorName:String = "";
      
      private var _initCreation:Boolean = true;
      
      private var _nextCommunitySoundMusicPage:int = 0;
      
      private var _copyObjects:Array;
      
      private var _nextUserSoundMusicPage:int = 0;
      
      private var _initThemeCode:String = null;
      
      private var _movie:MovieData;
      
      private var storecollection:Array;
      
      private var _soundMute:Boolean = true;
      
      private var _nextUserEffectPage:int = 0;
      
      private var _sounds:UtilHashArray;
      
      private var _speechManager:SpeechManager;
      
      private var LOCAL_CON:String = "importer_lc";
      
      private var _themeListXML:XML;
      
      private var _nextUserSoundTTSPage:int = 0;
      
      private var _nextUserPropPage:int = 0;
      
      private var _nextUserVideoPropPage:int = 0;
      
      private var _uploadType:String = "bg";
      
      private var _tempPublished:Boolean = true;
      
      private var _lastLoaddedTheme:Theme;
      
      private var _publishW:PublishWindow;
      
      private var _isCommonThemeLoadded:Boolean = false;
      
      private var _viewStackWindow:ViewStackWindow = null;
      
      private var _extSwfContainer:Canvas;
      
      private var _eventDispatcher:UtilEventDispatcher;
      
      private var _nextCommunitySoundVoicePage:int = 0;
      
      private var _nextUserSoundVoicePage:int = 0;
      
      private var _filmXML:XML;
      
      private var _assetId:Number = 0;
      
      private var _bubbleThumbGuide:Image;
      
      private var _loadProgress:ProgressBar;
      
      private var _capScreenLock:Boolean = false;
      
      private var _newlyAddedAssetIds:String = "";
      
      private var _userTheme:Theme;
      
      private var _mainStage:MainStage;
      
      private var _nextCommunityEffectPage:int = 0;
      
      private var _sci:int;
      
      private var _prevSoundInfo:ElementInfo;
      
      private var _ttsEnabled:Boolean;
      
      private var _tipsLayer:Canvas;
      
      private var _currDragObject:Asset;
      
      private var _isLoaddingCommonThemeChar:Boolean = false;
      
      private var _topButtonBar:TopButtonBar;
      
      private var _nextCommunityBgPage:int = 0;
      
      private var _isLoaddingCommonThemeProp:Boolean = false;
      
      private var _stageViewStack:ViewStack;
      
      private var _swfLoader:SWFLoader;
      
      private var _actionshopLoader:SWFLoader;
      
      private var _searchedTheme:Theme;
      
      private var _popUp:GoPopUp = null;
      
      private var _studioType:String;
      
      public var fbAuthToken:String = null;
      
      private var _siteId:String;
      
      private var _isStudioReady:Boolean = false;
      
      private var _isLoadding:Boolean = false;
      
      private var _uploadedAssetXML:XML;
      
      private var _purchasedAssetsXML:XMLList;
      
      private var _holdable:Boolean;
      
      public function Console(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:Canvas, param7:PropertiesWindow, param8:Canvas, param9:ScreenCapTool, param10:TutorialManager = null, param11:String = "tiny_studio")
      {
         var _loc12_:CommandStack = null;
         var _loc13_:UtilHashArray = null;
         var _loc14_:Number = NaN;
         this._externalPreviewPlayerController = new ExternalPreviewWindowController();
         this._speechManager = new SpeechManager();
         this._swfLoader = new SWFLoader();
         this._inspirationLoader = new SWFLoader();
         this._actionshopLoader = new SWFLoader();
         this.storecollection = new Array();
         this._byteArrayReturnFromLoadCcChar = new UtilHashArray();
         super();
         if(param1 != null && param2 != null && param3 != null && param5 != null)
         {
            this._myAnimatedMask = AnimatedMask.getInstance();
            Util.initLog();
            _logger.debug("Console initialized");
            this._mainStage = param1;
            this._topButtonBar = param2;
            this.enableRedo(false);
            this.enableUndo(false);
            this._mainStage.loggedIn = UtilUser.loggedIn;
            this._thumbTray = param3;
            this._timeline = param5;
            this._effectTray = param4;
            this._extSwfContainer = param6;
            this.pptPanel = param7;
            this._tipsLayer = param8;
            this.screenCapTool = param9;
            this.goWalker = param10;
            this._studioType = param11;
            this._timeline.addEventListener(TimelineEvent.SCENE_MOUSE_UP,this.onSceneUpHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_MOUSE_DOWN,this.onSceneDownHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_START,this.onSceneResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_COMPLETE,this.onSceneResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_CLICK,this.onSoundClickHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOVE,this.onSoundMoveHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE,this.onSoundResizeHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_START,this.onSoundResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_COMPLETE,this.onSoundResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_DOWN,this.onSoundMouseDownHandler);
            this._movie = new MovieData();
            this._movie.addEventListener(MovieEvent.SCENE_SELECTED,this.onSceneSelected);
            this._movie.addEventListener(MovieEvent.SCENE_ADDED,this.onSceneAdded);
            this._movie.addEventListener(MovieEvent.SCENE_REMOVED,this.onSceneRemoved);
            this._movie.addEventListener(MovieEvent.SCENE_MOVED,this.onSceneMoved);
            this._previewData = new UtilHashArray();
            this._sounds = new UtilHashArray();
            this._metaData = new MetaData();
            this._tempMetaData = new MetaData();
            this._tempMetaData.lang = Util.preferLanguageShortCode();
            this._metaData.lang = Util.preferLanguageShortCode();
            this._eventDispatcher = new UtilEventDispatcher();
            this._stageViewStack = this._mainStage.stageViewStack;
            this._themes = new UtilHashArray();
            this._userTheme = new Theme();
            this._userTheme.id = "ugc";
            this._communityTheme = new Theme();
            this._communityTheme.id = "ugc";
            this._lastLoaddedTheme = new Theme();
            this._lastLoaddedTheme.id = "ugc";
            this._searchedTheme = new Theme();
            this._searchedTheme.id = "ugc";
            (_loc12_ = CommandStack.getInstance()).addEventListener(CommandEvent.ADDED,this.onCommandAddedHandler);
            _loc13_ = Util.getFlashVar();
            this._ttsEnabled = _loc13_.getValueByKey("tts_enabled") == "1";
            this._purchaseEnabled = _loc13_.getValueByKey("pts") == "1";
            this._uploadedAssetsEnabled = _loc13_.getValueByKey("upl") != "0";
            this._blacklistEnabled = _loc13_.getValueByKey("hb") == "1";
            this._siteId = _loc13_.getValueByKey("siteId");
            if(this._siteId == "" || this._siteId == null)
            {
               this._siteId = Util.getFlashVar().getValueByKey("siteId");
            }
            if(!this._uploadedAssetsEnabled)
            {
               this._thumbTray.disallowUploadedAssets();
            }
            this._thumbTray.initThumbTrayDefaultTab(this.studioType != MESSAGE_STUDIO);
            this._thumbTray.addEventListener(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this.doGoToCopyChar);
            this.addEventListener(CoreEvent.LOAD_THEMELIST_COMPLETE,this.doLoadDefaultTheme);
            _loc14_ = 1;
            if(this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO)
            {
               if(FeatureManager.shouldAutoSaveBeEnabled)
               {
                  this.initAutoSave();
               }
            }
            else if(this.studioType == MESSAGE_STUDIO)
            {
               _loc14_ = 1;
            }
            if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_NEW)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_NEW;
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_SEMI)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_SEMI;
            }
            this.groupController = new GroupController();
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID) != null)
            {
               this.groupController.currentGroup = new Group(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID),Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_NAME));
            }
            this.linkageController = new LinkageController();
            this.linkageController.eventDispatcher.addEventListener(SoundEvent.UPDATED,this.onUpdateLinkage);
            this.loadThemeList(_loc14_);
            this.addCallBack();
            UtilUser.eventDispatcher.addEventListener(UtilUser.ACCOUNT_UPGRADED,this.onUserAccountUpgraded);
         }
      }
      
      public static function getConsole() : Console
      {
         if(_console != null)
         {
            return _console;
         }
         throw new Error("Console must be intialized first");
      }
      
      public static function initializeConsole(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:Canvas, param7:PropertiesWindow, param8:Canvas, param9:ScreenCapTool, param10:TutorialManager = null, param11:String = "tiny_studio") : Object
      {
         if(_console == null)
         {
            _console = new Console(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         }
         return _console;
      }
      
      private function doAddSoundAtSceneAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:AnimeScene = _loc3_[0] as AnimeScene;
         var _loc5_:SoundThumb = _loc3_[1] as SoundThumb;
         var _loc6_:AnimeSound = _loc3_[2] as AnimeSound;
         var _loc7_:Point = _loc3_[3] as Point;
         var _loc8_:Boolean = _loc3_[4] as Boolean;
         this.addSoundAtScene(_loc4_,_loc5_,_loc7_,_loc6_,_loc8_);
         Util.gaTracking("/gostudio/assets/" + _loc5_.theme.id + "/loaded/" + _loc5_.id,Console.getConsole().mainStage.stage);
      }
      
      public function deleteAsset(param1:MouseEvent = null) : void
      {
         if(this.isTutorialOn)
         {
            return;
         }
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
               this.lookOut();
            }
         }
         if(this._movie.currentScene)
         {
            if(this._movie.currentScene.assetGroup.length > 1)
            {
               this._movie.currentScene.deleteAssetGroup();
            }
            else if(this._movie.currentScene.selectedAsset != null)
            {
               this._movie.currentScene.selectedAsset.deleteAsset();
            }
            else if(this._tempAsset != null)
            {
               this._tempAsset.deleteAsset();
               this._tempAsset = null;
            }
            this._movie.currentScene.selectedAsset = null;
            this.refreshAllSpeechText();
         }
      }
      
      private function hideGuideBubble(param1:Image) : void
      {
         var _loc2_:Fade = null;
         _loc2_ = new Fade();
         _loc2_.target = param1;
         _loc2_.alphaFrom = 1;
         _loc2_.alphaTo = 0;
         _loc2_.easingFunction = Exponential.easeOut;
         _loc2_.addEventListener(EffectEvent.EFFECT_END,this.removeGuideBubbleAfterFade);
         _loc2_.play();
      }
      
      private function doLoadMovieComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var bytesLoaded:ByteArray = null;
         var checkCode:int = 0;
         var zip:ZipFile = null;
         var sceneXML:XML = null;
         var bubbleXML:XML = null;
         var _fontManager:FontManager = null;
         var i:int = 0;
         var loadMgr:UtilLoadMgr = null;
         var themeTrees:UtilHashArray = null;
         var curThemeId:String = null;
         var j:int = 0;
         var filename:String = null;
         var curThemeXml:XML = null;
         var th:Theme = null;
         var bytes:ByteArray = null;
         var event:Event = param1;
         urlLoader = event.target as URLLoader;
         bytesLoaded = urlLoader.data as ByteArray;
         checkCode = bytesLoaded.readByte();
         if(checkCode == 0)
         {
            zip = new ZipFile(bytesLoaded);
            this._movieXML = new XML(zip.getInput(zip.getEntry(AnimeConstants.MOVIE_XML_FILENAME)));
            if(this._movieXML != null)
            {
               _fontManager = FontManager.getFontManager();
               i = 0;
               while(i < this._movieXML.child(AnimeScene.XML_NODE_NAME).length())
               {
                  sceneXML = this._movieXML.child(AnimeScene.XML_NODE_NAME)[i];
                  j = 0;
                  while(j < sceneXML.child(BubbleAsset.XML_NODE_NAME).length())
                  {
                     bubbleXML = sceneXML.child(BubbleAsset.XML_NODE_NAME)[j];
                     if(!_fontManager.isFontLoaded(bubbleXML.child("bubble")[0].child("text")[0].@font) && bubbleXML.child("bubble")[0].child("text")[0].@embed != "false")
                     {
                        filename = _fontManager.nameToFileName(bubbleXML.child("bubble")[0].child("text")[0].@font) + ".swf";
                        _fontManager.getFonts().push(bubbleXML.child("bubble")[0].child("text")[0].@font,zip.getInput(zip.getEntry(filename)),true);
                     }
                     j++;
                  }
                  i++;
               }
               loadMgr = new UtilLoadMgr();
               themeTrees = this.getThemeTrees(this._movieXML,zip);
               i = 0;
               while(i < themeTrees.length)
               {
                  curThemeId = (themeTrees.getValueByIndex(i) as ThemeTree).getThemeID();
                  if(this.getTheme(curThemeId) == null)
                  {
                     th = new Theme();
                     this.addTheme(curThemeId,th);
                     th.modifyPremiumContent(this._purchasedAssetsXML.(@theme == curThemeId));
                  }
                  curThemeXml = new XML(zip.getInput(zip.getEntry(curThemeId + ".xml")).toString());
                  loadMgr.addEventDispatcher(this.getTheme(curThemeId).eventDispatcher,CoreEvent.LOAD_THEMETREE_COMPLETE);
                  this.getTheme(curThemeId).initThemeByThemeTree(themeTrees.getValueByIndex(i) as ThemeTree,curThemeXml,zip,this);
                  i++;
               }
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doInitFonts);
               loadMgr.commit();
            }
         }
         else
         {
            bytes = new ByteArray();
            bytesLoaded.readBytes(bytes);
            _logger.error("return code is:" + checkCode + "\n error message: \n" + bytes.toString());
            Alert.show("the return code is: " + checkCode + "\n error message: \n" + bytes.toString());
         }
      }
      
      private function sceneChangeEffect() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Glow = null;
         var _loc3_:Blur = null;
         var _loc4_:Parallel = null;
         _loc1_ = 800;
         _loc2_ = new Glow();
         _loc2_.duration = 800;
         _loc2_.blurXFrom = 0;
         _loc2_.blurXTo = 60;
         _loc2_.blurYFrom = 0;
         _loc2_.blurYTo = 60;
         _loc2_.color = 0;
         _loc3_ = new Blur();
         _loc3_.duration = 800;
         _loc3_.blurXFrom = 10;
         _loc3_.blurXTo = 0;
         _loc3_.blurYFrom = 10;
         _loc3_.blurYTo = 0;
         (_loc4_ = new Parallel()).duration = _loc1_;
         _loc4_.targets = [this._stageViewStack];
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.play();
      }
      
      public function get initCreation() : Boolean
      {
         return this._initCreation;
      }
      
      public function getTheme(param1:String) : Theme
      {
         return this._themes.getValueByKey(param1) as Theme;
      }
      
      public function setCurrentScene(param1:int) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function getSoundInfoById(param1:String) : ElementInfo
      {
         return this.timeline.getSoundInfoById(param1);
      }
      
      private function onGetCNUserGameScoreComplete(param1:Event) : void
      {
         var userScoreXML:XML = null;
         var c:XMLList = null;
         var i:int = 0;
         var e:Event = param1;
         (e.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,arguments.callee);
         userScoreXML = XML((e.currentTarget as URLLoader).data);
         c = userScoreXML.asset.(@e == "1");
         i = 0;
         while(i < c.length())
         {
            this.unlockedAssets.push({
               "id":String(c[i].@id),
               "type":String(c[i].@type)
            });
            i++;
         }
         this.doGetCNUserScores(e);
      }
      
      public function set boxMode(param1:Boolean) : void
      {
         this._boxMode = param1;
      }
      
      public function pasteAsset() : void
      {
         if(this._copyObjects && this._copyObjects.length > 0 && this._movie.currentScene)
         {
            this._movie.currentScene.pasteAssets(this._copyObjects);
         }
      }
      
      public function set initCreation(param1:Boolean) : void
      {
         this._initCreation = param1;
      }
      
      public function onBubbleMsgChoosen(param1:BubbleMsgEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBubbleMsgChoosen);
         var _loc2_:BubbleMsgChooser = param1.target as BubbleMsgChooser;
         _loc2_.closeWindow();
         var _loc3_:BubbleMsgChooserItem = param1.bubbleMsgItem;
         if(_loc3_.isBubble)
         {
            this.changeBubbleMsg(_loc3_.bubbleAsset,_loc3_.msg);
         }
         if(_loc3_.isSound)
         {
            this.currentScene.createAsset(_loc3_.soundThumb);
         }
      }
      
      public function deleteTempProp() : void
      {
         ThumbnailCanvas(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId))).deleteThumbnail(false);
      }
      
      public function onUserLogined(param1:String) : void
      {
         Util.setFlashVar("u_info",param1);
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_COMPLETE,this));
      }
      
      public function loadThemeBg(param1:String) : void
      {
         var _loc2_:Theme = null;
         if(this._themes.containsKey(param1))
         {
            _loc2_ = this.getTheme(param1);
         }
         else
         {
            _loc2_ = null;
            trace("Error: theme not found when loading bg zip with themeId:" + param1);
         }
         if(_loc2_.isBgZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/backgrounds",Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/backgrounds",Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeBg = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc2_.loadBg();
      }
      
      public function getStoreCollection() : Array
      {
         return this.storecollection;
      }
      
      private function closeThemeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         _loc2_.visible = false;
      }
      
      private function addCallBack() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("showActionShop",this.showActionShop);
            ExternalInterface.addCallback("reloadAllCC",this.reloadAllCC);
            ExternalInterface.addCallback("showBuyGoBuckPopUp",this.showBuyGoBuckPopUp);
            ExternalInterface.addCallback("showTransactionPopUp",this.showTransactionPopUp);
            if(!UtilUser.loggedIn)
            {
               ExternalInterface.addCallback("onUserLogined",this.onUserLogined);
               ExternalInterface.addCallback("onUserLoginCancel",this.onUserLoginCancel);
            }
         }
      }
      
      public function lookOut() : void
      {
         this.mainStage.hideCameraView();
      }
      
      private function onSceneResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         this._prevSceneLength = _loc2_.totalPixel;
         this._prevAllSoundInfo = Timeline(param1.currentTarget).getAllSoundInfo();
      }
      
      public function askUserToGoToCcCreator() : void
      {
         var _loc1_:GoAlert = null;
         _loc1_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc1_._lblConfirm.text = "";
         _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_goToCcCreator");
         _loc1_._txtDelete.setStyle("textAlign","left");
         _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCreateMyChar);
         _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = 100;
      }
      
      private function alertClickHandler(param1:MouseEvent) : void
      {
         if(Button(param1.currentTarget).id == "_btnDelete")
         {
            if(ServerConstants.APPCODE == "go")
            {
               ExternalInterface.call("newAnimation");
            }
            else
            {
               this.newAnimation();
            }
         }
      }
      
      public function addNewlyAddedAssetId(param1:String) : void
      {
         if(this._newlyAddedAssetIds == "")
         {
            this._newlyAddedAssetIds = this._newlyAddedAssetIds + param1;
         }
         else
         {
            this._newlyAddedAssetIds = this._newlyAddedAssetIds + ("," + param1);
         }
      }
      
      public function loadCommonThemeBg() : void
      {
         var _loc1_:Theme = null;
         if(this._themes.containsKey("common"))
         {
            _loc1_ = this.getTheme("common");
         }
         else
         {
            _loc1_ = null;
            trace("Error: theme not found when loading bg zip with themeId:common");
         }
         if(_loc1_.isBgZipLoaded())
         {
            this.thumbTray.loadBackgroundThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeBg = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc1_.loadBg();
      }
      
      public function get timeline() : Timeline
      {
         return this._timeline;
      }
      
      public function set studioProgress(param1:Canvas) : void
      {
         this._studioProgress = param1;
      }
      
      public function hideInspiration() : void
      {
         this._inspirationLoader.visible = false;
         this._extSwfContainer.visible = false;
      }
      
      private function closeOverTray(param1:Event) : void
      {
         this.showOverTray(false);
      }
      
      public function showProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
         this.loadProgress = _loc2_;
         if(param1.bytesLoaded >= param1.bytesTotal)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.showProgress);
         }
      }
      
      public function get linkageController() : LinkageController
      {
         return this._linkageController;
      }
      
      public function hideActionPack() : void
      {
         this._actionshopLoader.visible = false;
         this._extSwfContainer.visible = false;
         if(this.currentScene != null)
         {
            this.currentScene.playScene();
         }
      }
      
      public function changeTempPropName() : void
      {
         var _loc1_:DisplayObject = DisplayObject(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId)));
         if(_loc1_)
         {
            _loc1_.name = "cellUserProp";
         }
      }
      
      public function get tempPrivateShared() : Boolean
      {
         return this._tempPrivateShared;
      }
      
      public function showOverTray(param1:Boolean = true) : void
      {
         var _loc2_:PropertyWindowEvent = null;
         if(this.studioType != MESSAGE_STUDIO && !this._boxMode)
         {
            if(param1)
            {
               OverTray(this.pptPanel.parent.parent.parent).open();
               this.pptPanel._close.addEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
            else
            {
               OverTray(this.pptPanel.parent.parent.parent).close();
               this.pptPanel._close.removeEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
         }
         if(this._boxMode)
         {
            _loc2_ = new PropertyWindowEvent(!!param1?PropertyWindowEvent.EVENT_OPEN:PropertyWindowEvent.EVENT_CLOSE);
            _loc2_.view = PropertyWindowEvent.VIEW_PROPERTY_WINDOW;
            Application.application.dispatchEvent(_loc2_);
         }
      }
      
      private function soStatusListener(param1:NetStatusEvent) : void
      {
         if(param1.info.code != "SharedObject.Flush.Success")
         {
            if(param1.info.code == "SharedObject.Flush.Failed")
            {
            }
         }
         this.thumbSO.removeEventListener(NetStatusEvent.NET_STATUS,this.soStatusListener);
         this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
      }
      
      private function showTip() : void
      {
         var _loc1_:TipWindow = new TipWindow();
         _loc1_.width = 400;
         _loc1_.height = 200;
         _loc1_.x = (this.mainStage.width - _loc1_.width) / 2;
         _loc1_.y = (this.mainStage.height - _loc1_.height) / 2;
         _loc1_.addEventListener(Event.COMPLETE,this.initTip);
         this.mainStage.addChild(_loc1_);
      }
      
      private function onSceneDownHandler(param1:TimelineEvent) : void
      {
      }
      
      public function stopAllSounds() : void
      {
         var _loc1_:AnimeSound = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.sounds.length)
         {
            _loc1_ = AnimeSound(this.sounds.getValueByIndex(_loc2_));
            _loc1_.stopSound();
            _loc2_++;
         }
      }
      
      public function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:UtilHashArray = null;
         _loc5_ = new UtilHashArray();
         _loc3_ = 0;
         while(_loc3_ < param1.child(AnimeScene.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(AnimeScene.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,AnimeScene.getThemeTrees(_loc4_,param2,_loc5_));
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.child(AnimeSound.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,AnimeSound.getThemeTrees(_loc4_,param2));
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function get effectTray() : EffectTray
      {
         return this._effectTray;
      }
      
      public function requestLoadStatus(param1:Boolean, param2:Boolean = false, param3:Number = 1) : void
      {
         var _loc4_:Boolean = false;
         if(param1)
         {
            this._loadRequestCounter = this._loadRequestCounter + param3;
            if(this._loadRequestCounter == 1)
            {
               CursorManager.setBusyCursor();
               _loc4_ = true;
            }
            else
            {
               _loc4_ = false;
            }
         }
         else
         {
            this._loadRequestCounter = this._loadRequestCounter - param3;
            if(this._loadRequestCounter < 0)
            {
               this._loadRequestCounter = 0;
            }
            if(this._loadRequestCounter == 0)
            {
               _loc4_ = true;
               CursorManager.removeBusyCursor();
            }
            else
            {
               _loc4_ = false;
            }
         }
         if(_loc4_)
         {
            this._topButtonBar.setLoadingStatus(param1);
            this._mainStage.setLoadingStatus(param1,true);
            this._timeline.setLoadingStatus(param1);
            this._thumbTray.setLoadingStatus(param1);
            this.pptPanel.setLoadingStatus(param1);
         }
      }
      
      private function onFontLoaded(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:FontManager = null;
         _loc2_ = (param1.target.loader as Loader).name;
         _loc3_ = FontManager.getFontManager();
         _loc3_.setFontAsLoaded(_loc2_,param1.target.bytes as ByteArray);
      }
      
      public function loadCcChar() : void
      {
         var _loc1_:URLVariables = null;
         var _loc2_:URLRequest = null;
         var _loc3_:UtilURLStream = null;
         Console.getConsole().requestLoadStatus(true,true);
         if(this._byteArrayReturnFromLoadCcChar.getValueByKey(this.getCurTheme().id) == null)
         {
            _loc1_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc1_);
            _loc2_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
            _loc1_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
            _loc1_["count"] = 1000;
            _loc1_["page"] = 0;
            _loc1_["is_cc"] = "Y";
            _loc1_["cc_theme_id"] = this.getCurTheme().cc_theme_id;
            _loc1_["tray"] = this.getCurTheme().id;
            _loc2_.method = URLRequestMethod.POST;
            _loc2_.data = _loc1_;
            _loc3_ = new UtilURLStream();
            _loc3_.addEventListener(Event.COMPLETE,this.onLoadCcCharCompleted);
            _loc3_.load(_loc2_);
         }
         else
         {
            this.doPrepareLoadCcCharComplete(this._byteArrayReturnFromLoadCcChar.getValueByKey(this.getCurTheme().id) as ByteArray);
         }
      }
      
      public function get tempPublished() : Boolean
      {
         return this._tempPublished;
      }
      
      public function copyAsset() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:Asset = null;
         if(this._movie.currentScene)
         {
            this._copyObjects = new Array();
            _loc1_ = this._movie.currentScene.assetGroup.iterator();
            while(_loc1_.hasNext)
            {
               _loc2_ = _loc1_.next as Asset;
               if(_loc2_.isCopyable)
               {
                  this._copyObjects.push(_loc2_.serialize());
               }
            }
         }
      }
      
      private function onLoadCustomAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:Image = null;
         var _loc4_:Thumb = null;
         var _loc6_:ThumbnailCanvas = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Rectangle = null;
         var _loc13_:DisplayObject = null;
         var _loc14_:Image = null;
         var _loc15_:String = null;
         var _loc16_:DisplayObject = null;
         var _loc17_:BitmapData = null;
         var _loc18_:Bitmap = null;
         var _loc19_:SoundThumb = null;
         var _loc5_:String = "cellUserProp";
         if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc2_ = param1.target.loader;
            if(!(_loc2_.content is MovieClip) && !(_loc2_.content is AVM1Movie))
            {
               _loc5_ = String(this._assetId);
               this.thumbTray.popMaskImage(_loc2_.content,this._assetId,this._placeable,this._holdable,this._headable);
            }
         }
         if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
         {
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_ = param1.target.loader;
               _loc16_ = _loc2_.content;
               _loc3_ = Image(_loc2_.parent);
               _loc4_ = this.userTheme.getCharThumbById(this._uploadedAssetXML.@id);
               CharThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
               (_loc4_ as CharThumb).deSerialize(this._uploadedAssetXML,this._userTheme);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc3_ = (_loc16_ = (param1 as EffectEvt).thumbnail).parent as Image;
               ((_loc4_ = new EffectThumb()) as EffectThumb).deSerialize(this._uploadedAssetXML,this._userTheme);
            }
            _loc4_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
            _loc4_.theme = Console.getConsole().userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileCharUser.addChildAt(_loc6_,0);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileEffectUser.addChildAt(_loc6_,0);
            }
            _loc6_.name = _loc5_;
            _loc7_ = _loc16_.width;
            _loc8_ = _loc16_.height;
            _loc9_ = 1;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc16_.width = _loc10_;
                  _loc16_.height = _loc16_.height * _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc16_.width = _loc16_.width * _loc9_;
                  _loc16_.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc16_.width = _loc16_.width * _loc9_;
                     _loc16_.height = _loc11_;
                  }
                  else
                  {
                     _loc16_.width = _loc10_;
                     _loc16_.height = _loc16_.height * _loc9_;
                  }
               }
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc12_ = _loc2_.getBounds(_loc2_);
               _loc16_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc16_.width) / 2;
               _loc16_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc16_.height) / 2;
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc12_ = _loc16_.getBounds(_loc16_);
               _loc16_.x = (AnimeConstants.TILE_BUBBLE_WIDTH - _loc16_.width) / 2;
               _loc16_.y = (AnimeConstants.TILE_BUBBLE_HEIGHT - _loc16_.height) / 2;
            }
            _loc16_.x = _loc16_.x - _loc12_.left;
            _loc16_.y = _loc16_.y - _loc12_.top;
            _loc13_ = DisplayObject(_loc16_);
            UtilPlain.stopFamily(_loc13_);
            (_loc14_ = _loc3_).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = param1.target.loader;
            _loc3_ = Image(_loc2_.parent);
            _loc17_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            (_loc18_ = new Bitmap(_loc17_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc18_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            _loc3_.removeChild(_loc3_.getChildByName("imageLoader"));
            _loc3_.addChild(_loc18_);
            _loc4_ = new BackgroundThumb();
            _loc4_.id = _loc4_.thumbId = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
            _loc4_.theme = Console.getConsole().userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
            this.thumbTray._uiTileBgUser.addChildAt(_loc6_,0);
            _loc18_.x = AnimeConstants.TILE_INSETS;
            _loc18_.y = AnimeConstants.TILE_INSETS;
            _loc3_.graphics.beginFill(0,0);
            _loc3_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc3_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc3_ = Image(_loc2_.parent);
            (_loc4_ = new PropThumb()).id = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
            _loc4_.theme = Console.getConsole().userTheme;
            PropThumb(_loc4_).placeable = this._placeable;
            PropThumb(_loc4_).holdable = this._holdable;
            PropThumb(_loc4_).headable = this._headable;
            PropThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            (_loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_PROP_WIDTH,AnimeConstants.TILE_PROP_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled)).name = _loc5_;
            this.thumbTray._uiTilePropUser.addChildAt(_loc6_,0);
            _loc7_ = _loc2_.content.width;
            _loc8_ = _loc2_.content.height;
            _loc9_ = 1;
            _loc10_ = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc11_ = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc2_.content.width = _loc10_;
                  _loc2_.content.height = _loc2_.content.height * _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc2_.content.width = _loc2_.content.width * _loc9_;
                  _loc2_.content.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc2_.content.width = _loc2_.content.width * _loc9_;
                     _loc2_.content.height = _loc11_;
                  }
                  else
                  {
                     _loc2_.content.width = _loc10_;
                     _loc2_.content.height = _loc2_.content.height * _loc9_;
                  }
               }
            }
            _loc12_ = _loc2_.getBounds(_loc2_);
            _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
            _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
            _loc2_.x = _loc2_.x - _loc12_.left;
            _loc2_.y = _loc2_.y - _loc12_.top;
            if(_loc2_.content is MovieClip)
            {
               _loc13_ = DisplayObject(_loc2_.content);
               UtilPlain.stopFamily(_loc13_);
            }
            (_loc14_ = Image(_loc2_.parent)).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            _loc19_ = (param1 as CoreEvent).getEventCreater() as SoundThumb;
            this.thumbTray.addSoundTileCell(_loc19_,false);
            this.thumbTray.uploadedSoundThumb = _loc19_;
            _loc15_ = _loc19_.subType;
         }
         if(this._importer != null)
         {
            this._importer["success"]();
            if(this._uploadType != AnimeConstants.ASSET_TYPE_UNKNOWN)
            {
               this._thumbTray.showUserGoodies(this._uploadType,_loc15_);
            }
            this._thumbTray.show();
            this.currentScene.playScene();
         }
         else if(_loc19_ != null)
         {
            this.publishW.success(_loc19_);
         }
         this.requestLoadStatus(false,true);
      }
      
      public function set currDragSource(param1:DragSource) : void
      {
         this._currDragSource = param1;
      }
      
      public function loadTheme(param1:String) : void
      {
         var targetTheme:Theme = null;
         var id:String = param1;
         this.requestLoadStatus(true,true);
         var needLoad:Boolean = true;
         Util.gaTracking("/gostudio/themes/loading/" + id,Console.getConsole().mainStage.stage);
         if(this._themes.containsKey(id))
         {
            targetTheme = this._themes.getValueByKey(id) as Theme;
         }
         else
         {
            targetTheme = new Theme();
            targetTheme.id = id;
            targetTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == id));
         }
         if(id == "action" || id == "animal")
         {
            this._userTheme = new Theme();
            this._userTheme.id = "ugc";
            this._byteArrayReturnFromLoadCcChar = new UtilHashArray();
         }
         this._isLoaddingCommonTheme = false;
         targetTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         targetTheme.initThemeByLoadThemeFile(this,id);
      }
      
      public function loadMovieByXML(param1:XML) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:URLStream = null;
         this._movieXML = param1;
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_MOVIE_BY_XML);
         _loc2_.method = URLRequestMethod.POST;
         _loc3_ = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc3_[ServerConstants.PARAM_MOVIE_XML] = param1;
         _loc2_.data = _loc3_;
         this._isLoadding = true;
         (_loc4_ = new URLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc4_.load(_loc2_);
      }
      
      public function getImporter() : Application
      {
         return this._importer;
      }
      
      public function set timeline(param1:Timeline) : void
      {
         this._timeline = param1;
      }
      
      public function genDefaultTags() : void
      {
         var _loc1_:UtilHashArray = null;
         var _loc3_:UtilHashArray = null;
         var _loc4_:AnimeScene = null;
         var _loc5_:Thumb = null;
         var _loc6_:Thumb = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc1_ = new UtilHashArray();
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc3_ = new UtilHashArray();
         this.tempMetaData.clearHiddenTags();
         _loc7_ = 0;
         while(_loc7_ < this._movie.scenes.length)
         {
            if((_loc4_ = this._movie.getSceneAt(_loc7_)).characters.length > 0)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.characters.length)
               {
                  _loc6_ = Character(_loc4_.characters.getValueByIndex(_loc8_)).thumb;
                  if(_loc1_.getValueByKey(_loc6_.theme.id) == null)
                  {
                     _loc1_.push(_loc6_.theme.id,_loc6_.theme.id);
                     if(_loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.theme.id);
                     }
                  }
                  if(_loc3_.getValueByKey(_loc6_.id) == null)
                  {
                     _loc3_.push(_loc6_.id,_loc6_.id);
                     if(!_loc6_.isCC && _loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.id);
                     }
                  }
                  _loc8_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function get speechManager() : SpeechManager
      {
         return this._speechManager;
      }
      
      public function loadConvertedVideo(param1:Array) : void
      {
         var _loc3_:URLRequest = null;
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERVIDEOASSETS);
         _loc2_["count"] = 1000;
         _loc2_["page"] = 0;
         _loc2_["include_ids_only"] = param1.join(",");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onUpdateUserVideoAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      public function get themeListXML() : XML
      {
         return this._themeListXML;
      }
      
      public function prepareSaveMovieThumbnailScene() : void
      {
         var _loc1_:AnimeScene = null;
         this._isAutoSave = false;
         _loc1_ = this._movie.getSceneAt(this.selectedThumbnailIndex);
         if(_loc1_ != this.currentScene)
         {
            _loc1_.eventDispatcher.addEventListener(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this.onPreparedThumbnailScene);
            _loc1_.loadAllAssets();
         }
         else
         {
            this.saveMovie();
         }
      }
      
      public function playMovie() : void
      {
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).playMovie();
         }
      }
      
      private function doShowPublishWindow(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowPublishWindow);
         setTimeout(this.showPublishWindow,500);
      }
      
      public function showSoundMenu(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:AnimeSound;
         (_loc4_ = this.sounds.getValueByKey(param1) as AnimeSound).showMenu(param2,param3);
      }
      
      public function set linkageController(param1:LinkageController) : void
      {
         this._linkageController = param1;
      }
      
      public function get newlyAddedAssetIds() : String
      {
         return this._newlyAddedAssetIds;
      }
      
      private function onSceneResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:AnimeScene = null;
         var _loc4_:ICommand = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         if(this._prevSceneLength != _loc2_.totalPixel)
         {
            _loc3_ = this.getScene(param1.index);
            _loc3_.updateEffectTray(_loc2_.totalPixel,this._prevSceneLength);
            _loc3_.userLockedTime = _loc2_.totalPixel;
            (_loc4_ = new ChangeSceneLengthCommand(param1.index,this._prevSceneLength,this._prevAllSoundInfo)).execute();
         }
      }
      
      public function lookIntoAsset() : void
      {
         this.mainStage.showCameraView();
      }
      
      private function getMovieThumbnail(param1:Boolean = false) : ByteArray
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:Matrix = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc10_:JPGEncoder = null;
         var _loc11_:ByteArray = null;
         var _loc12_:Boolean = false;
         var _loc13_:ColorTransform = null;
         _loc2_ = this._movie.getSceneAt(this.selectedThumbnailIndex);
         _loc3_ = new Matrix();
         if(param1)
         {
            _loc4_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_WIDTH;
            _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_HEIGHT;
         }
         else
         {
            _loc4_ = AnimeConstants.MOVIE_THUMBNAIL_WIDTH;
            _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_HEIGHT;
         }
         if(_loc2_.sizingAsset != null)
         {
            _loc6_ = _loc4_ / _loc2_.sizingAsset.width;
            _loc7_ = _loc5_ / _loc2_.sizingAsset.height;
            _loc8_ = new BitmapData(AnimeConstants.STAGE_WIDTH * _loc6_ > 2880?2880:int(AnimeConstants.STAGE_WIDTH * _loc6_),AnimeConstants.STAGE_HEIGHT * _loc7_ > 2880?2880:int(AnimeConstants.STAGE_HEIGHT * _loc7_));
         }
         else
         {
            _loc6_ = _loc4_ / AnimeConstants.PLAYER_WIDTH;
            _loc7_ = _loc5_ / AnimeConstants.PLAYER_HEIGHT;
            _loc8_ = new BitmapData(AnimeConstants.STAGE_WIDTH,AnimeConstants.STAGE_HEIGHT);
         }
         _loc3_.createBox(_loc6_,_loc7_);
         if(_loc2_.sizingAsset != null)
         {
            _loc12_ = EffectAsset(_loc2_.sizingAsset).hideEffect();
            _loc8_.draw(_loc2_.canvas,_loc3_,null,null,null,true);
            if(_loc12_)
            {
               EffectAsset(_loc2_.sizingAsset).showEffect();
            }
         }
         else
         {
            _loc8_.draw(_loc2_.canvas,_loc3_,null,null,null,true);
         }
         _loc9_ = new BitmapData(_loc4_,_loc5_);
         if(_loc2_.sizingAsset != null)
         {
            _loc9_.copyPixels(_loc8_,new Rectangle(_loc2_.sizingAsset.x * _loc6_,_loc2_.sizingAsset.y * _loc7_,_loc4_,_loc5_),new Point(0,0));
         }
         else
         {
            _loc9_.copyPixels(_loc8_,new Rectangle(AnimeConstants.SCREEN_X * _loc6_,AnimeConstants.SCREEN_Y * _loc7_,_loc4_,_loc5_),new Point(0,0));
         }
         if(param1)
         {
            _loc13_ = new ColorTransform(0.5,0.5,0.5);
            _loc9_.colorTransform(new Rectangle(0,0,_loc9_.width,_loc9_.height),_loc13_);
         }
         return (_loc10_ = new JPGEncoder(80)).encode(_loc9_);
      }
      
      public function set thumbTrayActive(param1:Boolean) : void
      {
         this.thumbTray.active = param1;
      }
      
      public function set tempPrivateShared(param1:Boolean) : void
      {
         this._tempPrivateShared = param1;
      }
      
      public function addScene(param1:String = "", param2:String = "", param3:Number = 1, param4:Boolean = true) : AnimeScene
      {
         var _loc5_:AnimeScene = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:AnimeScene = null;
         var _loc9_:AnimeScene = null;
         if((_loc5_ = this.getScene(this._movie.currentIndex + param3)) != null)
         {
            _loc6_ = this.timeline.getSceneImageBitmapByIndex(this.getSceneIndex(_loc5_));
         }
         this.capScreenLock = true;
         if(this._movie.currentScene != null && param1 == "")
         {
            _loc7_ = this.timeline.getSceneImageBitmapByIndex(this._movie.currentIndex);
            if(param2 == "" && !this._addBlankScene)
            {
               _loc8_ = this._movie.currentScene.clone();
            }
            else
            {
               (_loc8_ = new AnimeScene()).console = this;
            }
         }
         else
         {
            (_loc8_ = new AnimeScene(param1)).console = this;
            _loc7_ = new BitmapData(100,100,false,16777215);
         }
         this._movie.addSceneAt(_loc8_,this._movie.currentIndex + param3);
         this.timeline.sceneLengthController.doChangeSceneLength(AnimeConstants.SCENE_LENGTH_DEFAULT,this.getSceneIndex(_loc8_),true);
         if(param2 != "")
         {
            _loc8_.deSerialize(XML(param2),true,true,false);
         }
         _loc8_.doUpdateTimelineLength();
         if(param4)
         {
            if(this._movie.currentIndex == this._movie.scenes.length - 1)
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._movie.currentIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._movie.currentIndex - 1).startPixel + this.timeline.getSceneInfoByIndex(this._movie.currentIndex - 1).totalPixel);
            }
            else
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._movie.currentIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._movie.currentIndex).startPixel);
            }
         }
         if(this._addBlankScene)
         {
            _loc7_ = new BitmapData(100,100,false,16777215);
         }
         if(_loc7_)
         {
            this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(_loc8_),_loc7_);
         }
         if(_loc9_ = this.getScene(this._movie.currentIndex + 1))
         {
            _loc9_.doUpdateTimelineLength();
            if(_loc6_)
            {
               this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(_loc9_),_loc6_);
            }
         }
         this.capScreenLock = false;
         return _loc8_;
      }
      
      private function onCommandAddedHandler(param1:CommandEvent) : void
      {
         this.mainStage.enableRedo(false);
      }
      
      public function get userTheme() : Theme
      {
         return this._userTheme;
      }
      
      private function onUserWannaSaveWork(param1:Event) : void
      {
         this.showPublishWindow();
      }
      
      private function onUpdateUserVideoAssetsComplete(param1:Event) : void
      {
         var _loc5_:ZipFile = null;
         var _loc6_:XML = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:Thumb = null;
         var _loc9_:ZipEntry = null;
         var _loc10_:int = 0;
         var _loc11_:CoreEvent = null;
         var _loc12_:ByteArray = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int = _loc3_.readByte();
         trace("returnCode:" + _loc4_);
         if(_loc4_ == 0)
         {
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            _loc5_ = new ZipFile(_loc3_);
            _loc6_ = new XML(_loc5_.getInput(_loc5_.getEntry("desc.xml")));
            this.userTheme.deSerialize(_loc6_);
            this._lastLoaddedTheme.clearAllThumbs();
            this._lastLoaddedTheme.deSerialize(_loc6_);
            _loc7_ = this._lastLoaddedTheme.propThumbs;
            _loc10_ = 0;
            while(_loc10_ < _loc7_.length)
            {
               _loc8_ = PropThumb(_loc7_.getValueByIndex(_loc10_));
               if((_loc9_ = _loc5_.getEntry(_loc8_.getFileName())) != null)
               {
                  _loc8_.imageData = _loc5_.getInput(_loc9_);
                  trace("thumb.id:" + _loc8_.id);
                  PropThumb(this._userTheme.propThumbs.getValueByKey(_loc8_.id)).imageData = _loc5_.getInput(_loc9_);
               }
               _loc10_++;
            }
            this.thumbTray.removeLoadingCanvas(this._loaddingAssetType);
            this.thumbTray.loadThumbs(this._lastLoaddedTheme,false,this.thumbTray._uiTileVideoPropUser);
            _loc11_ = new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this);
            this.onLoadUserThemeComplete(_loc11_);
         }
         else
         {
            _loc12_ = new ByteArray();
            _loc2_.readBytes(_loc12_);
            _logger.error("getUserAssets failed: \n" + _loc12_.toString());
            Alert.show("getUserAssets failed: \n" + _loc12_.toString());
         }
      }
      
      public function get mainStage() : MainStage
      {
         return this._mainStage;
      }
      
      private function onSceneUpHandler(param1:TimelineEvent) : void
      {
         if(this._movie.currentIndex != param1.index)
         {
            this._movie.currentIndex = param1.index;
         }
      }
      
      private function onGetCcCharCountComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = null;
         var _loc3_:String = null;
         var _loc4_:LoadCcCharCountEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onGetCcCharCountComplete);
         if(param1.type == Event.COMPLETE)
         {
            _loc2_ = param1.target as URLLoader;
            _loc3_ = _loc2_.data as String;
            if(_loc3_.length > 1 && _loc3_.charAt(0) == "0")
            {
               (_loc4_ = new LoadCcCharCountEvent(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this)).ccCharCount = Number(_loc3_.substr(1));
               this.dispatchEvent(_loc4_);
            }
         }
      }
      
      public function get currentLicensorName() : String
      {
         return this._currentLicensorName;
      }
      
      private function onSceneMoved(param1:MovieEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.sourceIndex >= 0 && param1.destIndex >= 0)
         {
            _loc2_ = this._stageViewStack.removeChildAt(param1.sourceIndex);
            if(param1.sourceIndex < param1.destIndex)
            {
               this._stageViewStack.addChildAt(_loc2_,param1.destIndex - 1);
            }
            else
            {
               this._stageViewStack.addChildAt(_loc2_,param1.destIndex);
            }
            this._stageViewStack.validateNow();
            this._timeline.moveScene(param1.sourceIndex,param1.destIndex);
         }
      }
      
      public function deserializeSound(param1:XML) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:AnimeSound = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:AnimeScene = null;
         var _loc10_:Character = null;
         _loc2_ = UtilXmlInfo.getAndSortXMLattribute(param1,"index",AnimeSound.XML_NODE_NAME);
         _loc3_ = 0;
         _loc4_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc4_];
            (_loc6_ = new AnimeSound()).deSerialize(_loc5_);
            if(_loc6_.startFrame < (this.timeline.getTotalTimeInSec() + 300) * AnimeConstants.FRAME_PER_SEC)
            {
               if(_loc6_.soundThumb != null)
               {
                  _loc7_ = 1;
                  if(_loc5_.attribute("vol").length() != 0)
                  {
                     _loc7_ = _loc5_.@vol;
                  }
                  if(_loc6_.soundThumb.ttsData)
                  {
                     _loc8_ = Console.getConsole().linkageController.getCharIdOfSpeech(_loc6_.getID());
                     if(_loc9_ = Console.getConsole().getScenebyId(AssetLinkage.getSceneIdFromLinkage(_loc8_)))
                     {
                        if(_loc10_ = _loc9_.getCharacterById(AssetLinkage.getCharIdFromLinkage(_loc8_)))
                        {
                           _loc10_.demoSpeech = true;
                        }
                        if(_loc6_.soundThumb.ttsData.type == "mic")
                        {
                           this.speechManager.micRecordingManager.addSoundBySound(_loc6_,false);
                        }
                        else if(_loc6_.soundThumb.ttsData.type == "file")
                        {
                           this.speechManager.voiceFileManager.addSoundBySound(_loc6_,false);
                        }
                        else
                        {
                           this.speechManager.ttsManager.addSoundBySound(_loc6_,false);
                        }
                        _loc9_.doUpdateTimelineLength(-1,true);
                     }
                  }
               }
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc4_];
            (_loc6_ = new AnimeSound()).deSerialize(_loc5_);
            if(_loc6_.startFrame < (this.timeline.getTotalTimeInSec() + 300) * AnimeConstants.FRAME_PER_SEC)
            {
               if(_loc6_.soundThumb != null)
               {
                  _loc7_ = 1;
                  if(_loc5_.attribute("vol").length() != 0)
                  {
                     _loc7_ = _loc5_.@vol;
                  }
                  if(!_loc6_.soundThumb.ttsData)
                  {
                     if(_loc5_.attribute("track").length() == 0)
                     {
                        this.addSound(_loc6_,UtilUnitConvert.frameToPixel(Number(_loc5_["start"].toString())),UtilUnitConvert.trackToPixel(Number(_loc3_)),_loc2_[_loc4_],false,true,_loc7_);
                        _loc3_ = _loc3_ == 3?0:int(_loc3_ + 1);
                     }
                     else
                     {
                        this.addSound(_loc6_,UtilUnitConvert.frameToPixel(Number(_loc5_["start"].toString())),UtilUnitConvert.trackToPixel(Number(_loc5_.@track.toString())),_loc2_[_loc4_],false,true,_loc7_);
                     }
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function doPrepareLoadCcCharComplete(param1:ByteArray) : void
      {
         var _loc4_:ZipFile = null;
         var _loc5_:ZipEntry = null;
         var _loc6_:XML = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:Thumb = null;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:CoreEvent = null;
         var _loc12_:ByteArray = null;
         var _loc13_:ZipFile = null;
         var _loc14_:XML = null;
         var _loc15_:ZipEntry = null;
         var _loc16_:ByteArray = null;
         var _loc17_:ZipEntry = null;
         var _loc18_:ZipFile = null;
         var _loc19_:int = 0;
         var _loc20_:ZipEntry = null;
         var _loc21_:ByteArray = null;
         param1.position = 0;
         var _loc2_:int = param1.readByte();
         var _loc3_:Array = new Array();
         trace("returnCode:" + _loc2_);
         if(_loc2_ == 0)
         {
            _loc4_ = new ZipFile(param1);
            _loc6_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            this._userTheme.deSerialize(_loc6_);
            this._lastLoaddedTheme.clearAllThumbs();
            this._lastLoaddedTheme.deSerialize(_loc6_);
            _loc7_ = this._lastLoaddedTheme.charThumbs;
            trace(_loc7_);
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length)
            {
               _loc8_ = CharThumb(_loc7_.getValueByIndex(_loc9_));
               _loc5_ = _loc4_.getEntry(_loc8_.getFileName());
               trace(_loc5_);
               _loc3_.push(_loc8_.id);
               if(_loc5_ != null)
               {
                  _loc12_ = _loc4_.getInput(_loc5_);
                  if(!CharThumb(_loc8_).isCC)
                  {
                     _loc8_.imageData = _loc4_.getInput(_loc5_);
                     trace("thumb.getFileName():" + _loc8_.getFileName());
                     CharThumb(this._userTheme.charThumbs.getValueByKey(_loc8_.id)).imageData = _loc4_.getInput(_loc5_);
                  }
                  else if(_loc8_.getFileName().indexOf("zip") >= 0)
                  {
                     _loc13_ = new ZipFile(_loc12_);
                     _loc8_.imageData = UtilPlain.convertZipAsImagedataObject(_loc13_);
                     trace(_loc8_.imageData);
                     if((_loc15_ = _loc4_.getEntry("char/" + _loc8_.id + "/" + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
                     {
                        _loc16_ = _loc4_.getInput(_loc15_) as ByteArray;
                        _loc18_ = new ZipFile(_loc16_);
                        _loc19_ = 0;
                        while(_loc19_ < _loc18_.size)
                        {
                           _loc17_ = _loc18_.entries[_loc19_];
                           CharThumb(_loc8_).addLibrary(_loc17_.name,_loc18_.getInput(_loc17_));
                           _loc19_++;
                        }
                     }
                  }
               }
               else
               {
                  _loc20_ = _loc4_.getEntry("char/" + _loc8_.id + "/" + _loc8_.id + ".png");
                  _loc8_.imageData = _loc4_.getInput(_loc20_);
                  CharThumb(this._userTheme.charThumbs.getValueByKey(_loc8_.id)).imageData = _loc4_.getInput(_loc20_);
                  _loc8_.useImageAsThumb = true;
               }
               _loc9_++;
            }
            this._userTheme.mergeTheme(this._lastLoaddedTheme);
            this.addTheme(this._userTheme.id,this._userTheme);
            this._thumbTray.removeLoadingCanvas(AnimeConstants.ASSET_TYPE_CHAR);
            (_loc10_ = new Object())["newCharIdArray"] = _loc3_;
            _loc10_["lastLoadedTheme"] = this._lastLoaddedTheme;
            _loc11_ = new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this,_loc10_);
            Console.getConsole().requestLoadStatus(false,true);
            this.dispatchEvent(_loc11_);
         }
         else
         {
            _loc21_ = new ByteArray();
            param1.readBytes(_loc21_);
            _logger.error("getUserAssets failed: \n" + _loc21_.toString());
            Alert.show("getUserAssets failed: \n" + _loc21_.toString());
         }
      }
      
      public function bringForward() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:Boolean = false;
         var _loc3_:Asset = null;
         var _loc4_:ICommand = null;
         if(this.isTutorialOn)
         {
            return;
         }
         _loc1_ = _console.currentScene;
         _loc2_ = _loc1_.bringForward();
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new BringForwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function get uploadType() : String
      {
         return this._uploadType;
      }
      
      public function getCurTheme() : Theme
      {
         return this._curTheme;
      }
      
      private function loadMovieById(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         var _loc5_:URLVariables = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:URLLoader = null;
         this._movieXML = null;
         _loc4_ = new URLVariables();
         _loc5_ = new URLVariables();
         _loc6_ = Util.getFlashVar();
         _loc5_[ServerConstants.PARAM_MOVIE_ID] = param1;
         _loc5_[ServerConstants.PARAM_USER_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_ID) as String;
         _loc5_[ServerConstants.PARAM_USER_TOKEN] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_TOKEN) as String;
         if(UtilLicense.isBoxEnvironment())
         {
            _loc5_[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
         }
         Util.addFlashVarsToURLvar(_loc4_);
         _loc2_ = ServerConstants.ACTION_GET_MOVIE + "?" + _loc5_.toString();
         _loc3_ = new URLRequest(_loc2_);
         _loc7_ = String(_loc4_[ServerConstants.PARAM_MOVIE_ID]);
         _loc8_ = String(_loc4_[ServerConstants.PARAM_ORIGINAL_ID]);
         if(_loc7_ != null && StringUtil.trim(_loc7_))
         {
            this.metaData.movieId = _loc7_;
         }
         else if(_loc8_ != null && StringUtil.trim(_loc8_))
         {
            _loc4_[ServerConstants.PARAM_MOVIE_ID] = _loc8_;
            this._originalId = _loc8_;
         }
         _loc4_[ServerConstants.PARAM_IS_EDIT_MODE] = "1";
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc4_;
         (_loc9_ = new URLLoader()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc9_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc9_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc9_.load(_loc3_);
      }
      
      public function premiumEnabled() : Boolean
      {
         return this._purchaseEnabled;
      }
      
      public function undo() : void
      {
         var _loc1_:CommandStack = null;
         var _loc2_:ICommand = null;
         this.currentScene.selectedAsset = null;
         _loc1_ = CommandStack.getInstance();
         if(_loc1_.hasPreviousCommands())
         {
            _loc2_ = _loc1_.previous();
            _loc2_.undo();
            Util.gaTracking("/gostudio/undo/" + _loc2_.toString(),Console.getConsole().mainStage.stage);
            if(!_loc1_.hasPreviousCommands())
            {
               this.enableUndo(false);
            }
            this.enableRedo(true);
         }
         this.refreshAllSpeechText();
      }
      
      public function get stageScale() : Number
      {
         return Console.getConsole().mainStage.zoomFactor;
      }
      
      public function addSound(param1:AnimeSound, param2:Number, param3:Number, param4:int = -1, param5:Boolean = false, param6:Boolean = false, param7:Number = 1) : void
      {
         this.sounds.push(param1.getID(),param1);
         param2 = UtilUnitConvert.snapToPixelWithTime(param2);
         var _loc8_:Number = UtilUnitConvert.snapToPixelWithTime(UtilUnitConvert.frameToPixel(param1.endFrame - param1.startFrame));
         this.timeline.addSoundAtTime(param1.getID(),param1.getLabel(),param2,param3,_loc8_,param4,param5,param6,param1.soundThumb.duration,param7);
         this.updateSoundById(param1.getID());
         this.stopAllSounds();
      }
      
      private function loadUserThemeIOErrorHandler(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeIOErrorHandler);
         this.loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      private function onLoadCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCcCharCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         this._byteArrayReturnFromLoadCcChar.push(this.getCurTheme().id,_loc3_);
         trace(_loc3_);
         this.doPrepareLoadCcCharComplete(_loc3_);
      }
      
      private function onSoundMouseDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
         this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
      }
      
      public function set tempPublished(param1:Boolean) : void
      {
         this._tempPublished = param1;
      }
      
      private function putFontData(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:FontManager = null;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         _loc3_ = FontManager.getFontManager();
         var _loc4_:UtilHashArray = _loc3_.getFonts().clone();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.getFonts().length)
         {
            _loc2_ = _loc3_.getFonts().getKey(_loc5_);
            if(param1.indexOf(_loc2_) > -1)
            {
               (_loc6_ = new ByteArray()).writeBytes(_loc3_.getFonts().getValueByKey(_loc2_) as ByteArray);
               this.putData(_loc3_.nameToFileName(_loc2_) + ".swf",_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function selectScene(param1:Number) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function get tipsLayer() : Canvas
      {
         return this._tipsLayer;
      }
      
      private function get externalPreviewPlayerController() : ExternalPreviewWindowController
      {
         return this._externalPreviewPlayerController;
      }
      
      public function set screenCapTool(param1:ScreenCapTool) : void
      {
         this._screenCapTool = param1;
      }
      
      public function initializeLoadingBar(param1:ProgressBar) : void
      {
         this._loadProgress = param1;
      }
      
      private function initAutoSave() : void
      {
         var _loc1_:Timer = new Timer(AnimeConstants.AUTOSAVE_INTERVAL);
         _loc1_.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
         _loc1_.start();
      }
      
      private function doGetCNUserScores(param1:Event) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLLoader = null;
         var _loc4_:int = 0;
         if(!this.unlockedAssets)
         {
            _loc2_ = UtilNetwork.getCNUserGameScoreRequest();
            _loc3_ = new URLLoader();
            _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc3_.addEventListener(Event.COMPLETE,this.onGetCNUserGameScoreComplete);
            this.unlockedAssets = [];
            _loc3_.load(_loc2_);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.unlockedAssets.length)
            {
               this._thumbTray.dispatchEvent(new CoreEvent(CoreEvent.UNLOCK_ASSET,this,this.unlockedAssets[_loc4_]));
               _loc4_++;
            }
         }
      }
      
      private function loadThumbnailCompleteHandle(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadThumbnailCompleteHandle);
         var _loc3_:ExtraDataLoader = ExtraDataLoader(_loc2_.loader);
         var _loc4_:Object = _loc3_.extraData;
         var _loc5_:BitmapData;
         (_loc5_ = new BitmapData(220,141)).draw(_loc3_);
         _loc3_ = null;
         this.timeline.updateSceneImageByBitmapData(_loc4_["_sci"],_loc5_);
      }
      
      public function checkMyCharNum() : void
      {
         this.addEventListener(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this.onGotCCCount);
         CursorManager.setBusyCursor();
         this.getCcCharCount();
      }
      
      public function enableUndo(param1:Boolean) : void
      {
         this.mainStage.enableUndo(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      private function setWhiteTerms(param1:String) : void
      {
         if(param1 != "")
         {
            this._whiteTerms = param1.split(",");
         }
      }
      
      public function get swfloader() : SWFLoader
      {
         return this._swfLoader;
      }
      
      public function set currentScene(param1:AnimeScene) : void
      {
         this._movie.currentScene = param1;
      }
      
      public function get publishW() : PublishWindow
      {
         return this._publishW;
      }
      
      public function closeImporter() : void
      {
         this._importer["close"]();
      }
      
      public function get isDeveloping() : Boolean
      {
         var _loc1_:String = null;
         _loc1_ = Util.getFlashVar().getValueByKey("apiserver") as String;
         return _loc1_.search("staging") > 0 || _loc1_.search("alvin") > 0;
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      private function doSaveMovieComplete(param1:Event) : void
      {
         var result:IDataInput = null;
         var checkCode:int = 0;
         var bytes:ByteArray = null;
         var currDate:Date = null;
         var localTime:String = null;
         var delaySaveComplete:Boolean = false;
         var i:int = 0;
         var sid:String = null;
         var bm:BitmapData = null;
         var pngEncoder:PNGEncoder = null;
         var barr:ByteArray = null;
         var flushStatus:String = null;
         var event:Event = param1;
         if(event.type != Event.COMPLETE)
         {
            _logger.error(event.toString());
         }
         else
         {
            currDate = new Date();
            localTime = UtilUnitConvert.getClockTime(currDate.getHours(),currDate.getMinutes());
            this.topButtonBar._btnSave.toolTip = UtilDict.toDisplay("go","topbtnbar_savenshare") + " (" + UtilDict.toDisplay("go","topbtnbar_lastsaved") + ": " + localTime + ")";
         }
         this.enableAfterSave();
         result = (event.target as MovieManager).data;
         checkCode = -1;
         if(result.bytesAvailable >= 1)
         {
            checkCode = result.readByte();
         }
         if(String.fromCharCode(checkCode) == "0" && event.type == Event.COMPLETE)
         {
            bytes = new ByteArray();
            result.readBytes(bytes);
            this.metaData.movieId = bytes.toString();
            this.tempMetaData.movieId = this.metaData.movieId;
            Application.application.parameters["movieId"] = this.metaData.movieId;
            if(this._isAutoSave)
            {
               this.mainStage.showAutoSaveHints();
            }
            this._movieXML = this._filmXML;
            delaySaveComplete = false;
            try
            {
               this.thumbSO = SharedObject.getLocal("studioThumbs_" + this.metaData.movieId);
            }
            catch(e:Error)
            {
               thumbSO = null;
            }
            if(this.thumbSO)
            {
               i = 0;
               while(true)
               {
                  if(i < this._movie.scenes.length)
                  {
                     sid = this.getScene(i).id;
                     bm = Console.getConsole().getThumbnailCaptureBySceneIndex(i);
                     pngEncoder = new PNGEncoder();
                     barr = pngEncoder.encode(bm);
                     barr.position = 0;
                     this.thumbSO.data[sid] = barr;
                     i++;
                     continue;
                  }
                  try
                  {
                     flushStatus = this.thumbSO.flush();
                     if(flushStatus == SharedObjectFlushStatus.PENDING)
                     {
                        this.thumbSO.addEventListener(NetStatusEvent.NET_STATUS,this.soStatusListener);
                        delaySaveComplete = true;
                        break;
                     }
                     if(flushStatus == SharedObjectFlushStatus.FLUSHED)
                     {
                     }
                     break;
                  }
                  catch(e:Error)
                  {
                  }
               }
            }
            if(!delaySaveComplete)
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
            }
         }
         else if(event.type == IOErrorEvent.IO_ERROR)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new IOError()));
         }
         else if(!(this._isAutoSave && event.type == IOErrorEvent.IO_ERROR))
         {
            bytes = new ByteArray();
            result.readBytes(bytes);
            _logger.error("return code is:" + checkCode + "\n error message: \n" + bytes.toString());
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new Error(bytes.toString())));
         }
         this._isAutoSave = false;
      }
      
      private function showActionShop(param1:String) : void
      {
         if(param1)
         {
            this.showActionShopWindow(param1);
         }
      }
      
      public function get sounds() : UtilHashArray
      {
         return this._sounds;
      }
      
      private function onLoadImporterFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this._extSwfContainer.removeChild(this._swfLoader);
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      public function loadCommonThemeProp() : void
      {
         var _loc1_:Theme = null;
         if(this._themes.containsKey("common"))
         {
            _loc1_ = this.getTheme("common");
         }
         else
         {
            _loc1_ = null;
            trace("Error: theme not found when loading bg zip with themeId:common");
         }
         if(_loc1_.isPropZipLoaded())
         {
            this.thumbTray.loadPropThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeProp = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc1_.loadProp();
      }
      
      public function doShowCopyMyCharAlert(param1:Event) : void
      {
         var _loc2_:GoAlert = null;
         _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc2_._lblConfirm.text = "";
         _loc2_._txtDelete.text = UtilDict.toDisplay("go","goalert_createMyChar");
         _loc2_._txtDelete.setStyle("textAlign","left");
         _loc2_._txtDelete.setStyle("fontSize","15");
         _loc2_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCreateMyChar);
         _loc2_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      public function alert(param1:String) : void
      {
         var _loc2_:GoPopUp = GoPopUp(PopUpManager.createPopUp(this.mainStage,GoPopUp,true));
         _loc2_.width = 400;
         _loc2_.addEventListener("okClick",this.onAlertOk);
         _loc2_.btnCancelVisible = false;
         _loc2_.text = UtilDict.toDisplay("go",param1);
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      private function set thumbSO(param1:SharedObject) : void
      {
         this._thumbSO = param1;
      }
      
      public function get currDragObject() : Asset
      {
         return this._currDragObject;
      }
      
      public function get scenes() : Array
      {
         return this._movie.scenes;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(param1 && !this._capScreenLock)
         {
            this.doUpdateTimeline(null,true);
            this.updateSceneLength();
         }
      }
      
      private function initTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,5,5,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","gotips_pleaseread");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",13);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).percentWidth = 80;
         _loc5_.setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","center");
         _loc5_.setStyle("horizontalCenter","1");
         _loc5_.setStyle("verticalScrollPolicy","off");
         var _loc6_:StyleSheet;
         (_loc6_ = new StyleSheet()).parseCSS(this.hoverStyles);
         var _loc7_:TextArea;
         (_loc7_ = new TextArea()).styleSheet = _loc6_;
         _loc7_.height = 100;
         _loc7_.selectable = false;
         _loc7_.htmlText = UtilDict.toDisplay("go","gotips_effectupdated");
         _loc7_.setStyle("fontSize",16);
         var _loc8_:TextArea;
         (_loc8_ = new TextArea()).styleSheet = _loc6_;
         _loc8_.selectable = false;
         _loc8_.htmlText = UtilDict.toDisplay("go","gotips_learnmore");
         _loc8_.setStyle("fontSize",16);
         _loc8_.setStyle("textAlign","right");
         _loc7_.verticalScrollPolicy = _loc8_.verticalScrollPolicy = "off";
         _loc7_.percentWidth = _loc8_.percentWidth = 100;
         _loc7_.selectable = _loc8_.selectable = false;
         _loc7_.editable = _loc8_.editable = false;
         _loc7_.setStyle("backgroundAlpha","0");
         _loc8_.setStyle("backgroundAlpha","0");
         _loc7_.setStyle("borderStyle","none");
         _loc8_.setStyle("borderStyle","none");
         _loc5_.addChild(_loc7_);
         _loc5_.addChild(_loc8_);
         _loc2_._content.height = 140;
         _loc2_.setContent(_loc5_);
         var _loc9_:Canvas;
         (_loc9_ = new Canvas()).width = _loc2_.width;
         _loc9_.setStyle("horizontalCenter","1");
         _loc9_.buttonMode = true;
         var _loc10_:Label;
         (_loc10_ = new Label()).text = UtilDict.toDisplay("go","gotips_close");
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = true;
         _loc10_.mouseChildren = false;
         _loc10_.x = (_loc9_.width - 80) / 2;
         _loc10_.setStyle("fontSize",14);
         _loc10_.addEventListener(MouseEvent.CLICK,this.closeTip);
         _loc9_.addChild(_loc10_);
         _loc2_.setClose(_loc9_);
      }
      
      public function alertSceneXml() : void
      {
         var _loc1_:XML = null;
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:XML = null;
         _loc1_ = this.serialize();
         _loc2_ = _loc1_.child("scene")[0] as XML;
         _loc3_ = "";
         for each(_loc4_ in _loc2_.children())
         {
            _loc3_ = _loc3_ + (_loc4_.toXMLString() + "\n");
         }
         Alert.show(_loc3_,"Scene XML");
      }
      
      public function showShareWindow(param1:Event) : void
      {
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            return;
         }
         CursorManager.setBusyCursor();
         this.requestLoadStatus(true,true);
         if(this._publishW != null)
         {
            this._publishW.setBtnStatus(false);
         }
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = decodeURI(_loc2_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String);
         var _loc4_:RegExp = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc3_ = _loc3_.replace(_loc4_,this.metaData.movieId);
         var _loc5_:URLVariables = new URLVariables();
         var _loc6_:URLRequest = null;
         if(Console.getConsole().boxMode)
         {
            if(this.movie.privateShared || this.movie.published)
            {
               _loc3_ = _loc3_.replace(/#/,"&goemail=goemail#");
            }
            _loc3_ = _loc3_.replace(/v=(\d+)/,"v=" + new Date().time.toString());
            (_loc6_ = new URLRequest(_loc3_)).method = URLRequestMethod.GET;
         }
         else
         {
            if(this.movie.privateShared || this.movie.published)
            {
               _loc5_["goemail"] = "goemail";
            }
            _loc5_["movieId"] = this.metaData.movieId;
            (_loc6_ = new URLRequest(_loc3_)).method = URLRequestMethod.POST;
            _loc6_.data = _loc5_;
         }
         ExternalInterface.call("exitStudio",this.movie.privateShared || this.movie.published?"1":"0");
         navigateToURL(_loc6_,"_self");
      }
      
      private function onPreparedThumbnailScene(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onPreparedThumbnailScene);
         setTimeout(this.saveMovie,500);
      }
      
      private function doAutoSave() : void
      {
         if(this._initialized == true)
         {
            if(UtilUser.loggedIn)
            {
               if(this._publishW == null)
               {
                  this._isAutoSave = true;
                  if(this.metaData.movieId == null)
                  {
                     this.genDefaultTags();
                     this._metaData = this._tempMetaData;
                  }
                  this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
                  this.saveMovie();
               }
            }
            else
            {
               this.mainStage.showAutoSaveHints();
            }
         }
      }
      
      private function onAlertOk(param1:Event) : void
      {
         PopUpManager.removePopUp(GoPopUp(param1.target));
      }
      
      public function addSceneOnDeserialize() : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:AnimeScene = null;
         var _loc6_:Boolean = false;
         var _loc7_:ByteArray = null;
         var _loc8_:ExtraDataLoader = null;
         var _loc9_:Object = null;
         var _loc1_:XML = this._movieXML;
         var _loc2_:Number = _loc1_.scene.length();
         if(this._sci < _loc2_)
         {
            this.requestLoadStatus(true,true);
            _loc3_ = _loc1_.child(AnimeScene.XML_NODE_NAME)[this._sci];
            if(this.isSceneGotoBuild(_loc3_))
            {
               _loc4_ = _loc3_.@id;
               _loc5_ = this.addScene(_loc4_);
               this.capScreenLock = true;
               _loc6_ = true;
               if(this.thumbSO && this.thumbSO.size > 0)
               {
                  if(_loc7_ = this.thumbSO.data[_loc4_] as ByteArray)
                  {
                     _loc7_.position = 0;
                     _loc8_ = new ExtraDataLoader();
                     (_loc9_ = new Object())["_sci"] = this._sci;
                     _loc8_.extraData = _loc9_;
                     _loc8_.loadBytes(_loc7_);
                     _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadThumbnailCompleteHandle);
                     _loc6_ = false;
                  }
               }
               if(_loc2_ > 1)
               {
                  if(_loc6_)
                  {
                     _loc5_.eventDispatcher.addEventListener(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this.onSceneComplete);
                     _loc5_.deSerialize(_loc3_,true,_loc6_);
                  }
                  else
                  {
                     _loc5_.sceneXML = _loc3_;
                     _loc5_.deserializeSceneLength(_loc3_);
                     setTimeout(this.addSceneOnDeserialize,250);
                  }
               }
               else
               {
                  _loc5_.eventDispatcher.addEventListener(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this.onSceneComplete);
                  _loc5_.deSerialize(_loc3_,true,true,false);
               }
            }
            else
            {
               setTimeout(this.addSceneOnDeserialize,250);
            }
         }
         if(this._sci == _loc2_)
         {
            this.capScreenLock = false;
            this.requestLoadStatus(false,true,_loc2_);
            if(_loc2_ > 0 && this.studioType != MESSAGE_STUDIO)
            {
               this.setCurrentScene(0);
               this.currentScene.unloadAllAssets();
               this.currentScene.loadAllAssets();
               this.timeline._timelineScrollbar.scrollPosition = 0;
               this.timeline._timelineScrollbar.dispatchEvent(new Event(ScrollEvent.SCROLL));
            }
            this.deserializeLinkage(_loc1_);
            this.deserializeSound(_loc1_);
            this.refreshAllSpeechText();
            this._initialized = true;
            if(this.metaData.mver <= 2 && UtilLicense.isEffectChangeTipsShouldBeShown(UtilLicense.getCurrentLicenseId()))
            {
               this.showTip();
            }
         }
         ++this._sci;
      }
      
      private function addSceneCtrl(param1:AnimeScene) : void
      {
         this._timeline.addScene(param1.id,Timeline.BITMAP,0,param1);
      }
      
      public function clearCurrentScene() : void
      {
         var _loc1_:ICommand = null;
         this.mainStage.hideCameraView();
         _loc1_ = new ClearSceneCommand();
         _loc1_.execute();
         this._movie.clearCurrentScene();
      }
      
      private function loadThemeBgComplete(param1:CoreEvent) : void
      {
         var _loc2_:Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemeBgComplete);
         _loc2_ = param1.getEventCreater() as Theme;
         this.thumbTray.loadBackgroundThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeBg && _loc2_.isBgZipLoaded())
         {
            this.loadCommonThemeBg();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/bg",Console.getConsole().mainStage.stage);
         }
      }
      
      public function changeBubbleMsg(param1:BubbleAsset, param2:String) : void
      {
         param1.text = param2;
         param1.bubble.backupText = param2;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function setCurrentSceneById(param1:String) : void
      {
         var _loc2_:int = this._movie.getSceneIndex(this._movie.getSceneById(param1));
         this.setCurrentScene(_loc2_);
      }
      
      public function set selectedThumbnailIndex(param1:int) : void
      {
         this._selectedThumbnailIndex = param1;
      }
      
      private function doUpdateTimeline(param1:Event, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         this._stageViewStack.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.doUpdateTimeline);
         if(!this._capScreenLock)
         {
            if(this._movie.currentScene != null)
            {
               this._stageViewStack.selectedChild = this._movie.currentScene.canvas;
               if(this._defaultUpdateAllTimelineImage)
               {
                  trace("RUN doupdatetimeline... full #######################################");
                  _loc3_ = 0;
                  while(_loc3_ < this._movie.scenes.length)
                  {
                     this.timeline.setSceneTarget(this._movie.getSceneAt(_loc3_).canvas,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
                     this._movie.getSceneAt(_loc3_).unloadAllAssets();
                     _loc3_++;
                  }
                  if(this._movie.scenes.length > 1)
                  {
                     this._defaultUpdateAllTimelineImage = false;
                  }
               }
               else
               {
                  _loc3_ = this._movie.currentIndex;
                  this.doUpdateTimelineByScene(this.getScene(_loc3_));
               }
            }
         }
      }
      
      public function set currentLicensorName(param1:String) : void
      {
         this._currentLicensorName = param1;
      }
      
      public function removeGuideBubbles() : void
      {
         this._needGuideBubbles = false;
         if(this._bubbleSceneGuide != null)
         {
            this.hideGuideSceneBub();
         }
         if(this._bubbleThumbGuide != null)
         {
            this.hideGuideThumbBub();
         }
      }
      
      private function onUpdateAssetComplete(param1:Event = null) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.UPDATE_ASSET_COMPLETE,this));
      }
      
      public function getCcCharCount() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         _loc1_ = new URLLoader();
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_CC_CHAR_COUNT);
         _loc2_.method = URLRequestMethod.POST;
         _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc3_ = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc2_.data = _loc3_;
         _loc1_.addEventListener(Event.COMPLETE,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCcCharCountComplete);
         _loc1_.load(_loc2_);
      }
      
      public function onTestButtonClick() : void
      {
         this.showUpgradePopup();
      }
      
      private function doLoadMovie(param1:Event) : void
      {
         var idToLoad:String = null;
         var movieId:String = null;
         var originalId:String = null;
         var shouldLoadExistMovie:Boolean = false;
         var turnOffLoading:Function = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.doLoadMovie);
         this.onStudioReady();
         idToLoad = "";
         movieId = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String;
         originalId = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         shouldLoadExistMovie = false;
         if(movieId != null && StringUtil.trim(movieId).length > 0)
         {
            shouldLoadExistMovie = true;
            idToLoad = movieId;
         }
         else if(originalId != null && StringUtil.trim(originalId).length > 0)
         {
            shouldLoadExistMovie = true;
            idToLoad = originalId;
         }
         if(shouldLoadExistMovie)
         {
            this.requestLoadStatus(true,true);
            turnOffLoading = function(... rest):void
            {
               var _loc2_:Console = null;
               var _loc3_:ItemClickEvent = null;
               _loc2_ = Console.getConsole();
               _loc2_.requestLoadStatus(false,true);
               if(studioType == MESSAGE_STUDIO)
               {
                  _loc3_ = new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
                  _loc3_.index = 1;
                  thumbTray.onClickThemeButton(_loc3_);
                  thumbTray.VSThumbTray.selectedChild = thumbTray._uiCanvasUser;
               }
            };
            this.addEventListener(CoreEvent.LOAD_MOVIE_COMPLETE,turnOffLoading);
            this.loadMovieById(idToLoad);
         }
         else
         {
            this.trackInitialTheme();
            this.newAnimation();
            this._initialized = true;
            Util.gaTracking("/gostudio/themeCompleted",Console.getConsole().mainStage.stage);
         }
      }
      
      public function addTheme(param1:String, param2:Theme) : void
      {
         var _loc3_:Theme = null;
         if(this._themes.getValueByKey(param1) == null)
         {
            this._themes.push(param1,param2);
         }
         else
         {
            _loc3_ = this._themes.getValueByKey(param1) as Theme;
            _loc3_.mergeTheme(param2);
            this._themes.push(param1,_loc3_);
         }
      }
      
      private function onSoundMoveHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getValueByKey(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel + _loc3_.totalPixel);
         _loc4_.trackNum = UtilUnitConvert.pixelToTrack(_loc3_.y);
         trace("on sound move:" + _loc4_.trackNum);
      }
      
      private function stopScene(param1:Function, param2:Number) : void
      {
         var _loc3_:AnimeScene = null;
         var _loc4_:int = 0;
         if(param2 > 0)
         {
            param2--;
            Console.getConsole().mainStage.callLater(param1,new Array(param1,param2));
         }
         else
         {
            _loc4_ = 1;
            while(_loc4_ < this._movie.scenes.length)
            {
               _loc3_ = Console.getConsole().getScene(_loc4_);
               _loc3_.stopScene();
               _loc4_++;
            }
         }
      }
      
      private function showTransactionPopUp() : void
      {
         UtilUser.showUpdatePopUp();
      }
      
      public function get topButtonBar() : TopButtonBar
      {
         return this._topButtonBar;
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = this._movie.scenes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this._movie.getSceneAt(_loc3_).replaceBubbleText(param1,param2);
            _loc3_++;
         }
      }
      
      private function onSceneRemoved(param1:MovieEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.index >= 0)
         {
            _loc2_ = this._stageViewStack.removeChildAt(param1.index);
            this._stageViewStack.validateNow();
            _loc2_ = null;
            this._timeline.removeScene(param1.index);
         }
      }
      
      private function closePopUp(param1:Event) : void
      {
         PopUpManager.removePopUp(Canvas(param1.target));
         this._popUp = null;
      }
      
      public function updateScLnCtrlPerf(param1:String) : void
      {
         this.timeline.sceneLengthController.userPreference = param1;
      }
      
      public function set uploadType(param1:String) : void
      {
         this._uploadType = param1;
      }
      
      public function playScene(param1:Boolean) : void
      {
         if(param1)
         {
            this.currentScene.playScene();
         }
         else
         {
            this.currentScene.stopScene();
         }
      }
      
      public function pasteScene(param1:Number = 1) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:AnimeScene = null;
         var _loc5_:ICommand = null;
         if(this._movie.copiedScene)
         {
            _loc2_ = this.currentScene.id;
            _loc3_ = this.timeline.getAllSoundInfo();
            _loc4_ = this.addScene("",this._movie.copiedScene,param1);
            this._movie.copiedScene = null;
            (_loc5_ = new AddSceneCommand(_loc4_.id,_loc3_)).execute();
         }
      }
      
      private function hideGuideThumbBub(param1:Event = null) : void
      {
         this.thumbTray.removeEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
         if(this._bubbleThumbGuide != null)
         {
            this._bubbleThumbGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
            this.hideGuideBubble(this._bubbleThumbGuide);
         }
      }
      
      private function onLoadFontsDone(param1:LoadMgrEvent = null) : void
      {
         this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
      }
      
      public function get searchedTheme() : Theme
      {
         return this._searchedTheme;
      }
      
      public function newAnimation(param1:Boolean = true) : void
      {
         if(this.currentScene != null)
         {
            this.currentScene.removeSound();
         }
         this._isMovieNew = true;
         this.stopAllSounds();
         if(this._movie.scenes.length > 0)
         {
            this.clearScenes();
         }
         if(this.sounds.length > 0)
         {
            this.removeAllSounds();
         }
         var _loc2_:AnimeScene = this.addScene();
         this.setCurrentSceneById(_loc2_.id);
         CommandStack.getInstance().reset();
         this._metaData = this._tempMetaData = new MetaData();
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this.movie.published = this._tempPublished = false;
            this.movie.privateShared = this._tempPrivateShared = false;
         }
         else
         {
            this.movie.published = this._tempPublished = false;
            this.movie.privateShared = this._tempPrivateShared = UtilSite.siteId == UtilSite.GOANIMATE;
         }
         if(this._thumbTray.fullReady())
         {
            if(param1)
            {
               this.addRandomAssetsToScene(this._curTheme,this._movie.currentScene);
            }
         }
         if(this._guideMode == ServerConstants.FLASHVAR_TM_NEW || this._guideMode == ServerConstants.FLASHVAR_TM_SEMI)
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE)
            {
            }
            this.goWalker.addEventListener(TutorialEvent.TUTORIAL_DONE,this.onTutorialDone);
            this._thumbTray.isTutorialOn = true;
            this.goWalker.startTutorial();
            this._needGuideBubbles = false;
         }
         if(this._needGuideBubbles && (this.studioType == TINY_STUDIO || this.studioType == FULL_STUDIO))
         {
            this.addGuideBubbles();
         }
         this.onStudioReady();
      }
      
      public function addNextScene(param1:Boolean = false) : void
      {
         var _loc2_:GoAlert = null;
         this.hideGuideSceneBub();
         this._addBlankScene = param1;
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if(this._movie.scenes.length >= this.MAX_SCENE_NUMBER)
            {
               _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
               _loc2_.hideCloseBtn();
               _loc2_.alertTitle = UtilDict.toDisplay("go","Oops...");
               _loc2_.alertContent = UtilDict.toDisplay("go","Your BASIC account can only create up to " + this.MAX_SCENE_NUMBER + " scenes. To remove this limit, please upgrade your account to GoPlus!");
               _loc2_.okButton = UtilDict.toDisplay("go","Upgrade Now");
               _loc2_.cancelButton = UtilDict.toDisplay("go","Later");
               _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.onUpgradeBtnClick);
               _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
               _loc2_.y = 100;
               return;
            }
         }
         if(this.myAnimatedMask.isplaying)
         {
            this.myAnimatedMask.stopDrawing();
         }
         this.myAnimatedMask.addEventListener("EventFinished",this.rdyToAddScene);
         this.myAnimatedMask.startDrawing(this.mainStage._addSceneEffectLayer);
      }
      
      public function onGotCCCount(param1:LoadCcCharCountEvent) : void
      {
         CursorManager.removeBusyCursor();
         if(param1.ccCharCount > 0)
         {
            this.thumbTray.switchTheme(ThumbTray.COMMON_THEME);
            this.thumbTray.loadCcTheme(ThumbTray.THEME_ID_CUSTOM_WORLD);
         }
         else
         {
            this.doShowCreateMyCharAlert();
         }
      }
      
      private function doShowNoSaveAlert(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowNoSaveAlert);
         var _loc2_:noSaveAlertWindow = noSaveAlertWindow(PopUpManager.createPopUp(this.mainStage,noSaveAlertWindow,true));
         _loc2_.x = (this.mainStage.stage.width - _loc2_.width) / 2;
         _loc2_.y = this.mainStage.y;
         this._topButtonBar._btnSave.enabled = false;
         this._topButtonBar._btnSave.styleName = "btnSaveFullDisabled";
         this._topButtonBar._btnSave.toolTip = "";
         this._topButtonBar._btnSave.addEventListener(MouseEvent.MOUSE_OVER,this.showNoSaveTips);
      }
      
      private function trackInitialTheme() : void
      {
         var _loc1_:UtilHashArray = null;
         var _loc4_:String = null;
         _loc1_ = Util.getFlashVar();
         var _loc2_:String = String(_loc1_.getValueByKey(ServerConstants.FLASHVAR_DEFAULT_TRAYTHEME));
         var _loc3_:String = String(_loc1_.getValueByKey(ServerConstants.FLASHVAR_THEME_ID));
         _loc4_ = this.getCurTheme().id;
         this._initThemeCode = _loc4_;
      }
      
      public function loadCommonTheme() : void
      {
         var commonTheme:Theme = null;
         Util.gaTracking("/gostudio/themes/loading/common",Console.getConsole().mainStage.stage);
         if(this._themes.containsKey("common"))
         {
            commonTheme = this._themes.getValueByKey("common") as Theme;
         }
         else
         {
            commonTheme = new Theme();
            commonTheme.id = "common";
            if(this._purchasedAssetsXML != null)
            {
               commonTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == "common"));
            }
         }
         this._isLoaddingCommonTheme = true;
         commonTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         commonTheme.initThemeByLoadThemeFile(this,"common");
      }
      
      public function showPublishWindow() : void
      {
         var _loc1_:Number = NaN;
         if(this.mainStage.currentScene == null || this._isAutoSave)
         {
            return;
         }
         this.mainStage.currentScene.selectedAsset = null;
         this.genDefaultTags();
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc1_ = Util.roundNum(Console.getConsole().timeline.getTotalTimeInSec());
            if(_loc1_ > FeatureManager.maxMovieDuration)
            {
               Console.getConsole().alert(UtilDict.toDisplay("go","At this time, only videos shorter than 2 minutes can be exported.  Please shorten your video."));
               return;
            }
         }
         this.publishW = PublishWindow(PopUpManager.createPopUp(Application.application as DisplayObject,PublishWindow,true));
         this.publishW.initPublishWindow(null,this.movie.published,this.movie.privateShared,this.getThumbnailCaptures(),this.tempMetaData.title,this.tempMetaData.getUgcTagString(),this.tempMetaData.description,this.tempMetaData.lang);
         PopUpManager.centerPopUp(this.publishW);
         this.publishW.y = 100;
         if(!UtilUser.loggedIn)
         {
            Util.gaTracking("/gostudio/action/save-with-no-account",Console.getConsole().mainStage.stage);
         }
      }
      
      public function showCopyMyChar(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         _loc2_ = (param1.target as DisplayObject).name.split("|");
         _loc3_ = ServerConstants.CC_PAGE_PATH;
         if(_loc2_[0])
         {
            _loc3_ = _loc3_ + ("/" + _loc2_[0]);
         }
         navigateToURL(new URLRequest(_loc3_ + "/copy/" + _loc2_[1]),ServerConstants.POPUP_WINDOW_NAME);
      }
      
      private function onGetCustomAssetComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:Thumb = null;
         var _loc6_:XML = null;
         var _loc7_:SoundThumb = null;
         var _loc8_:EffectThumb = null;
         var _loc9_:SuperEffect = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:Image = null;
         var _loc12_:Loader = null;
         var _loc13_:Image = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"]();
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc3_ = _loc2_.readByte();
            _loc4_ = new ByteArray();
            _loc2_.readBytes(_loc4_);
            if(!(_loc3_ % 48 == 0 && param1.type == Event.COMPLETE))
            {
               _logger.error("return code is:" + _loc3_ + "\n error message: \n" + _loc4_.toString());
               Alert.show("the return code is: " + _loc3_ + "\n error message: \n" + _loc4_.toString());
               if(this._importer != null)
               {
                  this._importer["error"](null);
               }
               throw new Error("load asset by id failed.");
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._placeable = true;
               _loc5_ = new BackgroundThumb();
               _loc5_.id = _loc5_.thumbId = this._uploadedAssetXML.file;
               _loc5_.name = this._uploadedAssetXML.title;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.theme = Console.getConsole().userTheme;
               _loc5_.imageData = _loc5_.thumbImageData = _loc4_;
               _loc5_.enable = true;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
               this.userTheme.backgroundThumbs.push(_loc5_.id,_loc5_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
            {
               this._holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR?true:false;
               this._headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD?true:false;
               this._placeable = true;
               (_loc5_ = new PropThumb()).id = this._uploadedAssetXML.file;
               _loc5_.name = this._uploadedAssetXML.title;
               _loc5_.theme = Console.getConsole().userTheme;
               _loc5_.imageData = _loc4_;
               PropThumb(_loc5_).placeable = true;
               PropThumb(_loc5_).holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR?true:false;
               PropThumb(_loc5_).headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD?true:false;
               PropThumb(_loc5_).facing = AnimeConstants.FACING_LEFT;
               _loc5_.enable = true;
               _loc5_.tags = this._uploadedAssetXML.tags;
               _loc5_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
               this.userTheme.propThumbs.push(_loc5_.id,_loc5_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               this._placeable = true;
               _loc6_ = new XML("<theme>" + this._uploadedAssetXML.toString() + "</theme>");
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  ((_loc5_ = new CharThumb()) as CharThumb).deSerialize(this._uploadedAssetXML,Console.getConsole().userTheme);
                  (_loc5_ as CharThumb).imageData = _loc4_;
                  (_loc5_ as CharThumb).name = this._uploadedAssetXML.@name;
                  Console.getConsole().userTheme.mergeThemeXML(_loc6_);
               }
               else
               {
                  (_loc5_ = new EffectThumb()).imageData = _loc4_;
                  _loc5_.deSerialize(this._uploadedAssetXML,Console.getConsole().userTheme);
                  Console.getConsole().userTheme.mergeThemeXML(_loc6_);
               }
               if(Boolean(this._importer["oldChar"]))
               {
                  this._importer["success"]();
                  return;
               }
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this.getTheme("ugc").charThumbs.push(_loc5_.id,_loc5_);
                  this.userTheme.charThumbs.push(_loc5_.id,_loc5_);
               }
               else
               {
                  this.userTheme.effectThumbs.push(_loc5_.id,_loc5_);
               }
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc7_ = new SoundThumb()).deSerializeByUserAssetXML(this._uploadedAssetXML,this.userTheme);
               (_loc5_ = _loc7_).enable = true;
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc5_ as SoundThumb).addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.onLoadCustomAssetImageComplete);
               (_loc5_ as SoundThumb).initSoundByByteArray(_loc4_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               (_loc9_ = (_loc8_ = _loc5_ as EffectThumb).getNewEffect()).addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc10_ = _loc9_.loadThumbnail(_loc8_.imageData as ByteArray);
               (_loc11_ = new Image()).addChild(_loc10_);
               _loc11_.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.doDrag);
            }
            else
            {
               (_loc12_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc12_.loadBytes(_loc4_);
               _loc12_.name = "imageLoader";
               (_loc13_ = new Image()).addChild(_loc12_);
               _loc13_.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.doDrag);
            }
         }
      }
      
      private function setCurTheme(param1:Theme) : void
      {
         this._curTheme = param1;
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         if(_loc2_ != null)
         {
            trace("onSoundResizeStart,soundId:" + _loc2_);
            this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
            trace("onSoundResizeStart:" + this._prevSoundInfo);
         }
      }
      
      private function loadThemePropComplete(param1:CoreEvent) : void
      {
         var _loc2_:Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemePropComplete);
         _loc2_ = param1.getEventCreater() as Theme;
         this.thumbTray.loadPropThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeProp)
         {
            this.loadCommonThemeProp();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/prop",Console.getConsole().mainStage.stage);
         }
      }
      
      public function doNewAnimation() : void
      {
         Alert.buttonWidth = 100;
         var _loc1_:GoAlert = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true));
         _loc1_._lblConfirm.text = "";
         _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_newanimation");
         _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc1_._btnCancel.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = (_loc1_.stage.height - _loc1_.height) / 3;
         _loc1_.hideCloseBtn();
      }
      
      public function set tipsLayer(param1:Canvas) : void
      {
         this._tipsLayer = param1;
      }
      
      private function set externalPreviewPlayerController(param1:ExternalPreviewWindowController) : void
      {
         this._externalPreviewPlayerController = param1;
      }
      
      public function invisibleImporter() : void
      {
         this._swfLoader.visible = false;
         this._extSwfContainer.visible = false;
      }
      
      public function getBadTerms() : Array
      {
         if(this._badTerms != null)
         {
            return this._badTerms;
         }
         return null;
      }
      
      public function get stageViewStage() : ViewStack
      {
         return this._stageViewStack;
      }
      
      public function showInspirationWindow(param1:Event = null) : void
      {
         var app:Application = null;
         var e:Event = param1;
         if(!this._extSwfContainer.contains(this._inspirationLoader))
         {
            this._inspirationLoader.percentWidth = 100;
            this._inspirationLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._inspirationLoader);
         }
         if(this._inspirationLoader.content == null)
         {
            this._inspirationLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadInspirationFail);
            this._inspirationLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _inspirationLoader.y = 0;
               _inspirationLoader.visible = true;
               CursorManager.removeBusyCursor();
               _inspirationLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  try
                  {
                     app = Application(SystemManager(_inspirationLoader.content).application);
                     app["init"](Application.application._console);
                     if(e is TutorialEvent)
                     {
                        app["showQuickMenu"](true);
                     }
                     else
                     {
                        app["showQuickMenu"](false);
                        app["showOpenedImage"]();
                     }
                     _inspirationLoader.content.removeEventListener(Event.RENDER,f);
                  }
                  catch(err:TypeError)
                  {
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._inspirationLoader.source = ServerConstants.SERVER_INSPIRATION_PATH;
            this._inspirationLoader.load();
         }
         else
         {
            this._inspirationLoader.visible = true;
            app = Application(SystemManager(this._inspirationLoader.content).application);
            app["showOpenedImage"]();
         }
         this._extSwfContainer.visible = true;
         this._guideMode = ServerConstants.FLASHVAR_TM_FIN;
      }
      
      public function redo() : void
      {
         var _loc1_:CommandStack = null;
         var _loc2_:ICommand = null;
         this.currentScene.selectedAsset = null;
         _loc1_ = CommandStack.getInstance();
         if(_loc1_.hasNextCommands())
         {
            _loc2_ = _loc1_.next();
            if(_loc2_ is ICommand)
            {
               ICommand(_loc2_).redo();
               Util.gaTracking("/gostudio/redo/" + _loc2_.toString(),Console.getConsole().mainStage.stage);
            }
            if(!_loc1_.hasNextCommands())
            {
               this.enableRedo(false);
            }
            this.enableUndo(true);
         }
         this.refreshAllSpeechText();
      }
      
      public function get currentSceneIndex() : Number
      {
         return this._movie.currentIndex;
      }
      
      public function calculateUsedBytes() : String
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         _loc1_ = Number(System.totalMemory / Math.pow(2,20));
         _loc2_ = 2;
         return _loc1_.toFixed(_loc2_).toString();
      }
      
      function updateSceneLength() : void
      {
         this.currentScene.doUpdateTimelineLength();
      }
      
      public function clearBubbleText(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BubbleAsset = null;
         _loc4_ = this._movie.scenes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < this._movie.getSceneAt(_loc2_).bubbles.length)
            {
               if((_loc5_ = BubbleAsset(this._movie.getSceneAt(_loc2_).bubbles.getValueByIndex(_loc3_))).bubble.backupText != "" && param1 == false)
               {
                  _loc5_.bubble.text = _loc5_.bubble.backupText;
               }
               else
               {
                  _loc5_.bubble.backupText = _loc5_.bubble.text;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get boxMode() : Boolean
      {
         return this._boxMode;
      }
      
      public function serializeSound(param1:Boolean = true) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:AnimeSound = null;
         _loc2_ = "";
         _loc3_ = 0;
         while(_loc3_ < this.sounds.length)
         {
            _loc4_ = this.sounds.getValueByIndex(_loc3_) as AnimeSound;
            _loc2_ = _loc2_ + _loc4_.serialize(param1,false,new Object());
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function showNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = new VBox();
         _loc2_.styleName = "vboxNoSave";
         _loc2_.setStyle("paddingTop","12");
         _loc2_.width = 400;
         _loc2_.height = 150;
         _loc2_.x = this._topButtonBar._btnSave.x + this._topButtonBar.x - _loc2_.width + this._topButtonBar._btnSave.width;
         _loc2_.y = this._topButtonBar._btnSave.y + this._topButtonBar.y;
         var _loc3_:TextArea = new TextArea();
         var _loc4_:TextArea = new TextArea();
         var _loc5_:StyleSheet;
         (_loc5_ = new StyleSheet()).parseCSS(this.hoverStyles);
         _loc3_.styleSheet = _loc4_.styleSheet = _loc5_;
         _loc3_.verticalScrollPolicy = _loc4_.verticalScrollPolicy = "off";
         _loc3_.htmlText = UtilDict.toDisplay("go","nstip_title1");
         _loc4_.htmlText = UtilDict.toDisplay("go","nstip_title2");
         _loc3_.percentWidth = _loc4_.percentWidth = 100;
         _loc3_.styleName = _loc4_.styleName = "textNormal";
         _loc3_.selectable = _loc4_.selectable = false;
         _loc3_.editable = _loc4_.editable = false;
         _loc3_.setStyle("textAlign","center");
         _loc4_.setStyle("textAlign","center");
         _loc3_.setStyle("backgroundAlpha","0");
         _loc4_.setStyle("backgroundAlpha","0");
         _loc3_.setStyle("borderStyle","none");
         _loc4_.setStyle("borderStyle","none");
         var _loc6_:Spacer;
         (_loc6_ = new Spacer()).percentHeight = 100;
         var _loc7_:Text;
         (_loc7_ = new Text()).text = UtilDict.toDisplay("go","nstip_title3");
         _loc7_.percentWidth = 100;
         _loc7_.styleName = "textSmall";
         _loc7_.selectable = false;
         _loc7_.setStyle("textAlign","right");
         _loc7_.setStyle("color","#666666");
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc4_);
         _loc2_.addChild(_loc6_);
         _loc2_.addChild(_loc7_);
         _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
         this.tipsLayer.addChild(_loc2_);
      }
      
      public function clearScenes() : void
      {
         if(this._movie.scenes.length > 0)
         {
            this._movie.removeAllScene();
            this._stageViewStack.removeAllChildren();
            this._timeline.removeAllScenes();
            this._timeline.removeAllSounds();
         }
      }
      
      private function onStudioReady(param1:Event = null) : void
      {
         this._studioProgress.visible = false;
         this._isStudioReady = true;
      }
      
      private function doAddScene() : void
      {
         var _loc1_:Array = null;
         var _loc2_:AnimeScene = null;
         var _loc3_:ICommand = null;
         if(this.currentScene)
         {
            this.currentScene.selectedAsset = null;
         }
         _loc1_ = this.timeline.getAllSoundInfo();
         _loc2_ = this.addScene();
         this.currentScene.canvas.callLater(this.sceneChangeEffect);
         _loc3_ = new AddSceneCommand(_loc2_.id,_loc1_);
         _loc3_.execute();
      }
      
      public function showImporterWindow(param1:String, param2:String = null) : void
      {
         var type:String = param1;
         var text:String = param2;
         if(!this._extSwfContainer.contains(this._swfLoader))
         {
            this._swfLoader.percentWidth = 100;
            this._swfLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._swfLoader);
         }
         if(text != null)
         {
            this._tempAsset = this._movie.currentScene.selectedAsset;
         }
         if(this._importer == null)
         {
            this._swfLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadImporterFail);
            this._swfLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _swfLoader.y = 0;
               _swfLoader.visible = true;
               CursorManager.removeBusyCursor();
               _swfLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  if(!_importerOpenedBefore)
                  {
                     try
                     {
                        _importer = Application(SystemManager(_swfLoader.content).application);
                        _importer["init"](Application.application._console);
                        _swfLoader.content.removeEventListener(Event.RENDER,f);
                        if(_studioType == TINY_STUDIO)
                        {
                           _importer["isFacebook"]();
                        }
                        if(_studioType == MESSAGE_STUDIO)
                        {
                           _importer["isEmessage"]();
                        }
                        _importer["gotoPanel"](type,text);
                        _importerOpenedBefore = true;
                     }
                     catch(err:TypeError)
                     {
                     }
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._swfLoader.source = ServerConstants.SERVER_IMPORTER_PATH;
            this._swfLoader.load();
         }
         else
         {
            if(!this._importerOpenedBefore)
            {
               this._importer = Application(SystemManager(this._swfLoader.content).application);
               this._importer["init"](Application.application._console);
               if(this._studioType != FULL_STUDIO)
               {
                  this._importer["isFacebook"]();
               }
               this._importerOpenedBefore = true;
            }
            this._importer["gotoPanel"](type,text);
            this._swfLoader.content.visible = true;
            this._swfLoader.visible = true;
         }
         if(this.currentScene != null)
         {
            this.currentScene.stopScene();
         }
         this._extSwfContainer.visible = true;
      }
      
      private function loadUserThemeSecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeSecurityErrorHandler);
         this.loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      private function addGuideBubbles() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:XML = null;
         var _loc4_:Bubble = null;
         var _loc5_:Rectangle = null;
         var _loc6_:XML = null;
         var _loc7_:Bubble = null;
         _loc1_ = 106;
         if(this._studioType == TINY_STUDIO)
         {
            if(this._bubbleThumbGuide == null)
            {
               _loc3_ = <bubble x="0" y="0" w="180" h="90" rotate="0" type="ROUNDRECTANGULAR">
											        <body rgb="16777215" alpha="0.9" linergb="0" tailx="25" taily="-34"/>
											        <text rgb="0" font="TrebuchetMS1" size="35" align="center" bold="false" italic="false">
											          Mouse over here to bring out characters
											        </text>
											      </bubble>;
               (_loc4_ = BubbleMgr.getBubbleByXML(_loc3_)).useDeviceFont = true;
               this._bubbleThumbGuide = new Image();
               this._bubbleThumbGuide.addChild(_loc4_);
               _loc5_ = this.thumbTray.getBounds(this.thumbTray);
               this._bubbleThumbGuide.x = 71;
               this._bubbleThumbGuide.y = _loc1_;
               this._bubbleThumbGuide.useHandCursor = true;
               this._bubbleThumbGuide.mouseChildren = false;
               this._bubbleThumbGuide.buttonMode = true;
            }
            this.thumbTray.parent.addChild(this._bubbleThumbGuide);
            this.thumbTray.addEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
            this._bubbleThumbGuide.addEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
         }
         _loc2_ = 361;
         _loc1_ = 381;
         if(this._studioType == FULL_STUDIO)
         {
            _loc2_ = this.mainStage.x + this.mainStage.width - 295;
            _loc1_ = this.mainStage.y + this.mainStage.height - 155;
         }
         if(this._bubbleSceneGuide == null)
         {
            _loc6_ = <bubble x="0" y="0" w="180" h="100" rotate="0" type="ELLIPSE">
						  <body rgb="16777215" alpha="0.9" linergb="0" tailx="164" taily="107"/>
						    <text rgb="0" font="TrebuchetMS1" size="25" align="center" bold="false" italic="false" embed="false"></text>
						</bubble>;
            (_loc7_ = BubbleMgr.getBubbleByXML(_loc6_)).useDeviceFont = false;
            _loc7_.text = UtilDict.toDisplay("go","guide_bubble_text");
            this._bubbleSceneGuide = new Image();
            this._bubbleSceneGuide.addChild(_loc7_);
            this._bubbleSceneGuide.x = _loc2_;
            this._bubbleSceneGuide.y = _loc1_;
            this._bubbleSceneGuide.useHandCursor = true;
            this._bubbleSceneGuide.mouseChildren = false;
            this._bubbleSceneGuide.buttonMode = true;
         }
         this.thumbTray.parent.addChild(this._bubbleSceneGuide);
         this._bubbleSceneGuide.addEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
      }
      
      private function onUpdateLinkage(param1:SoundEvent) : void
      {
         this.refreshAllSpeechText();
      }
      
      public function onGetCustomCharComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:Thumb = null;
         var _loc4_:ZipFile = null;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:CharThumb = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"](null);
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc4_ = new ZipFile(_loc2_);
            _loc5_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            _loc6_ = this._importer["charId"];
            this.userTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            this._lastLoaddedTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            if((_loc7_ = this._lastLoaddedTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,this._lastLoaddedTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if((_loc7_ = this._userTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,this._userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if(this.getTheme("ugc") != null)
            {
               _loc7_ = this.getTheme("ugc").getCharThumbById(_loc6_);
            }
            else
            {
               _loc7_ = null;
            }
            if(_loc7_ != null)
            {
               _loc7_.deSerialize(_loc5_,this._userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            this._importer["success"]();
         }
      }
      
      private function testing(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.testing);
            _loc2_.loaderInfo.loader.parent.parent.removeChild(_loc2_.loaderInfo.loader.parent);
            this.doAddScene();
         }
         else
         {
            trace("Current Frame: " + _loc2_.currentFrame + "         ");
            trace("Total Frame: " + _loc2_.totalFrames + "\n");
         }
      }
      
      public function removeAllSounds() : void
      {
         this.stopAllSounds();
         this.sounds.removeAll();
         this.timeline.removeAllSounds();
      }
      
      public function searchAsset(param1:String, param2:String, param3:int, param4:int) : void
      {
         this.requestLoadStatus(true,true);
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["type"] = param2;
         _loc5_["keywords"] = param1;
         _loc5_["page"] = param3;
         _loc5_["count"] = param4;
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_SEARCH_ASSET)).method = URLRequestMethod.POST;
         _loc6_.data = _loc5_;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).addEventListener(Event.COMPLETE,this.onSearchComplete);
         _loc7_.load(_loc6_);
      }
      
      public function get thumbTray() : ThumbTray
      {
         return this._thumbTray;
      }
      
      private function onLoadActionshopFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this.requestLoadStatus(false,true);
         this._extSwfContainer.removeChild(this._actionshopLoader);
         this._actionshopLoader = new SWFLoader();
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      public function get studioType() : String
      {
         return this._studioType;
      }
      
      public function enableRedo(param1:Boolean) : void
      {
         this.mainStage.enableRedo(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function get currDragSource() : DragSource
      {
         return this._currDragSource;
      }
      
      public function getThumbnailCaptures() : UtilHashArray
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:int = 0;
         _loc1_ = new UtilHashArray();
         _loc2_ = 0;
         while(_loc2_ < this.scenes.length)
         {
            _loc1_.push(String(_loc2_),null);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function onSceneComplete(param1:Event) : void
      {
         trace("onSceneComplete:" + param1);
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSceneComplete);
         this.addSceneOnDeserialize();
      }
      
      public function loadSingleCcChar(param1:String) : void
      {
         var _loc3_:URLRequest = null;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
         _loc2_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
         _loc2_["count"] = 100;
         _loc2_["page"] = 0;
         _loc2_["is_cc"] = "Y";
         _loc2_["include_ids_only"] = param1;
         _loc2_["cc_theme_id"] = this.getCurTheme().cc_theme_id;
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).dataFormat = URLLoaderDataFormat.BINARY;
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadSingleCcCharCompleted);
         _loc4_.load(_loc3_);
      }
      
      public function deserializeLinkage(param1:XML) : void
      {
         this.linkageController.deserialize(param1);
      }
      
      public function set publishW(param1:PublishWindow) : void
      {
         this._publishW = param1;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      private function set loadProgress(param1:Number) : void
      {
         this._loadProgress.visible = param1 < 100;
         this._loadProgress.setProgress(param1,100);
      }
      
      public function showLogin() : void
      {
         ExternalInterface.call("startLoginProcess");
      }
      
      public function showSignup() : void
      {
         ExternalInterface.call("startSignupProcess");
      }
      
      public function showActionShopWindow(param1:String, param2:Thumb = null) : void
      {
         var app:Application = null;
         var fn:Function = null;
         var aid:String = param1;
         var thumb:Thumb = param2;
         this.hideGuideSceneBub();
         if(!this._extSwfContainer.contains(this._actionshopLoader))
         {
            this._actionshopLoader.percentWidth = 100;
            this._actionshopLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._actionshopLoader);
         }
         if(this._actionshopLoader.content == null)
         {
            this._actionshopLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadActionshopFail);
            this._actionshopLoader.addEventListener(Event.COMPLETE,fn = function():void
            {
               var f:* = undefined;
               _actionshopLoader.visible = true;
               requestLoadStatus(false,true);
               _actionshopLoader.removeEventListener(Event.COMPLETE,fn);
               _actionshopLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  try
                  {
                     app = Application(SystemManager(_actionshopLoader.content).application);
                     app["init"](aid,true,Application.application._console,thumb as CharThumb);
                     _actionshopLoader.content.removeEventListener(Event.RENDER,f);
                  }
                  catch(err:TypeError)
                  {
                  }
               });
            });
            this.requestLoadStatus(true,true);
            this._actionshopLoader.source = ServerConstants.SERVER_ACTIONSHOP_PATH;
            this._actionshopLoader.load();
         }
         else
         {
            this._actionshopLoader.visible = true;
            app = Application(SystemManager(this._actionshopLoader.content).application);
            app["init"](aid,true,Application.application._console,thumb as CharThumb);
         }
         if(this.currentScene != null)
         {
            this.currentScene.stopScene();
         }
         this._extSwfContainer.visible = true;
      }
      
      public function getViewStackWindow() : ViewStackWindow
      {
         return this._viewStackWindow;
      }
      
      public function loadUserTheme(param1:String = "prop") : void
      {
         var _loc3_:URLRequest = null;
         Console.getConsole().addEventListener(CoreEvent.LOAD_USER_ASSET_COMPLETE,this.onLoadUserThemeComplete);
         this._loaddingAssetType = param1;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
         {
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_COMMUNITYASSETS);
            _loc2_["type"] = this._loaddingAssetType;
            if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextCommunityCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextCommunityBgPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
            {
               _loc2_["count"] = 24;
               _loc2_["page"] = this._nextCommunityPropPage;
               _loc2_["subtype"] = "";
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextCommunityCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundPage;
               _loc2_["inclde_files"] = 0;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundVoicePage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundEffectPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundMusicPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextCommunitySoundTTSPage;
               _loc2_["inclde_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextCommunityEffectPage;
            }
         }
         else if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
         {
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
            _loc2_["type"] = this._loaddingAssetType;
            if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 20;
               if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) != "1")
               {
                  _loc2_["is_cc"] = "N";
               }
               _loc2_["page"] = this._nextUserCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserBgPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
            {
               _loc2_["count"] = 24;
               _loc2_["page"] = this._nextUserPropPage;
               _loc2_["subtype"] = "";
               _loc2_["excludesubtype"] = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserCharPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundPage;
               _loc2_["include_files"] = 0;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundEffectPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundMusicPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundVoicePage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
            {
               _loc2_["count"] = 15;
               _loc2_["page"] = this._nextUserSoundTTSPage;
               _loc2_["include_files"] = 0;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc2_["count"] = 20;
               _loc2_["page"] = this._nextUserEffectPage;
            }
            else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               _loc2_["count"] = 10;
               _loc2_["page"] = this._nextUserVideoPropPage;
               _loc2_["subtype"] = this._loaddingAssetType;
               _loc2_["type"] = AnimeConstants.ASSET_TYPE_PROP;
            }
            _loc2_["exclude_ids"] = this._newlyAddedAssetIds;
         }
         trace(_loc3_.url);
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadUserAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      public function set goWalker(param1:TutorialManager) : void
      {
         this._goWalker = param1;
      }
      
      public function get screenCapTool() : ScreenCapTool
      {
         return this._screenCapTool;
      }
      
      public function loadThemeProp(param1:String) : void
      {
         var _loc2_:Theme = null;
         if(this._themes.containsKey(param1))
         {
            _loc2_ = this.getTheme(param1);
         }
         else
         {
            _loc2_ = null;
            trace("Error: theme not found when loading bg zip with themeId:" + param1);
         }
         if(_loc2_.isPropZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/props",Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/props",Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeProp = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc2_.loadProp();
      }
      
      public function onGetCustomAssetCompleteByte(param1:ByteArray, param2:XML, param3:Boolean, param4:Boolean = true) : SoundThumb
      {
         var sThumb:SoundThumb = null;
         var byte:ByteArray = param1;
         var my:XML = param2;
         var add:Boolean = param3;
         var switchTray:Boolean = param4;
         sThumb = new SoundThumb();
         this._uploadedAssetXML = my;
         sThumb.deSerializeByUserAssetXML(this._uploadedAssetXML,this.userTheme);
         sThumb.enable = true;
         sThumb.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,function():void
         {
            if(thumbTray.userAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               thumbTray.addSoundTileCell(sThumb);
               addNewlyAddedAssetId(_uploadedAssetXML.id);
            }
            if(_importer != null)
            {
               _importer["onLoadAssetCompleteHandler"](null);
            }
            if(switchTray)
            {
               thumbTray.gotoSpecifiedTabInMyGoodies("voiceover");
            }
            if(add)
            {
               _console.createAsset(sThumb);
            }
         });
         sThumb.initSoundByByteArray(byte);
         return sThumb;
      }
      
      public function flipAsset() : void
      {
         var _loc1_:Asset = null;
         if(_console.currentScene)
         {
            _loc1_ = _console.currentScene.selectedAsset;
            if(_loc1_)
            {
               _loc1_.flipIt();
               this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_FLIPPED));
            }
         }
      }
      
      private function doInitFonts(param1:LoadMgrEvent) : void
      {
         var _loc2_:FontManager = null;
         var _loc3_:UtilLoadMgr = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Loader = null;
         var _loc7_:* = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitFonts);
         _loc2_ = FontManager.getFontManager();
         if(_loc2_.getFonts().length > 0)
         {
            _loc3_ = new UtilLoadMgr();
            _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadFontsDone);
            _loc5_ = 0;
            while(_loc5_ < _loc2_.getFonts().length)
            {
               _loc4_ = _loc2_.getFonts().getKey(_loc5_);
               (_loc6_ = new Loader()).name = _loc4_;
               _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoaded);
               _loc7_ = _loc2_.nameToFileName(_loc4_) + ".swf";
               _loc3_.addEventDispatcher(_loc6_.contentLoaderInfo,Event.COMPLETE);
               _loc6_.loadBytes(_loc2_.getFonts().getValueByKey(_loc4_));
               _loc5_++;
            }
            _loc3_.commit();
         }
         else
         {
            this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
         }
      }
      
      public function get currentScene() : AnimeScene
      {
         return this._movie.currentScene;
      }
      
      private function showSaveMovieError(param1:CoreEvent) : void
      {
         var _loc2_:GoAlert = null;
         var _loc3_:Error = null;
         var _loc4_:String = null;
         var _loc5_:Feedback = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            _loc3_ = param1.getData() as Error;
            if(_loc3_.message == ServerConstants.ERROR_CODE_SAVE_MOVIE_BLOCKED_BY_VIDEO_RECORDING)
            {
               _loc2_ = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true));
               _loc4_ = UtilDict.toDisplay("go","constant_save_movie_error_due_to_video_record");
               _loc2_.width = 400;
               _loc2_.height = 300;
            }
            else
            {
               if(!(_loc3_ is IOError))
               {
                  (_loc5_ = Feedback(PopUpManager.createPopUp(this._movie.currentScene.canvas,Feedback,true))).error = _loc3_;
                  _loc5_.x = (_loc5_.stage.width - _loc5_.width) / 2;
                  _loc5_.y = 100;
                  return;
               }
               _loc2_ = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true));
               _loc4_ = UtilDict.toDisplay("go","constant_connecterr");
               this.enableAfterSave();
            }
            _loc2_.showButton(false,true);
            _loc2_._txtDelete.htmlText = _loc4_;
            _loc2_._btnCancel.label = UtilDict.toDisplay("go","ok");
            _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
            _loc2_.y = 100;
         }
      }
      
      public function refreshAllSpeechText() : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:String = null;
         var _loc4_:AnimeSound = null;
         var _loc5_:String = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._movie.scenes.length)
         {
            _loc2_ = this.getScene(_loc1_);
            _loc3_ = this.linkageController.getSpeechIdByScene(_loc2_);
            _loc4_ = this.speechManager.getValueByKey(_loc3_);
            _loc5_ = "";
            if(_loc4_ != null)
            {
               if(_loc4_.soundThumb.ttsData.type == "mic")
               {
                  _loc5_ = UtilDict.toDisplay("go","Mic Recording");
               }
               else
               {
                  _loc5_ = _loc4_.soundThumb.ttsData.text;
               }
            }
            this.timeline.updateSceneSpeechByIndex(_loc1_,_loc5_);
            _loc1_++;
         }
      }
      
      public function onUserLoginCancel() : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_CANCEL,this));
      }
      
      public function setCurrentSceneVisible() : void
      {
      }
      
      public function get isTutorialOn() : Boolean
      {
         if(this.goWalker != null && this.goWalker.guideMode)
         {
            return true;
         }
         return false;
      }
      
      public function copyCurrentScene() : void
      {
         this._movie.copyCurrentScene();
      }
      
      private function get thumbSO() : SharedObject
      {
         return this._thumbSO;
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function updateSoundById(param1:String) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:AnimeSound = null;
         _loc2_ = this.getSoundInfoById(param1);
         _loc3_ = this.sounds.getValueByKey(param1) as AnimeSound;
         _loc3_.startFrame = UtilUnitConvert.pixelToFrame(_loc2_.startPixel);
         _loc3_.endFrame = UtilUnitConvert.pixelToFrame(_loc2_.startPixel + _loc2_.totalPixel);
         _loc3_.trackNum = UtilUnitConvert.pixelToTrack(_loc2_.y);
         _loc3_.inner_volume = _loc2_.inner_volume;
      }
      
      private function doLoadDefaultTheme(param1:CoreEvent) : void
      {
         var targetThemeCode:String = null;
         var event:CoreEvent = param1;
         this.removeEventListener(CoreEvent.LOAD_THEMELIST_COMPLETE,this.doLoadDefaultTheme);
         this._themeListXML = event.getData() as XML;
         this.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.doUpdateThumbTray);
         if(!UtilUser.loggedIn && UtilSite.siteId == UtilSite.CN)
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doShowNoSaveAlert);
         }
         var trayId:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_DEFAULT_TRAYTHEME);
         var xmlList:XMLList = this._themeListXML.theme.(@id == trayId);
         if(trayId != null && xmlList.length() > 0)
         {
            targetThemeCode = trayId;
         }
         else
         {
            targetThemeCode = this._themeListXML.child("theme")[0].attribute("id");
         }
         if(Console.getConsole().isThemeCcRelated(targetThemeCode) && UtilUser.loggedIn)
         {
            Console.getConsole().addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadMovie);
         }
         else
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMovie);
         }
         this._thumbTray.initThemeDropdown(targetThemeCode);
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            this.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.doGetCNUserScores);
         }
         if(trayId != null && xmlList.length() > 0)
         {
            this._thumbTray.initThemeChosenById(targetThemeCode);
         }
         else
         {
            this.loadTheme(targetThemeCode);
         }
      }
      
      public function checkSoundSpaceAtScene(param1:AnimeScene, param2:SoundThumb, param3:AnimeSound = null, param4:Boolean = false) : void
      {
         var _loc7_:GoAlert = null;
         var _loc8_:Boolean = false;
         var _loc5_:int = this.getSceneIndex(param1);
         var _loc6_:Point;
         if((_loc6_ = this.timeline.getEarliestSoundSpace(_loc5_)).x == -999)
         {
            if(!param4)
            {
               (_loc7_ = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true)))._lblConfirm.text = "";
               _loc7_._txtDelete.text = UtilDict.toDisplay("go","timeline_soundexceed");
               _loc7_._btnDelete.visible = false;
               _loc7_._btnCancel.label = UtilDict.toDisplay("go","ok");
               _loc7_.x = (_loc7_.stage.width - _loc7_.width) / 2;
               _loc7_.y = 100;
            }
            return;
         }
         _loc8_ = true;
         this.addSoundAtScene(param1,param2,_loc6_,param3,_loc8_);
      }
      
      private function LoadThemeComplete(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.LoadThemeComplete);
         var _loc2_:Theme = param1.getEventCreater() as Theme;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this,_loc2_));
         Util.gaTracking("/gostudio/themes/complete/" + _loc2_.id,Console.getConsole().mainStage.stage);
      }
      
      private function onSearchComplete(param1:Event) : void
      {
         var _loc4_:ZipFile = null;
         var _loc5_:XML = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:Thumb = null;
         var _loc11_:ZipEntry = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:ByteArray = null;
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:int = _loc2_.readByte();
         if(_loc3_ == 0)
         {
            _loc4_ = new ZipFile(_loc2_);
            _loc5_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            this._thumbTray.hasMoreSearch = _loc5_.@moreBg == "1"?true:false;
            this._thumbTray.updateSearchCount(_loc5_.@all_asset_count);
            this._searchedTheme.clearAllThumbs();
            this._searchedTheme.deSerialize(_loc5_);
            _loc6_ = this._searchedTheme.backgroundThumbs;
            _loc7_ = this._searchedTheme.propThumbs;
            _loc8_ = this._searchedTheme.charThumbs;
            _loc9_ = this._searchedTheme.effectThumbs;
            _loc12_ = 0;
            while(_loc12_ < _loc6_.length)
            {
               _loc10_ = BackgroundThumb(_loc6_.getValueByIndex(_loc12_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
                  _loc10_.thumbImageData = _loc4_.getInput(_loc11_);
               }
               _loc12_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc7_.length)
            {
               _loc10_ = PropThumb(_loc7_.getValueByIndex(_loc13_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc13_++;
            }
            _loc14_ = 0;
            while(_loc14_ < _loc8_.length)
            {
               _loc10_ = CharThumb(_loc8_.getValueByIndex(_loc14_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc14_++;
            }
            _loc15_ = 0;
            while(_loc15_ < _loc9_.length)
            {
               _loc10_ = EffectThumb(_loc9_.getValueByIndex(_loc15_));
               if((_loc11_ = _loc4_.getEntry(_loc10_.getFileName())) != null)
               {
                  _loc10_.imageData = _loc4_.getInput(_loc11_);
               }
               _loc15_++;
            }
            this.addTheme(this._searchedTheme.id,this._searchedTheme);
            this._thumbTray.loadThumbs(this._searchedTheme);
         }
         else
         {
            _loc16_ = new ByteArray();
            _loc2_.readBytes(_loc16_);
            _logger.error("search community assets failed: \n" + _loc16_.toString());
            Alert.show("search community assets failed: \n" + _loc16_.toString());
         }
      }
      
      public function get selectedThumbnailIndex() : int
      {
         return this._selectedThumbnailIndex;
      }
      
      public function get siteId() : String
      {
         return this._siteId;
      }
      
      public function closePublishWindow() : void
      {
         if(this._publishW != null)
         {
            PopUpManager.removePopUp(this._publishW);
            this.publishW = null;
         }
      }
      
      public function set currDragObject(param1:Asset) : void
      {
         this._currDragObject = param1;
      }
      
      private function onLoadUserAssetsComplete(param1:Event) : void
      {
         var _loc5_:ZipFile = null;
         var _loc6_:XML = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:UtilHashArray = null;
         var _loc17_:UtilHashArray = null;
         var _loc18_:UtilHashArray = null;
         var _loc19_:UtilHashArray = null;
         var _loc20_:UtilHashArray = null;
         var _loc21_:Thumb = null;
         var _loc22_:ZipEntry = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:ByteArray = null;
         var _loc33_:ZipFile = null;
         var _loc34_:XML = null;
         var _loc35_:ZipEntry = null;
         var _loc36_:ByteArray = null;
         var _loc37_:ZipEntry = null;
         var _loc38_:ZipFile = null;
         var _loc39_:int = 0;
         var _loc40_:ZipEntry = null;
         var _loc41_:ByteArray = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int = _loc3_.readByte();
         trace("returnCode:" + _loc4_);
         if(_loc4_ == 0)
         {
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            _loc5_ = new ZipFile(_loc3_);
            _loc7_ = (_loc6_ = new XML(_loc5_.getInput(_loc5_.getEntry("desc.xml")))).@moreBg == "1"?true:false;
            _loc8_ = _loc6_.@moreProp == "1"?true:false;
            _loc9_ = _loc6_.@moreVideoProp == "1"?true:false;
            _loc10_ = _loc6_.@moreChar == "1"?true:false;
            _loc11_ = _loc6_.@moreFx == "1"?true:false;
            _loc12_ = _loc6_.@moreVoice == "1"?true:false;
            _loc13_ = _loc6_.@moreEffect == "1"?true:false;
            _loc14_ = _loc6_.@moreMusic == "1"?true:false;
            _loc15_ = _loc6_.@moreTTS == "1"?true:false;
            _loc23_ = 0;
            _loc24_ = 0;
            _loc25_ = 0;
            _loc26_ = 0;
            _loc27_ = 0;
            Util.gaTracking("/gostudio/" + this.thumbTray.assetTheme + "/complete/" + this._loaddingAssetType,Console.getConsole().mainStage.stage);
            if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
            {
               _loc23_ = this._communityTheme.backgroundThumbs.length;
               _loc24_ = this._communityTheme.propThumbs.length;
               _loc25_ = this._communityTheme.charThumbs.length;
               _loc26_ = this._communityTheme.effectThumbs.length;
               this._communityTheme.deSerialize(_loc6_);
               this._lastLoaddedTheme.clearAllThumbs();
               this._lastLoaddedTheme.deSerialize(_loc6_);
               _loc16_ = this._lastLoaddedTheme.backgroundThumbs;
               _loc17_ = this._lastLoaddedTheme.propThumbs;
               _loc18_ = this._lastLoaddedTheme.charThumbs;
               _loc19_ = this._lastLoaddedTheme.effectThumbs;
            }
            else if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               _loc23_ = this.userTheme.backgroundThumbs.length;
               _loc24_ = this.userTheme.propThumbs.length;
               _loc25_ = this.userTheme.charThumbs.length;
               _loc26_ = this.userTheme.effectThumbs.length;
               this._userTheme.deSerialize(_loc6_);
               this._lastLoaddedTheme.clearAllThumbs();
               this._lastLoaddedTheme.deSerialize(_loc6_);
               _loc16_ = this._lastLoaddedTheme.backgroundThumbs;
               _loc17_ = this._lastLoaddedTheme.propThumbs;
               _loc18_ = this._lastLoaddedTheme.charThumbs;
               _loc19_ = this._lastLoaddedTheme.effectThumbs;
            }
            _loc28_ = 0;
            while(_loc28_ < _loc16_.length)
            {
               _loc21_ = BackgroundThumb(_loc16_.getValueByIndex(_loc28_));
               if((_loc22_ = _loc5_.getEntry(_loc21_.getFileName())) != null)
               {
                  _loc21_.imageData = _loc5_.getInput(_loc22_);
                  _loc21_.thumbImageData = _loc5_.getInput(_loc22_);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     BackgroundThumb(this._userTheme.backgroundThumbs.getValueByKey(_loc21_.id)).imageData = _loc5_.getInput(_loc22_);
                     BackgroundThumb(this._userTheme.backgroundThumbs.getValueByKey(_loc21_.id)).thumbImageData = _loc5_.getInput(_loc22_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     BackgroundThumb(this._communityTheme.backgroundThumbs.getValueByIndex(_loc28_ + _loc23_)).imageData = _loc5_.getInput(_loc22_);
                     BackgroundThumb(this._communityTheme.backgroundThumbs.getValueByIndex(_loc28_ + _loc23_)).thumbImageData = _loc5_.getInput(_loc22_);
                  }
               }
               _loc28_++;
            }
            _loc29_ = 0;
            while(_loc29_ < _loc17_.length)
            {
               _loc21_ = PropThumb(_loc17_.getValueByIndex(_loc29_));
               _loc22_ = _loc5_.getEntry(_loc21_.getFileName());
               trace("[thumb.id, thumb.getFileName(),entry]:" + [_loc21_.id,_loc21_.getFileName(),_loc22_]);
               if(_loc22_ != null)
               {
                  _loc21_.imageData = _loc5_.getInput(_loc22_);
                  trace("thumb.id:" + _loc21_.id);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     PropThumb(this._userTheme.propThumbs.getValueByKey(_loc21_.id)).imageData = _loc5_.getInput(_loc22_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     PropThumb(this._communityTheme.propThumbs.getValueByIndex(_loc29_ + _loc24_)).imageData = _loc5_.getInput(_loc22_);
                  }
               }
               _loc29_++;
            }
            _loc30_ = 0;
            while(_loc30_ < _loc18_.length)
            {
               _loc21_ = CharThumb(_loc18_.getValueByIndex(_loc30_));
               if((_loc22_ = _loc5_.getEntry(_loc21_.getFileName())) != null)
               {
                  if(!CharThumb(_loc21_).isCC)
                  {
                     _loc21_.imageData = _loc5_.getInput(_loc22_);
                     if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                     {
                        trace("thumb.getFileName():" + _loc21_.getFileName());
                        CharThumb(this._userTheme.charThumbs.getValueByKey(_loc21_.id)).imageData = _loc5_.getInput(_loc22_);
                     }
                     else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                     {
                        CharThumb(this._communityTheme.charThumbs.getValueByIndex(_loc30_ + _loc25_)).imageData = _loc5_.getInput(_loc22_);
                     }
                  }
                  else if(_loc21_.getFileName().indexOf("zip") >= 0)
                  {
                     _loc32_ = _loc5_.getInput(_loc22_);
                     _loc33_ = new ZipFile(_loc32_);
                     _loc21_.imageData = UtilPlain.convertZipAsImagedataObject(_loc33_);
                     if((_loc35_ = _loc5_.getEntry("char/" + _loc21_.id + "/" + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
                     {
                        _loc36_ = _loc5_.getInput(_loc35_) as ByteArray;
                        _loc38_ = new ZipFile(_loc36_);
                        _loc39_ = 0;
                        while(_loc39_ < _loc38_.size)
                        {
                           _loc37_ = _loc38_.entries[_loc39_];
                           CharThumb(_loc21_).addLibrary(_loc37_.name,_loc38_.getInput(_loc37_));
                           _loc39_++;
                        }
                     }
                  }
               }
               else
               {
                  _loc40_ = _loc5_.getEntry("char/" + _loc21_.id + "/" + _loc21_.id + ".png");
                  _loc21_.imageData = _loc5_.getInput(_loc40_);
                  _loc21_.useImageAsThumb = true;
               }
               _loc30_++;
            }
            _loc31_ = 0;
            while(_loc31_ < _loc19_.length)
            {
               _loc21_ = EffectThumb(_loc19_.getValueByIndex(_loc31_));
               if((_loc22_ = _loc5_.getEntry(_loc21_.getFileName())) != null)
               {
                  _loc21_.imageData = _loc5_.getInput(_loc22_);
                  if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
                  {
                     EffectThumb(this._userTheme.effectThumbs.getValueByIndex(_loc31_ + _loc26_)).imageData = _loc5_.getInput(_loc22_);
                  }
                  else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     EffectThumb(this._communityTheme.effectThumbs.getValueByIndex(_loc31_ + _loc26_)).imageData = _loc5_.getInput(_loc22_);
                  }
               }
               _loc31_++;
            }
            if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
            {
               this._userTheme.mergeTheme(this._lastLoaddedTheme);
               this.addTheme(this._userTheme.id,this._userTheme);
               if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
               {
                  this._thumbTray.hasMoreUserBg = _loc7_;
                  ++this._nextUserBgPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
               {
                  this._thumbTray.hasMoreUserProp = _loc8_;
                  ++this._nextUserPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  this._thumbTray.hasMoreUserVideoProp = _loc9_;
                  ++this._nextUserVideoPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this._thumbTray.hasMoreUserChar = _loc10_;
                  ++this._nextUserCharPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
               {
                  this._thumbTray.hasMoreUserSoundEffect = _loc13_;
                  ++this._nextUserSoundEffectPage;
                  this._thumbTray.hasMoreUserSoundMusic = _loc14_;
                  ++this._nextUserSoundMusicPage;
                  this._thumbTray.hasMoreUserSoundVoice = _loc12_;
                  ++this._nextUserSoundVoicePage;
                  this._thumbTray.hasMoreUserSoundTTS = _loc15_;
                  ++this._nextUserSoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  this._thumbTray.hasMoreUserSoundEffect = _loc13_;
                  ++this._nextUserSoundEffectPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  this._thumbTray.hasMoreUserSoundMusic = _loc14_;
                  ++this._nextUserSoundMusicPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  this._thumbTray.hasMoreUserSoundVoice = _loc12_;
                  ++this._nextUserSoundVoicePage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  this._thumbTray.hasMoreUserSoundTTS = _loc15_;
                  ++this._nextUserSoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
               {
                  this._thumbTray.hasMoreUserEffect = _loc11_;
                  ++this._nextUserEffectPage;
               }
               this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
               this._thumbTray.loadThumbs(this._lastLoaddedTheme);
            }
            else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
            {
               this._communityTheme.mergeTheme(this._lastLoaddedTheme);
               this.addTheme(this._communityTheme.id,this._communityTheme);
               if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_BG)
               {
                  this._thumbTray.hasMoreCommunityBg = _loc7_;
                  ++this._nextCommunityBgPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP)
               {
                  this._thumbTray.hasMoreCommunityProp = _loc8_;
                  ++this._nextCommunityPropPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this._thumbTray.hasMoreCommunityChar = _loc10_;
                  ++this._nextCommunityCharPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND)
               {
                  this._thumbTray.hasMoreCommunitySoundEffect = _loc13_;
                  ++this._nextCommunitySoundEffectPage;
                  this._thumbTray.hasMoreCommunitySoundMusic = _loc14_;
                  ++this._nextCommunitySoundMusicPage;
                  this._thumbTray.hasMoreCommunitySoundVoice = _loc12_;
                  ++this._nextCommunitySoundVoicePage;
                  this._thumbTray.hasMoreCommunitySoundTTS = _loc15_;
                  ++this._nextCommunitySoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  this._thumbTray.hasMoreCommunitySoundEffect = _loc13_;
                  ++this._nextCommunitySoundEffectPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  this._thumbTray.hasMoreCommunitySoundMusic = _loc14_;
                  ++this._nextCommunitySoundMusicPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  this._thumbTray.hasMoreCommunitySoundVoice = _loc12_;
                  ++this._nextCommunitySoundVoicePage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  this._thumbTray.hasMoreCommunitySoundTTS = _loc15_;
                  ++this._nextCommunitySoundTTSPage;
               }
               else if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_FX)
               {
                  this._thumbTray.hasMoreCommunityEffect = _loc11_;
                  ++this._nextCommunityEffectPage;
               }
               this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
               this._thumbTray.loadThumbs(this._lastLoaddedTheme);
            }
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
         }
         else
         {
            _loc41_ = new ByteArray();
            _loc2_.readBytes(_loc41_);
            _logger.error("getUserAssets failed: \n" + _loc41_.toString());
            Alert.show("getUserAssets failed: \n" + _loc41_.toString());
         }
         if(this.thumbTray.assetTheme == ThumbTray.USER_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
         }
         else if(this.thumbTray.assetTheme == ThumbTray.COMMUNITY_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this));
         }
      }
      
      public function customAssetUploadCompleteHandler(param1:String, param2:String) : void
      {
         var idWithExtension:String = null;
         var idWithoutExt:String = null;
         var errorCode:String = null;
         var errorXML:XML = null;
         var returnData:String = param1;
         var ttype:String = param2;
         var checkCode:String = returnData.substr(0,1);
         if(checkCode == "0")
         {
            this._uploadType = ttype;
            this._uploadedAssetXML = new XML(returnData.substr(1));
            trace("_uploadedAssetXML:" + this._uploadedAssetXML);
            if(this._importer == null || !Boolean(this._importer["oldChar"]))
            {
               if(this._uploadedAssetXML.name() == "effect")
               {
                  idWithExtension = this._uploadedAssetXML.@id;
                  idWithoutExt = idWithExtension.split(".")[0];
                  this.addNewlyAddedAssetId(idWithoutExt);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
               else if(this._uploadedAssetXML.child("subtype") == "video")
               {
                  trace("add asset");
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.buildVideoThumb(this._uploadedAssetXML);
                  this.thumbTray.onLoadUserPropComplete();
               }
               else if(this._uploadedAssetXML.child("id").length() > 0)
               {
                  this._assetId = this._uploadedAssetXML.id;
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.getUserAssetById(this._uploadedAssetXML.child("id")[0]);
               }
               else
               {
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.@id);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
            }
            else
            {
               this.getUserCharById(this._importer["charId"]);
            }
         }
         else
         {
            errorCode = "";
            try
            {
               errorXML = new XML(returnData.substr(1));
               errorCode = errorXML.child("code");
            }
            catch(e:Error)
            {
            }
            if(errorCode == ServerConstants.ERROR_CODE_UNSUPPORTED_IMAGE_FORMAT)
            {
               Alert.show("The image format is not supported.");
            }
            else
            {
               Alert.show("Error occur during the upload process. Let\'s try again later.","Checkcode " + checkCode);
            }
            _logger.error("return code is:" + checkCode + "\n error message: \n" + returnData.substr(1));
         }
      }
      
      public function getWhiteTerms() : Array
      {
         if(this._whiteTerms != null)
         {
            return this._whiteTerms;
         }
         return null;
      }
      
      public function freezeCurrentScene(param1:Event) : void
      {
      }
      
      public function showCreateMyChar(param1:Event = null) : void
      {
         var _loc2_:String = null;
         trace("showmyChar");
         _loc2_ = ServerConstants.CC_PAGE_PATH;
         if(this._curTheme.cc_theme_id)
         {
            _loc2_ = _loc2_ + ("/" + this._curTheme.cc_theme_id);
         }
         navigateToURL(new URLRequest(_loc2_),ServerConstants.POPUP_WINDOW_NAME);
      }
      
      public function getScene(param1:int) : AnimeScene
      {
         return this._movie.getSceneAt(param1);
      }
      
      public function serialize(param1:Boolean = true) : XML
      {
         var ex:Error = null;
         var i:int = 0;
         var userLogData:Object = null;
         var published:Boolean = false;
         var privateShared:Boolean = false;
         var duration:Number = NaN;
         var xmlStr:String = null;
         var sclen:int = 0;
         var mbEx:MovieBodyError = null;
         var nEx:NestedError = null;
         var stockdata:Boolean = param1;
         this._previewData.removeAll();
         userLogData = {"phase":"metadata"};
         try
         {
            published = this.movie.published;
            privateShared = this.movie.privateShared;
            duration = Util.roundNum(this.timeline.getTotalTimeInSec());
            if(duration > FeatureManager.maxMovieDuration)
            {
               published = false;
               privateShared = false;
            }
            if(UtilSite.siteId == UtilSite.YOUTUBE)
            {
               if(published)
               {
                  privateShared = true;
               }
               published = false;
            }
            xmlStr = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "<film copyable=\"" + (!!this.movie.copyable?"1":"0") + "\" duration=\"" + duration + "\" published=\"" + (!!published?"1":"0") + "\" pshare=\"" + (!!privateShared?"1":"0") + "\">";
            this.metaData.mver = AnimeConstants.MOVIE_VERSION;
            xmlStr = xmlStr + this.metaData.serialize();
            sclen = this._movie.scenes.length;
            i = 0;
            while(i < sclen)
            {
               userLogData.phase = "Scene " + i;
               xmlStr = xmlStr + AnimeScene(this._movie.getSceneAt(i)).serialize(i,stockdata);
               i++;
            }
            userLogData.phase = "Sound";
            xmlStr = xmlStr + this.serializeSound(stockdata);
            userLogData.phase = "Speech Manager";
            xmlStr = xmlStr + this.speechManager.serializeSound(stockdata,userLogData);
            userLogData.phase = "Linkage";
            xmlStr = xmlStr + this.serializeLinkage();
            xmlStr = xmlStr + "</film>";
            try
            {
               return new XML(xmlStr);
            }
            catch(ex:Error)
            {
               mbEx = new MovieBodyError("Error occurred parsing serialized movie body",xmlStr);
               this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,mbEx));
            }
         }
         catch(ex:Error)
         {
            nEx = new NestedError("Error occurred serializing movie",ex);
            nEx.userData = userLogData;
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,nEx));
         }
         return ;
      }
      
      private function removeNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = VBox(param1.currentTarget);
         if(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.contains(_loc2_))
         {
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      public function showBubbleMsgWindow(param1:BubbleThumb, param2:BubbleAsset) : void
      {
         var _loc3_:int = 0;
         var _loc8_:SoundThumb = null;
         var _loc10_:BubbleMsgChooserItem = null;
         var _loc11_:SoundThumb = null;
         var _loc12_:String = null;
         var _loc4_:BubbleMsgChooser = PopUpManager.createPopUp(this.mainStage,BubbleMsgChooser,true) as BubbleMsgChooser;
         var _loc5_:Array = PresetMsg.getInstance().getMsgArray(param1.theme.id);
         var _loc6_:UtilHashArray = Console.getConsole().getTheme(param1.theme.id).soundThumbs;
         var _loc7_:UtilHashArray = new UtilHashArray();
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc8_ = _loc6_.getValueByIndex(_loc3_) as SoundThumb;
            _loc7_.push(_loc8_.name,_loc8_);
            _loc3_++;
         }
         var _loc9_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc12_ = _loc5_[_loc3_] as String;
            _loc11_ = _loc7_.getValueByKey(_loc12_);
            _loc10_ = new BubbleMsgChooserItem(_loc12_,(_loc3_ + 1).toString() + ") " + _loc12_,true,param2,_loc11_ != null,_loc11_);
            _loc9_.push(_loc10_);
            _loc3_++;
         }
         _loc4_.init(_loc9_);
         _loc4_.x = (this.mainStage.stage.width - _loc4_.width) / 2;
         _loc4_.y = this.mainStage.y;
         _loc4_.addEventListener(BubbleMsgEvent.ITEM_CHOOSEN,this.onBubbleMsgChoosen);
      }
      
      private function onUpgradeBtnClick(param1:MouseEvent) : void
      {
         this.showUpgradePopup();
      }
      
      public function removeSound(param1:String) : void
      {
         var _loc2_:AnimeSound = AnimeSound(this.sounds.getValueByKey(param1));
         if(_loc2_ != null)
         {
            _loc2_.stopSound();
         }
         this.sounds.remove(this.sounds.getIndex(param1),1);
         this.timeline.removeSoundById(param1);
         this.linkageController.deleteLinkageById(param1);
      }
      
      public function doMoveScene(param1:Number, param2:Number) : void
      {
         this._movie.moveScene(param1,param2);
         this.capScreenLock = false;
      }
      
      public function pauseMovie() : void
      {
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).pauseMovie();
         }
      }
      
      public function set groupController(param1:GroupController) : void
      {
         this._groupController = param1;
      }
      
      public function get myAnimatedMask() : AnimatedMask
      {
         return this._myAnimatedMask;
      }
      
      private function onLoadThemeListFailed(param1:IOErrorEvent) : void
      {
         Alert.show("Sorry, connection error occurs, please try again later.\n\nError: " + this._siteId + "\n\n" + param1.toString());
      }
      
      private function onLoadInspirationFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this._extSwfContainer.removeChild(this._inspirationLoader);
         this._inspirationLoader = new SWFLoader();
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      private function setBadTerms(param1:String) : void
      {
         this._badTerms = param1.split(",");
      }
      
      public function get isLoaddingCommonThemeChar() : Boolean
      {
         return this._isLoaddingCommonThemeChar;
      }
      
      public function get propertiesWindow() : PropertiesWindow
      {
         return this.pptPanel;
      }
      
      public function editAsset(param1:MouseEvent = null) : void
      {
         var _loc3_:Asset = null;
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
            }
         }
         var _loc2_:AnimeScene = _console.currentScene;
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ is EffectAsset)
         {
            (_loc3_ as EffectAsset).showInfoWindow();
         }
      }
      
      public function get isLoaddingCommonThemeProp() : Boolean
      {
         return this._isLoaddingCommonThemeProp;
      }
      
      public function updateAssetTime(param1:String, param2:Number, param3:Number, param4:Number = -1, param5:Number = -1) : void
      {
         var _loc6_:Asset;
         if((_loc6_ = this.currentScene.getAssetById(param1)) is BubbleAsset)
         {
            (_loc6_ as BubbleAsset).sttime = param2;
            (_loc6_ as BubbleAsset).edtime = param3;
         }
         else if(_loc6_ is EffectAsset)
         {
            (_loc6_ as EffectAsset).sttime = param2;
            (_loc6_ as EffectAsset).edtime = param3;
            if((_loc6_.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase())
            {
               (_loc6_ as EffectAsset).stzoom = param4;
               (_loc6_ as EffectAsset).edzoom = param5;
            }
         }
         this.onUpdateAssetComplete();
      }
      
      public function get currentSceneId() : String
      {
         if(this._movie.currentScene != null)
         {
            return this._movie.currentScene.id;
         }
         return null;
      }
      
      private function onSceneAdded(param1:MovieEvent) : void
      {
         var _loc2_:AnimeScene = null;
         if(param1.index >= 0)
         {
            _loc2_ = this._movie.getSceneAt(param1.index);
            this._stageViewStack.addChildAt(_loc2_.canvas,param1.index);
            this._stageViewStack.validateNow();
            this.addSceneCtrl(_loc2_);
            this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.SCENE_ADDED,this));
         }
      }
      
      public function doUpdateTimelineByScene(param1:AnimeScene, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BitmapData = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Matrix = null;
         var _loc9_:Number = NaN;
         var _loc10_:BitmapData = null;
         var _loc11_:Boolean = false;
         var _loc12_:Rectangle = null;
         if(param2 && this.currentScene != param1)
         {
            return;
         }
         if(param1 && !this._capScreenLock)
         {
            if(param1.assetGroup)
            {
               param1.assetGroup.hideControl();
            }
            this.timeline.setSceneTarget(param1.canvas,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            _loc3_ = this.getSceneIndex(param1);
            _loc5_ = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
            if(param1.sizingAsset)
            {
               _loc11_ = param1.sizingAsset.bundle.visible;
               param1.sizingAsset.bundle.visible = false;
               _loc12_ = new Rectangle(param1.sizingAsset.x,param1.sizingAsset.y,param1.sizingAsset.width,param1.sizingAsset.height);
               _loc4_ = Util.capturePicture(param1.canvas,_loc12_);
               param1.sizingAsset.bundle.visible = _loc11_;
            }
            else
            {
               _loc4_ = Util.capturePicture(param1.canvas,_loc5_);
            }
            _loc6_ = 220;
            _loc7_ = 141;
            _loc8_ = new Matrix();
            _loc9_ = _loc6_ / _loc4_.width;
            _loc10_ = new BitmapData(_loc6_,_loc7_);
            (_loc8_ = new Matrix()).scale(_loc9_,_loc9_);
            _loc10_.draw(_loc4_,_loc8_,null,null,null,true);
            this.timeline.updateSceneImageByBitmapData(_loc3_,_loc10_);
            if(param1.assetGroup)
            {
               param1.assetGroup.showControl();
            }
         }
      }
      
      public function redirectToBuyGoBuckPage(param1:Event) : void
      {
         this.closePopUp(param1);
         UtilNavigate.toBuyBuckPage();
      }
      
      public function set uploadedAssetXML(param1:XML) : void
      {
         this._uploadedAssetXML = param1;
      }
      
      public function addCutEffectonChar(param1:Character) : void
      {
         var _loc2_:EffectThumb = null;
         _loc2_ = this.getTheme("common").effectThumbs.getValueByKey("cut") as EffectThumb;
         this.createAsset(_loc2_,param1.bundle.x,param1.bundle.y - param1.movieObject.height / 4,true);
      }
      
      private function buildVideoThumb(param1:XML) : void
      {
         var _loc5_:ThumbnailCanvas = null;
         this._holdable = false;
         this._headable = false;
         this._placeable = true;
         var _loc2_:VideoPropThumb = new VideoPropThumb();
         _loc2_.id = this._uploadedAssetXML.file;
         _loc2_.name = this._uploadedAssetXML.title;
         _loc2_.theme = Console.getConsole().userTheme;
         VideoPropThumb(_loc2_).subType = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         VideoPropThumb(_loc2_).placeable = true;
         VideoPropThumb(_loc2_).holdable = false;
         VideoPropThumb(_loc2_).headable = false;
         VideoPropThumb(_loc2_).facing = AnimeConstants.FACING_LEFT;
         _loc2_.enable = true;
         _loc2_.tags = this._uploadedAssetXML.tags;
         _loc2_.isPublished = this._uploadedAssetXML.published == "1"?true:false;
         _loc2_.videoHeight = Number(this._uploadedAssetXML.height);
         _loc2_.videoWidth = Number(this._uploadedAssetXML.width);
         this.userTheme.addThumb(_loc2_,UtilXmlInfo.convertUploadedAssetXmlToThumbXml(param1));
         var _loc3_:Image = new Image();
         var _loc4_:DisplayObject = VideoPropThumb(_loc2_).loadThumbnail();
         _loc3_.addChild(_loc4_);
         _loc5_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc2_,true,false,this._purchaseEnabled,"",true,0,false,true);
         _loc5_.name = _loc5_.toolTip = _loc2_.name;
         this.thumbTray._uiTileVideoPropUser.addChild(_loc5_);
         if(this._importer != null)
         {
            this._importer["success"]();
            this.currentScene.playScene();
         }
      }
      
      public function flipCCLookAtCamera() : void
      {
         var _loc2_:Asset = null;
         var _loc3_:Character = null;
         var _loc1_:AnimeScene = _console.currentScene;
         _loc2_ = _console.currentScene.selectedAsset;
         if(_loc2_ is Character)
         {
            _loc3_ = Character(_loc2_);
            if(CharThumb(_loc3_.thumb).isCC)
            {
               _loc3_.toggleLookAtCamera();
            }
         }
      }
      
      public function copyMovieById(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         var _loc6_:URLLoader = null;
         this._movieXML = null;
         _loc4_ = new URLVariables();
         var _loc5_:UtilHashArray = Util.getFlashVar();
         Util.addFlashVarsToURLvar(_loc4_);
         _loc2_ = ServerConstants.ACTION_GET_MOVIE;
         _loc3_ = new URLRequest(_loc2_);
         _loc4_[ServerConstants.PARAM_MOVIE_ID] = _loc4_[ServerConstants.PARAM_ORIGINAL_ID] = param1;
         this._originalId = param1;
         _loc4_[ServerConstants.PARAM_IS_EDIT_MODE] = "1";
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc4_;
         (_loc6_ = new URLLoader()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc6_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc6_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc6_.load(_loc3_);
      }
      
      public function get movie() : MovieData
      {
         return this._movie;
      }
      
      private function onLoadUserThemeComplete(param1:Event) : void
      {
         if(this._loaddingAssetType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this.thumbTray.onLoadUserPropComplete();
         }
      }
      
      private function enableAfterSave() : void
      {
         this.requestLoadStatus(false,true);
         if(this._isAutoSave)
         {
            this._topButtonBar._btnSave.enabled = true;
            this._topButtonBar._btnSave.buttonMode = true;
            this._topButtonBar.currentState = "";
         }
         if(!this._isAutoSave)
         {
            if(this._publishW != null)
            {
               this.closePublishWindow();
            }
            if(this._viewStackWindow != null && !this._redirect)
            {
               this.doContinueEdit();
            }
         }
      }
      
      private function onSoundClickHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:AnimeSound = null;
         var _loc4_:Timeline = null;
         var _loc5_:SoundContainer = null;
         _loc2_ = param1.id;
         _loc3_ = this.sounds.getValueByKey(_loc2_) as AnimeSound;
         _loc4_ = Timeline(param1.currentTarget);
         _loc5_ = param1.soundContainer;
         _loc3_.showMenu(_loc4_.stage.mouseX,_loc4_.stage.mouseY,_loc5_);
      }
      
      public function moveScene(param1:Number, param2:Number) : void
      {
         var _loc3_:GoAlert = null;
         var _loc4_:ICommand = null;
         if(this._timeline.getNumOfSoundStartAtScene(param1) > 0)
         {
            _loc3_ = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true));
            _loc3_._lblConfirm.text = "";
            _loc3_._txtDelete.text = UtilDict.toDisplay("go","Please remove the sound(s) in this scene before moving it.");
            _loc3_.showButton(false,true);
            _loc3_.hideCloseBtn();
            _loc3_._btnCancel.label = UtilDict.toDisplay("go","ok");
            _loc3_.x = (_loc3_.stage.width - _loc3_.width) / 2;
            _loc3_.y = 100;
         }
         else
         {
            (_loc4_ = new MoveSceneCommand(param1,param2)).execute();
            this.doMoveScene(param1,param2);
         }
      }
      
      public function hideGuideSceneBub(param1:Event = null) : void
      {
         if(this._bubbleSceneGuide != null)
         {
            this._bubbleSceneGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
            this.hideGuideBubble(this._bubbleSceneGuide);
         }
      }
      
      public function get goWalker() : TutorialManager
      {
         return this._goWalker;
      }
      
      private function initThemeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,5,5,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_tipstheme");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",15);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).percentWidth = 85;
         _loc5_.setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","left");
         _loc5_.setStyle("horizontalCenter","1");
         var _loc6_:Text;
         (_loc6_ = new Text()).percentWidth = 100;
         _loc6_.text = UtilDict.toDisplay("go","thumbtray_tipsthemecontent");
         _loc6_.setStyle("fontSize",16);
         var _loc7_:Canvas;
         (_loc7_ = new Canvas()).width = 300;
         _loc7_.height = 110;
         _loc7_.styleName = "imgThemeArrow";
         _loc5_.addChild(_loc6_);
         _loc5_.addChild(_loc7_);
         _loc2_.setContent(_loc5_);
         var _loc8_:Canvas;
         (_loc8_ = new Canvas()).width = _loc2_.width;
         _loc8_.setStyle("horizontalCenter","1");
         _loc8_.buttonMode = true;
         var _loc9_:Label;
         (_loc9_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colorclose");
         _loc9_.buttonMode = true;
         _loc9_.useHandCursor = true;
         _loc9_.mouseChildren = false;
         _loc9_.x = (_loc8_.width - 80) / 2;
         _loc9_.setStyle("fontSize",14);
         _loc9_.addEventListener(MouseEvent.CLICK,this.closeThemeTip);
         _loc8_.addChild(_loc9_);
         _loc2_.setClose(_loc8_);
      }
      
      public function get tempMetaData() : MetaData
      {
         return this._tempMetaData;
      }
      
      private function doNavigateToPlayerPage(param1:Event) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:String = null;
         var _loc6_:RegExp = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.doNavigateToPlayerPage);
         _loc2_ = new URLVariables();
         _loc4_ = Util.getFlashVar();
         Util.gaTracking("/gostudio/close",Console.getConsole().mainStage.stage);
         if(_loc4_.containsKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID))
         {
            _loc2_[ServerConstants.SERVER_PLAYER_PARAM_USER_ID] = _loc4_.getValueByKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID) as String;
         }
         _loc5_ = _loc4_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String;
         _loc6_ = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc5_ = _loc5_.replace(_loc6_,this.metaData.movieId);
         _loc3_ = new URLRequest(_loc5_ + _loc2_.toString());
         navigateToURL(_loc3_,"_self");
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addSoundAtScene(param1:AnimeScene, param2:SoundThumb, param3:Point, param4:AnimeSound = null, param5:Boolean = true) : void
      {
         var _loc10_:ICommand = null;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:UtilLoadMgr = null;
         var _loc14_:Array = null;
         var _loc6_:int = this.getSceneIndex(param1);
         var _loc7_:ElementInfo = this.timeline.getSceneInfoByIndex(_loc6_);
         if(param2.sound != null && param2.sound.getIsReadyToPlay() && param2.lengthFrame != -1)
         {
            if(param4 == null)
            {
               (param4 = new AnimeSound()).init(param2,UtilUnitConvert.pixelToFrame(param3.x),UtilUnitConvert.pixelToFrame(param3.x) + param2.lengthFrame,null,UtilUnitConvert.pixelToTrack(param3.y));
               if(Console.getConsole().publishW != null)
               {
                  this.addSound(param4,param3.x,param3.y,-1,true);
                  this.timeline.setSoundInfoById(param4.getID(),0,this.timeline.getTotalTimeInPixel());
               }
               else
               {
                  this.addSound(param4,param3.x,param3.y,-1,true);
               }
            }
            else
            {
               _loc11_ = this.timeline.getSoundIndexById(param4.getID());
               this.sounds.push(param4.getID(),param4);
               if((_loc12_ = this._timeline.getNextSoundOnSameTrack(param3.y,param3.x)) < UtilUnitConvert.secToPixel(param2.duration / 1000))
               {
                  param4.startFrame = UtilUnitConvert.pixelToFrame(param3.x);
                  param4.endFrame = UtilUnitConvert.pixelToFrame(param3.x) + UtilUnitConvert.pixelToFrame(_loc12_);
               }
               else
               {
                  param4.startFrame = UtilUnitConvert.pixelToFrame(param3.x);
                  param4.endFrame = UtilUnitConvert.pixelToFrame(param3.x) + UtilUnitConvert.secToFrame(param2.duration / 1000);
               }
               param4.trackNum = UtilUnitConvert.pixelToTrack(param3.y);
               this.timeline.setSoundReadyByID(param4.getID());
               if(Console.getConsole().publishW != null)
               {
                  this.timeline.setSoundInfoById(param4.getID(),0,this.timeline.getTotalTimeInPixel());
               }
               else
               {
                  this.timeline.setSoundInfoById(param4.getID(),param3.x,UtilUnitConvert.frameToPixel(param4.endFrame - param4.startFrame),param4.getLabel(),UtilUnitConvert.trackToPixel(param4.trackNum));
               }
               this.stopAllSounds();
            }
            this.requestLoadStatus(false);
            if(this.sounds.length == 1 && !this.goWalker.hasSoundGuideShown)
            {
               this.goWalker.addEventListener(TutorialEvent.TUTORIAL_DONE,this.playArgSound);
               this.goWalker.startSoundTutorial(this.timeline,param4);
               param5 = false;
            }
            if(param5)
            {
               this._thumbTray.stopAllSounds();
               param4.playSound();
            }
            (_loc10_ = new AddSoundCommand(param4)).execute();
         }
         else
         {
            _loc13_ = new UtilLoadMgr();
            (param4 = new AnimeSound()).init(param2,0,UtilUnitConvert.secToPixel(param2.duration / 1000));
            this.timeline.addSoundAtTime(param4.getID(),"Loading ... " + param4.getLabel(),param3.x,param3.y,UtilUnitConvert.secToPixel(param2.duration / 1000),-1,false,false,param2.duration / 1000);
            (_loc14_ = new Array()).push(param1);
            _loc14_.push(param2);
            _loc14_.push(param4);
            _loc14_.push(param3);
            _loc14_.push(param5);
            _loc13_.setExtraData(_loc14_);
            _loc13_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc13_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doAddSoundAtSceneAgain);
            _loc13_.commit();
            this.requestLoadStatus(true);
            param2.initSoundFromNetwork();
         }
         var _loc8_:Object;
         (_loc8_ = new Object())["id"] = param4.getID();
         var _loc9_:SoundEvent = new SoundEvent(SoundEvent.ADDED,this,_loc8_);
         this.dispatchEvent(_loc9_);
      }
      
      public function get metaData() : MetaData
      {
         return this._metaData;
      }
      
      public function set isCommonThemeLoadded(param1:Boolean) : void
      {
         this._isCommonThemeLoadded = param1;
      }
      
      public function createAsset(param1:Object, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void
      {
         if(this._movie.currentScene != null)
         {
            this._movie.currentScene.createAsset(param1 as Thumb,param2,param3,"",param4);
         }
      }
      
      private function doUpdateThumbTray(param1:CoreEvent) : void
      {
         var _loc2_:Theme = param1.getData() as Theme;
         this.addTheme(_loc2_.id,_loc2_);
         if(_loc2_.id != "common")
         {
            this.setCurTheme(_loc2_);
            this._thumbTray.themeId = _loc2_.id;
         }
         if(_loc2_.id == "common")
         {
            this._isCommonThemeLoadded = true;
         }
         this._thumbTray.loadThumbs(_loc2_);
      }
      
      public function putData(param1:String, param2:Object) : void
      {
         if(this._previewData == null)
         {
            this._previewData = new UtilHashArray();
         }
         if(!this._previewData.containsKey(param1))
         {
            this._previewData.push(param1,param2,true);
         }
         else
         {
            this._previewData.replaceValueByKey(param1,param2);
         }
      }
      
      private function removeGuideBubbleAfterFade(param1:Event) : void
      {
         var fade:Fade = null;
         var bub:Image = null;
         var event:Event = param1;
         fade = event.target as Fade;
         bub = fade.target as Image;
         try
         {
            this.thumbTray.parent.removeChild(bub);
         }
         catch(e:Error)
         {
         }
         if(bub == this._bubbleThumbGuide)
         {
            this._bubbleThumbGuide = null;
         }
         if(bub == this._bubbleSceneGuide)
         {
            this._bubbleSceneGuide = null;
         }
      }
      
      private function deSerialize(param1:XML, param2:String, param3:String = null) : void
      {
         var indexArray:Array = null;
         var metaNode:XML = null;
         var skipEditHead:Boolean = false;
         var i:int = 0;
         var sceneNode:XML = null;
         var sceneId:String = null;
         var scene:AnimeScene = null;
         var movieXML:XML = param1;
         var movieID:String = param2;
         var originalId:String = param3;
         if(movieXML != null)
         {
            this.clearScenes();
            metaNode = movieXML.child(MetaData.XML_NODE_NAME)[0];
            this._metaData = new MetaData();
            this._metaData.deSerialize(metaNode,movieID,originalId);
            this._tempMetaData.deSerialize(metaNode,movieID,originalId);
            this._metaData.lang = this._tempMetaData.lang = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
            this.movie.published = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PUBLISHED) as String == "0"?false:true;
            this.movie.privateShared = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PRIVATESHARED) as String == "0"?false:true;
            this.movie.copyable = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_COPYABLE) as String == "1"?true:false;
            if(originalId != null && StringUtil.trim(originalId))
            {
               this._metaData.title = "";
               this._tempMetaData.title = "";
               this.movie.published = false;
               this.movie.privateShared = UtilSite.siteId == UtilSite.GOANIMATE;
               this.isCopy = true;
            }
            this.tempPublished = this.movie.published;
            this.tempPrivateShared = this.movie.privateShared;
            if(Console.getConsole().studioType == MESSAGE_STUDIO)
            {
               indexArray = UtilXmlInfo.getAndSortXMLattribute(movieXML,"index",AnimeScene.XML_NODE_NAME);
               skipEditHead = true;
               i = 0;
               while(i < indexArray.length)
               {
                  sceneNode = movieXML.child(AnimeScene.XML_NODE_NAME).(@index == indexArray[i] as int)[0];
                  sceneId = sceneNode.@id;
                  scene = this.addScene(sceneId);
                  this.capScreenLock = true;
                  scene.deSerialize(sceneNode,true,false,false);
                  this.capScreenLock = false;
                  if(sceneNode.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1)
                  {
                     skipEditHead = false;
                  }
                  i++;
               }
               this.setCurrentScene(indexArray.length - 1);
               this.currentScene.loadAllAssets();
               this.deserializeSound(movieXML);
               this.stopScene(this.stopScene,6);
               this._initialized = true;
               this.dispatchEvent(new CoreEvent(CoreEvent.PREPARE_MOVIE_COMPLETE,this,skipEditHead));
            }
            else
            {
               this._sci = 0;
               try
               {
                  this.thumbSO = SharedObject.getLocal("studioThumbs_" + this.metaData.movieId);
               }
               catch(e:Error)
               {
                  thumbSO = null;
               }
               this.addSceneOnDeserialize();
            }
         }
      }
      
      public function get communityTheme() : Theme
      {
         return this._communityTheme;
      }
      
      private function loadUserThemeTimeOutHandler(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeTimeOutHandler);
         this.loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this._thumbTray.removeLoadingCanvas(this._loaddingAssetType);
         Alert.show("Operation timeout");
      }
      
      private function onSoundResizeHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getValueByKey(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.pixelToFrame(_loc3_.startPixel + _loc3_.totalPixel);
      }
      
      public function publishMovie(param1:PublishWindow, param2:Boolean, param3:Boolean, param4:Boolean = false) : void
      {
         this.movie.published = param2;
         this.movie.privateShared = param3;
         this._metaData = this._tempMetaData;
         this._redirect = param4;
         Console.getConsole().groupController.currentGroup = Console.getConsole().groupController.tempCurrentGroup;
         if(this._redirect)
         {
            this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
            this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         }
         this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         this.prepareSaveMovieThumbnailScene();
      }
      
      private function isSceneGotoBuild(param1:XML) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1 && (this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO) && this.isCopy)
         {
            _loc2_ = false;
         }
         if(Number(param1.@adelay) < AnimeConstants.SCENE_DURATION_MINIMUM * AnimeConstants.FRAME_PER_SEC)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function onLoadSingleCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadSingleCcCharCompleted);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.doPrepareLoadCcCharComplete(_loc2_.data as ByteArray);
      }
      
      public function addRandomAssetsToScene(param1:Theme, param2:AnimeScene) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:BackgroundThumb = null;
         var _loc6_:SoundThumb = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:int = 0;
         if(param1 == null || param2 == null)
         {
            _logger.error("Both theme and scene could not be null");
            throw new Error("Both theme and scene could not be null");
         }
         _loc7_ = new UtilHashArray();
         _loc8_ = new UtilHashArray();
         if((_loc5_ = param1.defaultBgThumb) != null && _loc5_.enable)
         {
            _loc7_.push(_loc5_.id,_loc5_);
         }
         _loc9_ = 0;
         while(_loc9_ < param1.soundThumbs.length)
         {
            if((_loc6_ = SoundThumb(param1.soundThumbs.getValueByIndex(_loc9_))).enable && _loc6_.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc8_.push(_loc6_.id,_loc6_);
            }
            _loc9_++;
         }
         if(_loc7_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc7_.length;
            _loc5_ = BackgroundThumb(_loc7_.getValueByIndex(_loc4_));
            param2.createAsset(_loc5_);
         }
         if(_loc8_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc8_.length;
            _loc6_ = SoundThumb(_loc8_.getValueByIndex(_loc4_));
         }
         this._isMovieNew = false;
      }
      
      private function onUserAccountUpgraded(param1:Event) : void
      {
         var _loc2_:GoPopUp = GoPopUp(PopUpManager.createPopUp(Application.application as DisplayObject,GoPopUp,true));
         _loc2_.width = 400;
         _loc2_.okText = UtilDict.toDisplay("go","Save");
         _loc2_.cancelText = UtilDict.toDisplay("go","Close");
         _loc2_.addEventListener("okClick",this.onUserWannaSaveWork);
         _loc2_.text = UtilDict.toDisplay("go","Your account is now GoPlus ready.  Please save your work and reload the studio to enable the new features.");
         PopUpManager.centerPopUp(_loc2_);
         _loc2_.y = 100;
      }
      
      public function goCreateCC() : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE && this.thumbTray.themeId == "action")
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showCCBrowser");
            }
         }
         else
         {
            this.doShowCreateMyCharAlert();
         }
      }
      
      public function doShowCreateMyCharAlert() : void
      {
         UtilNavigate.toCreateCc(this._curTheme.cc_theme_id);
      }
      
      public function get groupController() : GroupController
      {
         return this._groupController;
      }
      
      private function set isCopy(param1:Boolean) : void
      {
         this._isCopy = param1;
      }
      
      public function thumbTrayCommand(param1:String, param2:String) : void
      {
         this.thumbTray["cmd"](param2);
      }
      
      public function showBuyGoBuckPopUp() : void
      {
         if(!this._popUp)
         {
            this._popUp = GoPopUp(PopUpManager.createPopUp(this._mainStage,GoPopUp,true));
            this._popUp.text = UtilDict.toDisplay("go","Hey there, looks like you need more GoBucks!  Want to get some now?");
            this._popUp.addEventListener("okClick",this.redirectToBuyGoBuckPage);
            this._popUp.addEventListener("cancelClick",this.closePopUp);
            this._popUp.okText = UtilDict.toDisplay("go","Yes");
            this._popUp.cancelText = UtilDict.toDisplay("go","No");
            this._popUp.width = 400;
            this._popUp.x = (this._popUp.stage.width - this._popUp.width) / 2;
            this._popUp.y = 150;
         }
      }
      
      private function onLoadThemeListComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var zip:ZipFile = null;
         var themeListXML:XML = null;
         var defaultZipEntry:ZipEntry = null;
         var commonZipEntry:ZipEntry = null;
         var BAD_TERMS_XML_NODE_NAME:String = null;
         var GOOD_TERMS_XML_NODE_NAME:String = null;
         var excludeAssetIds:Array = null;
         var aid:String = null;
         var node:XML = null;
         var i:int = 0;
         var j:int = 0;
         var ts:XMLList = null;
         var group:Group = null;
         var event:Event = param1;
         this.requestLoadStatus(false,true);
         if(Util.isDebugMode)
         {
            Alert.show("load theme list complete ");
         }
         try
         {
            urlLoader = event.target as URLLoader;
            zip = new ZipFile(urlLoader.data as ByteArray);
            themeListXML = new XML(zip.getInput(zip.getEntry("themelist.xml")).toString());
            ThemeEmbedConstant.defaultThemeId = themeListXML.child("theme")[0].attribute("id");
            this.currentLicensorName = themeListXML.child("theme")[0].attribute("name");
            defaultZipEntry = zip.getEntry(ThemeEmbedConstant.defaultThemeId + ".zip");
            if(defaultZipEntry != null)
            {
               ThemeEmbedConstant.defaultThemeZip = zip.getInput(defaultZipEntry);
            }
            commonZipEntry = zip.getEntry("common.zip");
            if(commonZipEntry != null)
            {
               ThemeEmbedConstant.commonThemeZip = zip.getInput(commonZipEntry);
            }
            BAD_TERMS_XML_NODE_NAME = "word";
            GOOD_TERMS_XML_NODE_NAME = "whiteword";
            if(themeListXML.child(BAD_TERMS_XML_NODE_NAME).length() > 0 && Util.getFlashVar().getValueByKey("hb") == "1")
            {
               this.setBadTerms(themeListXML.child(BAD_TERMS_XML_NODE_NAME)[0].toString());
               this.setWhiteTerms(themeListXML.child(GOOD_TERMS_XML_NODE_NAME)[0].toString());
            }
            else
            {
               this.setBadTerms("");
               this.setWhiteTerms("");
            }
            excludeAssetIds = String(themeListXML.excludeAssetIDs).split(",");
            this.excludedIds = new UtilHashArray();
            for each(aid in excludeAssetIds)
            {
               aid = StringUtil.trim(aid);
               if(aid != "")
               {
                  this.excludedIds.push(aid,aid);
               }
            }
            if(this._purchaseEnabled)
            {
               this._purchasedAssetsXML = themeListXML.child("premium");
               ts = themeListXML.child("points");
               if(ts.length() > 0)
               {
                  UtilUser.goBuck = themeListXML.child("points")[0].@money;
                  UtilUser.goPoint = themeListXML.child("points")[0].@sharing;
               }
               if(this._purchasedAssetsXML.length() != 0)
               {
                  this._userTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  this._lastLoaddedTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  this._searchedTheme.modifyPremiumContent(this._purchasedAssetsXML);
               }
               else
               {
                  this._purchasedAssetsXML = new XMLList();
               }
            }
            else
            {
               this._purchasedAssetsXML = new XMLList();
            }
            i = 0;
            while(i < themeListXML.child("school").length())
            {
               node = themeListXML.child("school")[i];
               this.groupController.schoolId = node.attribute("id");
               i++;
            }
            j = 0;
            while(j < themeListXML.child("group").length())
            {
               node = themeListXML.child("group")[j];
               group = new Group(node.attribute("id"),node.attribute("name"));
               this.groupController.addGroup(group);
               j++;
            }
            if(themeListXML.hasOwnProperty("category"))
            {
               this.groupController.categoryList = themeListXML.category;
            }
            if(themeListXML.hasOwnProperty("tts"))
            {
               TTSManager.credit = themeListXML.tts.@credit;
            }
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEMELIST_COMPLETE,this,themeListXML));
         }
         catch(e:TypeError)
         {
            _logger.error("Could not parse text into xml." + e.message);
            Alert.show(e.message + " ");
         }
         catch(e:Error)
         {
            _logger.error(e.getStackTrace());
            Alert.show(e.message + " ");
         }
      }
      
      private function closeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         this.mainStage.removeChild(_loc2_);
      }
      
      public function addStoreCollection(param1:String) : void
      {
         var _loc2_:String = null;
         if(this.storecollection.indexOf(param1) == -1)
         {
            _loc2_ = param1.replace(/\W/g,"_");
            this.storecollection.push(_loc2_);
         }
      }
      
      public function dispatchTutorialEvent(param1:TutorialEvent) : void
      {
         if(this.isTutorialOn)
         {
            this.dispatchEvent(param1);
         }
      }
      
      public function doKeyUp(param1:KeyboardEvent) : void
      {
         trace(param1.toString());
         if(this.isTutorialOn)
         {
            return;
         }
         if(param1.keyCode == 90 && param1.ctrlKey)
         {
            this.undo();
         }
         else if(param1.keyCode == 89 && param1.ctrlKey)
         {
            this.redo();
         }
      }
      
      public function set soundMute(param1:Boolean) : void
      {
         this._soundMute = param1;
         var _loc2_:int = 0;
         if(this.currentScene != null)
         {
            this.currentScene.muteSound(param1);
         }
      }
      
      private function doLoadThemeTreesCompleted(param1:LoadMgrEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         this.deSerialize(this._movieXML,this.metaData.movieId,_loc2_);
         this._isLoadding = false;
         Util.gaTracking("/gostudio/themeCompleted",Console.getConsole().mainStage.stage);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_MOVIE_COMPLETE,this));
      }
      
      public function set loadProgressVisible(param1:Boolean) : void
      {
         this._loadProgress.visible = param1;
      }
      
      public function get isLoaddingCommonTheme() : Boolean
      {
         return this._isLoaddingCommonTheme;
      }
      
      public function getSceneIndex(param1:AnimeScene) : int
      {
         return this._movie.getSceneIndex(param1);
      }
      
      public function getUserAssetById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            this._assetId = Number(param1);
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_ASSET);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomAssetComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function sendBackward() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:Boolean = false;
         var _loc3_:Asset = null;
         var _loc4_:ICommand = null;
         if(this.isTutorialOn)
         {
            return;
         }
         _loc1_ = _console.currentScene;
         _loc2_ = _loc1_.sendBackward();
         _loc3_ = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new SendBackwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function showUpgradePopup() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         _loc1_ = UtilPopUp.upgrade();
         _loc1_.width = 400;
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = 100;
      }
      
      public function updateAsset(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["assetId"] = param1;
         _loc5_["title"] = param2;
         _loc5_["tags"] = param3;
         _loc5_["isPublished"] = !!param4?"1":"0";
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_UPDATE_ASSET)).data = _loc5_;
         _loc6_.method = URLRequestMethod.POST;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).addEventListener(Event.COMPLETE,this.onUpdateAssetComplete);
         _loc7_.load(_loc6_);
      }
      
      private function reloadAllCC(param1:String) : void
      {
         if(this._isStudioReady)
         {
            this.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.thumbTray.doLoadSingleCcCharThumb);
            this.loadSingleCcChar(param1);
         }
      }
      
      public function get isCommonThemeLoadded() : Boolean
      {
         return this._isCommonThemeLoadded;
      }
      
      public function isThemeCcRelated(param1:String) : Boolean
      {
         var list:XMLList = null;
         var themeId:String = param1;
         list = this._themeListXML.child("theme").(attribute("id") == themeId && hasOwnProperty("@cc_theme_id") && attribute("cc_theme_id") != "");
         return list.length() > 0;
      }
      
      private function playArgSound(param1:TutorialEvent) : void
      {
         var _loc2_:AnimeSound = param1.data as AnimeSound;
         _loc2_.playSound();
      }
      
      public function getScenebyId(param1:String) : AnimeScene
      {
         return this._movie.getSceneById(param1);
      }
      
      public function getUserCharById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_CHAR);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomCharComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomCharComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomCharComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function isMovieNew() : Boolean
      {
         return this._isMovieNew;
      }
      
      public function saveMovie() : void
      {
         var flashVars:UtilHashArray = null;
         var request:URLRequest = null;
         var variables:URLVariables = null;
         var saveThumbnail:Boolean = false;
         var movieManager:MovieManager = null;
         var encodedThumb:Base64Encoder = null;
         var encodedThumbLarge:Base64Encoder = null;
         var fileName:String = null;
         var fileData:ByteArray = null;
         var zipOut:ZipOutput = null;
         var ze:ZipEntry = null;
         var zipData:ByteArray = null;
         var encodedMovie:Base64Encoder = null;
         var logger:UtilErrorLogger = null;
         flashVars = Util.getFlashVar();
         try
         {
            if(!(this._isAutoSave && this._publishW != null))
            {
               if(!this._isAutoSave)
               {
                  this.requestLoadStatus(true,true);
                  if(this.movie.published)
                  {
                     Util.gaTracking("/gostudio/SaveShare",Console.getConsole().mainStage.stage);
                  }
                  else if(this._redirect)
                  {
                     Util.gaTracking("/gostudio/SaveAndClose",Console.getConsole().mainStage.stage);
                  }
                  else
                  {
                     Util.gaTracking("/gostudio/SaveOnly",Console.getConsole().mainStage.stage);
                  }
                  if(this._redirect)
                  {
                     Util.gaTracking("/gostudio/onExitDiversion",Console.getConsole().mainStage.stage);
                  }
               }
               else
               {
                  this._topButtonBar._btnSave.buttonMode = false;
                  this._topButtonBar._btnSave.enabled = false;
                  this._topButtonBar.currentState = "autoSave";
               }
               if(this._publishW != null)
               {
                  this._publishW.setBtnStatus(false);
               }
               variables = new URLVariables();
               this._filmXML = this.serialize(false);
               this.dispatchEvent(new CoreEvent(CoreEvent.SERIALIZE_COMPLETE,this));
               if(this._isAutoSave)
               {
                  if(this.metaData.movieId != null && this._filmXML.children().toXMLString() == this._movieXML.children().toXMLString() && this.siteId != String(Global.BEN10))
                  {
                     this.enableAfterSave();
                     this._isAutoSave = false;
                     return;
                  }
                  if(this.metaData.movieId != null)
                  {
                     variables[ServerConstants.PARAM_AUTOSAVE] = 1;
                  }
                  variables[ServerConstants.PARAM_IS_TRIGGER_BY_AUTOSAVE] = 1;
                  Util.gaTracking(AnimeConstants.GA_ACTION__AUTO_SAVE,this.mainStage.stage);
               }
               Util.addFlashVarsToURLvar(variables);
               saveThumbnail = true;
               if(this._isAutoSave)
               {
                  if(this.metaData.movieId != null)
                  {
                     saveThumbnail = false;
                  }
                  else
                  {
                     this.selectedThumbnailIndex = this._movie.currentIndex;
                  }
               }
               variables[ServerConstants.PARAM_SAVE_THUMBNAIL] = !!saveThumbnail?"1":"0";
               if(saveThumbnail)
               {
                  encodedThumb = new Base64Encoder();
                  encodedThumbLarge = new Base64Encoder();
                  encodedThumb.encodeBytes(this.getMovieThumbnail());
                  encodedThumbLarge.encodeBytes(this.getMovieThumbnail(true));
                  variables[ServerConstants.PARAM_THUMBNAIL] = encodedThumb.flush();
                  variables[ServerConstants.PARAM_THUMBNAIL_LARGE] = encodedThumbLarge.flush();
                  this.unloadThumbnailScene();
               }
               if(UtilLicense.useZipAsBodyXML())
               {
                  fileName = PlayerConstant.FILM_XML_FILENAME;
                  fileData = new ByteArray();
                  fileData.writeUTFBytes(this._filmXML.toString());
                  zipOut = new ZipOutput();
                  ze = new ZipEntry(fileName);
                  zipOut.putNextEntry(ze);
                  zipOut.write(fileData);
                  zipOut.closeEntry();
                  zipOut.finish();
                  zipData = zipOut.byteArray;
                  encodedMovie = new Base64Encoder();
                  encodedMovie.encodeBytes(zipData);
                  variables[ServerConstants.PARAM_BODY_ZIP] = encodedMovie.flush();
               }
               else
               {
                  variables[ServerConstants.PARAM_BODY] = this._filmXML;
               }
               delete variables[ServerConstants.PARAM_MOVIE_ID];
               if(this.metaData.movieId != null)
               {
                  variables[ServerConstants.PARAM_MOVIE_ID] = this.metaData.movieId;
               }
               if(this.metaData.movieId == null && this._initThemeCode != null)
               {
                  variables[ServerConstants.PARAM_INITIAL_THEME_CODE] = this._initThemeCode;
               }
               variables[ServerConstants.PARAM_LANG] = this.metaData.lang;
               delete variables[ServerConstants.PARAM_ORIGINAL_ID];
               if(this.metaData.originalId != null && StringUtil.trim(this.metaData.originalId))
               {
                  variables[ServerConstants.PARAM_ORIGINAL_ID] = this.metaData.originalId;
               }
               if(Console.getConsole().studioType == MESSAGE_STUDIO)
               {
                  variables[ServerConstants.PARAM_EMESSAGE] = 1;
               }
               if(Console.getConsole().boxMode)
               {
                  variables[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = flashVars.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
               }
               if(this.groupController.isSchoolProject)
               {
                  variables[ServerConstants.PARAM_GROUP_ID] = this.groupController.currentGroup.id;
                  variables[ServerConstants.PARAM_CATEGORY] = this.groupController.category;
               }
               if(UtilSite.siteId == UtilSite.YOUTUBE)
               {
                  variables[ServerConstants.PARAM_YOUTUBE_PUBLISH] = !!this.movie.published?"publish":"private";
               }
               movieManager = new MovieManager();
               movieManager.addEventListener(Event.COMPLETE,this.doSaveMovieComplete);
               movieManager.addEventListener(IOErrorEvent.IO_ERROR,this.doSaveMovieComplete);
               movieManager.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doSaveMovieComplete);
               movieManager.saveMovie(variables);
            }
            else
            {
               this._isAutoSave = false;
            }
         }
         catch(exception:Error)
         {
            dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,exception));
         }
         finally
         {
            logger = UtilErrorLogger.getInstance();
            logger.flush();
         }
      }
      
      public function getThumbnailCaptureBySceneIndex(param1:int) : BitmapData
      {
         return this.timeline.getSceneImageBitmapByIndex(param1);
      }
      
      private function doContinueEdit(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnimeScene = null;
         if(this._viewStackWindow != null)
         {
            this._viewStackWindow.removeEventListener(Event.CANCEL,this.doContinueEdit);
            this._viewStackWindow.destory();
         }
         PopUpManager.removePopUp(this._viewStackWindow);
         this._viewStackWindow = null;
         this._publishW = null;
         this._previewData.removeAll();
         if(this._movie.currentScene != null)
         {
            this._movie.currentScene.playScene();
         }
         if(this.isTutorialOn)
         {
            this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.PREVIEW_DONE,this));
            this._guideMode = ServerConstants.FLASHVAR_TM_FIN;
            _loc2_ = 0;
            while(_loc2_ < this._movie.scenes.length)
            {
               _loc3_ = this.getScene(_loc2_);
               _loc3_.meltAllAssets();
               _loc2_++;
            }
         }
      }
      
      private function onSceneSelected(param1:MovieEvent) : void
      {
         if(param1.index >= 0)
         {
            this._mainStage.sceneIndexStr = param1.index >= 0?"" + (param1.index + 1):"";
            this._mainStage.hideCameraView();
            this._stageViewStack.selectedIndex = param1.index;
            this._stageViewStack.validateNow();
            this._timeline.setCurrentSceneByIndex(this._movie.currentIndex);
            this._movie.currentScene.refreshEffectTray(this.effectTray);
            this.soundMute = this.soundMute;
            this.dispatchEvent(new IndexChangedEvent(IndexChangedEvent.CHANGE));
         }
      }
      
      private function get isCopy() : Boolean
      {
         return this._isCopy;
      }
      
      private function loadThemeList(param1:Number = 0) : void
      {
         this.requestLoadStatus(true,true);
         var _loc2_:URLRequest = UtilNetwork.getGetThemeListRequest();
         var _loc3_:URLLoader = new URLLoader();
         (_loc2_.data as URLVariables)["siteId"] = this._siteId;
         (_loc2_.data as URLVariables)["xclZip"] = param1;
         _loc3_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadThemeListComplete);
         _loc3_.addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadThemeListFailed);
         _loc3_.load(_loc2_);
         var _loc4_:UtilHashArray = Util.getFlashVar();
      }
      
      private function onTimerHandler(param1:TimerEvent) : void
      {
         this.doAutoSave();
      }
      
      private function onTutorialDone(param1:TutorialEvent) : void
      {
         this._thumbTray.isTutorialOn = false;
      }
      
      public function slideAsset() : void
      {
      }
      
      private function onSoundMouseUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         this._timeline.removeEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
         _loc2_ = param1.id;
         this.updateSoundById(_loc2_);
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         if(_loc3_ != null && this._prevSoundInfo != null)
         {
            if(_loc3_.startPixel != this._prevSoundInfo.startPixel || _loc3_.y != this._prevSoundInfo.y)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
      }
      
      public function doDeleteCurrentScene() : void
      {
         this._movie.removeSceneAt(this._movie.currentIndex);
      }
      
      public function serializeLinkage() : String
      {
         return this.linkageController.serialize();
      }
      
      public function get soundMute() : Boolean
      {
         return this._soundMute;
      }
      
      public function checkMyCharNumAndShowCharImmediately() : void
      {
         this.thumbTray.registerShouldShowCharTabOnCcLoaded(true);
         this.checkMyCharNum();
      }
      
      public function deleteCurrentScene() : void
      {
         var _loc1_:GoAlert = null;
         var _loc2_:ICommand = null;
         if(this._movie.scenes.length == 1)
         {
            this.clearCurrentScene();
         }
         else if(this._movie.currentScene)
         {
            if(this._timeline.getNumOfSoundStartAtScene(this._movie.currentIndex) > 0)
            {
               _loc1_ = GoAlert(PopUpManager.createPopUp(this._movie.currentScene.canvas,GoAlert,true));
               _loc1_._lblConfirm.text = "";
               _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_removesound");
               _loc1_.showButton(false,true);
               _loc1_.hideCloseBtn();
               _loc1_._btnCancel.label = UtilDict.toDisplay("go","ok");
               _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
               _loc1_.y = 100;
            }
            else
            {
               _loc2_ = new RemoveSceneCommand();
               _loc2_.execute();
               this.doDeleteCurrentScene();
            }
         }
      }
      
      public function userHasTTSRight() : Boolean
      {
         return this._ttsEnabled;
      }
      
      public function doGoToCopyChar(param1:CopyThumbEvent) : void
      {
         var _loc2_:GoAlert = null;
         _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc2_._lblConfirm.text = UtilDict.toDisplay("go","goalert_copy_char_title");
         _loc2_._txtDelete.text = UtilDict.toDisplay("go","goalert_copy_char_window_alert_text");
         _loc2_._txtDelete.setStyle("textAlign","left");
         _loc2_._txtDelete.setStyle("fontSize","15");
         _loc2_._btnDelete.label = UtilDict.toDisplay("go","goalert_okay");
         _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.showCopyMyChar);
         _loc2_._btnDelete.name = [param1.thumb.xml.@cc_theme_id,param1.thumb.encryptId].join("|");
         _loc2_._btnCancel.label = UtilDict.toDisplay("go","goalert_cancel");
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      public function set pptPanel(param1:PropertiesWindow) : void
      {
         this._pptPanel = param1;
      }
      
      public function preview(param1:PreviewPlayer = null, param2:Boolean = false) : void
      {
         var _loc3_:UtilHashArray = null;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:Theme = null;
         var _loc7_:XML = null;
         var _loc8_:Number = NaN;
         this.stopAllSounds();
         this._filmXML = this.serialize();
         this.putFontData(this._filmXML.toXMLString());
         _logger.debug("the movie\'s xml: \n " + this._filmXML);
         _loc3_ = new UtilHashArray();
         _loc4_ = 0;
         while(_loc4_ < this._themes.length)
         {
            _loc3_.push(this._themes.getKey(_loc4_),(this._themes.getValueByIndex(_loc4_) as Theme).getThemeXML());
            _loc4_++;
         }
         _loc5_ = this.userTheme.getThemeXML();
         _loc6_ = this.getTheme("ugc");
         _loc7_ = null;
         if(_loc5_ == null || _loc6_ == null || _loc6_.getThemeXML() == null)
         {
            _loc7_ = _loc5_;
         }
         else
         {
            _loc7_ = Theme.merge2ThemeXml(_loc5_,_loc6_.getThemeXML(),"ugc","ugc",false);
         }
         _loc7_ = Theme.merge2ThemeXml(_loc6_ != null?_loc6_.getThemeXML():null,this.userTheme.getThemeXML(),"ugc","ugc");
         _loc3_.push(this.userTheme.id,_loc7_);
         if(this._shouldUseExternalPreviewPlayer == -1)
         {
            if(UtilLicense.isExternalPreviewPlayerShouldBeUsed(UtilLicense.getCurrentLicenseId()) && this.studioType == FULL_STUDIO && (this._guideMode == "" || this._guideMode == ServerConstants.FLASHVAR_TM_FIN))
            {
               this._shouldUseExternalPreviewPlayer = 1;
            }
            else
            {
               this._shouldUseExternalPreviewPlayer = 0;
            }
         }
         if(this._shouldUseExternalPreviewPlayer == 1)
         {
            this.externalPreviewPlayerController = new ExternalPreviewWindowController();
            this.externalPreviewPlayerController.removeEventListener(Event.CHANGE,this.showPublishWindow);
            this.externalPreviewPlayerController.removeEventListener(Event.CANCEL,this.doContinueEdit);
            this.externalPreviewPlayerController.addEventListener(Event.CHANGE,this.doShowPublishWindow);
            this.externalPreviewPlayerController.addEventListener(Event.CANCEL,this.doContinueEdit);
            _loc8_ = new Number();
            if(param2 == true)
            {
               _loc8_ = this._movie.currentIndex;
            }
            else
            {
               _loc8_ = 0;
            }
            this.externalPreviewPlayerController.initExternalPreviewWindow(this._filmXML,this._previewData,_loc3_,_loc8_);
         }
         else if(param1 == null)
         {
            this._viewStackWindow = ViewStackWindow(PopUpManager.createPopUp(this._movie.currentScene.canvas,ViewStackWindow,true));
            this._viewStackWindow.x = (this._viewStackWindow.stage.width - this._viewStackWindow.width) / 2;
            this._viewStackWindow.y = this._mainStage.y;
            this._viewStackWindow.initAndPreviewMovie(this._filmXML,this._previewData,_loc3_,this._tempMetaData.title);
            this._viewStackWindow.addEventListener(Event.CANCEL,this.doContinueEdit,false,0,true);
         }
         else
         {
            param1.initAndPreview(this._filmXML,this._previewData,_loc3_);
            param1.endScreen.isPreviewMode = false;
            param1.playerControl.fullScreenControl.visible = false;
         }
         if(this._movie.currentScene != null)
         {
            this._movie.currentScene.stopScene();
         }
         this.genDefaultTags();
      }
      
      private function rdyToAddScene(param1:Event) : void
      {
         this.removeEventListener("EventFinished",this.rdyToAddScene);
         this.doAddScene();
      }
      
      private function unloadThumbnailScene() : void
      {
         var _loc1_:AnimeScene = null;
         _loc1_ = this._movie.getSceneAt(this.selectedThumbnailIndex);
         if(_loc1_ != this.currentScene)
         {
            _loc1_.unloadAllAssets();
         }
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         _loc2_ = param1.id;
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         trace("onSoundResizeComplete:" + this._prevSoundInfo);
         if(this._prevSoundInfo != null)
         {
            if(_loc3_.totalPixel != this._prevSoundInfo.totalPixel)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
         if(_loc3_.totalPixel <= 0)
         {
            this.removeSound(_loc2_);
         }
      }
      
      public function get isLoaddingCommonThemeBg() : Boolean
      {
         return this._isLoaddingCommonThemeBg;
      }
      
      public function set stageViewStage(param1:ViewStack) : void
      {
         this._stageViewStack = param1;
         this._stageViewStack.buttonMode = true;
      }
      
      public function set currentSceneIndex(param1:Number) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function get pptPanel() : PropertiesWindow
      {
         return this._pptPanel;
      }
   }
}
