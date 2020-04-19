import "GameObject.dart";
import "dart:html";
import "Gun.dart";
import "Vector.dart";
import "Game.dart";
class Player implements GameMob{
  void draw(CanvasRenderingContext2D ctx){
    ctx.fillRect(ctx.canvas.width/2-(xSize/2), ctx.canvas.height/2-(ySize/2), xSize, ySize);
    move();
    checkCollisions();
  }
  List<Gun> guns = new List(10);
  int xSize;
  int ySize;
  int x;
  int y;
  int damage;
  int drawX;
  int drawY;
  Vector moveVector;
  Vector shootVector;
  Game game;
  int health;
  Player(this.x, this.y, this.xSize, this.ySize, this.game, this.guns){
    window.onKeyDown.listen(keyDownHandler);
    window.onKeyUp.listen(keyUpHandler);
    window.onMouseMove.listen(updateMousePos);

    window.onMouseUp.listen(this.mouseUp);

    window.onMouseDown.listen(this.mouseDown);
    this.moveVector = new Vector.zero();
    this.shootVector = new Vector(0, -5);
    damage = 1;
    health = 10;
  }
  int speed = 5;
  int angle = null;
  bool upDown = false;
  bool leftDown = false;
  bool rightDown = false;
  bool downDown = false;

  void keyDownHandler(KeyboardEvent e) {
      switch (e.keyCode) {
        case KeyCode.W :
          this.upDown = true;
          break;
        case KeyCode.A :
          this.leftDown = true;
          break;
        case KeyCode.D :
          this.rightDown = true;
          break;
        case KeyCode.S :
          this.downDown = true;
          break;
        default :
          break;
    }
    moveVector = updateVectors();
  }

  void keyUpHandler(KeyboardEvent e){
      switch (e.keyCode) {
        case KeyCode.W :
          this.upDown = false;
          break;
        case KeyCode.A :
          this.leftDown = false;
          break;
        case KeyCode.D :
          this.rightDown = false;
          break;
        case KeyCode.S :
          this.downDown = false;
          break;
        default :
          break;
    }
    moveVector = updateVectors();
  }

  Vector updateVectors(){
    Vector tempVector = new Vector(0, 0);
    if(downDown) tempVector += new Vector(0, 5);
    if(upDown) tempVector += new Vector(0, -5);
    if(leftDown) tempVector += new Vector(-5, 0);
    if(rightDown) tempVector += new Vector(5, 0);
    return tempVector;
  }

  void move(){
    x += moveVector.x;
    y += moveVector.y;
  }

  void updateMousePos(MouseEvent e){
    int mouseX = e.client.x-this.game.ctx.canvas.offsetLeft;
    int mouseY = e.client.y-this.game.ctx.canvas.offsetTop;
    Element mouseElement = document.elementFromPoint(e.client.x, e.client.y);
    if(mouseElement.toString() == "canvas") {
      Point mousePos = e.offset;

      shootVector = new Vector(mousePos.x - game.ctx.canvas.width/2, mousePos.y - game.ctx.canvas.height/2 );
    }
  }

  void mouseDown(MouseEvent e){
    if(e.button == 0) {
      guns[1].shooting = true;
      guns[1].shoot(this);
    }
  }

  void mouseUp(MouseEvent e){
    if(e.button == 0) guns[1].shooting = false;
  }

  void checkCollisions(){
    for(GameEntity obj in this.game.gameObjects){
      if (obj.x < this.x + this.xSize && obj.x + obj.xSize > this.x && obj.y < this.y + this.ySize && obj.y + obj.ySize > this.y) {
        // collision detected!
        if(!(obj is Bullet)) this.health -= obj.damage;
      }
    }
  }
}
