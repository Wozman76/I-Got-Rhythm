unit IGRInterface;

{
    ____   ______      __     ____  __          __  __            
   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ 
   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \
 _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /
/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ 
                                      /____/                      
}


Interface
uses sdl, sdl_mixer_nosmpeg, crt, sysutils, keyboard, IGRTypes, IGRSon;

procedure startScreen();
procedure menu(var choixMenu : Word; player : Joueur);
procedure difficulte(var niveau : Word; player : Joueur);
procedure choixMusique(niveau : Word ; var musique : String);
procedure joueur(var player : Joueur);
procedure afficherInterface();
procedure nouvellePartie(var finPartie : Boolean; player : Joueur);
procedure compteRebours();
procedure credits(var sound : pMIX_MUSIC);


Implementation

{affiche l'écran de lancement du jeu}
procedure startScreen();
var x, y : Word;
begin

	x := 36;
	y := 8;
	
	clrscr;
	
	GotoXY(x, y + 1);
	writeln('    ____');
	GotoXY(x, y + 2);
	writeln('   /  _/');
	GotoXY(x, y + 3);
	writeln('   / /  ');
	GotoXY(x, y + 4);
	writeln(' _/ /   ');
	GotoXY(x, y + 5);
	writeln('/___/   ');
	
	sleep(700);
	clrscr;
	sleep(500);
	
	x := 30;

	GotoXY(x, y + 1);
	writeln('   ______      __ ');
	GotoXY(x, y + 2);
	writeln('  / ________  / /_');
	GotoXY(x, y + 3);
	writeln(' / / __/ __ \/ __/');
	GotoXY(x, y + 4);
	writeln('/ /_/ / /_/ / /_  ');
	GotoXY(x, y + 5);
	writeln('\____/\____/\__/  ');
	
	sleep(700);
	clrscr;
	sleep(500);
	
	x := 18;

	
	GotoXY(x, y + 1);
	writeln('    ____  __          __  __            ');
	GotoXY(x, y + 2);
	writeln('   / __ \/ /_  __  __/ /_/ /_  ____ ___ ');
	GotoXY(x, y + 3);
	writeln('  / /_/ / __ \/ / / / __/ __ \/ __ `__ \');
	GotoXY(x, y + 4);
	writeln(' / _, _/ / / / /_/ / /_/ / / / / / / / /');
	GotoXY(x, y + 5);
	writeln('/_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ ');
	GotoXY(x, y + 6);
	writeln('            /____/                      ');
	
	
	
	sleep(700);
	clrscr;
	sleep(500);
	
	
	x := 8;

	
	GotoXY(x, y + 1);
	writeln('    ____   ______      __     ____  __          __  __            ');
	GotoXY(x, y + 2);
	writeln('   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ ');
	GotoXY(x, y + 3);
	writeln('   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \');
	GotoXY(x, y + 4);
	writeln(' _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /');
	GotoXY(x, y + 5);
	writeln('/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ ');
	GotoXY(x, y + 6);
	writeln('                                      /____/                      ');
	
	sleep(2500);
	
	writeln;
	writeln;
	writeln('Appuyez sur [ESPACE] pour continuer...');
	
	while GetKeyEventCode(GetKeyEvent()) <> 14624 do //test si la touche appuyée est [espace]
		sleep(10);

	

end; 



{demande nom d'utilisateur}
procedure joueur (var player : Joueur);
begin

	clrscr;
	writeln('------------------------------ I Got Rhythm -------------------------------');
	writeln;
	writeln('Bonjour ! Quel est votre nom?');
	writeln;
	write('> ');
	readln(player.nom);

end;


{affiche le menu}
procedure menu(var choixMenu : Word; player : Joueur);
var y, j, nbMenu : Word;
	k : TKeyEvent;
	tab : MenuDiffTab;
begin

	y := 5;
	nbMenu := 4;
	tab[1] := 'Jouer';
	tab[2] := 'Highscores';
	tab[3] := 'Crédits';
	tab[4] := 'Quitter';
	
	clrscr;
	writeln('------------------------------ I Got Rhythm -------------------------------');
	writeln;
	writeln('Bonjour ' + player.nom + ' ! Que voulez-vous faire ?');
	writeln;
	TextBackground(White);
	TextColor(Black);
	writeln('- ' + tab[1]);
	TextBackground(Black);
	TextColor(LightGray);
	
	for j := 2 to nbMenu do
			writeln('- ' + tab[j]);
	
	
	repeat 
	
		k := GetKeyEvent;
		case GetKeyEventCode(k) of
			18432 : if (y > 5) then	y := y - 1;		//test si touche appuyée est [UP] et si possibilité de monter dans le menu
			20480 : if (y < 4 + nbMenu) then y := y + 1; //test si touche appuyée est [DOWN] et si possibilité de descendre dans le menu
		end;
		
		
		GotoXY(1,5);
			for j := 1 to nbMenu do
				if j = y - 4 then
					begin
						TextBackground(White);
						TextColor(Black);
						writeln('- ' + tab[j]);     //change couleur de la ligne sélectionnée
						TextBackground(Black);
						TextColor(LightGray);
						
	
					end
				else writeln('- ' + tab[j]);   //réécrit les autres lignes dans le style par défaut
	
		
	until GetKeyEventCode(k) = 7181;  //s'arrête lorsque la touche [entrée] est pressée
	
	choixMenu := y - 4; // récupère le numéro du menu pour savoir quelle procédure lancer




end;





{choix de la difficultée (même pricipe que pour le menu)}
procedure difficulte(var niveau : Word; player : Joueur);
var y, j : Word;
	k : TKeyEvent;
	tab : MenuDiffTab;
begin

	niveau := 0;
	y := 5;
	tab[1] := 'facile';
	tab[2] := 'moyen';
	tab[3] := 'difficile';
	
	
	clrscr;
	writeln('------------------------------ I Got Rhythm -------------------------------');
	writeln;
	writeln ('Quelle difficulté voulez-vous?');
	writeln;
	TextBackground(White);
	TextColor(Black);
	writeln('- ' + tab[1]);
	TextBackground(Black);
	TextColor(LightGray);
	writeln('- ' + tab[2]);
	writeln('- ' + tab[3]);
	
	
	repeat	
	
		k := GetKeyEvent;
		case GetKeyEventCode(k) of
			18432 : if (y > 5) then	y := y - 1;		
			20480 : if (y < 7) then y := y + 1;
		end;
		
		
	GotoXY(1,5);
		for j := 1 to 3 do
			if j = y - 4 then
				begin
					TextBackground(White);
					TextColor(Black);
					writeln('- ' + tab[j]);
					TextBackground(Black);
					TextColor(LightGray);
					

				end
			else writeln('- ' + tab[j]);
		
		
	until GetKeyEventCode(k) = 7181; 
	
	niveau := y - 4;
	
end;


{choix de la musique en fonction de la difficultée}
procedure choixMusique(niveau : Word ; var musique : String);
var ficMusniv : Text;
	i, j, y : Word;
	tab : TabListMusique;
	k : TKeyEvent;
begin
	
	clrscr;
	
	i := 0;
	y := 5;
	
	case niveau of //charge le fichier correspondant en fonction de la difficulté
		1 : assign(ficMusniv, 'listes/listeFacile.txt');
		2 : assign(ficMusniv, 'listes/listeMoyen.txt');
		3 : assign(ficMusniv, 'listes/listeDifficile.txt');
	end;
	


	reset(ficMusniv);
	writeln('------------------------------ I Got Rhythm -------------------------------');
	writeln;
	writeln('Quelle musique voulez-vous?');
	writeln;
	while not (eof(ficMusniv)) do  //lit le fichier et met les noms des musiques dans un tableau
		begin
			i := i + 1;
			readln(ficMusniv, tab[i]);
			if i = 1 then //affiche la première ligne en surbrillance
				begin
					TextBackground(White);
					TextColor(Black);
					writeln('- ' + tab[1]);
					TextBackground(Black);
					TextColor(LightGray);
					

				end
			else writeln('- ' + tab[i]);
		end;
	close(ficMusniv);
	
	
	
	repeat	
	
		k := GetKeyEvent;
		case GetKeyEventCode(k) of
			18432 : if (y > 5) then	y := y - 1;		
			20480 : if (y < i + 4) then y := y + 1;
		end;
		
		GotoXY(1,5);
		for j := 1 to i do   //affiche les noms des musique stockées dans le tableau, en surbrillance ou non
			if j = y - 4 then
				begin
					TextBackground(White);
					TextColor(Black);
					writeln('- ' + tab[j]);
					TextBackground(Black);
					TextColor(LightGray);
					

				end
			else writeln('- ' + tab[j]);
		
		
		
	until GetKeyEventCode(k) = 7181; 
	
	musique := tab[y - 4];
		

	writeln;
	writeln;
	writeln('Vous avez choisi la musique ', musique);
	sleep(1000);
	clrscr;

end;




{affiche grille de jeu}
procedure afficherInterface();
var i : Word;
begin

	for i := 1 to 17 do
		begin
			GotoXY(28,i);
			write('|   |   |   |   |   |');
		end;
		

	
	
	GotoXY(1,18);
	write('--------------------------------------------------------------------------------');

	GotoXY(28, 19);
	write('| C | V | B | N | ? |');


end;

{demande si la personne veut rejouer. Si la personne ne veut pas rejouer le programme s'arrête}
procedure nouvellePartie(var finPartie : Boolean; player : Joueur);
var choixFin : Boolean;
	k : TKeyEvent;
begin
	choixFin := False;
	writeln;
	writeln;
	writeln('Voulez-vous rejouer? o (oui) / n (non)');
	
	
	repeat
	
		k := GetKeyEvent;
		case GetKeyEventCode(k) of
			6255 :	begin
						finPartie := False;
						choixFin := True;
					end;
					
			12654 :	begin
						finPartie := True;
						choixFin := True;
					end;
		else writeln('Mauvaise touche...');
		end;
		
	until choixFin;
	
	if finPartie then
		begin
			writeln;
			writeln('Au revoir, ' + player.nom);
		end;


end;



{affiche le compte a rebours avant le début de la partie}
procedure compteRebours();
var i, x, y : Word;
begin
	x := 38; //positionne au milieu de la grille
	y := 12;
	sleep(1000);
	for i := 3 downto 1 do
		begin
			GotoXY(x,y);
			write(i);
			sleep(1000);
			GotoXY(x,y);
			write(' ');
		end;
	GotoXY(1,1);

end;



procedure credits(var sound : pMIX_MUSIC);
var fichier : Text;
	tab : TabCredit;
	i, j, k : Word;
	arret : Boolean;
begin

	i := 1;
	j := 1;
	
	stopSon(sound);
	son(sound, 'Theme');
	
	arret := False;
	assign(fichier, 'credits.txt');
	

	reset(fichier);
	
	while not(eof(fichier)) do
		begin
			readln(fichier, tab[i]);
			i := i + 1;
		end;
	
	close(fichier);
	
	
	repeat 
	
		clrscr;
		GotoXY(1,1);
		writeln('------------------------------ I Got Rhythm -------------------------------');
		GotoXY(1,3);
		
		for k := j to j + 20 do
			begin
			if tab[k] = 'FIN' then
					arret := True
			else writeln(tab[k]);
			end;
	
		sleep(300);
		j := j + 1;
	
	
	
	
	until arret;
	
	sleep(3000);
	
	
	end;



END.
