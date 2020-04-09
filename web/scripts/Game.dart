import "dart:html";
import "GameObject.dart";
import 'Gun.dart';
import "Player.dart";
import "dart:math";

void main() {
 CanvasElement canvas = new CanvasElement()
  ..width = 500
  ..height = 500;
 document.body.append(canvas);
 CanvasRenderingContext2D ctx = canvas.context2D;
 Game game = new Game(ctx);
 game.startGame();
}

class Game {
  List<GameObject> gameObjects = new List<GameObject>();
  CanvasRenderingContext2D ctx;
  Game(this.ctx){
  }

  renderGame(num idontknowwhatthisis){
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    for(int i = 0; i< gameObjects.length; i++){
      gameObjects[i].draw(ctx);
    }
    window.animationFrame.then(renderGame);
  }

  startGame(){
   gameObjects.clear();
   List<Gun> gunlist = new List();
   for(int i = 0; i < 10; i++) {
     gunlist.add(new Gun());
   }
   gameObjects.add(new Player((ctx.canvas.width/2).round(), (ctx.canvas.width/2).round(), 50, 50, this, gunlist));
    window.animationFrame.then(renderGame);
  }
}
