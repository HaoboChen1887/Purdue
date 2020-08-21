import com.sun.nio.sctp.PeerAddressChangeNotification;

import java.util.ArrayList;
import java.util.List;
import java.awt.Image;
import javax.swing.ImageIcon;
import java.util.Random;

public class Spider extends Sprite implements Commons{
    private int dx, dy;
    public int lr, ud;
    public Spider(int x, int y){
        super(x, y);
        initSpider();
    }

    private void initSpider(){
        loadImage("src/images/spider0.png");
        System.out.print("Image" + image.getHeight(null) + " " + image.getWidth(null));
        life = 2;
        dx = 1;
        dy = 1;
        lr = 1;
        ud = 1;
    }

    public void setSpeed(int dx, int dy){
        this.dx = dx;
        this.dy = dy;
    }

    public void move(){
        Random rand = new Random();
        if(x >= BOARD_WIDTH - width){
            lr = -1;
            dx = (rand.nextInt(5)) * lr;
        }
        else if(x <= 0){
            lr = 1;
            dx = (rand.nextInt(5)) * lr;
        }
        if(y <= height){
            ud = 1;
            dy = (rand.nextInt(5)) * ud;
        }
        else if(y >= BOARD_HEIGHT - height){
            ud = -1;
            dy = (rand.nextInt(5)) * ud;
        }
        if(dx == 0){
            dx = (rand.nextInt(5)) * lr;
        }
        if(dy == 0){
            dy = (rand.nextInt(5)) * ud;
        }
        x += dx;
        y += dy;
        //System.out.println("dx: " + dx + " dy :" + dy + " lr: " +  lr + " ud: " + ud);
    }
}
