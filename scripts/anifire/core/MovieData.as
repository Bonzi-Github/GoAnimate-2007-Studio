package anifire.core
{
   import anifire.events.MovieEvent;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   
   public class MovieData extends EventDispatcher implements ICollection
   {
       
      
      private var _scenes:ArrayCollection;
      
      private var _privateShared:Boolean = false;
      
      private var _index:int = -1;
      
      private var _copiedScene:String;
      
      private var _copyable:Boolean = false;
      
      private var _published:Boolean = false;
      
      private var _scenesArray:Array;
      
      public function MovieData()
      {
         this._scenesArray = new Array();
         this._scenes = new ArrayCollection(this._scenesArray);
         super();
      }
      
      public function clearCurrentScene() : AnimeScene
      {
         return this.clearSceneAt(this._index);
      }
      
      public function removeSceneAt(param1:int) : Boolean
      {
         var _loc2_:AnimeScene = null;
         if(param1 >= 0 && param1 < this._scenes.length)
         {
            _loc2_ = AnimeScene(this._scenes.getItemAt(param1));
            if(_loc2_)
            {
               _loc2_.deleteAllAssets();
               _loc2_.removeAllAssets();
            }
            this._scenes.removeItemAt(param1);
            dispatchEvent(new MovieEvent(MovieEvent.SCENE_REMOVED,param1));
            if(this._index == this._scenes.length)
            {
               this.currentIndex = this.currentIndex - 1;
            }
            this.currentIndex = this._index;
            this.traceScene();
            return true;
         }
         return false;
      }
      
      public function selectSceneAt(param1:int) : AnimeScene
      {
         var _loc2_:AnimeScene = this.getSceneAt(param1);
         if(_loc2_)
         {
            this.currentScene = _loc2_;
            return _loc2_;
         }
         return null;
      }
      
      public function getNextScene(param1:AnimeScene) : AnimeScene
      {
         var _loc2_:int = this.getSceneIndex(param1);
         return this.getSceneAt(_loc2_ + 1);
      }
      
      private function traceScene() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._scenes.length)
         {
            trace(this.getSceneAt(_loc1_).id);
            _loc1_++;
         }
      }
      
      public function getSceneById(param1:String) : AnimeScene
      {
         var _loc2_:int = 0;
         var _loc3_:AnimeScene = null;
         while(_loc2_ < this._scenes.length)
         {
            _loc3_ = AnimeScene(this._scenes.getItemAt(_loc2_));
            if(_loc3_ && _loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function removeAllScene() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AnimeScene = null;
         while(_loc1_ < this._scenes.length)
         {
            _loc2_ = AnimeScene(this._scenes.getItemAt(_loc1_));
            if(_loc2_)
            {
               _loc2_.deleteAllAssets();
               _loc2_.removeAllAssets();
            }
            _loc1_++;
         }
         this._scenes.removeAll();
         this._index = -1;
      }
      
      public function get published() : Boolean
      {
         return this._published;
      }
      
      public function get copyable() : Boolean
      {
         return this._copyable;
      }
      
      public function set privateShared(param1:Boolean) : void
      {
         this._privateShared = param1;
      }
      
      public function get currentScene() : AnimeScene
      {
         return this.getSceneAt(this._index);
      }
      
      public function getSceneIndex(param1:AnimeScene) : int
      {
         if(param1)
         {
            return this._scenes.getItemIndex(param1);
         }
         return -1;
      }
      
      public function set currentScene(param1:AnimeScene) : void
      {
         if(this.currentScene == param1)
         {
         }
         if(this.currentScene)
         {
            this.currentScene.selectedAsset = null;
            this.currentScene.unloadAllAssets();
         }
         if(param1)
         {
            this._index = this.getSceneIndex(param1);
            if(this._index != -1)
            {
               param1.loadAllAssets();
               param1.playScene();
               param1.showEffects(true);
               dispatchEvent(new MovieEvent(MovieEvent.SCENE_SELECTED,this._index));
            }
         }
      }
      
      public function get currentIndex() : int
      {
         return this._index;
      }
      
      private function clearSceneAt(param1:int) : AnimeScene
      {
         var _loc2_:AnimeScene = this.getSceneAt(param1);
         if(_loc2_)
         {
            _loc2_.deSerialize(,true);
            return _loc2_;
         }
         return null;
      }
      
      public function selectSceneById(param1:String) : AnimeScene
      {
         var _loc2_:AnimeScene = this.getSceneById(param1);
         if(_loc2_)
         {
            this.currentScene = _loc2_;
            return _loc2_;
         }
         return null;
      }
      
      public function set copiedScene(param1:String) : void
      {
         this._copiedScene = param1;
      }
      
      public function set copyable(param1:Boolean) : void
      {
         this._copyable = param1;
      }
      
      public function get scenes() : Array
      {
         return this._scenes.source.concat();
      }
      
      public function copyCurrentScene() : AnimeScene
      {
         var _loc1_:AnimeScene = this.getSceneAt(this._index);
         if(_loc1_)
         {
            this._copiedScene = _loc1_.serialize(-1,false);
            return _loc1_;
         }
         return null;
      }
      
      public function get privateShared() : Boolean
      {
         return this._privateShared;
      }
      
      public function addScene(param1:AnimeScene) : Boolean
      {
         if(param1)
         {
            this._scenes.addItem(param1);
            dispatchEvent(new MovieEvent(MovieEvent.SCENE_ADDED,this._scenes.length - 1));
            this.currentScene = param1;
            this.traceScene();
            return true;
         }
         return false;
      }
      
      public function getSceneAt(param1:int) : AnimeScene
      {
         if(param1 >= 0 && param1 < this._scenes.length)
         {
            return AnimeScene(this._scenes.getItemAt(param1));
         }
         return null;
      }
      
      public function copySceneAt(param1:int) : AnimeScene
      {
         var _loc2_:AnimeScene = this.getSceneAt(param1);
         if(_loc2_)
         {
            this._copiedScene = _loc2_.serialize(-1,false);
            return _loc2_;
         }
         return null;
      }
      
      public function set currentIndex(param1:int) : void
      {
         if(param1 >= 0 && param1 < this._scenes.length)
         {
            this.currentScene = this.getSceneAt(param1);
         }
         else
         {
            this._index = -1;
         }
      }
      
      public function set published(param1:Boolean) : void
      {
         this._published = param1;
      }
      
      public function get copiedScene() : String
      {
         return this._copiedScene;
      }
      
      public function getPrevScene(param1:AnimeScene) : AnimeScene
      {
         var _loc2_:int = this.getSceneIndex(param1);
         return this.getSceneAt(_loc2_ - 1);
      }
      
      public function moveScene(param1:Number, param2:Number) : void
      {
         var _loc3_:AnimeScene = null;
         var _loc4_:MovieEvent = null;
         if(param1 >= 0 && param1 < this._scenes.length)
         {
            _loc3_ = AnimeScene(this._scenes.removeItemAt(param1));
            if(_loc3_ && param2 >= 0)
            {
               if(param1 < param2)
               {
                  if(param2 - 1 < this._scenes.length)
                  {
                     this._scenes.addItemAt(_loc3_,param2 - 1);
                  }
                  else
                  {
                     this._scenes.addItem(_loc3_);
                  }
               }
               else
               {
                  this._scenes.addItemAt(_loc3_,param2);
               }
               (_loc4_ = new MovieEvent(MovieEvent.SCENE_MOVED)).sourceIndex = param1;
               _loc4_.destIndex = param2;
               dispatchEvent(_loc4_);
               this.currentScene = _loc3_;
            }
         }
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._scenesArray);
      }
      
      public function addSceneAt(param1:AnimeScene, param2:int) : Boolean
      {
         if(param1 && param2 >= 0)
         {
            this._scenes.addItemAt(param1,param2);
            dispatchEvent(new MovieEvent(MovieEvent.SCENE_ADDED,param2));
            this.currentScene = param1;
            this.traceScene();
            return true;
         }
         return false;
      }
   }
}
