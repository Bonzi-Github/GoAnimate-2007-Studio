package anifire.playback
{
   import anifire.component.ProgressMonitor;
   import anifire.constant.CcLibConstant;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import br.com.stimuli.loading.BulkLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class PlayerDataStock extends EventDispatcher
   {
       
      
      private var _playerDataIsDecryptedArray:Object;
      
      private var _filmXmlArray:Array;
      
      private var bulkLoader:BulkLoader;
      
      private var urlRequestArray:Array;
      
      private var _themeXMLs:UtilHashArray;
      
      private var _playerDataArray:Object;
      
      public function PlayerDataStock()
      {
         this._filmXmlArray = new Array();
         super();
         this._playerDataArray = new Object();
         this._playerDataIsDecryptedArray = new Object();
         this._themeXMLs = new UtilHashArray();
      }
      
      public function initByLoadMovieZip(param1:Array) : void
      {
         var urlRequest:URLRequest = null;
         var urlRequestArray:Array = param1;
         trace("Start to load Movie.");
         try
         {
            this.urlRequestArray = urlRequestArray;
            this.bulkLoader = new BulkLoader(new Date().toString() + Math.random().toString());
            for each(urlRequest in urlRequestArray)
            {
               this.bulkLoader.add(urlRequest,{"type":BulkLoader.TYPE_BINARY});
            }
            this.bulkLoader.addEventListener(BulkLoader.ERROR,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.COMPLETE,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.PROGRESS,this.onLoadMovieProgress);
            ProgressMonitor.getInstance().addProgressEventDispatcher(this.bulkLoader);
            this.bulkLoader.start();
         }
         catch(e:TypeError)
         {
            trace("Error in loading file by url. Error: " + e.message);
         }
         catch(e:Error)
         {
            trace("Error in loading file by url. Error: " + e.message);
         }
      }
      
      private function addThemeXML(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc2_:String = UtilXmlInfo.getThemeIdFromThemeXML(param1);
         if(!this._themeXMLs.containsKey(_loc2_))
         {
            this._themeXMLs.push(_loc2_,param1);
         }
         else
         {
            _loc3_ = UtilXmlInfo.merge2ThemeXml(this._themeXMLs.getValueByKey(_loc2_) as XML,param1,_loc2_,"",false);
            this._themeXMLs.push(_loc2_,_loc3_);
         }
      }
      
      private function addFilmXML(param1:XML) : void
      {
         this._filmXmlArray.push(param1);
      }
      
      private function onLoadMovieZipCompleted(param1:Event) : void
      {
         var errorEvent:Event = null;
         var urlRequest:URLRequest = null;
         var byteArray:ByteArray = null;
         var contentByteArr:ByteArray = null;
         var zipFile:ZipFile = null;
         var i:int = 0;
         var zipEntry:ZipEntry = null;
         var fileBytes:ByteArray = null;
         var j:int = 0;
         var ccZipEntry:ZipEntry = null;
         var ccZipFile:ZipFile = null;
         var ccFileBytes:ByteArray = null;
         var object:Object = null;
         var errorXML:XML = null;
         var e:Event = param1;
         var bulkLoader:BulkLoader = e.target as BulkLoader;
         var returnCode:int = 0;
         var errorMsg:String = "";
         var errorCode:String = "";
         if(e.type != BulkLoader.COMPLETE)
         {
            errorMsg = errorMsg + ("Error loading file by url. The type of event returned is: " + e.toString() + ".");
            errorEvent = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,"");
            this.dispatchEvent(errorEvent);
            return;
         }
         for each(urlRequest in this.urlRequestArray)
         {
            byteArray = bulkLoader.getBinary(urlRequest,true);
            returnCode = byteArray.readByte();
            contentByteArr = new ByteArray();
            byteArray.readBytes(contentByteArr);
            if(returnCode != 0)
            {
               errorMsg = errorMsg + ("Downloading file completed with non-zero returnCode: " + returnCode + ". " + contentByteArr.toString());
               try
               {
                  errorXML = new XML(contentByteArr.toString());
                  errorCode = errorXML.child("code");
               }
               catch(e:Error)
               {
               }
            }
            if(errorMsg != "")
            {
               errorEvent = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,errorCode);
               this.dispatchEvent(errorEvent);
               return;
            }
            zipFile = new ZipFile(contentByteArr);
            i = 0;
            while(i < zipFile.size)
            {
               zipEntry = zipFile.entries[i];
               if(zipEntry.name == PlayerConstant.FILM_XML_FILENAME)
               {
                  this.addFilmXML(new XML(zipFile.getInput(zipEntry).toString()));
               }
               else if(zipEntry.name.indexOf("ugc.char") > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,object);
               }
               else if(zipEntry.name.indexOf("ugc.prop") > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,object);
               }
               else if(zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "xml")
               {
                  object = zipFile.getInput(zipEntry);
                  this.addThemeXML(new XML(object.toString()));
               }
               else if(zipEntry.name.indexOf(CcLibConstant.NODE_LIBRARY) > -1 && zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "zip")
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  ccZipFile = new ZipFile(fileBytes);
                  j = 0;
                  while(j < ccZipFile.size)
                  {
                     ccZipEntry = ccZipFile.entries[j];
                     if(ccZipEntry.name.substr(ccZipEntry.name.length - 3,3).toLowerCase() == "swf")
                     {
                        ccFileBytes = ccZipFile.getInput(ccZipEntry);
                        this.addPlayerData(ccZipEntry.name,ccFileBytes);
                     }
                     j++;
                  }
               }
               else if(zipEntry.name.substr(zipEntry.name.length - 3,3).toLowerCase() == "zip")
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  ccZipFile = new ZipFile(fileBytes);
                  this.addPlayerData(zipEntry.name,UtilPlain.convertZipAsImagedataObject(ccZipFile));
               }
               else
               {
                  fileBytes = zipFile.getInput(zipEntry);
                  this.addPlayerData(zipEntry.name,fileBytes);
               }
               i++;
            }
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
      
      private function onLoadMovieProgress(param1:Event) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS,param1));
      }
      
      public function getFilmXmlArray() : Array
      {
         return this._filmXmlArray;
      }
      
      public function decryptPlayerData(param1:String) : void
      {
         var _loc2_:UtilCrypto = null;
         if(!this._playerDataIsDecryptedArray[param1])
         {
            _loc2_ = new UtilCrypto();
            _loc2_.decrypt(this._playerDataArray[param1] as ByteArray);
            this._playerDataIsDecryptedArray[param1] = true;
         }
      }
      
      public function getPlayerData(param1:String) : Object
      {
         return this._playerDataArray[param1] as Object;
      }
      
      public function initByHashArray(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var _loc4_:int = 0;
         this.addFilmXML(param1.copy());
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            this.addPlayerData(param3.getKey(_loc4_),param3.getValueByIndex(_loc4_),true);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            this.addThemeXML(XML(param2.getValueByIndex(_loc4_)).copy());
            _loc4_++;
         }
      }
      
      private function addPlayerData(param1:String, param2:Object, param3:Boolean = false) : void
      {
         this._playerDataArray[param1] = param2;
         this._playerDataIsDecryptedArray[param1] = param3;
      }
      
      public function getThemeXMLs() : UtilHashArray
      {
         return this._themeXMLs;
      }
      
      public function destroy() : void
      {
         if(this.bulkLoader != null)
         {
            this.bulkLoader.removeAll();
         }
      }
      
      private function onInitPlayerDataStockDone(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitPlayerDataStockDone);
         trace("onInitPlayerDataStockDone");
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
   }
}
