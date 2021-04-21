package
{
   import anifire.components.studio.MainStage;
   import anifire.util.UtilUser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MainStageWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_MainStageWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MainStage.watcherSetupUtil = new _anifire_components_studio_MainStageWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[36] = new PropertyWatcher("_btnUndo",{"propertyChange":true},[param3[46]],param2);
         param4[32] = new PropertyWatcher("_zoomControl",{"propertyChange":true},[param3[40],param3[41]],param2);
         param4[34] = new PropertyWatcher("_btnCopy",{"propertyChange":true},[param3[44]],param2);
         param4[27] = new PropertyWatcher("_zoomSlider",{"propertyChange":true},[param3[34]],param2);
         param4[28] = new PropertyWatcher("value",{
            "valueCommit":true,
            "change":true
         },[param3[34]],null);
         param4[20] = new PropertyWatcher("isContentOnBottom",{"propertyChange":true},[param3[28]],param2);
         param4[41] = new PropertyWatcher("sceneIndexStr",{"propertyChange":true},[param3[51]],param2);
         param4[24] = new PropertyWatcher("_sceneLayer",{"propertyChange":true},[param3[32],param3[33]],param2);
         param4[25] = new PropertyWatcher("percentFormatter",{"propertyChange":true},[param3[34]],param2);
         param4[12] = new PropertyWatcher("panDropShadow",{"propertyChange":true},[param3[20]],param2);
         param4[16] = new PropertyWatcher("isContentOnRight",{"propertyChange":true},[param3[24]],param2);
         param4[38] = new PropertyWatcher("_bottomControlBar",{"propertyChange":true},[param3[50],param3[48],param3[54],param3[52],param3[57]],param2);
         param4[29] = new PropertyWatcher("_uiCanvasAutoSave",{"propertyChange":true},[param3[35],param3[36],param3[37]],param2);
         param4[14] = new PropertyWatcher("isContentOnLeft",{"propertyChange":true},[param3[22]],param2);
         param4[37] = new PropertyWatcher("_btnRedo",{"propertyChange":true},[param3[47]],param2);
         param4[44] = new PropertyWatcher("_topControlBar",{"propertyChange":true},[param3[56]],param2);
         param4[33] = new PropertyWatcher("_panControl",{"propertyChange":true},[param3[42],param3[43]],param2);
         param4[8] = new StaticPropertyWatcher("isDeveloper",null,[param3[8],param3[9],param3[10],param3[11],param3[12],param3[13],param3[14],param3[15]],null);
         param4[18] = new PropertyWatcher("isContentOnTop",{"propertyChange":true},[param3[26]],param2);
         param4[35] = new PropertyWatcher("_btnPaste",{"propertyChange":true},[param3[45]],param2);
         param4[36].updateParent(param1);
         param4[32].updateParent(param1);
         param4[34].updateParent(param1);
         param4[27].updateParent(param1);
         param4[27].addChild(param4[28]);
         param4[20].updateParent(param1);
         param4[41].updateParent(param1);
         param4[24].updateParent(param1);
         param4[25].updateParent(param1);
         param4[12].updateParent(param1);
         param4[16].updateParent(param1);
         param4[38].updateParent(param1);
         param4[29].updateParent(param1);
         param4[14].updateParent(param1);
         param4[37].updateParent(param1);
         param4[44].updateParent(param1);
         param4[33].updateParent(param1);
         param4[8].updateParent(UtilUser);
         param4[18].updateParent(param1);
         param4[35].updateParent(param1);
      }
   }
}
