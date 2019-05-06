unit IGRJeu;

{
    ____   ______      __     ____  __          __  __            
   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ 
   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \
 _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /
/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ 
                                      /____/                      
}


Interface

uses sdl, sdl_mixer_nosmpeg, crt, sysutils, DateUtils, keyboard, IGRTypes, IGRInterface, IGRSon, IGRScore;


procedure lancementPartie(player : Joueur; var tabScores : HighScores; var finPartie : Boolean; var sound : pMIX_MUSIC);
procedure initTab(music : String; var tab : TabMusic);
procedure partie(var sound : pMIX_MUSIC; musique : String; tab : TabMusic; var score : Word);
procedure verifTouche(var tab : TabMusic; i : Word; deb : TDateTime; var score, compteur, b : Word);



Implementation


procedure lancementPartie(player : Joueur; var tabScores : HighScores; var finPartie : Boolean; var sound : pMIX_MUSIC);
var musique : String;
	niveau : Word; 
	tab : TabMusic;
	score : Word;
	nbScores : Word;
begin

	score := 0;
	nbScores := 0;
	
	
	difficulte(niveau, player);
	choixMusique(niveau, musique);
	afficherHighscores(musique, player, tabScores, nbScores);
	
	sleep(3000);
	stopSon(sound);
	clrscr;
	

	initTab(musique,tab);
	afficherInterface;
	compteRebours();
	partie(sound, musique, tab, score);
	sleep(2000);
	clrscr;
	
	stockageScore(player, score, tabScores, nbScores, musique);
	afficherHighscores(musique, player, tabScores, nbScores);
	afficherScore(score);
	sleep(2000);

	nouvellePartie(finPartie, player);
	
	stopSon(sound);
end;





{initialise le tableau de touche en allant chercher les données dans le fichier de la musique sélectionnée}
procedure initTab(music : String; var tab : TabMusic);
var i : Integer;
	fichier : file of Touche;
begin

	i := 0;
	assign(fichier, 'donnees/' + music + '.song');
	reset(fichier);
	
	while not eof(fichier) do
		begin
			i := i + 1;
			read(fichier, tab[i]); //met les informations dans le tableau
			tab[i].visible := False;  //on initialise tous les booléens de visibilité à faux

		
			case tab[i].key of  // donne les positions X en fonction de la lettre trouvée dans le fichier
				'c' : tab[i].posX := 30;
				'v' : tab[i].posX := 34;
				'b' : tab[i].posX := 38;
				'n' : tab[i].posX := 42;
				'?' : tab[i].posX := 46;
			end;
			
			tab[i].posY := 2;   //initialise tous les Y à 2
			
		end;
end;
		
		
		
{partie de jeu, permet de savoir quelle donnée il faut afficher et tester les touches appuyées / compter le score}	
procedure partie(var sound : pMIX_MUSIC; musique : String; tab : TabMusic; var score : Word);
var i, minVis, maxVis : Word;
	deb : TDateTime;
	compteur, b : Word;
	fin : Boolean;
begin

	minVis := 1;
	compteur := 0;
	b := 1;
	son(sound, musique);
	
	deb := Now;
	
	
	while not(tab[minVis].visible) do  //on attend que la première touche soit visible
		begin
		if (MilliSecondsBetween(Now, Deb) > tab[minVis].temps - (18*50)) then    //18*50 correspond au temps laissé pour que la brique descende la totalité de la colonne
			begin
				tab[minVis].visible := True;
				maxVis := 1;
			end;
		end;
	
	
	repeat
	
	
		if (tab[minVis].visible = False) and ((maxVis - minVis) > 0) then
				minVis := minVis + 1;   //si le minimum visible n'est plus visible alors on passe au rang suivnat pour la borne minimal
				
	
	
	
		if (MilliSecondsBetween(Now, Deb) > tab[maxVis + 1].temps - (18*50)) then  // si le temps de la prochaine touche visible est dépassé alors on la met visible et augmente maxVis de 1
			begin
				maxVis := maxVis + 1;
				tab[maxVis].visible := True;
			end;
	
	
				GotoXY(1,1);   //on affiche en haut à gauche le temps, le score et le multiplicateur
				write(trunc(MilliSecondsBetween(Now, deb)/1000/60),'min ', trunc((MilliSecondsBetween(Now, deb)/1000/60 - trunc(MilliSecondsBetween(Now, deb)/1000/60))*60),'s ');
				GotoXY(1,2);
				write('Score : ', score);
				GotoXY(1,3);
				write('Multiplicateur : x',b);

		
			
		for i := minVis to maxVis do  //Entre les deux bornes visibles, on affiche les briques et on descend d'un leur position Y à chaque fois
			begin
	
				if tab[i].temps = 0 then
					fin := True;
					
				if (MilliSecondsBetween(Now, deb) > tab[i].temps) then
					begin
						tab[i].visible := False;
	
						GotoXY(tab[i].posX, tab[i].posY);
						if not(fin) then
							write('-');
						if (tab[i].appui = False) then  //si on a oublié d'appuyer sur la touche alors le compteur repart à zéro et le bonus à 1
							begin
								compteur := 0;
								b := 1;
							end;
					end
					
				else 
					begin
					
					
						GotoXY(tab[i].posX, tab[i].posY - 1);
						write(' ');
						GotoXY(tab[i].posX, tab[i].posY);
						write('=');
					
						//On descend a chaque fois la brique d'une position sauf si elle est déjà en bas 
					
						 if tab[i].posY + 1 <= 18 then
							tab[i].posY := tab[i].posY + 1;
	
				
	
					end;
				verifTouche(tab, i, deb, score, compteur, b);   //On teste si la touche appuyée est la bonne si oui le score augmente et le compteur aussi
			
			end;
		delay(50);
	
		
		
	until (fin);

	
		
		
end;



{vérifie si les touches sont bien appuyées et calcule le score correspondant avec le bonus}
procedure verifTouche(var tab : TabMusic; i : Word; deb : TDateTime; var score, compteur, b : Word);
var keyPressed : TKeyEvent;
	touche : Char;
begin

	If PollKeyEvent <> 0 then		//si une touche est appuyée
		begin
			keyPressed := GetKeyEvent;
			
			touche := GetKeyEventChar(TranslateKeyEvent(keyPressed));
	
			if (touche = 'c') or (touche = 'v') or (touche = 'b') or (touche = 'n') or (touche = ',') then //si touche appyée est parmi C V B N ,
				begin
					if touche = ',' then touche := '?';  
					if  (MilliSecondsBetween(deb, Now) < tab[i].temps + 100) and (MilliSecondsBetween(deb, Now) > tab[i].temps - 100) and (touche = tab[i].key) then
						begin
							tab[i].appui := True;   //Le booleen devient vrai et on augmente le score et le compteur
							score := score + 1 * b;
							compteur := compteur + 1;
							case compteur of   // en fonction du compteur on a un coefficient multiplicateur b pour le score
								2 : b := 2;
								4 : b := 3;
								6 : b := 4;
							end;
		
						end	
					else    //sinon le compteur revient à 0 et b à 1
						begin
							compteur := 0;
							b := 1;
						end;
				end;
		
		end;
end;






END.
