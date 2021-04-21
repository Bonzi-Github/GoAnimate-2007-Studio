package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.DefaultDragImage;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _DragManagerStyle
   {
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_657615002:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_657615002;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_657650851:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_657650851;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_1880598280:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_1880598280;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_657912894:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_657912894;
       
      
      public function _DragManagerStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DragManager");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("DragManager",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_657912894;
               this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_657615002;
               this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_1880598280;
               this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_657650851;
               this.defaultDragImageSkin = DefaultDragImage;
            };
         }
      }
   }
}
