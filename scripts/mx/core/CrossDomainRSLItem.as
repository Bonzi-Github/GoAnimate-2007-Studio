package mx.core
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import mx.events.RSLEvent;
   import mx.utils.LoaderUtil;
   import mx.utils.SHA256;
   
   use namespace mx_internal;
   
   public class CrossDomainRSLItem extends RSLItem
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      private var urlIndex:int = 0;
      
      private var digests:Array;
      
      private var hashTypes:Array;
      
      private var isSigned:Array;
      
      private var rslUrls:Array;
      
      private var policyFileUrls:Array;
      
      public function CrossDomainRSLItem(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:String = null)
      {
         super(param1[0],param6);
         this.rslUrls = param1;
         this.policyFileUrls = param2;
         this.digests = param3;
         this.hashTypes = param4;
         this.isSigned = param5;
      }
      
      override public function itemCompleteHandler(param1:Event) : void
      {
         completeCdRslLoad(param1.target as URLLoader);
      }
      
      private function loadBytesCompleteHandler(param1:Event) : void
      {
         super.itemCompleteHandler(param1);
      }
      
      override public function load(param1:Function, param2:Function, param3:Function, param4:Function, param5:Function) : void
      {
         var _loc7_:ErrorEvent = null;
         chainedProgressHandler = param1;
         chainedCompleteHandler = param2;
         chainedIOErrorHandler = param3;
         chainedSecurityErrorHandler = param4;
         chainedRSLErrorHandler = param5;
         urlRequest = new URLRequest(LoaderUtil.createAbsoluteURL(rootURL,rslUrls[urlIndex]));
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).dataFormat = URLLoaderDataFormat.BINARY;
         _loc6_.addEventListener(ProgressEvent.PROGRESS,itemProgressHandler);
         _loc6_.addEventListener(Event.COMPLETE,itemCompleteHandler);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,itemErrorHandler);
         _loc6_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,itemErrorHandler);
         if(policyFileUrls.length > urlIndex && policyFileUrls[urlIndex] != "")
         {
            Security.loadPolicyFile(policyFileUrls[urlIndex]);
         }
         if(isSigned[urlIndex])
         {
            if(!urlRequest.hasOwnProperty("digest"))
            {
               if(hasFailover())
               {
                  loadFailover();
                  return;
               }
               (_loc7_ = new ErrorEvent(RSLEvent.RSL_ERROR)).text = "Flex Error #1002: Flash Player 9.0.115 and above is required to support signed RSLs. Problem occurred when trying to load the RSL " + urlRequest.url + ".  Upgrade your Flash Player and try again.";
               super.itemErrorHandler(_loc7_);
               return;
            }
            urlRequest.digest = digests[urlIndex];
         }
         _loc6_.load(urlRequest);
      }
      
      private function completeCdRslLoad(param1:URLLoader) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:ErrorEvent = null;
         if(param1 == null || param1.data == null || ByteArray(param1.data).bytesAvailable == 0)
         {
            return true;
         }
         var _loc2_:Loader = new Loader();
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         _loc3_.securityDomain = null;
         if("allowLoadBytesCodeExecution" in _loc3_)
         {
            _loc3_["allowLoadBytesCodeExecution"] = true;
         }
         if(digests[urlIndex] != null && String(digests[urlIndex]).length > 0)
         {
            _loc4_ = false;
            if(!isSigned[urlIndex])
            {
               if(hashTypes[urlIndex] == SHA256.TYPE_ID)
               {
                  _loc5_ = null;
                  if(param1.data != null)
                  {
                     _loc5_ = SHA256.computeDigest(param1.data);
                  }
                  if(_loc5_ == digests[urlIndex])
                  {
                     _loc4_ = true;
                  }
               }
            }
            else
            {
               _loc4_ = true;
            }
            if(!_loc4_)
            {
               _loc6_ = hasFailover();
               (_loc7_ = new ErrorEvent(RSLEvent.RSL_ERROR)).text = "Flex Error #1001: Digest mismatch with RSL " + urlRequest.url + ". Redeploy the matching RSL or relink your application with the matching library.";
               itemErrorHandler(_loc7_);
               return !_loc6_;
            }
         }
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBytesCompleteHandler);
         _loc2_.loadBytes(param1.data,_loc3_);
         return true;
      }
      
      public function loadFailover() : void
      {
         if(urlIndex < rslUrls.length)
         {
            trace("Failed to load RSL " + rslUrls[urlIndex]);
            trace("Failing over to RSL " + rslUrls[urlIndex + 1]);
            ++urlIndex;
            url = rslUrls[urlIndex];
            load(chainedProgressHandler,chainedCompleteHandler,chainedIOErrorHandler,chainedSecurityErrorHandler,chainedRSLErrorHandler);
         }
      }
      
      public function hasFailover() : Boolean
      {
         return rslUrls.length > urlIndex + 1;
      }
      
      override public function itemErrorHandler(param1:ErrorEvent) : void
      {
         if(hasFailover())
         {
            trace(decodeURI(param1.text));
            loadFailover();
         }
         else
         {
            super.itemErrorHandler(param1);
         }
      }
   }
}
