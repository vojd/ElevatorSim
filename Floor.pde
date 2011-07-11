
class Floor{
	
	int x;
	int y;
	int floor_number;
	int button_x;

	ArrayList apartments;
	
	public Floor(int floor_number){
		this.floor_number = floor_number;
		x = 10;
		y = 50 * floor_number;
		button_x = width/2-10;
		println("Floor number " + floor_number + " y " + y);
		
		apartments = new ArrayList();

	}
	
	public void update(float delta){
		
	}
	
	public void render(){
		fill(255);
		//rect(x, y, (width/2)-5, y+10);
		rect(x, y, width-(x*2), 4);
		
		// Render elevator button
		fill(0,0,255);
		rect(button_x, y-5, 5, 5);

		fill(255);
		text(floor_number, width-20, y-10);


	}
	
	public int getFloorNumber(){
		return this.floor_number;
	}

	public int getX(){
		return x;
	}
	public int getY(){
		return y;
	}
	public int getButtonX(){
		return button_x;
	}
}