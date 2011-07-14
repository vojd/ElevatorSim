
class Floor{
	
	int x;
	int y;
	int floor_number;
	int button_x;

	ArrayList apartments;
	
	public Floor(int floor_number){
		int nof_floors = 4;
		this.floor_number = floor_number;
		x = 10;
		y = (height/nof_floors)*floor_number-25; //50 * floor_number;
		button_x = width/2-10;
		println("Floor number " + floor_number + " y " + y);
		
		apartments = new ArrayList();
		
		/** Add apartments to each floor **/
		for(int i=0; i<4; i++){
			Apartment a = new Apartment(this, i);
			apartments.add(a);
		}
	}
	
	public void update(float delta){
		for(int i=0; i<apartments.size(); i++){
			Apartment a = (Apartment)apartments.get(i);
			a.update(delta);
		}		
	}
	
	public void render(){
		// render apartments
		for(int i=0; i<apartments.size(); i++){
			Apartment a = (Apartment)apartments.get(i);
			a.render();
		}
		
		fill(255);
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
	public Apartment getRandomApartment(){
		int i = (int)random(0,apartments.size());
		Apartment a = (Apartment)apartments.get(i);
		return a;
	}

}