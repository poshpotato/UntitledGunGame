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
}

abstract class GameEntity extends GameObject{
  GameEntity(x, y, xSize, ySize, game) : super(x, y, xSize, ySize, game);
  Vector moveVector;
  Vector shootVector;
  void move(){
    x += moveVector.x;
    y += moveVector.y;
  }
}