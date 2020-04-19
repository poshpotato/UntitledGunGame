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
      new Bullet(e.x, e.y, 10, 10, e.game, e.shootVector, 10, e);
      new Timer(new Duration(milliseconds: 100), () => shoot(e));
    }
  }
}

class Bullet implements GameEntity{
  void draw(CanvasRenderingContext2D ctx){
    ctx.fillStyle = "#000000";
    ctx.fillRect(GameObject.getRenderX(x, ctx, origin)-(xSize/2), GameObject.getRenderY(y, ctx, origin)-(ySize/2), xSize, ySize);
    move(ctx);
  }
  int xSize;
  int ySize;
  int x;
  int y;
  int speed;
  int damage;
  Vector moveVector;
  Vector shootVector;
  Game game;
  GameObject origin;
  Bullet(this.x, this.y, this.xSize, this.ySize, this.game, this.moveVector, this.speed, this.origin){
    game.gameObjects.add(this);
    if(moveVector != new Vector.zero()) {
      moveVector = moveVector.norm() * speed;
    }
    damage = 5;
  }
  void move(ctx){
    x += moveVector.x;
    y += moveVector.y;
    checkCollisions();
  }
  void collisionEffects(GameEntity origin, GameEntity effectee){
    if(effectee is GameMob && effectee != this.origin){
      effectee.health -= this.damage;
    }
  }

  void checkCollisions() {
    for (GameEntity obj in this.game.gameObjects) {
      if (obj == this) {
      }else {
        if (obj.x < this.x + this.xSize && obj.x + obj.xSize > this.x &&
            obj.y < this.y + this.ySize && obj.y + obj.ySize > this.y) {
          // collision detected!
          obj.collisionEffects(obj, this);
        }
      }
    }
  }
}