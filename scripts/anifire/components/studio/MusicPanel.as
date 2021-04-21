package anifire.components.studio
{
   import anifire.components.containers.SoundTileCell;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.core.Theme;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import flash.display.DisplayObjectContainer;
   import flash.errors.IOError;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.Tile;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   
   use namespace mx_internal;
   
   public class MusicPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _709177983_btnShowImport:Button;
      
      private var _1868749467_labelTag:Label;
      
      private var _973409099_popWindowCover:Canvas;
      
      private var _23394237_canUploadSound:Canvas;
      
      private var _1097932920_txtAssetTags:TextInput;
      
      private var _1867156258_publishAddSound:HBox;
      
      private var _905402271_uiTileSoundMusicThemes:Tile;
      
      private var _1373853913_txtTitle:TextInput;
      
      private var _382283995_tempUploadSound:Tile;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _file:FileReference;
      
      private var _2080614473_pleaseEnterTitle:Label;
      
      private var _325902852_canSoundTutorial:Canvas;
      
      private var _993142004_soundForm:VBox;
      
      private var _53440340_btnPopSubmit:Button;
      
      private var _814129551_popUpAlert:Label;
      
      private var _2096658579_labelTag2:Label;
      
      private var _380890527_btnShowVideo:Button;
      
      private var _949564754_pageForm:Canvas;
      
      private var _1358079692_btnCommit:Button;
      
      mx_internal var _watchers:Array;
      
      private var _1383868793_btnBrowse:Button;
      
      public var _MusicPanel_Label1:Label;
      
      public var _MusicPanel_Label2:Label;
      
      public var _MusicPanel_Label3:Label;
      
      public var _MusicPanel_Label4:Label;
      
      public var _MusicPanel_Label5:Label;
      
      public var _MusicPanel_Label6:Label;
      
      public var _MusicPanel_Label7:Label;
      
      private var _filter:FileFilter;
      
      private var _1081336439_importView:ViewStack;
      
      private var _1479285453_txtFile:TextInput;
      
      private var _1472397637_btnSaveNShareSkipMusic:Button;
      
      private var _1416620697_txtTutorIntro:TextArea;
      
      private var _1554648078_pageBtn:Canvas;
      
      private var _680181914_userPublishUpload:VBox;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _589894064_ckPublic:CheckBox;
      
      private var _1325315106_popWindow:Canvas;
      
      private var _370236868_canSoundList:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _937704655_pageUploadDone:VBox;
      
      public function MusicPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"_soundForm",
                  "events":{"show":"___soundForm_show"},
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 8;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_MusicPanel_Label1",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"title",
                                 "percentWidth":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_MusicPanel_Label2",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"subTitle",
                                 "percentWidth":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_publishAddSound",
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 22;
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_canSoundList",
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalCenter = "1";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"canvasWhiteRoundRect",
                                          "height":310,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":VBox,
                                             "stylesFactory":function():void
                                             {
                                                this.verticalGap = 5;
                                                this.top = "5";
                                                this.bottom = "5";
                                                this.left = "5";
                                                this.right = "5";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalScrollPolicy":"off",
                                                   "horizontalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_MusicPanel_Label3",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                         this.color = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"subTitle",
                                                            "percentWidth":100
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Tile,
                                                      "id":"_uiTileSoundMusicThemes",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "label":"Music",
                                                            "width":292,
                                                            "percentHeight":100,
                                                            "horizontalScrollPolicy":"off"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_userPublishUpload",
                                    "stylesFactory":function():void
                                    {
                                       this.verticalGap = 22;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Canvas,
                                          "id":"_canUploadSound",
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"canvasWhiteRoundRect",
                                                "width":230,
                                                "height":130,
                                                "verticalScrollPolicy":"off",
                                                "horizontalScrollPolicy":"off",
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":VBox,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.horizontalAlign = "center";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "percentWidth":100,
                                                         "percentHeight":100,
                                                         "verticalScrollPolicy":"off",
                                                         "horizontalScrollPolicy":"off",
                                                         "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MusicPanel_Label4",
                                                            "stylesFactory":function():void
                                                            {
                                                               this.textAlign = "center";
                                                               this.color = 0;
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "styleName":"subTitle",
                                                                  "percentWidth":100
                                                               };
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":ViewStack,
                                                            "id":"_importView",
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "width":230,
                                                                  "percentHeight":100,
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":Canvas,
                                                                     "id":"_pageBtn",
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "percentWidth":100,
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Button,
                                                                              "id":"_btnShowImport",
                                                                              "events":{"click":"___btnShowImport_click"},
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.horizontalCenter = "1";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "styleName":"btnWhite",
                                                                                    "height":32,
                                                                                    "buttonMode":true
                                                                                 };
                                                                              }
                                                                           })]
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Canvas,
                                                                     "id":"_pageForm",
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "percentWidth":100,
                                                                           "percentHeight":100,
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":VBox,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "percentWidth":100,
                                                                                    "percentHeight":100,
                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                       "type":TextInput,
                                                                                       "id":"_txtFile",
                                                                                       "stylesFactory":function():void
                                                                                       {
                                                                                          this.fontSize = 12;
                                                                                          this.borderColor = 8947848;
                                                                                          this.borderThickness = 10;
                                                                                          this.themeColor = 8947848;
                                                                                       },
                                                                                       "propertiesFactory":function():Object
                                                                                       {
                                                                                          return {
                                                                                             "width":200,
                                                                                             "height":28,
                                                                                             "editable":false,
                                                                                             "styleName":"myTextInput"
                                                                                          };
                                                                                       }
                                                                                    }),new UIComponentDescriptor({
                                                                                       "type":Label,
                                                                                       "id":"_MusicPanel_Label5",
                                                                                       "stylesFactory":function():void
                                                                                       {
                                                                                          this.fontSize = 12;
                                                                                          this.color = 0;
                                                                                       }
                                                                                    }),new UIComponentDescriptor({
                                                                                       "type":HBox,
                                                                                       "propertiesFactory":function():Object
                                                                                       {
                                                                                          return {"childDescriptors":[new UIComponentDescriptor({
                                                                                             "type":Button,
                                                                                             "id":"_btnBrowse",
                                                                                             "events":{"click":"___btnBrowse_click"},
                                                                                             "propertiesFactory":function():Object
                                                                                             {
                                                                                                return {
                                                                                                   "width":80,
                                                                                                   "buttonMode":true,
                                                                                                   "styleName":"btnBlack"
                                                                                                };
                                                                                             }
                                                                                          }),new UIComponentDescriptor({
                                                                                             "type":Button,
                                                                                             "id":"_btnCommit",
                                                                                             "events":{"click":"___btnCommit_click"},
                                                                                             "propertiesFactory":function():Object
                                                                                             {
                                                                                                return {
                                                                                                   "width":89,
                                                                                                   "buttonMode":true,
                                                                                                   "styleName":"btnBlack"
                                                                                                };
                                                                                             }
                                                                                          })]};
                                                                                       }
                                                                                    })]
                                                                                 };
                                                                              }
                                                                           })]
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":VBox,
                                                                     "id":"_pageUploadDone",
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":230,
                                                                           "percentHeight":100,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_MusicPanel_Label6",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.textAlign = "center";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "styleName":"title",
                                                                                    "width":230
                                                                                 };
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":Tile,
                                                                              "id":"_tempUploadSound",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.verticalGap = 0;
                                                                                 this.horizontalCenter = "1";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "label":"Music",
                                                                                    "percentWidth":100,
                                                                                    "percentHeight":100,
                                                                                    "horizontalScrollPolicy":"off"
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
                                                })]
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Canvas,
                                          "id":"_canSoundTutorial",
                                          "stylesFactory":function():void
                                          {
                                             this.backgroundSize = "100%";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"canvasWhiteRoundRect",
                                                "width":230,
                                                "height":146,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":VBox,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.horizontalAlign = "center";
                                                      this.horizontalCenter = "1";
                                                      this.verticalCenter = "1";
                                                      this.verticalGap = 5;
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "percentWidth":100,
                                                         "percentHeight":100,
                                                         "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MusicPanel_Label7",
                                                            "stylesFactory":function():void
                                                            {
                                                               this.textAlign = "center";
                                                               this.color = 16742400;
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "styleName":"subTitle",
                                                                  "percentWidth":100
                                                               };
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"_txtTutorIntro",
                                                            "stylesFactory":function():void
                                                            {
                                                               this.fontSize = 12;
                                                               this.textAlign = "center";
                                                               this.backgroundAlpha = 0;
                                                               this.borderStyle = "none";
                                                               this.color = 0;
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "text":"",
                                                                  "styleName":"subTitle",
                                                                  "percentWidth":100,
                                                                  "wordWrap":true,
                                                                  "percentHeight":55,
                                                                  "selectable":false,
                                                                  "focusEnabled":false
                                                               };
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_btnShowVideo",
                                                            "events":{"click":"___btnShowVideo_click"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "styleName":"btnWhite",
                                                                  "height":32,
                                                                  "buttonMode":true
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
                              return {"height":8};
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
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"height":12};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_btnSaveNShareSkipMusic",
                                    "events":{"click":"___btnSaveNShareSkipMusic_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnWhite",
                                          "height":32,
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_popWindowCover",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 13421772;
                     this.backgroundAlpha = 0.55;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentHeight":100,
                        "percentWidth":100,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_popWindow",
                  "events":{
                     "show":"___popWindow_show",
                     "hide":"___popWindow_hide"
                  },
                  "stylesFactory":function():void
                  {
                     this.shadowDistance = 5;
                     this.backgroundColor = 16777215;
                     this.cornerRadius = 6;
                     this.borderStyle = "solid";
                     this.borderThickness = 3;
                     this.themeColor = 10724259;
                     this.borderColor = 11053224;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":252,
                        "width":400,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_popUpAlert",
                           "stylesFactory":function():void
                           {
                              this.fontWeight = "bold";
                              this.color = 16711680;
                              this.fontSize = 18;
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":99.5,
                                 "y":28,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_txtTitle",
                           "stylesFactory":function():void
                           {
                              this.themeColor = 16742400;
                              this.fontSize = 16;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":99.5,
                                 "y":97,
                                 "editable":true,
                                 "enabled":true,
                                 "width":212,
                                 "height":30
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_txtAssetTags",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 16;
                              this.themeColor = 16742400;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":99.5,
                                 "y":142,
                                 "editable":true,
                                 "width":212,
                                 "height":30
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_labelTag",
                           "stylesFactory":function():void
                           {
                              this.fontWeight = "bold";
                              this.fontSize = 18;
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":23.5,
                                 "y":143,
                                 "text":"Tags"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.fontWeight = "bold";
                              this.fontSize = 18;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":23.5,
                                 "y":98,
                                 "text":"Name"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":23.5,
                                 "y":52.5,
                                 "text":"Type: Sound - bg music"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.fontSize = 19;
                              this.fontWeight = "bold";
                              this.color = 0;
                              this.textDecoration = "normal";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":9,
                                 "y":3,
                                 "text":"Uploaded File Information"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_pleaseEnterTitle",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 17;
                              this.color = 9145227;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":162.5,
                                 "y":105,
                                 "text":"Please Enter a Title",
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_labelTag2",
                           "stylesFactory":function():void
                           {
                              this.fontWeight = "bold";
                              this.fontSize = 18;
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":23.5,
                                 "y":193,
                                 "text":"Tags",
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"_ckPublic",
                           "stylesFactory":function():void
                           {
                              this.fontWeight = "normal";
                              this.fontSize = 17;
                              this.themeColor = 16742400;
                              this.color = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":111.5,
                                 "y":190,
                                 "label":"Public",
                                 "selected":true,
                                 "enabled":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_btnPopSubmit",
                           "events":{"click":"___btnPopSubmit_click"},
                           "stylesFactory":function():void
                           {
                              this.themeColor = 16742400;
                              this.fontSize = 18;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":243.5,
                                 "y":195,
                                 "label":"Upload",
                                 "buttonMode":true,
                                 "enabled":true,
                                 "width":93
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___MusicPanel_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MusicPanel._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishAddSound() : HBox
      {
         return this._1867156258_publishAddSound;
      }
      
      public function upload() : void
      {
         var request:URLRequest = null;
         var variables:URLVariables = null;
         if(this._txtFile.text != "")
         {
            this._txtTitle.enabled = this._txtAssetTags.enabled = this._btnPopSubmit.enabled = false;
            CursorManager.setBusyCursor();
            variables = new URLVariables();
            Util.addFlashVarsToURLvar(variables);
            request = new URLRequest(ServerConstants.ACTION_SAVE_SOUND);
            variables["title"] = this._txtTitle.text;
            variables["keywords"] = this._txtAssetTags.text;
            variables["subtype"] = AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
            variables["type"] = AnimeConstants.ASSET_TYPE_SOUND;
            variables["is_published"] = !!this._ckPublic.selected?"1":"0";
            request.data = variables;
            request.method = URLRequestMethod.POST;
            try
            {
               this._file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this.onUploadCustomAssetComplete);
            }
            catch(e:Error)
            {
            }
            trace("request:" + request.url);
            trace("file:" + [this._file.name,this._file.size,this._file.type]);
            this._file.upload(request);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canSoundTutorial() : Canvas
      {
         return this._325902852_canSoundTutorial;
      }
      
      public function set _btnBrowse(param1:Button) : void
      {
         var _loc2_:Object = this._1383868793_btnBrowse;
         if(_loc2_ !== param1)
         {
            this._1383868793_btnBrowse = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBrowse",_loc2_,param1));
         }
      }
      
      private function init() : void
      {
         this.initAddingMusic();
         this._filter = new FileFilter(UtilDict.toDisplay("go","pubwin_soundfile"),"*.mp3;*.wav;*.m4a");
      }
      
      public function success(param1:SoundThumb) : void
      {
         CursorManager.removeBusyCursor();
         this._popWindow.visible = false;
         this._popWindowCover.visible = false;
         this._importView.selectedChild = this._pageUploadDone;
         this.addSoundTileCell(param1,this._tempUploadSound);
         this.deselectAllSoundTileCell();
         var _loc2_:SoundTileCell = SoundTileCell(ThumbnailCanvas(this._tempUploadSound.getChildAt(0)).getChildAt(0));
         ThumbnailCanvas(_loc2_.parent).clickPlay();
         _loc2_.data = "selected";
         _loc2_.dragSensor.graphics.clear();
         _loc2_.dragSensor.graphics.beginFill(16742400,0.5);
         _loc2_.dragSensor.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.dragSensor.graphics.endFill();
         this.updateSaveWithSoundBtn();
      }
      
      public function addSelectedSound() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc1_:Number = this._uiTileSoundMusicThemes.numChildren;
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               Console.getConsole().addSoundAtScene(Console.getConsole().currentScene,_loc5_.soundThumb,new Point(0,0),null,false);
               this.deselectAllSoundTileCell();
               return;
            }
            _loc2_++;
         }
         _loc1_ = this._tempUploadSound.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               Console.getConsole().addSoundAtScene(Console.getConsole().currentScene,_loc5_.soundThumb,new Point(0,0),null,false);
               this.deselectAllSoundTileCell();
               return;
            }
            _loc2_++;
         }
      }
      
      public function set _importView(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1081336439_importView;
         if(_loc2_ !== param1)
         {
            this._1081336439_importView = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_importView",_loc2_,param1));
         }
      }
      
      public function ___popWindow_show(param1:FlexEvent) : void
      {
         this._popWindowCover.visible = true;
      }
      
      public function deselectAllSoundTileCell(param1:SoundTileCell = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc2_:Number = this._uiTileSoundMusicThemes.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc3_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))) != param1)
            {
               _loc4_.clickStop();
               _loc5_.data = "";
               _loc5_.dragSensor.graphics.clear();
            }
            _loc3_++;
         }
         _loc2_ = this._tempUploadSound.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc3_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))) != param1)
            {
               _loc4_.clickStop();
               _loc5_.data = "";
               _loc5_.dragSensor.graphics.clear();
            }
            _loc3_++;
         }
      }
      
      public function set _pageBtn(param1:Canvas) : void
      {
         var _loc2_:Object = this._1554648078_pageBtn;
         if(_loc2_ !== param1)
         {
            this._1554648078_pageBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageBtn",_loc2_,param1));
         }
      }
      
      public function set _popUpAlert(param1:Label) : void
      {
         var _loc2_:Object = this._814129551_popUpAlert;
         if(_loc2_ !== param1)
         {
            this._814129551_popUpAlert = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popUpAlert",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _popWindow() : Canvas
      {
         return this._1325315106_popWindow;
      }
      
      public function initSoundList() : void
      {
         this.loadSoundThumbs(Console.getConsole().getCurTheme());
         this.loadSoundThumbs(Console.getConsole().getTheme("common"));
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageBtn() : Canvas
      {
         return this._1554648078_pageBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTitle() : TextInput
      {
         return this._1373853913_txtTitle;
      }
      
      public function ___btnSaveNShareSkipMusic_click(param1:MouseEvent) : void
      {
         this.onSaveMovieBtnClick();
      }
      
      private function initSoundTileCell(param1:FlexEvent) : void
      {
         var _loc2_:SoundTileCell = SoundTileCell(param1.currentTarget);
         _loc2_.getHitArea().addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
      }
      
      private function commit() : void
      {
         if(this._txtFile.text != "")
         {
            this._popWindow.visible = true;
            this._popWindowCover.visible = true;
            this._txtAssetTags.text = "";
            this._txtTitle.text = this._file.name.substring(0,this._file.name.lastIndexOf("."));
            this._ckPublic.selected = false;
            this._ckPublic.enabled = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageUploadDone() : VBox
      {
         return this._937704655_pageUploadDone;
      }
      
      public function setBtnStatus(param1:Boolean) : void
      {
         this.enableButton(this._btnSaveNShareSkipMusic,param1);
         this.enablingAllSoundTileCell(param1);
         if(this._userPublishUpload)
         {
            this._txtFile.enabled = param1;
            this.enableButton(this._btnBrowse,param1);
            this.enableButton(this._btnCommit,param1);
            this.enableButton(this._btnShowImport,param1);
            this.enableButton(this._btnShowVideo,param1);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCommit() : Button
      {
         return this._1358079692_btnCommit;
      }
      
      private function onSaveMovieBtnClick() : void
      {
         this.dispatchEvent(new Event("saveMovie"));
      }
      
      [Bindable(event="propertyChange")]
      public function get _pleaseEnterTitle() : Label
      {
         return this._2080614473_pleaseEnterTitle;
      }
      
      public function ___btnShowVideo_click(param1:MouseEvent) : void
      {
         this.showVideoTutorial();
      }
      
      [Bindable(event="propertyChange")]
      public function get _canSoundList() : Canvas
      {
         return this._370236868_canSoundList;
      }
      
      public function addSoundTileCell(param1:SoundThumb, param2:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc3_:SoundTileCell = param1.getTileCell().clone();
         _loc3_.buttonMode = true;
         _loc3_.removeEventListener(FlexEvent.CREATION_COMPLETE,param1.initTileCell);
         _loc3_.addEventListener(FlexEvent.CREATION_COMPLETE,this.initSoundTileCell);
         _loc4_ = param2;
         var _loc5_:ThumbnailCanvas = new ThumbnailCanvas(_loc3_.width,_loc3_.height,_loc3_,param1,false,false,false,"",true,1);
         _loc4_.addChild(_loc5_);
         if(_loc4_.numChildren % 2 != 0)
         {
            _loc3_.styleName = ThumbTray.STYLE_SOUND_TILE_1;
         }
         else
         {
            _loc3_.styleName = ThumbTray.STYLE_SOUND_TILE_2;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _pageForm() : Canvas
      {
         return this._949564754_pageForm;
      }
      
      public function set _popWindow(param1:Canvas) : void
      {
         var _loc2_:Object = this._1325315106_popWindow;
         if(_loc2_ !== param1)
         {
            this._1325315106_popWindow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popWindow",_loc2_,param1));
         }
      }
      
      public function ___btnPopSubmit_click(param1:MouseEvent) : void
      {
         this.upload();
      }
      
      public function onSoundMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:SoundTileCell = SoundTileCell(HBox(param1.currentTarget).parent);
         var _loc3_:HBox = HBox(param1.currentTarget);
         this.deselectAllSoundTileCell(_loc2_);
         if(_loc2_.data != "selected")
         {
            ThumbnailCanvas(_loc2_.parent).clickPlay(param1);
            _loc2_.data = "selected";
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(16742400,0.5);
            _loc3_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
            _loc3_.graphics.endFill();
         }
         else
         {
            ThumbnailCanvas(_loc2_.parent).clickStop(param1);
            _loc2_.data = "";
            _loc3_.graphics.clear();
         }
         this.updateSaveWithSoundBtn();
      }
      
      public function ___MusicPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnShowVideo() : Button
      {
         return this._380890527_btnShowVideo;
      }
      
      public function set _pageUploadDone(param1:VBox) : void
      {
         var _loc2_:Object = this._937704655_pageUploadDone;
         if(_loc2_ !== param1)
         {
            this._937704655_pageUploadDone = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageUploadDone",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelTag() : Label
      {
         return this._1868749467_labelTag;
      }
      
      public function ___popWindow_hide(param1:FlexEvent) : void
      {
         this._popWindowCover.visible = false;
      }
      
      public function set _btnPopSubmit(param1:Button) : void
      {
         var _loc2_:Object = this._53440340_btnPopSubmit;
         if(_loc2_ !== param1)
         {
            this._53440340_btnPopSubmit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPopSubmit",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTutorIntro() : TextArea
      {
         return this._1416620697_txtTutorIntro;
      }
      
      public function set _btnCommit(param1:Button) : void
      {
         var _loc2_:Object = this._1358079692_btnCommit;
         if(_loc2_ !== param1)
         {
            this._1358079692_btnCommit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCommit",_loc2_,param1));
         }
      }
      
      public function set _popWindowCover(param1:Canvas) : void
      {
         var _loc2_:Object = this._973409099_popWindowCover;
         if(_loc2_ !== param1)
         {
            this._973409099_popWindowCover = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_popWindowCover",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ckPublic() : CheckBox
      {
         return this._589894064_ckPublic;
      }
      
      [Bindable(event="propertyChange")]
      public function get _labelTag2() : Label
      {
         return this._2096658579_labelTag2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _userPublishUpload() : VBox
      {
         return this._680181914_userPublishUpload;
      }
      
      public function set _btnSaveNShareSkipMusic(param1:Button) : void
      {
         var _loc2_:Object = this._1472397637_btnSaveNShareSkipMusic;
         if(_loc2_ !== param1)
         {
            this._1472397637_btnSaveNShareSkipMusic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSaveNShareSkipMusic",_loc2_,param1));
         }
      }
      
      public function onUploadCustomAssetComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         if(Console.getConsole() != null)
         {
            if(param1 != null)
            {
               if(param1.type == DataEvent.UPLOAD_COMPLETE_DATA)
               {
                  _loc2_ = (param1 as DataEvent).data;
               }
               else
               {
                  _loc2_ = (param1.target as URLLoader).data;
               }
            }
            Console.getConsole().customAssetUploadCompleteHandler(_loc2_,AnimeConstants.ASSET_TYPE_SOUND);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundMusicThemes() : Tile
      {
         return this._905402271_uiTileSoundMusicThemes;
      }
      
      public function set _txtTitle(param1:TextInput) : void
      {
         var _loc2_:Object = this._1373853913_txtTitle;
         if(_loc2_ !== param1)
         {
            this._1373853913_txtTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTitle",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnShowImport() : Button
      {
         return this._709177983_btnShowImport;
      }
      
      public function set _canUploadSound(param1:Canvas) : void
      {
         var _loc2_:Object = this._23394237_canUploadSound;
         if(_loc2_ !== param1)
         {
            this._23394237_canUploadSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canUploadSound",_loc2_,param1));
         }
      }
      
      private function loadSoundThumbs(param1:Theme) : void
      {
         var _loc4_:SoundThumb = null;
         var _loc2_:Array = param1.soundThumbs.clone().getArray();
         _loc2_.sortOn("name",Array.CASEINSENSITIVE);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(!(!(_loc4_ = _loc2_[_loc3_] as SoundThumb).enable || _loc4_.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC))
            {
               trace("sThumb.sound:" + _loc4_.sound);
               this.addSoundTileCell(_loc4_,this._uiTileSoundMusicThemes);
            }
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBrowse() : Button
      {
         return this._1383868793_btnBrowse;
      }
      
      public function ___soundForm_show(param1:FlexEvent) : void
      {
         this.initAddingMusic();
      }
      
      [Bindable(event="propertyChange")]
      public function get _importView() : ViewStack
      {
         return this._1081336439_importView;
      }
      
      [Bindable(event="propertyChange")]
      public function get _popUpAlert() : Label
      {
         return this._814129551_popUpAlert;
      }
      
      public function set _pleaseEnterTitle(param1:Label) : void
      {
         var _loc2_:Object = this._2080614473_pleaseEnterTitle;
         if(_loc2_ !== param1)
         {
            this._2080614473_pleaseEnterTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pleaseEnterTitle",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:MusicPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._MusicPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MusicPanelWatcherSetupUtil");
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
      
      private function browse() : void
      {
         if(this._file == null)
         {
            this._file = new FileReference();
            this._file.addEventListener(Event.SELECT,this.onSelect);
         }
         try
         {
            this._file.browse([this._filter]);
         }
         catch(e:IOError)
         {
            throw new Error("IOError:" + e.getStackTrace());
         }
         catch(e:Error)
         {
            throw new Error("error: " + e.getStackTrace());
         }
      }
      
      private function enableButton(param1:Button, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 != null)
         {
            param1.enabled = param2;
            param1.buttonMode = param2;
         }
      }
      
      public function set _canSoundList(param1:Canvas) : void
      {
         var _loc2_:Object = this._370236868_canSoundList;
         if(_loc2_ !== param1)
         {
            this._370236868_canSoundList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canSoundList",_loc2_,param1));
         }
      }
      
      public function set _ckPublic(param1:CheckBox) : void
      {
         var _loc2_:Object = this._589894064_ckPublic;
         if(_loc2_ !== param1)
         {
            this._589894064_ckPublic = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ckPublic",_loc2_,param1));
         }
      }
      
      public function set _pageForm(param1:Canvas) : void
      {
         var _loc2_:Object = this._949564754_pageForm;
         if(_loc2_ !== param1)
         {
            this._949564754_pageForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pageForm",_loc2_,param1));
         }
      }
      
      public function ___btnCommit_click(param1:MouseEvent) : void
      {
         this.commit();
      }
      
      public function ___btnShowImport_click(param1:MouseEvent) : void
      {
         this._importView.selectedChild = this._pageForm;
      }
      
      public function ___btnBrowse_click(param1:MouseEvent) : void
      {
         this.browse();
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAssetTags() : TextInput
      {
         return this._1097932920_txtAssetTags;
      }
      
      private function _MusicPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","pubwin_astitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_assubtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_aslib");
         _loc1_ = UtilDict.toDisplay("go","pubwin_uploadtitle");
         _loc1_ = UtilDict.toDisplay("go","pubwin_import");
         _loc1_ = UtilDict.toDisplay("go","pubwin_max");
         _loc1_ = UtilDict.toDisplay("go","pubwin_browse");
         _loc1_ = UtilDict.toDisplay("go","pubwin_upload");
         _loc1_ = UtilDict.toDisplay("go","pubwin_importdone");
         _loc1_ = UtilDict.toDisplay("go","pubwin_learnmore");
         _loc1_ = UtilDict.toDisplay("go","pubwin_watch");
         _loc1_ = UtilDict.toDisplay("go","pubwin_savenosound");
         _loc1_ = UtilDict.toDisplay("go","pubwin_savensharetips");
         _loc1_ = this.width * 0.5 - 200;
         _loc1_ = this.height * 0.5 - 126;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPopSubmit() : Button
      {
         return this._53440340_btnPopSubmit;
      }
      
      private function updateSaveWithSoundBtn() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc1_:Number = this._uiTileSoundMusicThemes.numChildren;
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               _loc3_++;
            }
            _loc2_++;
         }
         _loc1_ = this._tempUploadSound.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc2_));
            if((_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).data == "selected")
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ > 0)
         {
            this._btnSaveNShareSkipMusic.label = UtilDict.toDisplay("go","pubwin_addnsave");
         }
         else
         {
            this._btnSaveNShareSkipMusic.label = UtilDict.toDisplay("go","pubwin_savenosound");
         }
      }
      
      private function onSelect(param1:Event) : void
      {
         this._txtFile.text = this._file.name;
         if(this._file.size > 7900000)
         {
            this.clearFileReference();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSaveNShareSkipMusic() : Button
      {
         return this._1472397637_btnSaveNShareSkipMusic;
      }
      
      public function set _publishAddSound(param1:HBox) : void
      {
         var _loc2_:Object = this._1867156258_publishAddSound;
         if(_loc2_ !== param1)
         {
            this._1867156258_publishAddSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishAddSound",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canUploadSound() : Canvas
      {
         return this._23394237_canUploadSound;
      }
      
      public function set _tempUploadSound(param1:Tile) : void
      {
         var _loc2_:Object = this._382283995_tempUploadSound;
         if(_loc2_ !== param1)
         {
            this._382283995_tempUploadSound = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tempUploadSound",_loc2_,param1));
         }
      }
      
      private function _MusicPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_astitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label1.text = param1;
         },"_MusicPanel_Label1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_assubtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label2.text = param1;
         },"_MusicPanel_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_aslib");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label3.text = param1;
         },"_MusicPanel_Label3.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_uploadtitle");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label4.text = param1;
         },"_MusicPanel_Label4.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_import");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnShowImport.label = param1;
         },"_btnShowImport.label");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_max");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label5.text = param1;
         },"_MusicPanel_Label5.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_browse");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnBrowse.label = param1;
         },"_btnBrowse.label");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_upload");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCommit.label = param1;
         },"_btnCommit.label");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_importdone");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label6.text = param1;
         },"_MusicPanel_Label6.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_learnmore");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MusicPanel_Label7.text = param1;
         },"_MusicPanel_Label7.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_watch");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnShowVideo.label = param1;
         },"_btnShowVideo.label");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_savenosound");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSaveNShareSkipMusic.label = param1;
         },"_btnSaveNShareSkipMusic.label");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_savensharetips");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnSaveNShareSkipMusic.toolTip = param1;
         },"_btnSaveNShareSkipMusic.toolTip");
         result[12] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width * 0.5 - 200;
         },function(param1:Number):void
         {
            _popWindow.x = param1;
         },"_popWindow.x");
         result[13] = binding;
         binding = new Binding(this,function():Number
         {
            return this.height * 0.5 - 126;
         },function(param1:Number):void
         {
            _popWindow.y = param1;
         },"_popWindow.y");
         result[14] = binding;
         return result;
      }
      
      public function set _btnShowVideo(param1:Button) : void
      {
         var _loc2_:Object = this._380890527_btnShowVideo;
         if(_loc2_ !== param1)
         {
            this._380890527_btnShowVideo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnShowVideo",_loc2_,param1));
         }
      }
      
      public function set _labelTag(param1:Label) : void
      {
         var _loc2_:Object = this._1868749467_labelTag;
         if(_loc2_ !== param1)
         {
            this._1868749467_labelTag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelTag",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _popWindowCover() : Canvas
      {
         return this._973409099_popWindowCover;
      }
      
      public function set _uiTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = this._905402271_uiTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._905402271_uiTileSoundMusicThemes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundMusicThemes",_loc2_,param1));
         }
      }
      
      public function set _txtTutorIntro(param1:TextArea) : void
      {
         var _loc2_:Object = this._1416620697_txtTutorIntro;
         if(_loc2_ !== param1)
         {
            this._1416620697_txtTutorIntro = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTutorIntro",_loc2_,param1));
         }
      }
      
      private function initAddingMusic() : void
      {
         var _loc1_:Canvas = null;
         if(UtilLicense.getCurrentLicenseId() == "7")
         {
            if(this._publishAddSound.getChildIndex(this._userPublishUpload) > 0)
            {
               this._publishAddSound.removeChild(this._userPublishUpload);
               _loc1_ = new Canvas();
               _loc1_.styleName = "domoMusic";
               _loc1_.width = 245;
               _loc1_.height = 310;
               this._publishAddSound.addChildAt(_loc1_,0);
            }
         }
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            if(this._publishAddSound.getChildIndex(this._userPublishUpload) > 0)
            {
               this._publishAddSound.removeChild(this._userPublishUpload);
            }
         }
         this._txtTutorIntro.text = UtilDict.toDisplay("go","pubwin_soundtutotialtips");
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtFile() : TextInput
      {
         return this._1479285453_txtFile;
      }
      
      public function clearFileReference() : void
      {
         if(this._file != null)
         {
            this._txtFile.text = "";
            this._file.cancel();
            this._file = null;
         }
      }
      
      public function set _userPublishUpload(param1:VBox) : void
      {
         var _loc2_:Object = this._680181914_userPublishUpload;
         if(_loc2_ !== param1)
         {
            this._680181914_userPublishUpload = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userPublishUpload",_loc2_,param1));
         }
      }
      
      private function enablingAllSoundTileCell(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ThumbnailCanvas = null;
         var _loc5_:SoundTileCell = null;
         var _loc2_:Number = this._uiTileSoundMusicThemes.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._uiTileSoundMusicThemes.getChildAt(_loc3_));
            (_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).dragSensor.enabled = param1;
            if(param1)
            {
               _loc5_.dragSensor.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            else
            {
               _loc5_.dragSensor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            _loc3_++;
         }
         _loc2_ = this._tempUploadSound.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ThumbnailCanvas(this._tempUploadSound.getChildAt(_loc3_));
            (_loc5_ = SoundTileCell(_loc4_.getChildAt(0))).dragSensor.enabled = param1;
            if(param1)
            {
               _loc5_.dragSensor.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            else
            {
               _loc5_.dragSensor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSoundMouseDown);
            }
            _loc3_++;
         }
      }
      
      public function set _soundForm(param1:VBox) : void
      {
         var _loc2_:Object = this._993142004_soundForm;
         if(_loc2_ !== param1)
         {
            this._993142004_soundForm = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundForm",_loc2_,param1));
         }
      }
      
      public function set _labelTag2(param1:Label) : void
      {
         var _loc2_:Object = this._2096658579_labelTag2;
         if(_loc2_ !== param1)
         {
            this._2096658579_labelTag2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labelTag2",_loc2_,param1));
         }
      }
      
      public function set _txtFile(param1:TextInput) : void
      {
         var _loc2_:Object = this._1479285453_txtFile;
         if(_loc2_ !== param1)
         {
            this._1479285453_txtFile = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtFile",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tempUploadSound() : Tile
      {
         return this._382283995_tempUploadSound;
      }
      
      public function set _txtAssetTags(param1:TextInput) : void
      {
         var _loc2_:Object = this._1097932920_txtAssetTags;
         if(_loc2_ !== param1)
         {
            this._1097932920_txtAssetTags = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAssetTags",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundForm() : VBox
      {
         return this._993142004_soundForm;
      }
      
      private function showVideoTutorial() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("showSoundTutorial");
         }
      }
      
      public function set _btnShowImport(param1:Button) : void
      {
         var _loc2_:Object = this._709177983_btnShowImport;
         if(_loc2_ !== param1)
         {
            this._709177983_btnShowImport = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnShowImport",_loc2_,param1));
         }
      }
      
      public function set _canSoundTutorial(param1:Canvas) : void
      {
         var _loc2_:Object = this._325902852_canSoundTutorial;
         if(_loc2_ !== param1)
         {
            this._325902852_canSoundTutorial = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canSoundTutorial",_loc2_,param1));
         }
      }
   }
}
