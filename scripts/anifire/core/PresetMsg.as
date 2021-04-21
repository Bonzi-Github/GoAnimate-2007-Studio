package anifire.core
{
   import anifire.util.UtilHashArray;
   import mx.collections.ArrayCollection;
   
   public class PresetMsg
   {
      
      private static var presetMsg:PresetMsg = null;
       
      
      private var _presetMsgTheme:UtilHashArray;
      
      public function PresetMsg()
      {
         super();
         this._presetMsgTheme = new UtilHashArray();
      }
      
      public static function getInstance() : PresetMsg
      {
         if(presetMsg == null)
         {
            presetMsg = new PresetMsg();
         }
         return presetMsg;
      }
      
      public function insertMsg(param1:String, param2:String) : void
      {
         if(!this._presetMsgTheme.containsKey(param1))
         {
            this._presetMsgTheme.push(param1,new ArrayCollection());
         }
         if(!(this._presetMsgTheme.getValueByKey(param1) as ArrayCollection).contains(param2))
         {
            (this._presetMsgTheme.getValueByKey(param1) as ArrayCollection).addItem(param2);
         }
      }
      
      public function getMsgArray(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:ArrayCollection = null;
         if(this._presetMsgTheme.containsKey(param1))
         {
            _loc3_ = this._presetMsgTheme.getValueByKey(param1) as ArrayCollection;
            _loc2_ = _loc3_.toArray();
         }
         else
         {
            _loc2_ = new Array();
         }
         return _loc2_;
      }
      
      public function getRandomMsg(param1:String) : String
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._presetMsgTheme.containsKey(param1))
         {
            _loc2_ = this._presetMsgTheme.getValueByKey(param1) as ArrayCollection;
            if(_loc2_.length > 0)
            {
               _loc3_ = _loc2_.length - 1;
               _loc4_ = Math.round(Math.random() * _loc3_);
               return _loc2_.getItemAt(_loc4_) as String;
            }
         }
         return null;
      }
   }
}
