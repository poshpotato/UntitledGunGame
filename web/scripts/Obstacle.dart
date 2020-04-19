import 'dart:html';

import 'Game.dart';
import 'GameObject.dart';
import 'Vector.dart';

class Obstacle implements GameEntity {
  Vector moveVector;
  Vector shootVector;
  int x;
  int y;
  int xSize;
  int ySize;
  Game game;
  int speed;

  Obstacle(this.x, this.y, this.xSize, this.ySize, this.game) {
    game.gameObjects.add(this);
  }

  void draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(GameObject.getRenderX(x, ctx, this.game.player),
        GameObject.getRenderY(y, ctx, this.game.player), xSize, ySize);
    checkCollisions();
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

  void collisionEffects(GameEntity origin, GameEntity effectee) {
    print(effectee);
    if(game.gameObjects.contains(effectee)){
      game.gameObjects.remove(effectee);
    }
  }
}