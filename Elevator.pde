class Elevator{
	
	/*
		The requested Levels to go to.
	*/
	
	int x;
	int y;
	int top;	// elevator top
	int bottom;	// elevator height, bottom = y + height
	int w;		// elevator width
	int vel;	// velocity
	int direction;	// movement direction
	int current_floor;
	//int destination_floor;
	ArrayList elevator_floors;	// list of where to move the elevator
	Floor destination_floor;
	
	Boolean moving;
	Boolean doors_open;
	
	int destination_floor_number;
	
	public Elevator(ArrayList floors, int start_floor){
		/* start at the last floor by default*/

		elevator_floors = new ArrayList();

		for(int i=0; i<1; i++){
			Floor fl = (Floor)floors.get(i);
			elevator_floors.add(fl);			
		}
		Floor sf = (Floor) elevator_floors.get(elevator_floors.size()-1);
		current_floor = sf.getFloorNumber();	// start level			
		
		x = width/2;
		y = sf.getY()-20;
		w = 20;
		bottom = 20;		
		vel = 20;
		direction = 0;
		moving = false;
		doors_open = false;
	}
	
	public void update(float delta){

		destination_floor = getDestinationFloor();
		try{
			destination_floor_number = destination_floor.getFloorNumber();
		}catch(Exception e){
			destination_floor_number = current_floor;
		}
		
		if(true){
			move();
		}
	}
	
	public void move(){
		//Floor f = (Floor) elevator_floors.get(0);
		//destination_floor = f.getFloorNumber();
		Floor df;
		try{
			df = (Floor)elevator_floors.get(0);			
		}catch(Exception e){
			df = null;
		}
		if(df != null){
			if(current_floor < destination_floor_number){
				closeDoors();
				moveUp(df);
			}else if(current_floor > destination_floor_number){
				closeDoors();
				moveDown(df);
			}else if(current_floor == df.getFloorNumber() && elevator_floors.size() > 0){
				moving=false;
				elevator_floors.remove(0);
				openDoors();
			}	
		}

	}
	
	public void moveUp(Floor destination_floor){
		moving=true;
		if(y+bottom<destination_floor.getY()){
			y+=10;
		}else{
			current_floor++;			
		}

	}
	
	public void moveDown(Floor destination_floor){
		//Floor df = (Floor)elevator_floors.get(0);
		moving = true;
		if(y+bottom>destination_floor.getY()){
			y-=10;
		}else{
			current_floor--;
		}
	}
	
	public void openDoors(){
		if(!doors_open){
			doors_open = true;
			println("open doors, welcome aboard");			
		}
	}
	public void closeDoors(){
		if(doors_open){
			doors_open = false;
			println("closing doors, dont get caught");			
		}
	}
	
	public void render(){

		text("Current level: "+ current_floor, 10,40);	
		if(elevator_floors.size() > 0){

			text("Current " + current_floor + " next " + destination_floor.getFloorNumber(), 10,80);
			text("elevator y " + y + " next_floor y " + destination_floor.getY(), 10,100);
			
			for(int i=0; i<elevator_floors.size(); i++){
				Floor fl = (Floor)elevator_floors.get(i);
				text("[ " + fl.getFloorNumber() + " ]", 10+ (i*40),60);
			}
		}
		rect(x, y, w, bottom);
	}

	public void addFloor(int floor_number){
		try{
			Floor f = (Floor) elevator_floors.get(floor_number);
		}catch(Exception e){
			println("Add floor to sequence");
			elevator_floors.add(new Floor(floor_number));
		}
	}
	public ArrayList getFloors(){
		return elevator_floors;
	}
	public Floor getDestinationFloor(){
		if(elevator_floors.size() > 0){
			return (Floor) elevator_floors.get(0);
		}
		return null;
	}

	public int getX(){
		return x;
	}
	public int getY(){
		return y;
	}
	public int getInsidePosition(){
		return w/2+x;
	}
	public int getFloorPosition(){
		return y+bottom;
	}
	public Boolean doorsOpen(){
		return doors_open;
	}
	
}