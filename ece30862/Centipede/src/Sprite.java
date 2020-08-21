import java.awt.*;
import javax.swing.ImageIcon;

public class Sprite {
    protected int x;
    protected int y;
    protected int width;
    protected int height;
    protected Image image;
    protected int life;
    protected boolean visible;

    public Sprite(int x, int y){
        this.x = x;
        this.y = y;
        visible = true;
    }

    public void loadImage(String imagePath){
        ImageIcon ii = new ImageIcon(imagePath);
        image = ii.getImage();
        width = image.getWidth(null);
        height = image.getHeight(null);
    }

    public Image getImage(){
        return image;
    }

    public int getX(){
        return x;
    }

    public int getY(){
        return y;
    }

    public int getWidth(){
        return width;
    }

    public int getHeight(){
        return height;
    }

    public boolean isVisible(){
        return visible;
    }

    public void setVisible(boolean visible){
        this.visible = visible;
    }

    public void decLife(){
        life--;
        if(life == 0){
            visible = false;
        }
    }
}
