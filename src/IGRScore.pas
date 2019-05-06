unit IGRScore;

{
    ____   ______      __     ____  __          __  __            
   /  _/  / ________  / /_   / __ \/ /_  __  __/ /_/ /_  ____ ___ 
   / /   / / __/ __ \/ __/  / /_/ / __ \/ / / / __/ __ \/ __ `__ \
 _/ /   / /_/ / /_/ / /_   / _, _/ / / / /_/ / /_/ / / / / / / / /
/___/   \____/\____/\__/  /_/ |_/_/ /_/\__, /\__/_/ /_/_/ /_/ /_/ 
                                      /____/                      
}


Interface
uses sysutils, crt, IGRTypes;

procedure afficherScore(score : Word);
procedure afficherHighscores(musique : String; var player : Joueur; var tabScores : HighScores; var nbScores : Word);
procedure stockageScore(player : Joueur; score : Word; var tabScores : Highscores; nbScores : Word; musique : String);


Implementation



{affiche le score du joueur}
procedure afficherScore(score : Word);
begin
GotoXY(30, 25);
writeln('Vous avez fait : ', score);
end;



{va chercher les données des scores dans le fichier de la musique et les affiche}
procedure afficherHighscores(musique : String; var player : Joueur; var tabScores : HighScores; var nbScores : Word);
var fichier : File of Joueur;
	j : Word;
	
begin

	nbScores := 0;
	
	
	writeln('Liste des meilleurs scores :');
	writeln;

	writeln('Scores pour ' + musique +' :');
	writeln;
	
	
	assign(fichier, 'scores/' + musique + '_scores.dat');  // on assigne le fichier et s'il n'existe pas on le crée (idem pour dossier)
	if not(DirectoryExists('scores')) then
		CreateDir('scores');
	if not(FileExists('scores/' + musique + '_scores.dat')) then
	 
		rewrite(fichier)
		
	else reset(fichier);
	
	while not(eof(fichier)) do
		begin
			nbScores := nbScores + 1; //trouve la nb de scores stockés dans le tableau
			read(fichier, tabScores[nbScores]);
			writeln('- ', tabScores[nbScores].nom, ' : ', tabScores[nbScores].score);
			
		end;
	close(fichier);
	
	


	for j := 1 to nbScores do
		
	writeln;
	

end;



{ajoute le score du joueur dans le tableau des scores ordonnés décroissants en passant par un tableau temporaire}
procedure ajoutScoreTableau(player : Joueur; nbScores : Word; var tabScores : HighScores);
var i, j : Word;
	tabTempScores : HighScores;
begin
	
	i := 1;
	while (i < nbScores + 1) and (player.score < tabScores[i].score) do
		begin
			tabTempScores[i] := tabScores[i];
			i := i + 1;
		end;	
	tabTempScores[i] := player;
	
	if i < nbScores + 1 then
		for j := i to nbScores do
		tabTempScores[j + 1] := tabScores[j];
		

		
	for j := 1 to nbScores + 1 do
		tabScores[j] := tabTempScores[j];
		

end;



{enregistre le tableau des scores dans le fichier en ne gardant que les 5 meilleurs scores au maximum}
procedure stockageScore(player : Joueur; score : Word; var tabScores : Highscores; nbScores : Word; musique : String);
var fichier : File of Joueur;
	j : Integer;
begin

	player.score := score;
	
	assign(fichier, 'scores/' + musique + '_scores.dat');
	
	
	//ajoute le score dans le tableau
	ajoutScoreTableau(player, nbScores, tabScores);

	
	rewrite(fichier);
	
	if nbScores >= 5 then
		nbScores := 4;
		
		
	for j := 1 to nbScores + 1 do
		write(fichier, tabScores[j]);   //écrit les scores dans le fichier
		
		
	close(fichier);
	

end;



 


END.
