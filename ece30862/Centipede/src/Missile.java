public class Missile extends Sprite implements Commons{
    private final int SPEED = 6;
    public Missile(int x, int y){
        super(x, y);
        initMissile();
    }

    private void initMissile(){
        loadImage("src/images/shot.png");
    }

    public void move(){
        y -= SPEED;
        if(y < 0){
            visible = false;
        }
    }
}
