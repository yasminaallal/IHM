/*
 * Définition d'un Point - et méthodes associées
 */ 
 
class Point {
  float X;
  float Y;
  
  Point(float x, float y) {
    X = x;
    Y = y;
  }
  Point() {
    X = 0;
    Y = 0;
  }
  
  float getX(){
    return this.X;
  }
  
   float getY(){
    return this.Y;
  }
  
  void setLocation(Point p){
    this.X= p.X;
    this.Y=p.Y;
  }

  float distance(Point other) {
    return dist(X, Y, other.X, other.Y);
  }
}
