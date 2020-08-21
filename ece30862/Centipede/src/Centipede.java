import java.util.ArrayList;
import java.util.List;
import java.awt.Image;
import javax.swing.ImageIcon;
import java.util.Random;

public class Centipede extends Sprite implements Commons {
    private final int SPEED = 1;
    public int lr = -1;
    public Centipede(int x, int y){
        super(x, y);
        centipedeInit();
    }

    private void centipedeInit(){
        loadImage("src/images/centipede.png");
        life = 2;
        //System.out.println("w " + width + " h " + height);
    }

    public void move(){
        x += SPEED * lr;
    }

    public void moveDown(){
        y += height + 1;
    }
}
