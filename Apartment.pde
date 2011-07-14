
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
		h = 26;
		x = width/4 * id + 50;
		y = floor.getY()-h;

	}
	
	public void update(float delta){
		
	}
	
	public void render(){
		//println("render apat" + x + " " + y + " " + w + " " + h);
		fill(0,255,255);
		rect(x,y,w,h);
	}

	public int getX(){
		return x;
	}
	public int getY(){
		return y;
	}
	public int getW(){
		return w;
	}
}