import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import java.io.*;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.List;
import javax.sound.sampled.*;

public class Player extends Sprite implements Commons{
    private List<Missile> Missiles;
    private AudioInputStream stream;
    private AudioFormat format;
    private byte[] samples;
    public Player(int x, int y){
        super(x, y);
        initPlayer();
        life = 3;
    }

    public Player(int x, int y, int life){
        super(x, y);
        initPlayer();
        this.life = life;
        System.out.println("life : " + life);
    }

    private void initPlayer(){
        Missiles = new ArrayList<>();
        loadImage("src/images/player.png");
        x = BOARD_WIDTH / 2;
        y = BOARD_HEIGHT - image.getHeight(null) * 2;
        //System.out.println("x = " + x + " y = " + y);
    }

    public List<Missile> getMissiles(){
        return Missiles;
    }

    public void mousePressed(MouseEvent e){
        fire();
    }

    public void mouseMoved(MouseEvent e){
        x = e.getX();
        y = e.getY();
    }

    public int getLife(){
        return life;
    }

    public void fire(){
        Missiles.add(new Missile(x + width / 2, y - height));
        //InputStream sound = new ByteArrayInputStream(getSamples());
        //play(sound);
        try {
            // Open an audio input stream.
            File soundFile = new File("src/sounds/fire_shot.wav"); //you could also get the sound file with an URL
            AudioInputStream audioIn = AudioSystem.getAudioInputStream(soundFile);
            // Get a sound clip resource.
            Clip clip = AudioSystem.getClip();
            // Open audio clip and load samples from the audio input stream.
            clip.open(audioIn);
            clip.start();
        } catch (UnsupportedAudioFileException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (LineUnavailableException e) {
            e.printStackTrace();
        }

    }
}
