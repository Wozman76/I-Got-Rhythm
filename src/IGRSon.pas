unit IGRSon; {$MODE DELPHI}


{
    ____   ______      __     ____  __          __  __            
   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ 
   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \
 _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /
/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ 
                                      /____/                      
}

Interface
uses sdl, sdl_mixer_nosmpeg, sysutils;

CONST 	AUDIO_FREQUENCY:INTEGER=22050;
		AUDIO_FORMAT:WORD=AUDIO_S16;
		AUDIO_CHANNELS:INTEGER=2;
		AUDIO_CHUNKSIZE:INTEGER=4096;

procedure son(var sound : pMIX_MUSIC; musique : String);
procedure stopSon(var sound : pMIX_MUSIC);


Implementation


{procédure pour donner les paramètres du son et lancer la musique}
procedure son(var sound : pMIX_MUSIC; musique : String);
begin

	
    if MIX_OpenAudio(AUDIO_FREQUENCY, AUDIO_FORMAT,AUDIO_CHANNELS, 
		AUDIO_CHUNKSIZE)<>0 then HALT;
	

	sound := MIX_LOADMUS(PChar('ressources/' + musique + '.mp3'));


    MIX_VolumeMusic(MIX_MAX_VOLUME);
    MIX_PlayMusic(sound, -1);
end;


procedure stopSon(var sound : pMIX_MUSIC);
begin
	MIX_FREEMUSIC(sound);
	Mix_CloseAudio();
end;



END.
