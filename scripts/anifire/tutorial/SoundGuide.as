package anifire.tutorial
{
   import flash.events.MouseEvent;
   
   public class SoundGuide extends TutorialObject
   {
       
      
      public function SoundGuide()
      {
         super();
         _data = <tutorial>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 175}">
						{"<b>Sounds in GoAnimate</b><br><br>The sound you selected will be added to the timeline below.<br><br>Click on it to stop it. Drag it around. Or pull the sides to shorten and lengthen it.<br><br>If you want to add your own music and sound effects, check the import button on top. You can import sounds from your computer or search extra ones online."}
					</message>
					<uncover>
					</uncover>		
					<focus target="lastAddedSound"/>
					<guide visible="false" action="stand" facial="head_talk_happy"/>	
					<event type="{MouseEvent.CLICK}"/>			
				</step>
			</tutorial>;
      }
   }
}
