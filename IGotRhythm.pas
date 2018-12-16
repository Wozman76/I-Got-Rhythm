program IGotRhythm;

{
    ____   ______      __     ____  __          __  __            
   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ 
   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \
 _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /
/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ 
                                      /____/                      
}


uses sdl, sdl_mixer_nosmpeg, crt, sysutils, keyboard,   {$ifdef Unix} unix, {$endif} IGRTypes, IGRInterface, IGRSon, IGRJeu, IGRScore;




////////////////////////////////////////////////////////////////////////////////////////////


var niveau : Word;
	
	
	musique : String;
	player : Joueur;
	tabScores : HighScores;
	finPartie : Boolean;
	choixMenu : Word;
	nbScores : Word;
	sound : pMIX_MUSIC;

BEGIN

	finPartie := False;
	SDL_Init(SDL_INIT_AUDIO);
	son(sound, 'Invincible');
	
	
	{$ifdef Unix}
	SysUtils.ExecuteProcess('/usr/bin/tput', 'civis', []); ///enleve curseur
	{$endif}
	
	InitKeyBoard();

	startScreen;   //lance l'écran d'accueil
	joueur(player);   //récupérer nom du joueur

	repeat
		
		menu(choixMenu, player);

		
		case choixMenu of
			1 : lancementPartie(player, tabScores, finPartie, sound);  //lance la partie si le choix est 1
			2 : begin
					difficulte(niveau, player);  //demande difficulté
					choixMusique(niveau, musique);   //demande musique
					afficherHighscores(musique, player, tabScores, nbScores);   //affiche les meilleurs scores pour la musique sélectionnée
					writeln;
					writeln;
					writeln('Appuyez sur [ESPACE] pour continuer...');
	
					while GetKeyEventCode(GetKeyEvent()) <> 14624 do   //tant qu'on appuie pas sur [espace], le programme attend
						sleep(10);
				
					clrscr;
					
				end;
			3 : credits(sound);
			4 : begin
					finPartie := True;
					writeln;
					writeln('Au revoir, ' + player.nom);
				end;
		end;
		
		if not(choixMenu = 2) then
			son(sound, 'Invincible');
		
	until finPartie;

	stopSon(sound);
	DoneKeyboard();


END.
