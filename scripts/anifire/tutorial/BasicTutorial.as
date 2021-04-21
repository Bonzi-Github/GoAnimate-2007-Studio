package anifire.tutorial
{
   import flash.events.MouseEvent;
   
   public class BasicTutorial extends TutorialObject
   {
       
      
      public function BasicTutorial()
      {
         super();
         _data = <tutorial>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 200}">
						{"Welcome to the GoAnimate Animation Studio, where you can easily make your own cartoons.\n\nSince this is the first time you are here, we should go through a short tutorial to show you the basics.  Let\'s get started!"}
					</message>
					<uncover>
					</uncover>		
					<guide visible="true" action="talk01" facial="head_talk_happy"/>	
					<event type="{MouseEvent.CLICK}"/>			
				</step>
				<step>
					<message x="54" y="128">
						{"Select the Background Tab"}
					</message>
					<uncover>
						<rect x="105" y="49" w="49" h="40"/>
					</uncover>	
					<focus x="130" y="67"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.BG_TAB_SELECTED}"/>
				</step>
				<step>
					<message x="53" y="404">
						{"Let\'s select a location for your cartoon.  Drag a background to the stage"}
					</message>
					<uncover>
						<rect x="7" y="101" w="294" h="370"/>
						<rect x="356" y="58" w="553" h="355"/>
					</uncover>	
					<focus x="184" y="253"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.BG_ADDED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT}">
						{"Nicely done!  Next, we should select a main character for your story."}
					</message>
					<uncover>
			
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="100" y="40">
						{"Select the Character Tab"}
					</message>
					<uncover>
						<rect x="5" y="48" w="46" h="40"/>
					</uncover>	
					<focus x="28" y="68"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_TAB_SELECTED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT}">
						{"Right now, there are already a few characters in your tray.  You can always add more characters using the Character Creator."}
					</message>
					<uncover>
			
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="15" y="240">
						{"Drag a character to the stage"}
					</message>
					<uncover>
						<rect x="7" y="101" w="294" h="338"/>
						<rect x="356" y="58" w="553" h="355"/>
					</uncover>	
					<focus x="144" y="178"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_ADDED}"/>
				</step>
				<step>
					<message x="464" y="419">
						{"Click on your character"}
					</message>
					<uncover>
						<rect x="356" y="58" w="553" h="355"/>
					</uncover>	
					<focus target="lastAddedCharacter"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_SELECTED}"/>
				</step>
				<step>
					<message x="25" y="473">
						{"Enter some text, select a voice, and hit \'Add Voice\'"}
					</message>
					<uncover>
						<rect x="15" y="173" w="273" h="284"/>
					</uncover>	
					<focus x="135" y="235"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.TTS_ADDED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 50}">
						{"Congratulations, you just used the text-to-voice function.  Very easy, isn\'t it?\n\nNotice whenever you use text-to-voice, your character\'s talk action automatically gets selected."}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 50}">
						{"Now, let\'s continue your story.  To add more actions and have longer conversations, we need to have more scenes.\n\nThink of scenes as frames in a comic strip or storyboard."}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="460" y="504">
						{"Click on \'Add Scene\'"}
					</message>
					<uncover>
						<rect x="815" y="443" w="99" h="18"/>
					</uncover>	
					<focus x="860" y="455"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.SCENE_ADDED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 200}">
						{"Good!  Each character can perform one action per scene.  Also, each scene can only have a person speaking.  Remember a scene is like a frame in a comic strip.\n\nYou now have 2 scenes in your video and we are looking at Scene 2.   Let\'s look at how to control your character."}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="464" y="419">
						{"Click on your character"}
					</message>
					<uncover>
						<rect x="356" y="58" w="553" h="355"/>
					</uncover>	
					<focus target="lastAddedCharacter"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_SELECTED}"/>
				</step>
				<step>
					<message x="52" y="86">
						{"Click the Flip button to have your character face left or right"}
					</message>
					<uncover>
						<rect x="161" y="12" w="36" h="37"/>
					</uncover>	
					<focus x="178" y="32"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_FLIPPED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT}">
						{"Cool, you just changed the direction your character is facing."}
					</message>
					<uncover>
			
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="29" y="191">
						{"To perform an action, click on the Actions Tab"}
					</message>
					<uncover>
						<rect x="24" y="106" w="85" h="26"/>
					</uncover>	
					<focus x="68" y="129"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.ACTION_TAB_SELECTED}"/>
				</step>
				<step>
					<message x="222" y="156">
						{"Select an action"}
					</message>
					<uncover>
						<rect x="18" y="140" w="268" h="258"/>
					</uncover>	
					<focus x="58" y="185"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_ACTION_CHANGED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT}">
						{"Nice acting skills!  Alright, now, let\'s say we want to change the voice we entered back in Scene 1."}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="102" y="555">
						{"Select Scene 1"}
					</message>
					<uncover>
						<rect x="80" y="473" w="861" h="51"/>
					</uncover>	
					<focus x="141" y="500"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.SCENE_SELECTED}"/>
				</step>
				<step>
					<message x="464" y="419">
						{"Click on your character"}
					</message>
					<uncover>
						<rect x="356" y="58" w="553" h="355"/>
					</uncover>	
					<focus target="lastAddedCharacter"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.CHARACTER_SELECTED}"/>
				</step>
				<step>
					<message x="114" y="191">
						{"Click on the Voice Tab"}
					</message>
					<uncover>
						<rect x="110" y="106" w="85" h="26"/>
					</uncover>	
					<focus x="153" y="129"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.VOICE_TAB_SELECTED}"/>
				</step>
				<step>
					<message x="25" y="473">
						{"Type something new and hit \'Update Voice\'"}
					</message>
					<uncover>
						<rect x="15" y="173" w="273" h="284"/>
					</uncover>	
					<focus x="135" y="235"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.TTS_ADDED}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT}">
						{"Great!  The voice has been updated.  This is looking like the beginning of a cool cartoon. It\'s time to preview what we have done so far."}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="talk01" facial="head_talk_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
				<step>
					<message x="390" y="83">
						{"Click on Preview"}
					</message>
					<uncover>
						<rect x="733" y="1" w="93" h="32"/>
					</uncover>	
					<focus x="784" y="17"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<event type="{TutorialEvent.PREVIEW_DONE}"/>
				</step>
				<step>
					<message x="{MESSAGE_BOX_X_DEFAULT}" y="{MESSAGE_BOX_Y_DEFAULT - 200}">
						{"That\'s pretty neat!  With GoAnimate, you can do lots more -\n\n* Record your voice\n* Upload your own music\n* Mix facial expressions with actions\n* Move characters behind props\n* Drag props for characters to hold\n\nAnyway, what we covered should be enough to get you started.  Don\'t hesitate to visit the forums if you need help.  Have fun!"}
					</message>
					<uncover>
					</uncover>	
					<guide visible="true" action="excited" facial="head_happy"/>
					<event type="{MouseEvent.CLICK}"/>
				</step>
			</tutorial>;
      }
   }
}
