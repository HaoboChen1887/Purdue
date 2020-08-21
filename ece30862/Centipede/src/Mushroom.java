import java.util.ArrayList;
import java.util.List;
import java.awt.Image;
import javax.swing.ImageIcon;

public class Mushroom extends Sprite implements Commons{
    Image image0, image1, image2;
    public Mushroom(int x, int y){
        super(x, y);
        life = 3;
        initMushroom();
    }

    private void initMushroom(){
        loadImage();
    }

    public void loadImage(){
        ImageIcon ii0 = new ImageIcon("src/images/mushroom0.png");
        image0 = ii0.getImage();
        ImageIcon ii1 = new ImageIcon("src/images/mushroom1.png");
        image1 = ii1.getImage();
        ImageIcon ii2 = new ImageIcon("src/images/mushroom2.png");
        image2 = ii2.getImage();
        width = image0.getWidth(null);
        height = image0.getHeight(null);
    }

    public Image getImage(){
        if(life == 3){
            return image0;
        }
        else if(life == 2){
            return image1;
        }
        else{
            return image2;
        }
    }
}
