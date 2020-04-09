import "dart:html";

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
  static double getRenderX(int x, CanvasRenderingContext2D ctx, GameObject p){
    double ret = (ctx.canvas.width/2 - p.x) + x;
    return ret;
  }
  static double getRenderY(int y, CanvasRenderingContext2D ctx, GameObject p){
    double ret = (ctx.canvas.height/2 - p.y) + y;
    return ret;
  }
}

abstract class GameEntity extends GameObject{
  GameEntity(x, y, xSize, ySize, game) : super(x, y, xSize, ySize, game);
  Vector moveVector;
  Vector shootVector;
}