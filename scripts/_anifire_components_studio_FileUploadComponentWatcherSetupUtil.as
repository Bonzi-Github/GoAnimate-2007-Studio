package
{
   import anifire.components.studio.FileUploadComponent;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_FileUploadComponentWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_FileUploadComponentWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FileUploadComponent.watcherSetupUtil = new _anifire_components_studio_FileUploadComponentWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("width",{"widthChanged":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("_btnBrowse",{"propertyChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("width",{"widthChanged":true},[param3[0]],null);
         param4[3] = new PropertyWatcher("_txtFile",{"propertyChange":true},[param3[1],param3[2],param3[3],param3[4]],param2);
         param4[7] = new PropertyWatcher("height",{"heightChanged":true},[param3[4]],null);
         param4[6] = new PropertyWatcher("width",{"widthChanged":true},[param3[3]],null);
         param4[5] = new PropertyWatcher("y",{"yChanged":true},[param3[2]],null);
         param4[4] = new PropertyWatcher("x",{"xChanged":true},[param3[1]],null);
         param4[0].updateParent(param1);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[7]);
         param4[3].addChild(param4[6]);
         param4[3].addChild(param4[5]);
         param4[3].addChild(param4[4]);
      }
   }
}
