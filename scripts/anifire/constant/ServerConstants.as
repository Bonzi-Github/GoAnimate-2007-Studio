package anifire.constant
{
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import mx.core.Application;
   import mx.utils.URLUtil;
   
   public class ServerConstants
   {
      
      public static const PARAM_ISOFFLINE:String = "isOffline";
      
      public static const FLASHVAR_NEXT_URL:String = "nextUrl";
      
      public static const ERROR_CODE_MOVIE_NOT_FOUND:String = "NOTFOUND";
      
      public static const ACTION_GET_LATEST_ASSET_ID:String = get_server_path() + "getLatestAssetId/";
      
      public static const ACTION_ADD_TUTORIAL_GOPOINT:String = get_server_path() + "tutaction/";
      
      public static const PARAM_BADTERMS:String = "badterms";
      
      public static const ACTION_BUY_PACK:String = get_server_path() + "buyActionpack/";
      
      public static const PARAM_MOVIE_ID:String = "movieId";
      
      public static const PARAM_USER_ID:String = "userId";
      
      public static const ACTION_GET_PACKS:String = get_server_path() + "getActionpacks/";
      
      public static const VODPOD_ACCOUNT_ID:String = "1967590";
      
      public static const PARAM_RSS_MOVIENUM:String = "movieNum";
      
      public static const USER_PATH:String = HOST_PATH + "go/user/";
      
      public static const FLASHVAR_MOVIENUM:String = "movieNum";
      
      public static const ACTION_GET_USERVIDEOASSETS:String = get_server_path() + "getUserVideoAssets/";
      
      public static const ERROR_CODE_MOVIE_NOT_SHARE:String = "NOT_SHARE_VIEWABLE";
      
      public static const PARAM_IS_EDIT_MODE:String = "editMode";
      
      public static const CLIENT_LOCALE_PATH:String = HOST_PATH + "static/client_theme/";
      
      public static const ACTION_SAVE_SOUND_BY_URL:String = get_server_path() + "saveSoundByUrl/";
      
      public static const ACTION_GET_SAMPLE:String = HOST_PATH + "/static/docs/sample_fla_files.zip";
      
      public static const PARAM_ASSET_ID:String = "assetId";
      
      public static const ACTION_GET_THEME:String = get_server_path() + "getTheme/";
      
      public static const ACTION_RATE_MOVIE:String = get_server_path() + "rateMovie/";
      
      public static const PARAM_BUBBLE:String = "bubble";
      
      public static const PARAM_CATEGORY:String = "category";
      
      public static const FLASHVAR_CC_START_PAGE:String = "page";
      
      public static const ACTION_UPDATE_PROP:String = get_server_path() + "updateProp/";
      
      public static const STUDIO_PAGE_PATH:String = HOST_PATH + "go/studio/";
      
      public static const FLASHVAR_CHAIN_MOVIE_ID:String = "chain_mids";
      
      public static const FLASHVAR_IS_GOLITE_PREVIEW:String = "is_golite_preview";
      
      public static const FLASHVAR_APISERVER:String = "apiserver";
      
      public static const FLASHVAR_MOVIE_LICENSE_ID:String = "movieLid";
      
      public static const FLASHVAR_IS_USER_LOGIN_MODE:String = "isLogin";
      
      public static const ACTION_SAVE_VIDEO:String = get_server_path() + "saveVideo/";
      
      public static const ACTION_CN_GET_USER_GAME_SCORES:String = get_server_path() + "cnGetGameScores/";
      
      public static const ACTION_GET_STREAM_SOUND:String = "rtmpe://rtmp.voxcdn.com/3420.file";
      
      public static const PARAM_CHAR_ID:String = "characterId";
      
      public static const PARAM_ISSLIDE:String = "is_slideshow";
      
      public static const FLASHVAR_TUTORIAL_MODE:String = "tm";
      
      public static const ACTION_SEARCH_ASSET:String = get_server_path() + "searchCommunityAssets/";
      
      public static const ACTION_GET_USERASSETS:String = get_server_path() + "getUserAssets/";
      
      public static const FLASHVAR_STORE_PATH:String = "storePath";
      
      public static const FLASHVAR_CLIENT_THEME_PATH:String = "clientThemePath";
      
      public static const PARAM_MOVIE_XML:String = "movieXML";
      
      public static const ACTION_GET_CC_CHAR_COUNT:String = get_server_path() + "getCcCharacterCount/";
      
      public static const ERROR_CODE_NO_ACCESS:String = "NO_ACCESS";
      
      public static const PARAM_ROLE:String = "role";
      
      public static const ACTION_GET_ASSET_TYPE:String = get_server_path() + "getAssetType/";
      
      public static const FLASHVAR_CNCONTEST:String = "ch";
      
      public static const FLASHVAR_TM_FIN:String = "FIN";
      
      public static const ACTION_GET_MOVIEXML:String = get_server_path() + "getMovieXML/";
      
      public static const ACTION_CHANGE_DEFAULT_ACTION:String = get_server_path() + "setDefaultAction/";
      
      public static const PARAM_PROP_EX:String = "propex";
      
      public static const ACTION_SAVE_BG:String = get_server_path() + "saveBackground/";
      
      public static const PARAM_SEGMENT:String = "segment";
      
      public static const FLASHVAR_IS_VIDEO_RECORD_MODE:String = "isVideoRecord";
      
      public static const ACTION_SAVE_PROP_BYTE:String = get_server_path() + "savePropByByte/";
      
      public static const UPGRADE_PAGE_PATH:String = HOST_PATH + "plusfeatures";
      
      public static const ACTION_SAVE_SOUND:String = get_server_path() + "saveSound/";
      
      public static const PARAM_BG:String = "bg";
      
      public static const ACTION_GET_UGC_CHAR_ACTION:String = get_server_path() + "getCharacterAction/";
      
      public static const PARAM_BOX_PARENT_URL:String = "purl";
      
      public static const ACTION_GET_LATEST_ASSET:String = get_server_path() + "getLatestAsset/";
      
      public static const ACTION_GET_MOVIE_BY_XML:String = get_server_path() + "getMovieByXML/";
      
      public static const PARAM_ORIGINAL_ID:String = "originalId";
      
      public static const FLASHVAR_THEME_ID:String = "thmid";
      
      public static const PARAM_SENDER_NAME:String = "sender_name";
      
      public static const ACTION_TOILET_AD_FEEDBACK:String = get_server_path() + "toiletfeedback/";
      
      public static const ACTION_SCHOOLPLUS_SIGNUP:String = HOST_PATH + "/public_signup/";
      
      public static const PARAM_EFFECT:String = "effect";
      
      public static const PARAM_APPCODE:String = "appCode";
      
      public static const PARAM_RSS_PATH:String = "rsspath";
      
      public static const ACTION_GET_THEMELIST:String = get_server_path() + "getThemeList/";
      
      public static const ACTION_GET_ASSET:String = get_server_path() + "getAsset/";
      
      public static const ACTION_GOOGLE_ANALYTIC:String = get_server_path() + "logActionToGA/";
      
      public static const ACTION_SAVE_FX:String = get_server_path() + "saveEffect/";
      
      public static const FLASHVAR_STORE_PLACEHOLDER:String = "<store>";
      
      public static const FLASHVAR_CUSTOM_PLAYER_WIDTH:String = "playerWidth";
      
      public static const ACTION_BUY_BUCKS:String = HOST_PATH + "go/buybucks/";
      
      public static const FLASHVAR_SHOWSHARE:String = "showshare";
      
      public static const FLASHVAR_CHANNEL:String = "channel";
      
      public static const FLASHVAR_IS_PUBLISHED_PLAYER:String = "isPublished";
      
      public static const PARAM_PREVIOUS_ASSET_ID:String = "pre_aid";
      
      public static const FLASHVAR_IS_ADMIN:String = "uisa";
      
      public static const PARAM_RECIPIENT_EMAIL:String = "recipient_email";
      
      public static const ACTION_START_PHONE_RECORD:String = get_server_path() + "startPhoneRecord/";
      
      public static const FLASHVAR_MONEY_MODE:String = "m_mode";
      
      public static const CLIENT_THEME_PATH:String = HOST_PATH + "static/client_theme/";
      
      public static const URL_TOILET_AD_PAGE:String = "http://tw.goserver5.com/";
      
      public static const ACTION_GET_COMMUNITYASSETS:String = get_server_path() + "getCommunityAssets/";
      
      public static const ACTION_RSS_PATH:String = HOST_PATH;
      
      public static const FLASHVAR_STYLECODE:String = "styleCode";
      
      public static const ACTION_GET_MOVIE:String = get_server_path() + "getMovie/";
      
      public static const FLASHVAR_CUSTOM_PLAYER_HEIGHT:String = "playerHeight";
      
      public static const PARAM_TOILET_AD_CLICKED:String = "clk";
      
      public static const ACTION_SAVE_CHAR:String = get_server_path() + "saveCharacterAction/";
      
      public static const VIDEO_TUTOR_PATH:String = HOST_PATH + "howdoesitwork";
      
      public static const PARAM_THUMBNAIL_LARGE:String = "thumbnail_large";
      
      public static const FLASHVAR_SITE_ID:String = "siteId";
      
      public static const ACTION_SAVE_PROP:String = get_server_path() + "saveProp/";
      
      public static const FLASHVAR_CLIENT_THEME_LANG_CODE:String = "tlang";
      
      public static const FLASHVAR_THEME_COLOR:String = "themeColor";
      
      public static const FAQ_GOBUCK_PATH:String = HOST_PATH + "go/faq#faqd";
      
      public static const PARAM_BODY:String = "body";
      
      public static const ACTION_GET_ALL_QUESTION:String = get_server_path() + "getMsgQuestion/";
      
      public static const PARAM_GOOGLE_ANALYTIC_ACTION:String = "ga_action";
      
      public static const POPUP_WINDOW_NAME:String = "wndstudio";
      
      public static const ACTION_SEARCH_SOUNDSNAP:String = get_server_path() + "searchSoundSnap/";
      
      public static const ACTION_GET_MOVIE_INFO:String = get_server_path() + "getMovieInfo/";
      
      public static const FLASHVAR_CLIENT_THEME_PLACEHOLDER:String = "<client_theme>";
      
      public static const PARAM_CUSTOM_GET_WIDGET_URL_PARAM:String = "customGetWidgetParam";
      
      public static const PARAM_U_INFO:String = "u_info";
      
      public static const FLASHVAR_TM_SEMI:String = "SEMI";
      
      public static const PARAM_CHAR_ACTION:String = "char_action";
      
      public static const PARAM_ACTION_ID:String = "actionId";
      
      public static const PARAM_BODY_ZIP:String = "body_zip";
      
      public static const PARAM_LANG:String = "lang";
      
      public static const PARAM_CHAR_FACIAL:String = "char_facial";
      
      public static const FLASHVAR_S3_SHOULD_BE_USED:String = "useS3";
      
      public static const ACTION_BUY_POINTS:String = HOST_PATH + "go/faq#faqc3";
      
      public static const ERROR_CODE_MOVIE_MODERATING:String = "MOVIE_UNDER_MODERATION";
      
      public static const ACTION_GET_CC_PRE_MADE_CHARACTERS:String = get_server_path() + "getCCPreMadeCharacters";
      
      public static const ACTION_SEND_BUG_REPORT:String = get_server_path() + "clientbug/";
      
      public static const PARAM_COMMONITEM:String = "commonItem";
      
      public static const PARAM_GROUP_ID:String = "school_group_id";
      
      public static const PARAM_SAVE_THUMBNAIL:String = "save_thumbnail";
      
      public static const PARAM_SOUND:String = "sound";
      
      public static const GIGYA_ACCOUNT_ID:String = "143841";
      
      public static const ACTION_DELETE_ASSET:String = get_server_path() + "deleteAsset/";
      
      public static const ACTION_GET_CHAR:String = get_server_path() + "getCharacter/";
      
      public static const FLASHVAR_TUTORIAL_MODE_CC:String = "tmcc";
      
      public static const MY_VOX_API_SERVER_URL:String = "http://api.myVox.com/vr";
      
      public static const ERROR_CODE_MOVIE_DELETED:String = "MOVIE_DELETED";
      
      public static const YOUTUBE_MOVIE_PATH:String = HOST_PATH + "movies";
      
      public static const PARAM_ISEMBED_ID:String = "isEmbed";
      
      public static const CC_PAGE_PATH:String = HOST_PATH + "go/character_creator";
      
      public static const FLASHVAR_IS_PSHARED:String = "is_private_shared";
      
      public static const FLASHVAR_DEFAULT_TRAYTHEME:String = "tray";
      
      public static const FLASHVAR_IS_COPYABLE:String = "copyable";
      
      public static const FLASHVAR_TM_NEW:String = "NEW";
      
      public static const PARAM_IS_PRIVATESHARED:String = "is_private_shared";
      
      public static const ACTION_GET_CC_CHAR_COMPOSITION_XML:String = get_server_path() + "getCcCharCompositionXml/";
      
      public static const FLASHVAR_CLIENT_THEME_CODE:String = "ctc";
      
      public static const FLASHVAR_S3_URL:String = "s3URL";
      
      public static const SERVER_PLAYER_PARAM_USER_ID:String = "csd";
      
      public static const PARAM_U_INFO_SCHOOL:String = PARAM_U_INFO + "_school";
      
      public static const FLASHVAR_AUTOSTART:String = "autostart";
      
      public static const PATH_INSPIRATION_COMIC:String = HOST_PATH + "/static/go/img/comicstrip";
      
      public static const PARAM_BOX_PHP_SESSION_ID:String = "PHPSESSID";
      
      public static const ACTION_GET_POINT_STATUS:String = get_server_path() + "getPointStatus/";
      
      public static const FLASHVAR_ANICALLBACK:String = "nextanicallback";
      
      public static const PARAM_FLASHVAR_PHP_SESSION_ID:String = "ps";
      
      public static const PARAM_THEME_ID:String = "themeId";
      
      public static const PARAM_RSS_CHANNEL:String = "channel";
      
      public static const PARAM_STEP_NUM:String = "stepNo";
      
      public static const FLASHVAR_USER_ID:String = "userId";
      
      public static const STUDIO_FULLSCREEN_PAGE_PATH:String = HOST_PATH + "go/studioFullscreen/";
      
      public static const FLASHVAR_NEXT_URL_PLACEHOLDER:String = "<movieId>";
      
      public static const ACTION_SAVE_JPEG:String = get_server_path() + "jpg_download/";
      
      public static const FLASHVAR_IS_LOGO_HIDDEN:String = "noWatermark";
      
      public static const ACTION_CHANGE_CC_AVATAR:String = get_server_path() + "changeCCAvatar/";
      
      public static const ACTION_GET_PDF_PLUS:String = HOST_PATH + "static/docs/upload_guidelines_plus.pdf";
      
      public static const ACTION_PURCHASE_ASSET:String = get_server_path() + "buyPremiumAsset/";
      
      public static const PARAM_KEYWORDS:String = "keywords";
      
      public static const PARAM_AUTOSAVE:String = "autosave";
      
      public static const PARAM_SUBJECT:String = "subject";
      
      public static const ACTION_UPDATE_ASSET:String = get_server_path() + "updateAsset/";
      
      public static const ACTION_GET_PDF:String = HOST_PATH + "static/docs/upload_guidelines.pdf";
      
      public static const FLASHVAR_IS_VIP_USER:String = "ve";
      
      public static const FLASHVAR_IS_IN_SPEEDY_MODE:String = "isSpeedy";
      
      public static const ERROR_CODE_SAVE_MOVIE_BLOCKED_BY_VIDEO_RECORDING:String = "video_block_save";
      
      public static const ACTION_GOPLUS_SIGNUP:String = HOST_PATH_HTTPS + "/plussignup/";
      
      public static const ACTION_GET_FB_PHOTO_BYTE:String = get_server_path() + "getFacebookPhoto/";
      
      public static const ERROR_CODE_UNSUPPORTED_IMAGE_FORMAT:String = "UNSUPPORTED_IMAGE_FORMAT";
      
      public static const ACTION_SAVE_BG_BYTE:String = get_server_path() + "saveBackgroundByByte/";
      
      public static const PARAM_PARENT_CONSENT:String = "ptct";
      
      public static const PARAM_THUMBNAIL:String = "thumbnail";
      
      public static const PARAM_GROUP_NAME:String = "group_name";
      
      public static const PARAM_USER_TOKEN:String = "ut";
      
      public static const ACTION_GET_SAMPLE_PLUS:String = HOST_PATH + "/static/docs/sample_fla_files_plus.zip";
      
      public static const PARAM_IS_PUBLISHED:String = "is_published";
      
      public static const PARAM_SENDER_EMAIL:String = "sender_email";
      
      public static const PARAM_EMESSAGE:String = "emsg";
      
      public static const PARAM_SHOW_GET_WIDGET_BUTTON:String = "isShowGetWidget";
      
      public static const PARAM_PROP_STATE:String = "prop_state";
      
      public static const ACTION_SEND_SHARE_EMAIL:String = get_server_path() + "sendShareEmail/";
      
      public static const ACTION_GET_ALL_CONTACT:String = get_server_path() + "getAllAddress/";
      
      public static const ACTION_TEXT_TO_SPEECH:String = get_server_path() + "convertTextToSoundAsset/";
      
      public static const FLASHVAR_RANDOMIZE_FEED:String = "randomizeFeed";
      
      public static const FLASHVAR_THUMBNAIL:String = "thumbnailURL";
      
      public static const ACTION_GET_CHAR_LIST:String = get_server_path() + "getUserCharacterList/";
      
      public static const PARAM_INITIAL_THEME_CODE:String = "ithm";
      
      public static const ACTION_GET_THEME_COMPLETE:String = get_server_path() + "themeCompleted/";
      
      public static const PARAM_TTS_ENABLED:String = "tts_enabled";
      
      public static const PARAM_CHAR:String = "char";
      
      public static const PARAM_YOUTUBE_PUBLISH:String = "youtube_publish";
      
      public static const PARAM_IS_TRIGGER_BY_AUTOSAVE:String = "is_triggered_by_autosave";
      
      public static const PARAM_PROP:String = "prop";
      
      public static const MOVIE_PATH:String = HOST_PATH + "go/movie/";
       
      
      public function ServerConstants()
      {
         super();
      }
      
      static function get_server_path(param1:int = -1) : String
      {
         var host:String = null;
         var myPattern:RegExp = null;
         var contingency_webserver_index:int = param1;
         var flashVars:UtilHashArray = Util.getFlashVar();
         var FLASHVAR_APPCODE:String = PARAM_APPCODE;
         var appCode:String = "fb";
         if(flashVars.containsKey(FLASHVAR_APPCODE))
         {
            if(flashVars.getValueByKey(FLASHVAR_APPCODE) as String != "")
            {
               appCode = flashVars.getValueByKey(FLASHVAR_APPCODE) as String;
            }
         }
         if(contingency_webserver_index < 0)
         {
            host = flashVars.getValueByKey(FLASHVAR_APISERVER) as String;
         }
         else
         {
            host = "http://" + (get_contingency_web_server_array(appCode)[contingency_webserver_index] as String) + "/";
         }
         try
         {
            myPattern = /:80/;
            host = host.replace(myPattern,"");
         }
         catch(e:Error)
         {
         }
         return host + appCode + "api/";
      }
      
      public static function get HOST_PATH() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         return _loc1_.getValueByKey(FLASHVAR_APISERVER) as String;
      }
      
      public static function isLookAtCameraEnabled() : Boolean
      {
         return true;
      }
      
      public static function get SERVER_IMPORTER_PATH() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey("v");
         return "importer.swf?v=" + _loc2_;
      }
      
      public static function get SERVER_ACTIONSHOP_PATH() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey("v");
         return "actionshop.swf?v=" + _loc2_;
      }
      
      public static function get_contingency_web_server_array(param1:String = "go") : Array
      {
         var _loc3_:Boolean = false;
         var _loc2_:Array = new Array();
         if(IS_ON_PRODUCTION_SERVER)
         {
            if(param1 == "go")
            {
               _loc2_.push("web2.goanimate.com");
               _loc2_.push("web3.goanimate.com");
               _loc2_.push("web4.goanimate.com");
            }
         }
         return _loc2_;
      }
      
      public static function get SERVER_INSPIRATION_PATH() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey("v");
         return "inspiration.swf?v=" + _loc2_;
      }
      
      public static function getPOList(param1:String) : Array
      {
         if(param1 == "slideplayer")
         {
            return ["player","slideplayer"];
         }
         if(param1 == "cc")
         {
            return ["cc","store"];
         }
         if(param1 == "go")
         {
            return ["go","player","store","emessage"];
         }
         if(param1 == "player")
         {
            return ["player"];
         }
         if(param1 == "import")
         {
            return ["import"];
         }
         return [];
      }
      
      public static function get_ACTION_SAVE_MOVIE(param1:int = -1) : String
      {
         if(param1 < 0)
         {
            return get_server_path() + "saveMovie/";
         }
         return get_server_path(param1) + "saveMovie/";
      }
      
      public static function get IS_ON_PRODUCTION_SERVER() : Boolean
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(FLASHVAR_APISERVER);
         if(_loc2_.search("goanimate.org") < 0 && _loc2_.search("192.168.3.") < 0)
         {
            return true;
         }
         return false;
      }
      
      public static function get STORE_VERSION() : int
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey("v");
         return Number(_loc2_);
      }
      
      public static function get HOST_PATH_HTTPS() : String
      {
         var _loc1_:String = HOST_PATH;
         return _loc1_.replace(/^http:/,"https:");
      }
      
      public static function get APPCODE() : String
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = PARAM_APPCODE;
         var _loc3_:String = "fb";
         if(_loc1_.containsKey(_loc2_))
         {
            if(_loc1_.getValueByKey(_loc2_) as String != "")
            {
               _loc3_ = _loc1_.getValueByKey(_loc2_) as String;
            }
         }
         return _loc3_;
      }
      
      public static function get SERVER_PLAYER_PATH() : String
      {
         var _loc2_:Boolean = false;
         var _loc4_:String = null;
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = "facebookAppURL";
         if(_loc1_.containsKey(_loc3_))
         {
            if((_loc4_ = _loc1_.getValueByKey(_loc3_) as String).length > 0)
            {
               _loc2_ = true;
            }
            else
            {
               _loc2_ = false;
            }
         }
         else
         {
            _loc2_ = false;
         }
         if(_loc2_)
         {
            return (_loc1_.getValueByKey(_loc3_) as String) + "movie/";
         }
         return URLUtil.getProtocol(Application.application.url) + "://" + URLUtil.getServerNameWithPort(Application.application.url) + "/movie/";
      }
   }
}
