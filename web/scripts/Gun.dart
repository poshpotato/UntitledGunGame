import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'GameObject.dart';
import 'Vector.dart';
import 'Game.dart';

class Gun{
  bool shooting = false;
  void shoot(GameEntity e){
    if(shooting == true){
      new Bullet(e.x, e.y, 10, 10, e.game, e.shootVector, 10);
    }
    new Timer(new Duration(milliseconds: 100), () => shoot(e));
  }
}

class Bullet implements GameEntity{
  void draw(CanvasRenderingContext2D ctx){
    ctx.fillRect(x-(xSize/2), y-(ySize/2), xSize, ySize);
    move();
  }
  int xSize;
  int ySize;
  int x;
  int y;
  int speed;
  Vector moveVector;
  Vector shootVector;
  Game game;
  Bullet(this.x, this.y, this.xSize, this.ySize, this.game, this.moveVector, this.speed){
    print("new bullet made");
    game.gameObjects.add(this);
    if(moveVector != new Vector.zero()) {
      moveVector = moveVector.norm() * speed;
    }
  }
  void move(){
    x += moveVector.x;
    y += moveVector.y;
    if(x > game.ctx.canvas.width || y > game.ctx.canvas.height || x < 0|| x < 0){
      game.gameObjects.remove(this);
    };
  }
}