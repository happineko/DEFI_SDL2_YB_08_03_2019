
program defi;

uses SDL2, SDL2_image;

var
	Window : PSDL_Window;
    Sto : TSDL_Rect;
	Renderer : PSDL_Renderer;
	Rectangle : PSDL_Rect;
	gif : TSDL_Rect;
	Texture, gifT : PSDL_Texture;
	fond : PSDL_Texture;
	Event : PSDL_Event;
	exitloop : boolean = false;
	text : string = '';
    i : INTEGER;
	
BEGIN
	//initialisation du sous-systeme video
	if SDL_Init( SDL_INIT_VIDEO ) < 0 then HALT;
	
	//Création de la fenetre
	Window := SDL_CreateWindow( 'Window', 50, 50, 500, 500, SDL_WINDOW_FULLSCREEN_DESKTOP );
	if Window = nil then HALT;


	
	//création du moteur de rendu
	Renderer := SDL_CreateRenderer( Window, -1, 0 );
	if Renderer = nil then HALT;
	
	new( Rectangle );
	Rectangle^.x := 10; Rectangle^.y := 10; Rectangle^.w := 200; Rectangle^.h := 200;
	
	//Creation de figure geometrique
	
	SDL_SetRenderDrawColor( Renderer,255,0,0,255 );
	SDL_RenderDrawRect( Renderer, Rectangle );
	SDL_RenderDrawLine( Renderer, 310, 10, 210, 210 );
	SDL_RenderDrawLine( Renderer, 310, 10, 410, 210 );
	SDL_RenderDrawLine( Renderer, 210, 210, 410, 210 );
	SDL_RenderPresent( Renderer );
	SDL_Delay(2000);
	
	//Affichage d'un bitmap
	
	Texture := IMG_LoadTexture( Renderer, 'rider.bmp');
	if Texture = nil then HALT;
	SDL_RenderCopy( Renderer, Texture, nil, nil );
	SDL_RenderPresent( Renderer );
	SDL_Delay( 2000 );
	SDL_DestroyTexture( Texture );
	SDL_RenderClear(Renderer);
	
	//Affichage d'un helicoptere anime et controlable via le curseur de la souris
	
	GifT := IMG_LoadTexture ( Renderer, 'helicopter.png');
		if GifT = nil then HALT;
	fond := IMG_LoadTexture ( Renderer, 'jagoulou.jpg ');
	Sto.x := 0;
	Sto.y := 0;
	Sto.w := 128;
    Sto.h := 55;
	gif.w := 128;
	gif.h := 55;
	SDL_SetRenderDrawColor( Renderer,0,0,0,0 );
	SDL_RenderCopy(Renderer, fond, nil, nil);

  new( Event );
  while exitloop = false do
  begin
	if exitloop = false then
	begin	
		Sto.x := Sto.x+128;
               If (Sto.x > 384) Then //Si on dépasse la derniere frame
				begin
					Sto.x := 0; //repart à la 1ere frame
				end;
				SDL_RenderCopy(Renderer, fond, nil, nil);
				SDL_RenderCopy(Renderer, GifT, @Sto, @gif); //On met la Zone Sélectionnée dans le rectangle d'affichage
				SDL_RenderPresent(Renderer); //On Affiche le résultat ->
				SDL_Delay (1); //Pendant 0.001 secondes ->
				SDL_RenderClear(Renderer); //Puis on efface le résultat
	end;
    while SDL_PollEvent( Event ) = 1 do
    begin
		gif.x := Event^.motion.x - (128 div 2);
		gif.y := Event^.motion.y - (55 div 2);

	           

      case Event^.type_ of

        //keyboard events
        SDL_KEYDOWN:
		begin
			
			case Event^.key.keysym.sym of
				SDLK_ESCAPE: exitloop := true;  // exit on pressing ESC key

            end;
        end;
		SDL_MOUSEMOTION:
		begin
			
            writeln( 'X: ', Event^.motion.x, '   Y: ', Event^.motion.y,'   dX: ', Event^.motion.xrel, '   dY: ', Event^.motion.yrel );
        end;
      end;
    end;
    SDL_Delay( 20 );
  end;

  dispose( Event );
	
	//Libération de la memoire
	SDL_DestroyRenderer( Renderer );
	SDL_DestroyWindow ( Window );
	
	//Arret du sous-systeme video
	SDL_Quit;
end.
