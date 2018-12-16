program musicGen;
uses DateUtils, crt, sysutils, keyboard, IGRTypes;



var fichier : file of Touche;
	deb : TDateTime;
	tab : TabMusic;
	i, j : Word;
	k : TKeyEvent;
	touche : Word;
	toucheChar, newTouche : Char;
	musique : String;

BEGIN

randomize;

toucheChar := ' ';
newTouche := ' ';
i := 1;


writeln('Quel est le titre de la musique?');
readln(musique);

assign(fichier, musique + '.song');



	



for j := 1 to MAX do
	tab[i].temps := 0;



writeln('Appuyez sur espace pour lancer le timer');

while GetKeyEventChar(TranslateKeyEvent(GetKeyEvent())) <> ' ' do
	sleep(1);
	
writeln('go');
deb := Now;

repeat
	
	k := GetKeyEvent;


	
		case  GetKeyEventChar(TranslateKeyEvent(k)) of
			' ' : 		begin
						tab[i].temps := MilliSecondsBetween(deb, Now);
						writeln(tab[i].temps);
						
						i := i + 1;
						end;

		end;

		

until GetKeyEventCode(k) = 7181;


for i := 1 to MAX do
	begin
	if tab[i].temps <> 0 then
		begin
			while newTouche = toucheChar do
				begin
					touche := random(5) + 1;
						case touche of 
							1 : newTouche := 'c';
							2 : newTouche := 'v';
							3 : newTouche := 'b';
							4 : newTouche := 'n';
							5 : newTouche := '?';
						end;
				end;
			toucheChar := newTouche;
			tab[i].key := toucheChar;
		end;
	end;



rewrite(fichier);
for i := 1 to MAX do
	write(fichier,tab[i]);
close(fichier);




END.
