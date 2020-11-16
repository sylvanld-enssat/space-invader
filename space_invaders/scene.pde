
class Earth extends Drawable{
	int earthOffset;
	PImage img;
	
	Earth(Scene scene) {
		img = loadImage("earth.jpg");
		img.resize(scene.width, int(scene.width * img.height / img.width));
		earthOffset = scene.height - img.height;
	}
	
	void draw() {
		image(img, 0, earthOffset);
	}
}

/**
* Store drawable objects
*/
class Scene extends Drawable{
	int width, height;
	ArrayList<Drawable> items;
	Earth earth;
	boolean isGameOver = false;
	String gameOverMessage = "";
	ArrayList<Shot> shots;
	
	Scene(int width, int height) {
		this.width = width;
		this.height = height;
		this.reset();
	}
	
	void gameOver(String message) {
		println("Set game over message" + message);
		this.gameOverMessage = message;
		this.isGameOver = true;
	}
	
	void clear() {
		this.items = new ArrayList();
		this.shots = new ArrayList();
		// TODO: refactoring, shouldn't be in the scene
		this.isGameOver = false;
	}
	
	void addShot(Shot shot) {
		this.shots.add(shot);
	}
	
	void removeShot(Shot shot) {
		this.shots.remove(shot);
	}
	
	void reset() {
		this.clear();
		// create earth and add it to the scene
		this.earth = new Earth(this);
		this.add(this.earth);
	}
	
	boolean gameRunning() {
		return !this.isGameOver;
	}
	
	int getPlayerSize() {
		// TODO: put aspect ratio here
		return int(0.125 * this.width);
	}
	
	/**
	* Add a drawable object to the scene.
	**/
	void add(Drawable item) {
		items.add(item);
	}
	
	void remove(Drawable item) {
		items.remove(item);
	}
	
	/**
	* individually draw each element of the scene
	*/
	void draw() {
		background(0);
		
		for (int i = 0; i < items.size(); i++) {
			items.get(i).draw();
		}
		
		// draw shots
		for (int i = 0; i < shots.size(); i++) {
			shots.get(i).draw();
		}
		
		if (isGameOver) {
			int titleWidth = int(0.8 * this.width * 0.1);
			int halfWidth = int(this.width / 2);
			int halfHeight = int(0.5 * this.earth.earthOffset);
			int borderWidth = 3;
			
			textSize(int(titleWidth * 0.3));
			textAlign(LEFT);
			text("Press[Space] to play a new game...", 0, int(titleWidth * 0.3));
			
			textAlign(CENTER);
			
			textSize(titleWidth);
			
			fill(0, 0, 0);
			for (int x =- borderWidth; x < borderWidth + 1; x++) {
				for (int y =- borderWidth; y < borderWidth + 1; y++) {
					text(this.gameOverMessage + "\nGame over!", halfWidth - x, halfHeight - y);
				}
			}
			
			fill(255, 255, 255);
			text(this.gameOverMessage + "\nGame over!", halfWidth, halfHeight);
		}
	}
}
