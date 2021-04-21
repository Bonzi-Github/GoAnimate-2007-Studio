package
{
   import flash.system.ApplicationDomain;
   import mx.core.EmbeddedFontRegistry;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.managers.SystemManager;
   
   public class _go_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory
   {
       
      
      public function _go_mx_managers_SystemManager()
      {
         super();
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0?"go":String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object;
         if((_loc4_ = new _loc3_()) is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         if(rest.length == 0)
         {
            EmbeddedFontRegistry.registerFonts(this.info()["fonts"],this);
         }
         return _loc4_;
      }
      
      override public function info() : Object
      {
         return {
            "applicationComplete":"initialConsole();",
            "backgroundGradientAlphas":"[1.0, 1.0]",
            "backgroundGradientColors":"[#FFFFFF, #FFFFFF]",
            "cdRsls":[{
               "rsls":["framework_3.3.0.4852.swz","framework_3.3.0.4852.swf"],
               "policyFiles":["",""],
               "digests":["077ba3fd3a24318b67b13f8297375c8df03582d8f6495f1391e74526498e773f","077ba3fd3a24318b67b13f8297375c8df03582d8f6495f1391e74526498e773f"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,false]
            },{
               "rsls":["rpc_3.3.0.4852.swz","rpc_3.3.0.4852.swf"],
               "policyFiles":["",""],
               "digests":["e507eca26d5bd6e3feff5882f3d93ecc0210452643fc6425c58103d3a67ffa85","e507eca26d5bd6e3feff5882f3d93ecc0210452643fc6425c58103d3a67ffa85"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,false]
            }],
            "compiledLocales":["en_US"],
            "compiledResourceBundleNames":["SharedResources","collections","containers","controls","core","effects","formatters","logging","skins","states","styles","utils"],
            "currentDomain":ApplicationDomain.currentDomain,
            "fonts":{"TrebuchetMS1":{
               "regular":true,
               "bold":true,
               "italic":false,
               "boldItalic":false
            }},
            "frameRate":"24",
            "height":"720",
            "layout":"absolute",
            "mainClassName":"go",
            "mixins":["_go_FlexInit","_LinkButtonStyle","_AccordionHeaderStyle","_alertButtonStyleStyle","_SWFLoaderStyle","_headerDateTextStyle","_SwatchPanelStyle","_TitleWindowStyle","_todayStyleStyle","_AccordionStyle","_windowStylesStyle","_TextInputStyle","_dateFieldPopupStyle","_ApplicationControlBarStyle","_ComboBoxStyle","_dataGridStylesStyle","_TabStyle","_headerDragProxyStyleStyle","_popUpMenuStyle","_TabNavigatorStyle","_HSliderStyle","_ProgressBarStyle","_DragManagerStyle","_windowStatusStyle","_TextAreaStyle","_ContainerStyle","_swatchPanelTextFieldStyle","_RadioButtonStyle","_ButtonBarStyle","_textAreaHScrollBarStyleStyle","_MenuBarStyle","_comboDropdownStyle","_CheckBoxStyle","_ButtonStyle","_PopUpButtonStyle","_linkButtonStyleStyle","_richTextEditorTextAreaStyleStyle","_ControlBarStyle","_textAreaVScrollBarStyleStyle","_globalStyle","_VSliderStyle","_ListBaseStyle","_AlertStyle","_TabBarStyle","_TileListStyle","_ApplicationStyle","_ToolTipStyle","_CursorManagerStyle","_ButtonBarButtonStyle","_opaquePanelStyle","_errorTipStyle","_MenuStyle","_HRuleStyle","_activeTabStyleStyle","_PanelStyle","_ScrollBarStyle","_plainStyle","_activeButtonStyleStyle","_ColorPickerStyle","_VRuleStyle","_weekDayStyleStyle","_anifire_timeline_BackgroundGridWatcherSetupUtil","_anifire_components_studio_PublishPanelWatcherSetupUtil","_anifire_components_studio_BubbleMsgItemRendererWatcherSetupUtil","_anifire_components_studio_BubbleMsgChooserWatcherSetupUtil","_anifire_components_studio_noSaveAlertWindowWatcherSetupUtil","_anifire_popups_UpdateAccountWatcherSetupUtil","_anifire_components_containers_InputWindowWatcherSetupUtil","_anifire_component_GoActionBannerWatcherSetupUtil","_anifire_components_containers_AssetInfoWindow_inlineComponent1WatcherSetupUtil","_anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil","_anifire_component_TextButtonWatcherSetupUtil","_anifire_component_DoubleStateButtonWatcherSetupUtil","_anifire_components_studio_ControlButtonBarWatcherSetupUtil","_anifire_components_studio_FileUploadComponentWatcherSetupUtil","_anifire_components_studio_MicRecordingComponentWatcherSetupUtil","_anifire_components_containers_AssetTimingWatcherSetupUtil","_anifire_control_FontChooserWatcherSetupUtil","_anifire_control_FontChooser_inlineComponent1WatcherSetupUtil","_anifire_components_containers_HyperLinkWindowWatcherSetupUtil","_anifire_components_studio_CharacterActionPanelWatcherSetupUtil","_anifire_components_studio_ThemeSelectionWatcherSetupUtil","_anifire_component_GoAlertWatcherSetupUtil","_anifire_popups_UpgradeOnTtsWatcherSetupUtil","_anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil","_anifire_playerComponent_PreviewPlayerWatcherSetupUtil","_anifire_components_studio_FeedbackWatcherSetupUtil","_anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil","_anifire_component_SharingPanelWatcherSetupUtil","_anifire_components_containers_AssetHyperLinkWatcherSetupUtil","_anifire_components_studio_SpeechComponentWatcherSetupUtil","_anifire_components_studio_TTSComponentWatcherSetupUtil","_anifire_components_studio_PreviewWindowWatcherSetupUtil","_anifire_components_studio_OverTrayWatcherSetupUtil","_anifire_components_containers_SoundTileCellWatcherSetupUtil","_anifire_components_studio_MaskImageWatcherSetupUtil","_anifire_components_studio_AssetButtonBarWatcherSetupUtil","_anifire_components_studio_PropertiesWindowWatcherSetupUtil","_anifire_timeline_TimelineWatcherSetupUtil","_anifire_components_studio_MainStageWatcherSetupUtil","_anifire_components_studio_ThumbTrayWatcherSetupUtil","_anifire_timeline_SoundContainerWatcherSetupUtil","_anifire_components_containers_AssetInfoWindowWatcherSetupUtil","_anifire_timeline_SceneContainerWatcherSetupUtil","_anifire_timeline_SceneElementWatcherSetupUtil","_anifire_components_studio_PublishWindowWatcherSetupUtil","_anifire_tutorial_TutorialManagerWatcherSetupUtil","_anifire_components_studio_MusicPanelWatcherSetupUtil","_anifire_components_studio_TopButtonBarWatcherSetupUtil"],
            "usePreloader":true,
            "width":"646"
         };
      }
   }
}
