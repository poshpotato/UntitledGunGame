import 'dart:html';

import 'Game.dart';
import 'GameObject.dart';

class Level{
  ImageElement levelImage;
  String imagePath;
  int width;
  int height;
  int x = 0;
  int y = 0;
  Game game;
  Level(this.game, this.imagePath){
    this.levelImage = new ImageElement(src : imagePath);
  }

  void draw(CanvasRenderingContext2D ctx){
    //BY BAGADIX I'VE GOT IT
    //ITS THE PLAYERS ACTUAL RENDERING POSITION - THE PLAYERS INTERNAL POSITION
    //ALL HAIL BAGADIX
    //(ctx.canvas.width - game.player.x)
    ctx.drawImage(levelImage, GameObject.getRenderX(x, ctx, game.player), GameObject.getRenderY(y, ctx, game.player));
  }
}