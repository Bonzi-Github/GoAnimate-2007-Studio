package anifire.core
{
   import anifire.event.ExtraDataEvent;
   
   public class CoreEvent extends ExtraDataEvent
   {
      
      public static const LOAD_MOVIE_COMPLETE:String = "load_movie_complete";
      
      public static const SWITCH_TO_COMMUNITY_THEME_COMPLETE:String = "switch_to_community_theme_complete";
      
      public static const LOAD_THEME_COMPLETE:String = "load_theme_complete";
      
      public static const SAVE_MOVIE_COMPLETE:String = "save_movie_complete";
      
      public static const LOAD_THEME_CHAR_COMPLETE:String = "load_theme_prop_complete";
      
      public static const UNLOCK_ASSET:String = "unlock_asset";
      
      public static const LOAD_THUMB_COMPLETE:String = "load_thumb_complete";
      
      public static const LOAD_CC_CHAR_COMPLETE:String = "load_cc_char_complete";
      
      public static const USER_LOGIN_CANCEL:String = "user_login_cancel";
      
      public static const LOAD_THEME_PROP_COMPLETE:String = "load_theme_prop_complete";
      
      public static const LOAD_THEMELIST_COMPLETE:String = "load_themelist_complete";
      
      public static const DESERIALIZE_SCENE_COMPLETE:String = "deserialize_scene_complete";
      
      public static const LOAD_THEMETREE_COMPLETE:String = "load_themetree_complete";
      
      public static const LOAD_COMMUNITY_ASSET_COMPLETE:String = "load_community_asset_complete";
      
      public static const SWITCH_TO_USER_THEME_COMPLETE:String = "switch_to_user_theme_complete";
      
      public static const LOAD_STATE_COMPLETE:String = "load_state_complete";
      
      public static const LOAD_ASSET_COMPLETE:String = "load_asset_complete";
      
      public static const LOAD_ALL_THUMBS_COMPLETE:String = "load_all_thumbs_complete";
      
      public static const ADD_ASSET_COMPLETE:String = "add_asset_complete";
      
      public static const SAVE_MOVIE_ERROR_OCCUR:String = "save_movie_error_occur";
      
      public static const LOAD_EFFECT_COMPLETE:String = "load_effect_complete";
      
      public static const SERIALIZE_COMPLETE:String = "serialize_complete";
      
      public static const LOAD_ALL_ASSETS_COMPLETE:String = "load_all_assets_complete";
      
      public static const PREPARE_MOVIE_COMPLETE:String = "prepare_movie_complete";
      
      public static const LOAD_USER_ASSET_COMPLETE:String = "load_user_asset_complete";
      
      public static const USER_LOGIN_COMPLETE:String = "user_login_complete";
      
      public static const PLAY_SOUND_COMPLETE:String = "play_sound_complete";
      
      public static const LOAD_THEME_BACKGROUND_COMPLETE:String = "load_theme_background_complete";
      
      public static const UPDATE_ASSET_COMPLETE:String = "update_asset_complete";
       
      
      public function CoreEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
