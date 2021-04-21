package anifire.util
{
   import anifire.constant.ServerConstants;
   import flash.display.DisplayObject;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class UtilSharing
   {
      
      private static var objsToHideWhenGigyaClose:DisplayObject = null;
       
      
      public function UtilSharing()
      {
         super();
      }
      
      public static function closeObjectWhenGigyaClose() : void
      {
         if(objsToHideWhenGigyaClose != null)
         {
            objsToHideWhenGigyaClose.visible = false;
         }
      }
      
      public static function registerObjectToHideWhenGigyaClose(param1:DisplayObject) : void
      {
         objsToHideWhenGigyaClose = param1;
      }
      
      public static function buildPlainHtmlEmbedTag(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : String
      {
         var _loc10_:String = null;
         var _loc12_:String = null;
         var _loc8_:URLVariables;
         (_loc8_ = new URLVariables())["utm_source"] = param5;
         if(param4 != "")
         {
            _loc8_["uid"] = param4;
         }
         var _loc9_:String = getMovieUrl(param1,_loc8_);
         if(param7 != null)
         {
            _loc12_ = getUserUrl(param7,_loc8_);
         }
         _loc10_ = UtilDict.toDisplay("player","sharing_website_displayname");
         return "<b>" + _loc10_ + "</b>: " + "<a href=\"" + _loc9_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param2) + "</a>" + (param7 != null?" by <a href=\"" + _loc12_ + "\">" + UtilXmlInfo.xmlEscape(param6) + "</a>":" by " + UtilXmlInfo.xmlEscape(param6)) + "<br>" + "<img alt=\"thumbnail for this animation\" src=\"" + param3 + "\">" + "<br/>" + UtilXmlInfo.xmlEscape(_loc9_) + "<br><br>" + "Like it? Create your own at " + "<a target=\"_blank\" href=\"" + ServerConstants.HOST_PATH + "?utm_source=" + param5 + "\"><b>" + _loc10_ + "</b></a>" + ". It\'s free and fun!";
      }
      
      public static function buildVodpodEmbedTag(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:String, param10:Boolean, param11:Boolean, param12:Boolean, param13:String) : String
      {
         var _loc14_:String = !!("userId=" + escape(param5) + "&movieId=" + escape(param2) + "&movieTitle=" + escape(param3) + "&movieDesc=" + escape(param4) + "&apiserver=" + escape(param6) + "&appCode=" + escape(param7) + "&thumbnailURL=" + escape(param8) + "&fb_app_url=" + escape(param9) + "&copyable=" + param10)?"1":!!("0" + "&showButtons=1&isEmbed=1&is_private_shared=" + param12)?"1":!!("0" + "&isPublished=" + param11)?"1":"0";
         return "<b>GoAnimate.com</b><br/>[vodpod id=Groupvideo." + ServerConstants.VODPOD_ACCOUNT_ID + "&w=400&h=300&fv=" + escape(_loc14_) + "] <br/>Like it? It\'s free and fun! Create your own at <a href=\'http://goanimate.com?utm_source=" + param13 + "\'>GoAnimate.com</a>.";
      }
      
      public static function getUserUrl(param1:String, param2:URLVariables) : String
      {
         var _loc3_:String = param2.toString();
         if(_loc3_.length > 0)
         {
            _loc3_ = "?" + _loc3_;
         }
         return ServerConstants.USER_PATH + param1 + _loc3_;
      }
      
      public static function buildEmbedTag(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:String, param10:Boolean, param11:Boolean, param12:Boolean, param13:String, param14:String, param15:String, param16:String, param17:String, param18:String) : String
      {
         var _loc21_:String = null;
         var _loc19_:URLVariables;
         (_loc19_ = new URLVariables())["utm_source"] = param13;
         var _loc20_:String = ServerConstants.HOST_PATH + "?" + _loc19_.toString();
         if(param14 != null)
         {
            _loc21_ = getUserUrl(param14,_loc19_);
         }
         var _loc22_:String = getMovieUrl(param2,_loc19_);
         var _loc23_:String = UtilDict.toDisplay("player","sharing_website_displayname");
         return "<b>" + _loc23_ + "</b>: " + "<a href=\"" + _loc22_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param3) + "</a>" + (param14 != null?" by <a href=\"" + _loc21_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param1) + "</a>":" by " + UtilXmlInfo.xmlEscape(param1)) + "<br/>" + "<embed " + "src=\'" + param6 + "/api/animation/player?utm_source=" + escape(param13) + "\' " + "type=\'application/x-shockwave-flash\' " + "wmode=\'transparent\' " + "width=\'400\' " + "height=\'286\' " + "FlashVars=" + "\'movieOwner=" + escape(param1) + "&movieId=" + escape(param2) + "&" + ServerConstants.FLASHVAR_MOVIE_LICENSE_ID + "=" + escape(param15) + "&movieTitle=" + escape(param3) + "&movieDesc=" + escape(param4) + "&userId=" + escape(param5) + "&apiserver=" + escape(param6) + "&appCode=" + escape(param7) + "&thumbnailURL=" + escape(param8) + "&fb_app_url=" + escape(param9) + "&copyable=" + (!!param10?"1":"0") + "&showButtons=1" + "&isEmbed=1" + "&" + ServerConstants.FLASHVAR_CHAIN_MOVIE_ID + "=" + escape(param18) + "&" + ServerConstants.FLASHVAR_CLIENT_THEME_CODE + "=" + param16 + "&" + ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE + "=" + param17 + "&isPublished=" + (!!param11?"1":"0") + (param14 != null?"&movieOwnerId=" + escape(param14):"") + "&is_private_shared=" + (!!param12?"1":"0") + "\' " + "allowScriptAccess=\'always\' allowFullScreen=\'true\'>" + "</embed>" + "<br><br>Like it? Create your own at <a href=\"" + _loc20_ + "\"><b>" + _loc23_ + "</b></a>" + ". It\'s free and fun!";
      }
      
      public static function navigateToMoviePage(param1:String, param2:URLVariables) : void
      {
         var _loc3_:URLRequest = new URLRequest(getMovieUrl(param1,param2));
         navigateToURL(_loc3_,"_blank");
      }
      
      public static function getBoxMovieUrl(param1:String, param2:URLVariables) : String
      {
         return Util.generateBoxUrl("/movie/topanimations/0/" + param1,false,param2);
      }
      
      public static function getMovieUrl(param1:String, param2:URLVariables) : String
      {
         var _loc3_:String = param2.toString();
         if(_loc3_.length > 0)
         {
            _loc3_ = "?" + _loc3_;
         }
         return ServerConstants.MOVIE_PATH + param1 + _loc3_;
      }
      
      public static function getBoxUserUrl(param1:String) : String
      {
         return Util.generateBoxUrl("/user/" + param1 + "/0",false);
      }
      
      public static function buildBoxPlainHtmlEmbedTag(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : String
      {
         var _loc11_:String = null;
         var _loc8_:URLVariables;
         (_loc8_ = new URLVariables())["utm_source"] = param5;
         _loc8_["utm_campaign"] = UtilLicense.boxCustomerID;
         if(param4 != "")
         {
            _loc8_["uid"] = param4;
         }
         var _loc9_:String = getBoxMovieUrl(param1,_loc8_);
         if(param7 != null)
         {
            _loc11_ = getBoxUserUrl(param7);
         }
         return "<a href=\"" + _loc9_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param2) + "</a>" + (param7 != null?" by <a href=\"" + _loc11_ + "\">" + UtilXmlInfo.xmlEscape(param6) + "</a>":" by " + UtilXmlInfo.xmlEscape(param6)) + "<br>" + "<img alt=\"thumbnail for this animation\" src=\"" + param3 + "\">" + "<br/>" + UtilXmlInfo.xmlEscape(_loc9_) + "<br>";
      }
      
      public static function buildBoxEmbedTag(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:String, param10:Boolean, param11:Boolean, param12:Boolean, param13:String, param14:String, param15:String, param16:String, param17:String, param18:String) : String
      {
         var _loc20_:String = null;
         var _loc19_:URLVariables;
         (_loc19_ = new URLVariables())["utm_source"] = param13;
         _loc19_["utm_campaign"] = UtilLicense.boxCustomerID;
         if(param14 != null)
         {
            _loc20_ = getBoxUserUrl(param14);
         }
         var _loc21_:String = getBoxMovieUrl(param2,_loc19_);
         return "<a href=\"" + _loc21_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param3) + "</a>" + (param14 != null?" by <a href=\"" + _loc20_ + "\" target=\"_blank\">" + UtilXmlInfo.xmlEscape(param1) + "</a>":" by " + UtilXmlInfo.xmlEscape(param1)) + "<br/>" + "<embed " + "src=\'" + param6 + "/api/animation/player?utm_source=" + escape(param13) + "&utm_campaign=" + UtilLicense.boxCustomerID + "\' " + "type=\'application/x-shockwave-flash\' " + "wmode=\'transparent\' " + "width=\'400\' " + "height=\'286\' " + "FlashVars=" + "\'movieOwner=" + escape(param1) + "&movieId=" + escape(param2) + "&" + ServerConstants.FLASHVAR_MOVIE_LICENSE_ID + "=" + escape(param15) + "&movieTitle=" + escape(param3) + "&movieDesc=" + escape(param4) + "&userId=" + escape(param5) + "&purl=" + escape(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_BOX_PARENT_URL)) + "&apiserver=" + escape(param6) + "&appCode=" + escape(param7) + "&thumbnailURL=" + escape(param8) + "&fb_app_url=" + escape(param9) + "&copyable=" + (!!param10?"1":"0") + "&showButtons=1" + "&isEmbed=1" + "&" + ServerConstants.FLASHVAR_CHAIN_MOVIE_ID + "=" + escape(param18) + "&" + ServerConstants.FLASHVAR_CLIENT_THEME_CODE + "=" + param16 + "&" + ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE + "=" + param17 + "&isPublished=" + (!!param11?"1":"0") + (param14 != null?"&movieOwnerId=" + escape(param14):"") + "&is_private_shared=" + (!!param12?"1":"0") + "\' " + "allowScriptAccess=\'always\' allowFullScreen=\'true\'>" + "</embed>" + "<br>";
      }
   }
}
