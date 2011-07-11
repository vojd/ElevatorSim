class UI{

	ArrayList components;
	ArrayList floor_list;
	class Cursor extends Component{
		int x;
		int y;
		PImage sprite;
		public Cursor(){
			sprite = loadImage("cursor.png");
		}
		public void update(float delta){
			x = mouseX;
			y = mouseY;
		}
		public void render(){
			image(sprite, x, y);
		}
	}
	class Button extends Component{
		int x;
		int y;
		int id;
		Boolean active;
		PImage sprite_on;
		PImage sprite_off;
		public Button(int id, PImage sprite_on, PImage sprite_off, int x, int y){
			this.id = id;
			this.sprite_on = sprite_on;
			this.sprite_off = sprite_off;
			this.x = x;
			this.y = y;
			
			active=false;
		}
		public void update(float delta){
			/*
				if button is pressed, light it up
			*/

		}
		public void render(){
			if(active){
				image(sprite_on, x, y);
			}else{
				image(sprite_off, x, y);
			}
			text(id, x+15, y+30);

		}
	}

	Cursor cursor;
	
	public UI(ArrayList floor_list){
		this.floor_list = floor_list;
		cursor = new Cursor();
		components = new ArrayList();
		components.add(new Cursor());
		// one button for each floor
		components.add(new Button(1, loadImage("button_on.png"), loadImage("button_off.png"), 10,height-100));
		components.add(new Button(2, loadImage("button_on.png"), loadImage("button_off.png"), 60,height-100));
		components.add(new Button(3, loadImage("button_on.png"), loadImage("button_off.png"), 110,height-100));
		components.add(new Button(4, loadImage("button_on.png"), loadImage("button_off.png"), 160,height-100));
	}
	
	void update(float delta){
		for(int i=0; i<components.size(); i++){
			Component c = (Component) components.get(i);
			c.update(delta);
		}
	}
	
	void render(){
		for(int i=0; i<components.size(); i++){
			Component c = (Component) components.get(i);
			c.render();
		}		
	}
	
}