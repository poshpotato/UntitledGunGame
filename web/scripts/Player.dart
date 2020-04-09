import "GameObject.dart";
import "dart:html";
import "Gun.dart";
import "Vector.dart";
import "Game.dart";
class Player implements GameEntity{
  void draw(CanvasRenderingContext2D ctx){
    ctx.fillRect(x-(xSize/2), y-(ySize/2), xSize, ySize);
    move();
  }
  List<Gun> guns = new List(10);
  int xSize;
  int ySize;
  int x;
  int y;
  Vector moveVector;
  Vector shootVector;
  Game game;
  Player(this.x, this.y, this.xSize, this.ySize, this.game, this.guns){
    window.onKeyDown.listen(keyDownHandler);
    window.onKeyUp.listen(keyUpHandler);
    this.moveVector = new Vector.zero();

    this.shootVector = new Vector(0, -5);
  }
  int speed = 5;
  int angle = null;
  bool upDown = false;
  bool leftDown = false;
  bool rightDown = false;
  bool downDown = false;

  void keyDownHandler(KeyboardEvent e) {
    if(e.keyCode >= 48 && e.keyCode <= 57){
      int gunNum = e.keyCode-48;
      try{
        guns[gunNum].shoot(this);
      } catch(e){}
    } else {
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
    }
    moveVector = updateVectors();
  }

  void keyUpHandler(KeyboardEvent e){
    if(e.keyCode >= 48 && e.keyCode <= 57){
      int gunNum = e.keyCode-48;
      guns[gunNum].shooting = false;
    } else {
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
    }
    moveVector = updateVectors();
  }

  Vector updateVectors(){
    Vector tempVector = new Vector(0, 0);
    if(downDown) tempVector += new Vector(0, 5);
    if(upDown) tempVector += new Vector(0, -5);
    if(leftDown) tempVector += new Vector(-5, 0);
    if(rightDown) tempVector += new Vector(5, 0);
    if(tempVector != new Vector.zero()) shootVector = tempVector;
    return tempVector;
  }

  void move(){
    x += moveVector.x;
    y += moveVector.y;
  }
}
