
import ddf.minim.*;
Minim minim;

Elevator elevator;

UI ui;
ArrayList persons;
ArrayList floors;
/* elevator variables */
int nof_floors = 4;
int start_floor = 1;	// 1 eq ground floor

/* person variables */
int nof_people;

PFont font;

void setup(){

	minim = new Minim(this);
	size(400,400);
	background(0);
	font = loadFont("Dialog-18.vlw");
	textFont(font);
	floors = new ArrayList();
	for(int i=0; i<nof_floors; i++){
		floors.add(new Floor(i+1));
	}

	elevator = new Elevator(floors, start_floor);

	persons = new ArrayList();
	for(int i=0; i<1; i++){
		persons.add(generatePerson());
	}

	ArrayList floor_list = elevator.getFloors();
	ui = new UI(floor_list);
}

public void spawnPerson(){
	println("spawnPerson");
	persons.add(generatePerson());
}
public Person generatePerson(){
	int sf = (int)random(0, floors.size());
	int df = sf;
	while(df==sf){
		df = (int)random(0, floors.size());
	}
	Floor _sf = (Floor)floors.get(sf);
	Floor _df = (Floor)floors.get(df);
	Elevator e = elevator;
	return new Person(e, _sf, _df);
}

void draw(){

	delay(500);
	float delta = 0.0f;
	update(delta);
	render();	
}

void update(float delta){

	//ui.update(delta);
	elevator.update(delta);
	for(int i=0; i<persons.size(); i++){
		Person p = (Person) persons.get(i);
		p.update(delta);
		/* If person reached the exit, remove it */
		if(p.reached_exit){
			persons.remove(i);
		}
	}
}

void render(){
	
	background(0);

	for(int i=0; i<floors.size(); i++){
		Floor floor = (Floor) floors.get(i);
		floor.render();
	}
	for(int i=0; i<persons.size(); i++){
		Person p = (Person) persons.get(i);
		p.render();
	}
	elevator.render();
	//ui.render();
}


void pushButton(int floor_to_visit){
	elevator.addFloor(floor_to_visit);
}

void keyPressed(){
	
	int v = -1;
	if(key == 'p'){
		spawnPerson();
	}
	
	switch(keyCode){

		case '1':
			v = 1;
			break;
			
		case '2':
			v = 2;
			break;

		case '3':
			v = 3;
			break;
			
		case '4':
			v = 4;
			break;

		/*
		case LEFT:
			ui.cursorLeft();
			break;
		case RIGHT:
			ui.cursorRight();
			break;
		case UP:
			ui.cursorUp();
			break;
		case DOWN:
			ui.cursorDown();
			break;
		*/
			
		default:
			v = -1;
			break;			
	}
	
	if(v != -1){
		pushButton(v);
	}
		

}

void stop(){

	// clean up sound resources
	
	for(int i=0; i<persons.size(); i++){
		Person p = (Person)persons.get(i);
		p.cleanUp();
	}
	
	minim.stop();
	super.stop();
}

