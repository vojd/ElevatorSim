class Person{
	
	int x;
	int y;
	int y_offset;
	int vel;
	int dir;
	
	Floor destination_floor;
	Floor current_floor;
	Boolean inside_elevator;
	Boolean button_pushed;
	Boolean reached_exit;
	Elevator elevator;
	Apartment start_apartment;
	Apartment destination_apartment;
	
	String state;
	int nof_frames = 4;
	int frame = 0;
	int nof_samples = 2;
	int sample = 0;
	PImage[] sprites = new PImage[nof_frames];
	AudioSample[] samples = new AudioSample[nof_samples];
	
	
	Person(Elevator e, Floor cf, Floor df){
		elevator = e;

		current_floor = cf;
		destination_floor = df;
		start_apartment = cf.getRandomApartment();
		destination_apartment = df.getRandomApartment();
		vel = 10;
		inside_elevator = false;
		button_pushed = false;
		reached_exit = false;
		state = "";
		
		sprites = assets.getPersonSprites();
		samples = assets.getPersonSamples();
		
		y_offset = sprites[3].height;
		//x = width/2 - 20;
		x = start_apartment.getX();
		y = current_floor.getY()-y_offset;
		

	}
	
	public void update(float delta){
		/* if person is not in the elevator and has not reached its destination floor, 
		move it towards the elevator button on this floor */
		
		/*
		om jag inte är på slutvåningen
			om jag är i hissen
				vänta
			annars
				om jag inte står vid hissen
					gå mot hissen
				annars
					om hissdörren är öppen
						gå in i hissen
						tryck på den våning jag vill åka till
					annars
						om jag inte har tryckt på knappen
							tryck på knappen
						annars
							vänta
		annars
			om jag inte är i hissen
				gå mot utgång
			annars
				gå ur hissen
		*/
		
		if(!reachedFinalLevel()){
			if(insideElevator()){
				idle();
			}else{
				if(!reachedElevator()){
					walkTowardsElevatorButton();
				}else{
					if(elevatorDoorOpen()){
						enterElevator();
						pushElevatorButton();
					}else{
						if(!buttonPushed()){
							pushButton();
						}else{
							idle();
						}
					}
				}
			}
		}else{
			if(!insideElevator()){
				walkTowardsExit();
			}else{
				exitElevator();
			}
		}
		
		if(dir!=0){
			x+=vel*dir;			
		}

	}
	
	public Boolean reachedFinalLevel(){

		if(insideElevator() && elevator.current_floor == destination_floor.getFloorNumber()){
			state = "reached final level";
			current_floor = destination_floor;
		}
		
		if(current_floor == destination_floor){
			return true;
		}else{
			return false;
		}
	}
	
	public Boolean insideElevator(){
		if(inside_elevator){
			state = "inside elevator";
		}
		return inside_elevator;
	}
	
	public Boolean reachedElevator(){
		if(x>=current_floor.getButtonX() && x<=current_floor.getButtonX()+10 ){
			state = "Reached elevator";
			dir = 0;
			return true;
		}
		return false;
	}
	
	public void walkTowardsElevatorButton(){
		/*
		if(x<current_floor.getButtonX()){
			dir=1;
		}else if(x>current_floor.getButtonX()+10){
			dir=-1;
		}else{
			dir=0;
		}
		*/

		if(x<width/2-10){
			dir=1;
		}else if(x>width/2){
			dir=-1;
		}else{
			dir=0;
		}

		if(dir!=0){
			state = "walking towards elevator" + x;
		}
	}
	
	public Boolean elevatorDoorOpen(){
		if(elevator.current_floor == current_floor.floor_number && elevator.doorsOpen()) {
			return true;
		}
		return false;
	}
	
	public void walkTowardsExit(){
		state = "walking towards exit";
		println("a>>" + x + " " + destination_apartment.getX());
		// If user is inside the door

		if(x>=destination_apartment.getX() && x<=destination_apartment.getX() + destination_apartment.getW()){
			reached_exit = true;
			println("reached exit!");
		}else{
			if(x>destination_apartment.getX()){
				dir=-1;
			}else if(x<destination_apartment.getX()){
				dir=1;
			}			
		}
	}
	
	public void enterElevator(){
		//println("Person enters elevator");
		state = "Person enters elevator";
		x = width/2;
		inside_elevator = true;
	}
	public void exitElevator(){
		state = "Person exits elevator";
		inside_elevator = false;
	}
	public Boolean buttonPushed(){
		return button_pushed;
	}
	public void pushButton(){
		/* push external elevator button */
		button_pushed = !button_pushed;
		elevator.addFloor(current_floor.getFloorNumber());
	}
	public void pushElevatorButton(){
		/* push button inside elevator */
		state = "internal elevator button pushed";
		elevator.addFloor(destination_floor.getFloorNumber());
	}
	
	public void idle(){
		/* just wait */
		if(insideElevator()){
			x = elevator.getInsidePosition();
			y = elevator.getFloorPosition()-y_offset;
		}
		state = "waiting";
	}
	
	
	public void render(){
		image(sprites[frame], x, y);
		if(dir!=0){
			frame++;
			if(frame>3){
				frame=0;
			}
			samples[0].trigger();
		}
	}

	public void cleanUp(){
		for(int i=0; i<samples.length; i++){
			samples[i].close();
		}
	}
}