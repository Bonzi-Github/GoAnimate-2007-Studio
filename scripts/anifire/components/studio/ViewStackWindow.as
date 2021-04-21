package anifire.components.studio
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.util.UtilHashArray;
   import com.adobe.ac.mxeffects.DistortionConstants;
   import com.adobe.ac.mxeffects.Flip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import mx.containers.ViewStack;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   public class ViewStackWindow extends ViewStack
   {
       
      
      private const SHOW_DURATION:Number = 600;
      
      private var _318184504preview:PreviewWindow;
      
      private var _235365105publish:PublishWindow;
      
      private const FLIP_DURATION:Number = 600;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private const RESIZE_DURATION:Number = 200;
      
      public function ViewStackWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewStack,
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":PreviewWindow,
                     "id":"preview",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":616,
                           "height":500
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":PublishWindow,
                     "id":"publish",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":616,
                           "height":280
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 616;
         this.height = 500;
         this.addEventListener("creationComplete",this.___ViewStackWindow_ViewStack1_creationComplete);
      }
      
      public function ___ViewStackWindow_ViewStack1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      [Bindable(event="propertyChange")]
      public function get preview() : PreviewWindow
      {
         return this._318184504preview;
      }
      
      public function hide() : void
      {
         PopUpManager.removePopUp(ViewStackWindow(this));
         if(Console.getConsole().currentScene != null)
         {
            Console.getConsole().currentScene.playScene();
         }
      }
      
      public function initAndPreviewMovie(param1:XML, param2:UtilHashArray, param3:UtilHashArray, param4:String = "Untitled") : void
      {
         this.preview.initAndPreviewMovie(param1,param2,param3);
         this.preview.movieName = param4;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function onCancelHandler(param1:Event) : void
      {
         this.preview.pause(true);
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      public function destory() : void
      {
         this.preview.destoryMC();
         this.preview = null;
         this.publish = null;
      }
      
      private function onChangeHandler(param1:Event) : void
      {
         if(param1.currentTarget == this.preview)
         {
            this.flipToPublish();
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function popupCloseEffect(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number;
         var _loc6_:Number = (_loc5_ = (param1 = param1 / param4) * param1) * param1;
         return param2 + param3 * (0.0028901734104049837 * _loc6_ * _loc5_ + 0 * _loc5_ * _loc5_ + 3.98843930635838 * _loc6_ + -8.98843930635838 * _loc5_ + 5.997109826589595 * param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get publish() : PublishWindow
      {
         return this._235365105publish;
      }
      
      public function set preview(param1:PreviewWindow) : void
      {
         var _loc2_:Object = this._318184504preview;
         if(_loc2_ !== param1)
         {
            this._318184504preview = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preview",_loc2_,param1));
         }
      }
      
      public function flipToPreview() : void
      {
         var _loc1_:Flip = new Flip(this.publish);
         _loc1_.siblings = [this.preview];
         _loc1_.direction = DistortionConstants.LEFT;
         _loc1_.duration = this.FLIP_DURATION;
         _loc1_.addEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect,false,0,true);
         _loc1_.play();
         this.preview.play(true);
      }
      
      private function onEndPublishEffect(param1:EffectEvent) : void
      {
         if(Flip(param1.currentTarget).target == this.preview)
         {
            this.preview.visible = false;
            this.preview.alpha = 0;
         }
         else
         {
            this.preview.visible = true;
            this.preview.alpha = 1;
         }
         param1.currentTarget.removeEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect);
      }
      
      public function flipToPublish() : void
      {
         var _loc1_:Flip = new Flip(this.preview);
         _loc1_.siblings = [this.publish];
         _loc1_.direction = DistortionConstants.RIGHT;
         _loc1_.duration = this.FLIP_DURATION;
         _loc1_.addEventListener(EffectEvent.EFFECT_END,this.onEndPublishEffect,false,0,true);
         _loc1_.play();
         this.preview.pause(true);
         var _loc2_:Rectangle = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this.publish.initPublishWindow(this.preview,Console.getConsole().tempPublished,Console.getConsole().tempPrivateShared,Console.getConsole().getThumbnailCaptures(),Console.getConsole().tempMetaData.title,Console.getConsole().tempMetaData.getUgcTagString(),Console.getConsole().tempMetaData.description,Console.getConsole().tempMetaData.lang,"< Back to preview");
         Console.getConsole().publishW = this.publish;
      }
      
      public function set publish(param1:PublishWindow) : void
      {
         var _loc2_:Object = this._235365105publish;
         if(_loc2_ !== param1)
         {
            this._235365105publish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publish",_loc2_,param1));
         }
      }
      
      private function initApp() : void
      {
         this.preview.addEventListener(Event.CHANGE,this.onChangeHandler,false,0,true);
         this.preview.addEventListener(Event.CANCEL,this.onCancelHandler,false,0,true);
         this.publish.addEventListener(Event.CHANGE,this.onChangeHandler,false,0,true);
      }
   }
}
