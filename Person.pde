class Person{
	
	int x;
	int y;
	int vel;
	int dir;
	
	Floor destination_floor;
	Floor current_floor;
	Boolean inside_elevator;
	Boolean button_pushed;
	Boolean reached_exit;
	Elevator elevator;
	String state;
	
	Person(Elevator e, Floor cf, Floor df){
		elevator = e;
		println("elevator " + elevator);
		current_floor = cf;
		destination_floor = df;
		//x = 20;
		x = width/2 - 20;
		y = current_floor.getY();
		vel = 10;
		inside_elevator = false;
		button_pushed = false;
		reached_exit = false;
		state = "";
		

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
			//println("person has not reached final level");
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
		if(x==180){
			state = "Reached elevator";
			return true;
		}
		return false;
	}
	
	public void walkTowardsElevatorButton(){
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
		if(x>0){
			dir=-1;
		}else{
			state = "Person reached the exit! hurra!";
			reached_exit = true;
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
			y = elevator.getFloorPosition();
		}
		state = "waiting";
	}
	
	public void render(){

		fill(255,0,0);
		rect(x,y-5,5,5);
		//text("From " + current_floor.floor_number + " to " + destination_floor.floor_number, 10,150);
		//text("State " +state, 10,180);
	}
	

}