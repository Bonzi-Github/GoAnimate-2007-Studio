package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.core.CoreEvent;
   import anifire.core.Group;
   import anifire.core.SoundThumb;
   import anifire.managers.FeatureManager;
   import anifire.timeline.Timeline;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.ComboBox;
   import mx.controls.HRule;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.PopUpManager;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class PublishWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private const SAVE_SIGNUP:String = "pubwin_save_signup";
      
      private var _2108378084_cbCategory:ComboBox;
      
      private var _12195225_txtMovieTitle:TextArea;
      
      private var _726431551_shareBtnBg:Canvas;
      
      private var _1959512361_txtTagsAdd:Text;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _169721479savePanel:VBox;
      
      private var _1490936023_lbGroupRequired:Label;
      
      private var _2121733154_pubForm:VBox;
      
      private var _82141533_mainView:ViewStack;
      
      private var _1463219121_vbTag:VBox;
      
      private var _lang_array:Array = null;
      
      private var _993142004_soundForm:MusicPanel;
      
      private var _1730701776_btnNext:Button;
      
      public var _PublishWindow_Label10:Label;
      
      private var _1958100315_lblWarning:Label;
      
      public var _PublishWindow_Label11:Label;
      
      private const SAVE_SHARE:String = "pubwin_savenshare";
      
      public var _PublishWindow_Label14:Label;
      
      private var _1985600873_vsCaptures:ViewStack;
      
      private var _1126007977_saveProgress:SaveProgress;
      
      private var _284436046_shareBtnBgEffect:Parallel;
      
      private const SAVE_CLOSE:String = "pubwin_savenclose";
      
      private var _1393458143_cbGroup:ComboBox;
      
      private var _40784716_captures:UtilHashArray;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private const TIP_SAVE:String = "pubwin_saveonlytips";
      
      private var _143330933_txtDescription:TextArea;
      
      private var _1114913131_btnSaveNShare:Button;
      
      private var _1113266043_radioPublic:RadioButton;
      
      private const TIP_SAVE_SHARE_CLOSE:String = "pubwin_savensharetips";
      
      private const TIP_SAVE_CLOSE:String = "pubwin_savenclosetips";
      
      private var _1237099340_publishForm:PublishPanel;
      
      private var _1150463470_savingOption:RadioButtonGroup;
      
      private var _324236192_txtSaveAs:Label;
      
      private var _1839914382_sharingOption:RadioButtonGroup;
      
      public var _PublishWindow_Label1:Label;
      
      public var _PublishWindow_Label2:Label;
      
      public var _PublishWindow_Label3:Label;
      
      public var _PublishWindow_Label4:Label;
      
      public var _PublishWindow_Label5:Label;
      
      public var _PublishWindow_Label6:Label;
      
      public var _PublishWindow_Label7:Label;
      
      public var _PublishWindow_Label9:Label;
      
      public var _PublishWindow_Text2:Text;
      
      public var _PublishWindow_Text4:Text;
      
      private var _1384121864_parentalAlert:Canvas;
      
      private var _1710757388_vbGroup:VBox;
      
      private var _1391325653_txtAlert:Text;
      
      private var _826688622_publishShareControl:VBox;
      
      private var _775146496_vsSaveAdditional:ViewStack;
      
      private var _1816075551_vsMoreInfo:ViewStack;
      
      private var _1730630288_btnPrev:Button;
      
      private var _1154689974_pShared:Boolean = false;
      
      mx_internal var _watchers:Array;
      
      private var _230640921_radioPrivate:RadioButton;
      
      private var _1952108612_groupAlert:VBox;
      
      private var _2944988_tip:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1962716122_lblPage:Label;
      
      private var _1988842562_langBox:ComboBox;
      
      private var _temp_is_redirect:Boolean;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _previewWindow:PreviewWindow;
      
      private var _41509777_published:Boolean = false;
      
      private var _1061294085_radioDraft:RadioButton;
      
      private var _151508365_radioPublish:RadioButton;
      
      private var _1479694698_txtTags:TextArea;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function PublishWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":500,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "events":{"creationComplete":"___PublishWindow_Canvas1_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"popupWindowBackground",
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":ViewStack,
                              "id":"_mainView",
                              "stylesFactory":function():void
                              {
                                 this.paddingTop = 10;
                                 this.paddingBottom = 15;
                                 this.paddingLeft = 15;
                                 this.paddingRight = 15;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"_pubForm",
                                       "stylesFactory":function():void
                                       {
                                          this.verticalGap = 5;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PublishWindow_Label1",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"title"};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PublishWindow_Label2",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"subTitle"};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 0;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":HBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.verticalAlign = "bottom";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"childDescriptors":[new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "id":"_PublishWindow_Label3",
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {"styleName":"midTitle"};
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "id":"_PublishWindow_Label4",
                                                                     "stylesFactory":function():void
                                                                     {
                                                                        this.color = 16730369;
                                                                        this.fontSize = 12;
                                                                        this.fontWeight = "normal";
                                                                     }
                                                                  })]};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_txtMovieTitle",
                                                               "events":{"change":"___txtMovieTitle_change"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.fontWeight = "bold";
                                                                  this.fontSize = 12;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "height":20,
                                                                     "width":295,
                                                                     "maxChars":50
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Spacer,
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"height":5};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":ViewStack,
                                                               "id":"_vsMoreInfo",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"childDescriptors":[new UIComponentDescriptor({
                                                                     "type":VBox,
                                                                     "id":"_vbTag",
                                                                     "stylesFactory":function():void
                                                                     {
                                                                        this.verticalGap = 0;
                                                                        this.verticalAlign = "top";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":HBox,
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.verticalAlign = "bottom";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PublishWindow_Label5",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"styleName":"midTitle"};
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PublishWindow_Label6",
                                                                                    "stylesFactory":function():void
                                                                                    {
                                                                                       this.color = 16730369;
                                                                                       this.fontSize = 12;
                                                                                       this.fontWeight = "normal";
                                                                                    }
                                                                                 })]};
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":TextArea,
                                                                              "id":"_txtTags",
                                                                              "events":{"change":"___txtTags_change"},
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontSize = 12;
                                                                                 this.fontWeight = "bold";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":20,
                                                                                    "width":295,
                                                                                    "maxChars":50
                                                                                 };
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":Text,
                                                                              "id":"_txtTagsAdd",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontSize = 11;
                                                                                 this.textAlign = "left";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "width":291,
                                                                                    "styleName":"midTitle",
                                                                                    "selectable":false
                                                                                 };
                                                                              }
                                                                           })]
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":VBox,
                                                                     "id":"_vbGroup",
                                                                     "stylesFactory":function():void
                                                                     {
                                                                        this.verticalGap = 0;
                                                                        this.verticalAlign = "top";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":HBox,
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.verticalAlign = "bottom";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PublishWindow_Label7",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"styleName":"midTitle"};
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_lbGroupRequired",
                                                                                    "stylesFactory":function():void
                                                                                    {
                                                                                       this.color = 16730369;
                                                                                       this.fontSize = 12;
                                                                                       this.fontWeight = "normal";
                                                                                    }
                                                                                 })]};
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":ComboBox,
                                                                              "id":"_cbGroup",
                                                                              "events":{"change":"___cbGroup_change"},
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontSize = 12;
                                                                                 this.fontWeight = "bold";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"width":295};
                                                                              }
                                                                           })]
                                                                        };
                                                                     }
                                                                  })]};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Spacer,
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"height":5};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_PublishWindow_Label9",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"styleName":"midTitle"};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_txtDescription",
                                                               "events":{"change":"___txtDescription_change"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.fontSize = 12;
                                                                  this.fontWeight = "bold";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "height":100,
                                                                     "width":295,
                                                                     "maxChars":255
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Spacer,
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"height":5};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_PublishWindow_Label10",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"styleName":"midTitle"};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":ComboBox,
                                                               "id":"_langBox",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.fontFamily = "Verdana";
                                                                  this.fontSize = 14;
                                                                  this.textAlign = "left";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"width":295};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Text,
                                                               "id":"_PublishWindow_Text2",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.fontSize = 11;
                                                                  this.textAlign = "left";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":291,
                                                                     "styleName":"midTitle",
                                                                     "selectable":false
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Spacer,
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"height":5};
                                                               }
                                                            })]};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":30,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.horizontalCenter = "0";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"verticalSpacer",
                                                                        "width":2,
                                                                        "height":300
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 0;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_PublishWindow_Label11",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"styleName":"midTitle"};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Canvas,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.cornerRadius = 8;
                                                                  this.backgroundColor = 5658198;
                                                                  this.borderThickness = 6;
                                                                  this.borderColor = 5658198;
                                                                  this.borderStyle = "solid";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":232,
                                                                     "height":153,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":ViewStack,
                                                                        "id":"_vsCaptures",
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":220,
                                                                              "height":141
                                                                           };
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":HBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_btnPrev",
                                                                        "events":{"click":"___btnPrev_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "buttonMode":true,
                                                                              "styleName":"btnPrevious"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_lblPage",
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"subTitle",
                                                                              "width":81.6
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_btnNext",
                                                                        "events":{"click":"___btnNext_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "buttonMode":true,
                                                                              "styleName":"btnNext"
                                                                           };
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Spacer,
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"height":5};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "id":"savePanel",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.verticalGap = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"childDescriptors":[new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "id":"_txtSaveAs",
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {"styleName":"midTitle"};
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":HBox,
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "horizontalScrollPolicy":"off",
                                                                           "percentWidth":100,
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":RadioButton,
                                                                              "id":"_radioDraft",
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "groupName":"_savingOption",
                                                                                    "styleName":"radioButton",
                                                                                    "buttonMode":true
                                                                                 };
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":RadioButton,
                                                                              "id":"_radioPublish",
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "groupName":"_savingOption",
                                                                                    "styleName":"radioButton",
                                                                                    "buttonMode":true
                                                                                 };
                                                                              }
                                                                           })]
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Spacer,
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {"height":5};
                                                                     }
                                                                  })]};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":ViewStack,
                                                               "id":"_vsSaveAdditional",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "id":"_publishShareControl",
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"childDescriptors":[new UIComponentDescriptor({
                                                                              "type":HBox,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_PublishWindow_Label14",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"styleName":"midTitle"};
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_tip",
                                                                                    "events":{"creationComplete":"___tip_creationComplete"},
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "styleName":"btnTip",
                                                                                          "buttonMode":true
                                                                                       };
                                                                                    }
                                                                                 })]};
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":HBox,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":RadioButton,
                                                                                    "id":"_radioPublic",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "groupName":"_sharingOption",
                                                                                          "styleName":"radioButton",
                                                                                          "buttonMode":true
                                                                                       };
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":RadioButton,
                                                                                    "id":"_radioPrivate",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "groupName":"_sharingOption",
                                                                                          "styleName":"radioButton",
                                                                                          "buttonMode":true
                                                                                       };
                                                                                    }
                                                                                 })]};
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":ComboBox,
                                                                              "id":"_cbCategory",
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"visible":false};
                                                                              }
                                                                           })]};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "id":"_parentalAlert",
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"parentalAlertBg",
                                                                              "percentWidth":100,
                                                                              "percentHeight":100,
                                                                              "childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":Text,
                                                                                 "id":"_txtAlert",
                                                                                 "stylesFactory":function():void
                                                                                 {
                                                                                    this.horizontalCenter = "0";
                                                                                    this.verticalCenter = "0";
                                                                                    this.textAlign = "center";
                                                                                    this.color = 16777215;
                                                                                    this.fontSize = 14;
                                                                                 },
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "percentWidth":90,
                                                                                       "selectable":false
                                                                                    };
                                                                                 }
                                                                              })]
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "id":"_groupAlert",
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.backgroundColor = 15648455;
                                                                           this.verticalAlign = "middle";
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"parentalAlertBg",
                                                                              "percentWidth":100,
                                                                              "percentHeight":100,
                                                                              "childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":Text,
                                                                                 "id":"_PublishWindow_Text4",
                                                                                 "stylesFactory":function():void
                                                                                 {
                                                                                    this.textAlign = "center";
                                                                                    this.color = 6954528;
                                                                                    this.fontSize = 14;
                                                                                 },
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "percentWidth":100,
                                                                                       "selectable":false
                                                                                    };
                                                                                 }
                                                                              })]
                                                                           };
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            })]};
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"percentHeight":100};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HRule,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "height":1
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.bottom = "15";
                                                   this.paddingLeft = 5;
                                                   this.paddingRight = 5;
                                                   this.horizontalGap = 0;
                                                   this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Button,
                                                         "id":"_btnSave",
                                                         "events":{"click":"___btnSave_click"},
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "styleName":"btnWhite",
                                                               "width":150,
                                                               "height":32,
                                                               "buttonMode":true
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Spacer,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":209,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_lblWarning",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalCenter = "0";
                                                                     this.horizontalCenter = "0";
                                                                     this.fontSize = 18;
                                                                     this.color = 16320794;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"visible":false};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":SaveProgress,
                                                                  "id":"_saveProgress",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"visible":true};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Spacer,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_shareBtnBg",
                                                         "events":{
                                                            "creationComplete":"___shareBtnBg_creationComplete",
                                                            "resize":"___shareBtnBg_resize"
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "clipContent":false,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_btnSaveNShare",
                                                                  "events":{"click":"___btnSaveNShare_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "label":"",
                                                                        "styleName":"btnWhite",
                                                                        "minWidth":150,
                                                                        "height":32,
                                                                        "buttonMode":true,
                                                                        "toolTip":""
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MusicPanel,
                                       "id":"_soundForm",
                                       "events":{"saveMovie":"___soundForm_saveMovie"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":PublishPanel,
                                       "id":"_publishForm",
                                       "events":{
                                          "saveAsPublic":"___publishForm_saveAsPublic",
                                          "saveAsPrivate":"___publishForm_saveAsPrivate"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":IconTextButton,
                              "id":"_btnCloseTop",
                              "events":{
                                 "click":"___btnCloseTop_click",
                                 "creationComplete":"___btnCloseTop_creationComplete"
                              },
                              "stylesFactory":function():void
                              {
                                 this.right = "10";
                                 this.top = "10";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnCloseTop",
                                    "buttonMode":true,
                                    "labelPlacement":"left"
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.layout = "absolute";
         this.width = 616;
         this.height = 500;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "popupWindow";
         this.creationPolicy = "all";
         this._PublishWindow_RadioButtonGroup1_i();
         this._PublishWindow_Parallel1_i();
         this._PublishWindow_RadioButtonGroup2_i();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PublishWindow._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsSaveAdditional() : ViewStack
      {
         return this._775146496_vsSaveAdditional;
      }
      
      public function success(param1:SoundThumb) : void
      {
         this._soundForm.success(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioDraft() : RadioButton
      {
         return this._1061294085_radioDraft;
      }
      
      public function set _vsSaveAdditional(param1:ViewStack) : void
      {
         var _loc2_:Object = this._775146496_vsSaveAdditional;
         if(_loc2_ !== param1)
         {
            this._775146496_vsSaveAdditional = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsSaveAdditional",_loc2_,param1));
         }
      }
      
      private function closeWindow(param1:Event) : void
      {
         if(this._mainView.selectedChild == this._publishForm)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
            this.doSaveMovie();
         }
         else
         {
            this._soundForm.deselectAllSoundTileCell();
            if(this.parent != null && this.parent is ViewStackWindow)
            {
               ViewStackWindow(this.parent).onCancelHandler(null);
            }
            else
            {
               Console.getConsole().closePublishWindow();
            }
         }
      }
      
      private function _PublishWindow_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this._savingOption = _loc1_;
         _loc1_.addEventListener("itemClick",this.___savingOption_itemClick);
         _loc1_.initialized(this,"_savingOption");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbGroup() : VBox
      {
         return this._1710757388_vbGroup;
      }
      
      public function ___soundForm_saveMovie(param1:Event) : void
      {
         this.onSaveMovieFromMusicPanel();
      }
      
      public function set _parentalAlert(param1:Canvas) : void
      {
         var _loc2_:Object = this._1384121864_parentalAlert;
         if(_loc2_ !== param1)
         {
            this._1384121864_parentalAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_parentalAlert",_loc2_,param1));
         }
      }
      
      public function set _radioDraft(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1061294085_radioDraft;
         if(_loc2_ !== param1)
         {
            this._1061294085_radioDraft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioDraft",_loc2_,param1));
         }
      }
      
      private function setTempPrivateShared() : void
      {
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = true;
            }
            else if(this._radioPrivate.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = true;
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
            }
            this._cbCategory.visible = this._radioPublic.selected;
         }
         else if(UtilSite.siteId != UtilSite.YOUTUBE)
         {
            if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = false;
            }
            else if(this._radioPrivate.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = true;
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
            }
         }
         this.enableButton(this._btnSaveNShare,true,true);
      }
      
      [Bindable(event="propertyChange")]
      public function get _parentalAlert() : Canvas
      {
         return this._1384121864_parentalAlert;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbCategory() : ComboBox
      {
         return this._2108378084_cbCategory;
      }
      
      [Bindable(event="propertyChange")]
      public function get _pubForm() : VBox
      {
         return this._2121733154_pubForm;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbGroup() : ComboBox
      {
         return this._1393458143_cbGroup;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAlert() : Text
      {
         return this._1391325653_txtAlert;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblPage() : Label
      {
         return this._1962716122_lblPage;
      }
      
      private function initCategory() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [{"label":"No category"}];
         var _loc2_:String = Console.getConsole().groupController.category;
         var _loc3_:XMLList = Console.getConsole().groupController.categoryList;
         if(_loc3_)
         {
            _loc1_ = [{"label":"Pick a Category"}];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc1_.push({"label":_loc3_[_loc4_].@name});
               if(_loc2_ == _loc3_[_loc4_].@name)
               {
                  this._cbCategory.selectedIndex = _loc4_ + 1;
               }
               _loc4_++;
            }
         }
         this._cbCategory.dataProvider = _loc1_;
      }
      
      private function doModifyMovieName() : void
      {
         Console.getConsole().tempMetaData.title = this._txtMovieTitle.text;
         if(this._previewWindow != null)
         {
            this._previewWindow.movieName = this._txtMovieTitle.text;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNext() : Button
      {
         return this._1730701776_btnNext;
      }
      
      public function set _cbCategory(param1:ComboBox) : void
      {
         var _loc2_:Object = this._2108378084_cbCategory;
         if(_loc2_ !== param1)
         {
            this._2108378084_cbCategory = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbCategory",_loc2_,param1));
         }
      }
      
      public function set _vsMoreInfo(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1816075551_vsMoreInfo;
         if(_loc2_ !== param1)
         {
            this._1816075551_vsMoreInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsMoreInfo",_loc2_,param1));
         }
      }
      
      public function set _pubForm(param1:VBox) : void
      {
         var _loc2_:Object = this._2121733154_pubForm;
         if(_loc2_ !== param1)
         {
            this._2121733154_pubForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pubForm",_loc2_,param1));
         }
      }
      
      public function ___txtTags_change(param1:Event) : void
      {
         this.doModifyTags();
      }
      
      public function set _cbGroup(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1393458143_cbGroup;
         if(_loc2_ !== param1)
         {
            this._1393458143_cbGroup = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbGroup",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbTag() : VBox
      {
         return this._1463219121_vbTag;
      }
      
      private function _PublishWindow_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_title");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label1.text = param1;
         },"_PublishWindow_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_subtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label2.text = param1;
         },"_PublishWindow_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movietitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label3.text = param1;
         },"_PublishWindow_Label3.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label4.text = param1;
         },"_PublishWindow_Label4.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_tags");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label5.text = param1;
         },"_PublishWindow_Label5.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label6.text = param1;
         },"_PublishWindow_Label6.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_tagsub");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _txtTagsAdd.text = param1;
         },"_txtTagsAdd.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Group");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label7.text = param1;
         },"_PublishWindow_Label7.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _lbGroupRequired.text = param1;
         },"_lbGroupRequired.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_description");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label9.text = param1;
         },"_PublishWindow_Label9.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movielang");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label10.text = param1;
         },"_PublishWindow_Label10.text");
         result[10] = binding;
         binding = new Binding(this,function():Object
         {
            return LANG_ARRAY;
         },function(param1:Object):void
         {
            _langBox.dataProvider = param1;
         },"_langBox.dataProvider");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movielangsub");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Text2.text = param1;
         },"_PublishWindow_Text2.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_pickthumb");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label11.text = param1;
         },"_PublishWindow_Label11.text");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = _vsCaptures.selectedIndex + 1 + "/" + _captures.length;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _lblPage.text = param1;
         },"_lblPage.text");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveas");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _txtSaveAs.text = param1;
         },"_txtSaveAs.text");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_draft");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _radioDraft.label = param1;
         },"_radioDraft.label");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_publish");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _radioPublish.label = param1;
         },"_radioPublish.label");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_psharing");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Label14.text = param1;
         },"_PublishWindow_Label14.text");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_public");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _radioPublic.label = param1;
         },"_radioPublic.label");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_private");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _radioPrivate.label = param1;
         },"_radioPrivate.label");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_parent");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _txtAlert.text = param1;
         },"_txtAlert.text");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Create groups of students to enable publishing your animations.");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _PublishWindow_Text4.text = param1;
         },"_PublishWindow_Text4.text");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonly");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.label = param1;
         },"_btnSave.label");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonlytips");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSave.toolTip = param1;
         },"_btnSave.toolTip");
         result[24] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.loggedIn;
         },function(param1:Boolean):void
         {
            _btnSave.visible = param1;
         },"_btnSave.visible");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_warningtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _lblWarning.text = param1;
         },"_lblWarning.text");
         result[26] = binding;
         binding = new Binding(this,function():*
         {
            return _shareBtnBgEffect;
         },function(param1:*):void
         {
            _shareBtnBg.setStyle("creationCompleteEffect",param1);
         },"_shareBtnBg.creationCompleteEffect");
         result[27] = binding;
         binding = new Binding(this,function():*
         {
            return _shareBtnBgEffect;
         },function(param1:*):void
         {
            _shareBtnBg.setStyle("resizeEffect",param1);
         },"_shareBtnBg.resizeEffect");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCloseTop.label = param1;
         },"_btnCloseTop.label");
         result[29] = binding;
         return result;
      }
      
      public function set _lblPage(param1:Label) : void
      {
         var _loc2_:Object = this._1962716122_lblPage;
         if(_loc2_ !== param1)
         {
            this._1962716122_lblPage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblPage",_loc2_,param1));
         }
      }
      
      private function onSaveAsPrivate() : void
      {
         Console.getConsole().tempPublished = false;
         Console.getConsole().tempPrivateShared = true;
         this.doSaveMovie(true,true);
      }
      
      public function set _lbGroupRequired(param1:Label) : void
      {
         var _loc2_:Object = this._1490936023_lbGroupRequired;
         if(_loc2_ !== param1)
         {
            this._1490936023_lbGroupRequired = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lbGroupRequired",_loc2_,param1));
         }
      }
      
      private function doModifyGroup() : void
      {
         if(this._cbGroup.selectedItem.data != "-1")
         {
            Console.getConsole().groupController.tempCurrentGroup = new Group(this._cbGroup.selectedItem.data,this._cbGroup.selectedItem.label);
         }
      }
      
      private function _PublishWindow_Parallel1_i() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         this._shareBtnBgEffect = _loc1_;
         _loc1_.repeatCount = 0;
         _loc1_.children = [this._PublishWindow_Glow1_c(),this._PublishWindow_Glow2_c()];
         return _loc1_;
      }
      
      public function set _btnNext(param1:Button) : void
      {
         var _loc2_:Object = this._1730701776_btnNext;
         if(_loc2_ !== param1)
         {
            this._1730701776_btnNext = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNext",_loc2_,param1));
         }
      }
      
      public function set _txtAlert(param1:Text) : void
      {
         var _loc2_:Object = this._1391325653_txtAlert;
         if(_loc2_ !== param1)
         {
            this._1391325653_txtAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAlert",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishShareControl() : VBox
      {
         return this._826688622_publishShareControl;
      }
      
      [Bindable(event="propertyChange")]
      private function get _published() : Boolean
      {
         return this._41509777_published;
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharingOption() : RadioButtonGroup
      {
         return this._1839914382_sharingOption;
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublish() : RadioButton
      {
         return this._151508365_radioPublish;
      }
      
      private function onCancelClickHandler(param1:Event = null) : void
      {
         if(this._previewWindow != null)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
         else
         {
            this.hide();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublic() : RadioButton
      {
         return this._1113266043_radioPublic;
      }
      
      [Bindable(event="propertyChange")]
      public function get savePanel() : VBox
      {
         return this._169721479savePanel;
      }
      
      private function doOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
         this.orderConsoleToSaveMovie();
      }
      
      private function enableButton(param1:Button, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 != null)
         {
            param1.enabled = param2;
            param1.buttonMode = param2;
            if(param1 == this._btnSaveNShare && UtilSite.siteId != UtilSite.YOUTUBE)
            {
               if(param3 && UtilSite.siteId != UtilSite.SCHOOL)
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SHARE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_SHARE_CLOSE);
               }
               else
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_CLOSE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_CLOSE);
               }
               if(!UtilUser.loggedIn)
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SIGNUP) + " >";
               }
            }
         }
      }
      
      public function ___sharingOption_itemClick(param1:ItemClickEvent) : void
      {
         this.setTempPrivateShared();
      }
      
      private function set _captures(param1:UtilHashArray) : void
      {
         var _loc2_:Object = this._40784716_captures;
         if(_loc2_ !== param1)
         {
            this._40784716_captures = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_captures",_loc2_,param1));
         }
      }
      
      public function ___btnNext_click(param1:MouseEvent) : void
      {
         this.nextThumbnail();
      }
      
      public function set _vbTag(param1:VBox) : void
      {
         var _loc2_:Object = this._1463219121_vbTag;
         if(_loc2_ !== param1)
         {
            this._1463219121_vbTag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbTag",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblWarning() : Label
      {
         return this._1958100315_lblWarning;
      }
      
      [Bindable(event="propertyChange")]
      public function get _saveProgress() : SaveProgress
      {
         return this._1126007977_saveProgress;
      }
      
      public function initPublishWindow(param1:PreviewWindow, param2:Boolean, param3:Boolean, param4:UtilHashArray, param5:String = "", param6:String = "", param7:String = "", param8:String = "", param9:String = "", param10:Number = 0) : void
      {
         var _loc11_:BitmapData = null;
         var _loc12_:int = 0;
         var _loc13_:BitmapData = null;
         var _loc14_:Number = NaN;
         this._previewWindow = param1;
         this._published = param2;
         this._pShared = param3;
         this._captures = param4;
         this._txtMovieTitle.text = param5;
         this._txtTags.text = param6;
         this._txtDescription.text = param7;
         if(param4 != null)
         {
            _loc11_ = Console.getConsole().getThumbnailCaptureBySceneIndex(0);
            Console.getConsole().selectedThumbnailIndex = 0;
            this.fitBitmapIntoCaptures(_loc11_,0);
            _loc12_ = 1;
            while(_loc12_ < param4.length)
            {
               _loc13_ = param4.getValueByIndex(_loc12_);
               this.fitBitmapIntoCaptures(_loc13_,_loc12_);
               _loc12_++;
            }
            if(param10 > param4.length - 1)
            {
               param10 = param4.length - 1;
            }
            this._lblPage.text = param10 + 1 + "/" + param4.length;
            if(param10 == 0)
            {
               this.enableButton(this._btnPrev,false);
            }
            if(param10 == param4.length - 1)
            {
               this.enableButton(this._btnNext,false);
            }
            this._vsCaptures.selectedIndex = param10;
         }
         if(param8 == "")
         {
            param8 = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
         }
         _loc12_ = 0;
         while(_loc12_ < this.LANG_ARRAY.length)
         {
            if(param8 == this.LANG_ARRAY[_loc12_].data)
            {
               this._langBox.selectedIndex = _loc12_;
            }
            _loc12_++;
         }
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if((_loc14_ = Util.roundNum(Console.getConsole().timeline.getTotalTimeInSec())) > FeatureManager.maxMovieDuration)
            {
               this.allowDraftOnly();
               Console.getConsole().alert("As your movie is longer than 2 mins, you may only save it as a draft. In order to publish it, you have to make it shorter or upgrade your account to GoPlus.");
            }
         }
         this.enableButton(this._btnSaveNShare,true,this._published || this._pShared);
         this.initSavinOption();
      }
      
      private function initSavinOption(param1:int = -1) : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            this._tip.toolTip = UtilDict.toDisplay("go","pubwin_psharingtips");
            this._vsSaveAdditional.selectedChild = this._publishShareControl;
            this._savingOption.selection = this._published || this._pShared?this._radioPublish:this._radioDraft;
            this._vsSaveAdditional.visible = this._published || this._pShared;
            this._sharingOption.selection = !!this._pShared?this._radioPrivate:this._radioPublic;
         }
         else if(UtilSite.siteId == UtilSite.CN)
         {
            this._vsSaveAdditional.selectedChild = this._parentalAlert;
            this._vsSaveAdditional.visible = false;
            this._savingOption.selection = this._published || this._pShared?this._radioPublish:this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "0")
            {
               this.allowDraftOnly();
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "2")
            {
               this.allowDraftOnly();
               this._vsSaveAdditional.visible = true;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_nonactivate");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 121)
            {
               this.allowDraftOnly();
               this._vsSaveAdditional.visible = true;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 25.1 && (Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != null && Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != "0"))
            {
               this.allowDraftOnly();
               this._vsSaveAdditional.visible = true;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert25");
            }
            else
            {
               this._vsSaveAdditional.visible = this._radioPublish.selected;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_moderators");
               this._txtAlert.setStyle("color","0x000000");
               this._parentalAlert.setStyle("backgroundColor","0xBBE0E3");
            }
         }
         else if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            this._vsMoreInfo.selectedChild = this._vbGroup;
            this._txtTags.text = "school";
            this._radioPublic.label = UtilDict.toDisplay("go","Lesson Gallery");
            this._radioPrivate.label = UtilDict.toDisplay("go","Students only");
            this._radioPublic.setStyle("fontSize","12");
            this._radioPrivate.setStyle("fontSize","12");
            this._tip.toolTip = UtilDict.toDisplay("go","Students only: Only students in the group you selected can see this animatio\n\nLesson Gallery: Collaborate with other educators and include this animation in the lesson gallery");
            this._vsSaveAdditional.selectedChild = this._publishShareControl;
            this._savingOption.selection = this._published || this._pShared?this._radioPublish:this._radioDraft;
            this._vsSaveAdditional.visible = this._published || this._pShared;
            this._sharingOption.selection = this._published && this._pShared?this._radioPublic:this._radioPrivate;
            this.initGroupComboBox();
            this.initCategory();
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this._vsSaveAdditional.visible = false;
            this._savingOption.selection = !!this._published?this._radioPublish:this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            this._radioPublish.label = UtilDict.toDisplay("go","pubwin_public");
            this._btnSave.label = UtilDict.toDisplay("go","Save Project");
            this._txtSaveAs.text = UtilDict.toDisplay("go","Publish to YouTube as:");
            this.savePanel.visible = false;
            this._btnSaveNShare.label = UtilDict.toDisplay("go","Publish to YouTube" + " >");
         }
         this.setTempPublished();
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishForm() : PublishPanel
      {
         return this._1237099340_publishForm;
      }
      
      public function ___PublishWindow_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initWindow();
      }
      
      private function get LANG_ARRAY() : Array
      {
         var _loc1_:Object = null;
         var _loc2_:UtilHashArray = null;
         var _loc3_:int = 0;
         if(this._lang_array == null)
         {
            this._lang_array = new Array();
            _loc2_ = UtilLicense.getCurrentLicensorSupportedShortLangCodes();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = new Object();
               _loc1_.label = _loc2_.getValueByIndex(_loc3_);
               _loc1_.data = _loc2_.getKey(_loc3_);
               this._lang_array.push(_loc1_);
               _loc3_++;
            }
         }
         return this._lang_array;
      }
      
      private function validateMovieDetail() : Boolean
      {
         var _loc1_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this._lblWarning.visible = false;
         if(_loc1_.containsBadword(this._txtMovieTitle.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return false;
         }
         if(StringUtil.trim(this._txtMovieTitle.text) == "")
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return false;
         }
         if(_loc1_.containsBadword(this._txtTags.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtTags.setFocus();
            return false;
         }
         if(StringUtil.trim(this._txtTags.text) == "")
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK_TAG);
            this._lblWarning.visible = true;
            this._txtTags.setFocus();
            return false;
         }
         if(_loc1_.containsBadword(this._txtDescription.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtDescription.setFocus();
            return false;
         }
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._cbGroup.selectedItem.data == "-1")
            {
               this._lblWarning.text = UtilDict.toDisplay("go","Please select a group");
               this._lblWarning.visible = true;
               this._cbGroup.setFocus();
               return false;
            }
            if(this._radioPublic.selected && this._radioPublish.selected && Console.getConsole().groupController.categoryList && this._cbCategory.selectedIndex == 0)
            {
               this._lblWarning.text = UtilDict.toDisplay("go","Please select a category");
               this._lblWarning.visible = true;
               this._cbCategory.setFocus();
               return false;
            }
         }
         return true;
      }
      
      public function ___txtDescription_change(param1:Event) : void
      {
         this.doModifyDescription();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : Button
      {
         return this._1730556742_btnSave;
      }
      
      private function onSaveBtnClick() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
         }
         this.doSaveMovie();
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _shareBtnBg() : Canvas
      {
         return this._726431551_shareBtnBg;
      }
      
      public function set _mainView(param1:ViewStack) : void
      {
         var _loc2_:Object = this._82141533_mainView;
         if(_loc2_ !== param1)
         {
            this._82141533_mainView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainView",_loc2_,param1));
         }
      }
      
      public function set _txtTags(param1:TextArea) : void
      {
         var _loc2_:Object = this._1479694698_txtTags;
         if(_loc2_ !== param1)
         {
            this._1479694698_txtTags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTags",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTagsAdd() : Text
      {
         return this._1959512361_txtTagsAdd;
      }
      
      public function set _vsCaptures(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1985600873_vsCaptures;
         if(_loc2_ !== param1)
         {
            this._1985600873_vsCaptures = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsCaptures",_loc2_,param1));
         }
      }
      
      public function set _publishShareControl(param1:VBox) : void
      {
         var _loc2_:Object = this._826688622_publishShareControl;
         if(_loc2_ !== param1)
         {
            this._826688622_publishShareControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishShareControl",_loc2_,param1));
         }
      }
      
      public function ___shareBtnBg_creationComplete(param1:FlexEvent) : void
      {
         this.drawWhiteBorder();
      }
      
      private function doModifyTags() : void
      {
         Console.getConsole().tempMetaData.setUgcTagsByString(this._txtTags.text);
      }
      
      public function set _sharingOption(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1839914382_sharingOption;
         if(_loc2_ !== param1)
         {
            this._1839914382_sharingOption = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharingOption",_loc2_,param1));
         }
      }
      
      public function set _btnSaveNShare(param1:Button) : void
      {
         var _loc2_:Object = this._1114913131_btnSaveNShare;
         if(_loc2_ !== param1)
         {
            this._1114913131_btnSaveNShare = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSaveNShare",_loc2_,param1));
         }
      }
      
      public function set _radioPublish(param1:RadioButton) : void
      {
         var _loc2_:Object = this._151508365_radioPublish;
         if(_loc2_ !== param1)
         {
            this._151508365_radioPublish = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublish",_loc2_,param1));
         }
      }
      
      public function set _btnPrev(param1:Button) : void
      {
         var _loc2_:Object = this._1730630288_btnPrev;
         if(_loc2_ !== param1)
         {
            this._1730630288_btnPrev = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPrev",_loc2_,param1));
         }
      }
      
      private function set _published(param1:Boolean) : void
      {
         var _loc2_:Object = this._41509777_published;
         if(_loc2_ !== param1)
         {
            this._41509777_published = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_published",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPrivate() : RadioButton
      {
         return this._230640921_radioPrivate;
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundForm() : MusicPanel
      {
         return this._993142004_soundForm;
      }
      
      private function doCancelOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _radioPublic(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1113266043_radioPublic;
         if(_loc2_ !== param1)
         {
            this._1113266043_radioPublic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublic",_loc2_,param1));
         }
      }
      
      public function set savePanel(param1:VBox) : void
      {
         var _loc2_:Object = this._169721479savePanel;
         if(_loc2_ !== param1)
         {
            this._169721479savePanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"savePanel",_loc2_,param1));
         }
      }
      
      public function set _txtDescription(param1:TextArea) : void
      {
         var _loc2_:Object = this._143330933_txtDescription;
         if(_loc2_ !== param1)
         {
            this._143330933_txtDescription = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDescription",_loc2_,param1));
         }
      }
      
      private function onSaveAndShareBtnClick() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(this.validateMovieDetail())
            {
               this._mainView.selectedChild = this._publishForm;
            }
         }
         else
         {
            this.doSaveMovie(true);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsMoreInfo() : ViewStack
      {
         return this._1816075551_vsMoreInfo;
      }
      
      private function initWindow() : void
      {
         this._mainView.selectedChild = this._pubForm;
      }
      
      private function fitBitmapIntoCaptures(param1:BitmapData, param2:int) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Image = null;
         var _loc5_:Canvas = null;
         if(param1 != null)
         {
            _loc3_ = new Bitmap(param1);
            _loc3_.width = 220;
            _loc3_.height = 141;
            (_loc4_ = new Image()).addChild(_loc3_);
            (_loc5_ = new Canvas()).width = this._vsCaptures.width;
            _loc5_.height = this._vsCaptures.height;
            _loc5_.addChild(_loc4_);
            this._vsCaptures.addChildAt(_loc5_,param2);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lbGroupRequired() : Label
      {
         return this._1490936023_lbGroupRequired;
      }
      
      public function set _txtMovieTitle(param1:TextArea) : void
      {
         var _loc2_:Object = this._12195225_txtMovieTitle;
         if(_loc2_ !== param1)
         {
            this._12195225_txtMovieTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMovieTitle",_loc2_,param1));
         }
      }
      
      public function ___txtMovieTitle_change(param1:Event) : void
      {
         this.doModifyMovieName();
      }
      
      private function setTempPublished() : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE)
            {
               this._vsSaveAdditional.visible = this._radioPublish.selected;
            }
            if(this._radioDraft.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            else
            {
               this.setTempPrivateShared();
               this.enableButton(this._btnSaveNShare,true,true);
            }
         }
         else if(UtilSite.siteId == UtilSite.CN)
         {
            if(this._radioPublish.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,true);
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            if(this._txtAlert.text === UtilDict.toDisplay("go","pubwin_moderators"))
            {
               this._vsSaveAdditional.visible = this._radioPublish.selected;
            }
         }
         else if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._radioDraft.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            else
            {
               this.setTempPrivateShared();
               this.enableButton(this._btnSaveNShare,true,true);
            }
            if(this._vsSaveAdditional.selectedChild == this._publishShareControl)
            {
               if(Console.getConsole().groupController.isTeacher)
               {
                  this._vsSaveAdditional.visible = this._radioPublish.selected;
               }
            }
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
      }
      
      private function nextThumbnail() : void
      {
         var _loc1_:BitmapData = null;
         if(this._vsCaptures.selectedIndex < this._captures.length - 1)
         {
            if(this._vsCaptures.selectedIndex + 1 >= this._vsCaptures.numChildren)
            {
               Console.getConsole().requestLoadStatus(true);
               _loc1_ = Console.getConsole().getThumbnailCaptureBySceneIndex(this._vsCaptures.selectedIndex + 1);
               this.fitBitmapIntoCaptures(_loc1_,this._vsCaptures.selectedIndex + 1);
               Console.getConsole().requestLoadStatus(false);
            }
            this._vsCaptures.selectedIndex = this._vsCaptures.selectedIndex + 1;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == this._captures.length - 1)
            {
               this.enableButton(this._btnNext,false);
            }
            if(this._btnPrev.enabled == false)
            {
               this.enableButton(this._btnPrev,true);
            }
         }
      }
      
      public function setBtnStatus(param1:Boolean) : void
      {
         if(this._mainView.selectedChild == this._pubForm)
         {
            this.enableButton(this._btnSave,param1);
            this.enableButton(this._btnSaveNShare,param1,Console.getConsole().movie.privateShared);
            this._txtMovieTitle.enabled = param1;
            this._txtTags.enabled = param1;
            this._txtDescription.enabled = param1;
            this._langBox.enabled = param1;
            this._radioDraft.enabled = param1;
            this._radioPublish.enabled = param1;
            this._radioPublic.enabled = param1;
            this._radioPrivate.enabled = param1;
            if(param1)
            {
               this.initSavinOption();
            }
            this._btnPrev.enabled = param1;
            this._btnNext.enabled = param1;
            this._btnCloseTop.visible = param1;
            if(param1)
            {
               this._saveProgress.visible = false;
               this._saveProgress.stopSavingProgress();
            }
            else
            {
               this._saveProgress.visible = true;
               this._saveProgress.startSavingProgress();
            }
         }
         else if(this._mainView.selectedChild == this._soundForm)
         {
            this._soundForm.setBtnStatus(param1);
         }
      }
      
      public function set _txtSaveAs(param1:Label) : void
      {
         var _loc2_:Object = this._324236192_txtSaveAs;
         if(_loc2_ !== param1)
         {
            this._324236192_txtSaveAs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtSaveAs",_loc2_,param1));
         }
      }
      
      public function hide() : void
      {
         PopUpManager.removePopUp(PublishWindow(this));
         if(Console.getConsole().currentScene != null)
         {
            Console.getConsole().currentScene.playScene();
         }
      }
      
      private function _PublishWindow_Glow2_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.startDelay = 1500;
         _loc1_.alphaFrom = 0.5;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1500;
         _loc1_.blurXFrom = 14;
         _loc1_.blurYFrom = 14;
         _loc1_.blurXTo = 14;
         _loc1_.blurYTo = 14;
         _loc1_.color = 3713279;
         _loc1_.strength = 10;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get _captures() : UtilHashArray
      {
         return this._40784716_captures;
      }
      
      public function set _lblWarning(param1:Label) : void
      {
         var _loc2_:Object = this._1958100315_lblWarning;
         if(_loc2_ !== param1)
         {
            this._1958100315_lblWarning = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblWarning",_loc2_,param1));
         }
      }
      
      public function ___savingOption_itemClick(param1:ItemClickEvent) : void
      {
         this.setTempPublished();
      }
      
      private function onSaveAsPublic() : void
      {
         Console.getConsole().tempPublished = true;
         Console.getConsole().tempPrivateShared = false;
         this.doSaveMovie(true,true);
      }
      
      public function set _saveProgress(param1:SaveProgress) : void
      {
         var _loc2_:Object = this._1126007977_saveProgress;
         if(_loc2_ !== param1)
         {
            this._1126007977_saveProgress = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_saveProgress",_loc2_,param1));
         }
      }
      
      public function ___tip_creationComplete(param1:FlexEvent) : void
      {
         this.initTip();
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainView() : ViewStack
      {
         return this._82141533_mainView;
      }
      
      public function set _shareBtnBgEffect(param1:Parallel) : void
      {
         var _loc2_:Object = this._284436046_shareBtnBgEffect;
         if(_loc2_ !== param1)
         {
            this._284436046_shareBtnBgEffect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_shareBtnBgEffect",_loc2_,param1));
         }
      }
      
      private function doSaveMovie(param1:Boolean = false, param2:Boolean = false) : void
      {
         var self:IEventDispatcher = null;
         var redirect:Boolean = param1;
         var skipAddSound:Boolean = param2;
         if(this.validateMovieDetail() == false)
         {
            return;
         }
         if((Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared) && (Console.getConsole().sounds.length < 1 && Console.getConsole().speechManager.ttsManager.sounds.length < 1) && redirect && !skipAddSound)
         {
            this._mainView.selectedChild = this._soundForm;
            this._soundForm.initSoundList();
            if(UtilUser.loggedIn)
            {
               return;
            }
         }
         if(skipAddSound)
         {
            this._soundForm.addSelectedSound();
         }
         this._temp_is_redirect = redirect;
         if(UtilUser.loggedIn)
         {
            Console.getConsole().groupController.category = this._cbCategory.selectedLabel;
            this.setTempPrivateShared();
            this.setTempPublished();
            self = this;
            Console.getConsole().addEventListener(CoreEvent.SERIALIZE_COMPLETE,function(param1:CoreEvent):void
            {
               Console.getConsole().removeEventListener(CoreEvent.SERIALIZE_COMPLETE,arguments.callee);
               _saveProgress.dispatchEvent(new CoreEvent(CoreEvent.SERIALIZE_COMPLETE,self));
            });
            this.orderConsoleToSaveMovie();
         }
         else
         {
            Util.gaTracking("/gostudio/action/signup-and-save",Console.getConsole().mainStage.stage);
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doOrderConsoleToSaveMovie);
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doCancelOrderConsoleToSaveMovie);
            Console.getConsole().showSignup();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsCaptures() : ViewStack
      {
         return this._1985600873_vsCaptures;
      }
      
      public function set _publishForm(param1:PublishPanel) : void
      {
         var _loc2_:Object = this._1237099340_publishForm;
         if(_loc2_ !== param1)
         {
            this._1237099340_publishForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishForm",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPrev() : Button
      {
         return this._1730630288_btnPrev;
      }
      
      private function initTip() : void
      {
         var _loc1_:ColorTransform = null;
         _loc1_ = new ColorTransform(0.5,0.5,0.5);
         this._tip.transform.colorTransform = _loc1_;
      }
      
      private function set _pShared(param1:Boolean) : void
      {
         var _loc2_:Object = this._1154689974_pShared;
         if(_loc2_ !== param1)
         {
            this._1154689974_pShared = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pShared",_loc2_,param1));
         }
      }
      
      public function set _btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._1730556742_btnSave;
         if(_loc2_ !== param1)
         {
            this._1730556742_btnSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSave",_loc2_,param1));
         }
      }
      
      public function set _groupAlert(param1:VBox) : void
      {
         var _loc2_:Object = this._1952108612_groupAlert;
         if(_loc2_ !== param1)
         {
            this._1952108612_groupAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_groupAlert",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTags() : TextArea
      {
         return this._1479694698_txtTags;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSaveNShare() : Button
      {
         return this._1114913131_btnSaveNShare;
      }
      
      public function ___publishForm_saveAsPrivate(param1:Event) : void
      {
         this.onSaveAsPrivate();
      }
      
      public function set _langBox(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1988842562_langBox;
         if(_loc2_ !== param1)
         {
            this._1988842562_langBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_langBox",_loc2_,param1));
         }
      }
      
      private function orderConsoleToSaveMovie() : void
      {
         this.enabled = false;
         Console.getConsole().tempMetaData.lang = this._langBox.selectedItem.data;
         Console.getConsole().metaData.lang = this._langBox.selectedItem.data;
         Console.getConsole().addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.onSaveMovieComplete);
         Console.getConsole().publishMovie(this,Console.getConsole().tempPublished,Console.getConsole().tempPrivateShared,this._temp_is_redirect);
      }
      
      override public function initialize() : void
      {
         var target:PublishWindow = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._PublishWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PublishWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDescription() : TextArea
      {
         return this._143330933_txtDescription;
      }
      
      public function ___btnSaveNShare_click(param1:MouseEvent) : void
      {
         this.onSaveAndShareBtnClick();
      }
      
      private function doModifyDescription() : void
      {
         Console.getConsole().tempMetaData.description = this._txtDescription.text;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMovieTitle() : TextArea
      {
         return this._12195225_txtMovieTitle;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtSaveAs() : Label
      {
         return this._324236192_txtSaveAs;
      }
      
      private function _PublishWindow_Glow1_c() : Glow
      {
         var _loc1_:Glow = new Glow();
         _loc1_.duration = 1500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0.5;
         _loc1_.blurXFrom = 14;
         _loc1_.blurYFrom = 14;
         _loc1_.blurXTo = 14;
         _loc1_.blurYTo = 14;
         _loc1_.color = 3713279;
         _loc1_.strength = 10;
         return _loc1_;
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.onSaveBtnClick();
      }
      
      private function allowDraftOnly() : void
      {
         this._published = false;
         this._pShared = false;
         this._radioPublish.enabled = false;
         this._radioPublish.selected = false;
         this.setTempPublished();
      }
      
      public function ___publishForm_saveAsPublic(param1:Event) : void
      {
         this.onSaveAsPublic();
      }
      
      public function ___cbGroup_change(param1:ListEvent) : void
      {
         this.doModifyGroup();
      }
      
      public function set _txtTagsAdd(param1:Text) : void
      {
         var _loc2_:Object = this._1959512361_txtTagsAdd;
         if(_loc2_ !== param1)
         {
            this._1959512361_txtTagsAdd = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTagsAdd",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _pShared() : Boolean
      {
         return this._1154689974_pShared;
      }
      
      private function _PublishWindow_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","pubwin_title");
         _loc1_ = UtilDict.toDisplay("go","pubwin_subtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_movietitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = UtilDict.toDisplay("go","pubwin_tags");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = UtilDict.toDisplay("go","pubwin_tagsub");
         _loc1_ = UtilDict.toDisplay("go","Group");
         _loc1_ = UtilDict.toDisplay("go","pubwin_required");
         _loc1_ = UtilDict.toDisplay("go","pubwin_description");
         _loc1_ = UtilDict.toDisplay("go","pubwin_movielang");
         _loc1_ = this.LANG_ARRAY;
         _loc1_ = UtilDict.toDisplay("go","pubwin_movielangsub");
         _loc1_ = UtilDict.toDisplay("go","pubwin_pickthumb");
         _loc1_ = this._vsCaptures.selectedIndex + 1 + "/" + this._captures.length;
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveas");
         _loc1_ = UtilDict.toDisplay("go","pubwin_draft");
         _loc1_ = UtilDict.toDisplay("go","pubwin_publish");
         _loc1_ = UtilDict.toDisplay("go","pubwin_psharing");
         _loc1_ = UtilDict.toDisplay("go","pubwin_public");
         _loc1_ = UtilDict.toDisplay("go","pubwin_private");
         _loc1_ = UtilDict.toDisplay("go","pubwin_parent");
         _loc1_ = UtilDict.toDisplay("go","Create groups of students to enable publishing your animations.");
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveonly");
         _loc1_ = UtilDict.toDisplay("go","pubwin_saveonlytips");
         _loc1_ = UtilUser.loggedIn;
         _loc1_ = UtilDict.toDisplay("go","pubwin_warningtitle");
         _loc1_ = this._shareBtnBgEffect;
         _loc1_ = this._shareBtnBgEffect;
         _loc1_ = UtilDict.toDisplay("go","Close");
      }
      
      [Bindable(event="propertyChange")]
      public function get _shareBtnBgEffect() : Parallel
      {
         return this._284436046_shareBtnBgEffect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _groupAlert() : VBox
      {
         return this._1952108612_groupAlert;
      }
      
      public function set _tip(param1:Button) : void
      {
         var _loc2_:Object = this._2944988_tip;
         if(_loc2_ !== param1)
         {
            this._2944988_tip = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tip",_loc2_,param1));
         }
      }
      
      private function _PublishWindow_RadioButtonGroup2_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this._sharingOption = _loc1_;
         _loc1_.addEventListener("itemClick",this.___sharingOption_itemClick);
         _loc1_.initialized(this,"_sharingOption");
         return _loc1_;
      }
      
      private function initGroupComboBox() : void
      {
         var _loc1_:int = 0;
         var _loc6_:Boolean = false;
         var _loc2_:Array = Console.getConsole().groupController.getGroups();
         var _loc3_:Group = Console.getConsole().groupController.currentGroup;
         if(_loc3_.id != "0")
         {
            _loc6_ = false;
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(Group(_loc2_[_loc1_]).id == _loc3_.id)
               {
                  _loc6_ = true;
               }
               _loc1_++;
            }
            if(!_loc6_)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("name");
         var _loc4_:ArrayCollection = new ArrayCollection();
         var _loc5_:Number = 0;
         if(_loc2_.length > 0)
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","Please select group"),
               "data":"-1"
            });
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               _loc4_.addItem({
                  "label":Group(_loc2_[_loc1_]).name,
                  "data":Group(_loc2_[_loc1_]).id
               });
               if(_loc3_ != null && _loc3_.id == Group(_loc2_[_loc1_]).id)
               {
                  Console.getConsole().groupController.tempCurrentGroup = _loc3_;
                  _loc5_ = _loc1_ + 1;
               }
               _loc1_++;
            }
            this._vsSaveAdditional.visible = false;
         }
         else
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","No existing group"),
               "data":"0"
            });
            Console.getConsole().groupController.tempCurrentGroup = new Group();
            this._lbGroupRequired.visible = false;
            this._vsSaveAdditional.visible = true;
            this._vsSaveAdditional.selectedChild = this._groupAlert;
            this.allowDraftOnly();
         }
         this._cbGroup.dataProvider = _loc4_;
         this._cbGroup.selectedIndex = _loc5_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _langBox() : ComboBox
      {
         return this._1988842562_langBox;
      }
      
      public function set _radioPrivate(param1:RadioButton) : void
      {
         var _loc2_:Object = this._230640921_radioPrivate;
         if(_loc2_ !== param1)
         {
            this._230640921_radioPrivate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPrivate",_loc2_,param1));
         }
      }
      
      private function drawWhiteBorder() : void
      {
         this._shareBtnBg.graphics.clear();
         this._shareBtnBg.graphics.beginFill(16777215);
         this._shareBtnBg.graphics.drawRoundRect(-1,-1,this._shareBtnBg.width + 2,34,10,10);
         this._shareBtnBg.graphics.endFill();
      }
      
      public function ___shareBtnBg_resize(param1:ResizeEvent) : void
      {
         this.drawWhiteBorder();
      }
      
      public function set _shareBtnBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._726431551_shareBtnBg;
         if(_loc2_ !== param1)
         {
            this._726431551_shareBtnBg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_shareBtnBg",_loc2_,param1));
         }
      }
      
      public function set _savingOption(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1150463470_savingOption;
         if(_loc2_ !== param1)
         {
            this._1150463470_savingOption = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_savingOption",_loc2_,param1));
         }
      }
      
      private function onSaveMovieFromMusicPanel() : void
      {
         this.doSaveMovie(true,true);
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      public function ___btnPrev_click(param1:MouseEvent) : void
      {
         this.prevThumbnail();
      }
      
      private function onSaveMovieComplete(param1:Event) : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
      }
      
      public function set _soundForm(param1:MusicPanel) : void
      {
         var _loc2_:Object = this._993142004_soundForm;
         if(_loc2_ !== param1)
         {
            this._993142004_soundForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundForm",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _savingOption() : RadioButtonGroup
      {
         return this._1150463470_savingOption;
      }
      
      public function set _vbGroup(param1:VBox) : void
      {
         var _loc2_:Object = this._1710757388_vbGroup;
         if(_loc2_ !== param1)
         {
            this._1710757388_vbGroup = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbGroup",_loc2_,param1));
         }
      }
      
      private function prevThumbnail() : void
      {
         if(this._vsCaptures.selectedIndex > 0)
         {
            this._vsCaptures.selectedIndex = this._vsCaptures.selectedIndex - 1;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == 0)
            {
               this.enableButton(this._btnPrev,false);
            }
            if(this._btnNext.enabled == false)
            {
               this.enableButton(this._btnNext,true);
            }
         }
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
         }
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      [Bindable(event="propertyChange")]
      public function get _tip() : Button
      {
         return this._2944988_tip;
      }
   }
}
