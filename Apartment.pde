
class Apartment{
	
	Floor floor;
	int x;
	int y;
	int w;
	int h;
	int id;
	
	public Apartment(Floor f, int _id){
		id = _id;
		floor = f;

		w = 10;
		h = 20;		
		x = width/4 * id + 30;
		y = floor.getY()-h;

	}
	
	public void update(float delta){
		
	}
	
	public void render(){
		println("render apat" + x + " " + y + " " + w + " " + h);
		fill(0,255,255);
		rect(x,y,w,h);
	}
	
}