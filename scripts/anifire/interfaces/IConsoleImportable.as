package anifire.interfaces
{
   import flash.events.MouseEvent;
   
   public interface IConsoleImportable
   {
       
      
      function customAssetUploadCompleteHandler(param1:String, param2:String) : void;
      
      function deleteAsset(param1:MouseEvent = null) : void;
      
      function thumbTrayCommand(param1:String, param2:String) : void;
      
      function requestLoadStatus(param1:Boolean, param2:Boolean = false, param3:Number = 1) : void;
      
      function playScene(param1:Boolean) : void;
      
      function get currentLicensorName() : String;
      
      function invisibleImporter() : void;
      
      function userHasTTSRight() : Boolean;
   }
}
