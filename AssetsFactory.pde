/**
	Instantiate sprites and samples for reuse
**/
class AssetsFactory{

	PImage[] person_sprites = new PImage[4];
	AudioSample[] person_samples = new AudioSample[2];

	public AssetsFactory(){
		person_sprites = loadPersonSprites();
		person_samples = loadPersonSamples();
	}
	
	private PImage[] loadPersonSprites(){
		person_sprites[0] = loadImage("person_01.png");
		person_sprites[1] = loadImage("person_02.png");
		person_sprites[2] = loadImage("person_03.png");
		person_sprites[3] = loadImage("person_02.png");
		return person_sprites;
	}
	
	private AudioSample[] loadPersonSamples(){
		person_samples[0] = minim.loadSample("pr-b-01.wav");
		person_samples[1] = minim.loadSample("pr-b-02.wav");
		return person_samples;
	}
	
	public PImage[] getPersonSprites(){
		if(person_sprites==null){

		}
		return person_sprites;
	}
	public AudioSample[] getPersonSamples(){
		return person_samples;
	}
	
}