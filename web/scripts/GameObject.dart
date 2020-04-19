import "dart:html";

import 'Player.dart';
import 'Vector.dart';
import 'Game.dart';

abstract class GameObject{
  int x;
  int y;
  int xSize;
  int ySize;
  Game game;
  GameObject(this.x, this.y, this.xSize, this.ySize, this.game);
  void draw(CanvasRenderingContext2D ctx);
  static double getRenderX(int x, CanvasRenderingContext2D ctx, Player p){
    double ret = (ctx.canvas.width/2 - p.x - p.xSize/2) + x;
    return ret;
  }
  static double getRenderY(int y, CanvasRenderingContext2D ctx, Player p){
    double ret = (ctx.canvas.height/2 - p.y - p.ySize/2) + y;
    return ret;
  }
}

abstract class GameEntity extends GameObject{
  GameEntity(x, y, xSize, ySize, game) : super(x, y, xSize, ySize, game);
  Vector moveVector;
  Vector shootVector;
  void collisionEffects(GameEntity origin, GameEntity effectee){
  }
}

abstract class GameMob extends GameEntity{
  GameMob(x, y, xSize, ySize, game) : super(x, y, xSize, ySize, game);
  Vector moveVector;
  Vector shootVector;
  int health;
}