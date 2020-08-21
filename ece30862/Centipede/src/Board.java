import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import java.awt.*;
import java.awt.event.*;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.security.cert.CertificateEncodingException;
import java.util.Timer;
import java.util.List;
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.Random;

public class Board extends JPanel implements Commons, Runnable{
    private Image img;
    private int x, y;
    private Thread animator;
    private Player player;
    private List<Mushroom> mushrooms;
    private List<Centipede> centipedes;
    private Spider spider;
    private int score;
    public Board(){
        initBoard();
    }

    private void initBoard(){
        MAdaptor m_ada = new MAdaptor();
        addMouseListener(m_ada);
        addMouseMotionListener(m_ada);
        setCursor(getToolkit().createCustomCursor(getToolkit().getImage(""), new Point(), "invisible"));
        setBackground(Color.BLACK);
        setPreferredSize(new Dimension(BOARD_WIDTH, BOARD_HEIGHT));


        player = new Player(BOARD_WIDTH / 2, BOARD_HEIGHT);
        mushrooms = genenrateMushrooms(100);
        Random rand = new Random();
        spider = new Spider(0, BOARD_HEIGHT - rand.nextInt(BOARD_HEIGHT));
        centipedes = generateCentipedes(10);
    }

    @Override public void addNotify(){
        super.addNotify();
        animator = new Thread(this);
        animator.start();
    }

    @Override public void paintComponent(Graphics g){
        super.paintComponent(g);
        //System.out.println("Painting");

        updateCentipedes();
        updateMissiles();
        updateMushrooms();
        updateSpider();
        updatePlayer();
        drawCentipede(g);
        drawMushroom(g);
        drawPlayer(g);
        drawSpider(g);
        drawInfo(g);

    }

    @Override public void run(){
        long prev_time, time_diff, sleep;
        prev_time = System.currentTimeMillis();

        while(player.isVisible()) {
            repaint();

            time_diff = System.currentTimeMillis() - prev_time;
            sleep = INIT_DELAY - time_diff;

            if (sleep < 0) {
                sleep = 2;
            }

            try {
                Thread.sleep(sleep);
            } catch (InterruptedException e) {
                System.out.println("Thread interupped");
            }
            prev_time = System.currentTimeMillis();
        }
        if(player.getLife() == 0) {
            gameOver();
        }
        else{
            gameWon();
        }
    }

    private void drawPlayer(Graphics g){
        if(player.isVisible()) {
            g.drawImage(player.getImage(), player.getX(), player.getY(), null);
            //Toolkit.getDefaultToolkit().sync();

            List<Missile> missiles = player.getMissiles();
            for (Missile missile : missiles) {
                g.drawImage(missile.getImage(), missile.getX(), missile.getY(), null);
                //Toolkit.getDefaultToolkit().sync();
            }
        }
    }

    private void drawMushroom(Graphics g){
        for(Mushroom mushroom : mushrooms){
            g.drawImage(mushroom.getImage(), mushroom.getX(), mushroom.getY(), null);
            //Toolkit.getDefaultToolkit().sync();
        }
    }

    private void drawSpider(Graphics g){
        g.drawImage(spider.getImage(), spider.getX(), spider.getY(), null);
        //Toolkit.getDefaultToolkit().sync();
    }

    private void drawCentipede(Graphics g){
        for(Centipede centipede : centipedes){
            g.drawImage(centipede.getImage(), centipede.getX(), centipede.getY(), null);
            //Toolkit.getDefaultToolkit().sync();
        }
    }

    private void drawInfo(Graphics g){
        g.setColor(Color.white);
        Font info = new Font("Helvetica", Font.BOLD, 14);
        g.drawString("Score " + score, 0, 10);
        g.drawString("Life " + player.getLife(), 0, 20);
    }

    private void updateMissiles(){
        List<Missile> missiles = player.getMissiles();
        for(int ct = 0; ct < missiles.size(); ct++){
            Missile missile = missiles.get(ct);
            if(missile.isVisible()){
                missile.move();
                //System.out.println(missile.getX() + " " + missile.getY() + " " + ct);
            }
            else{
                missiles.remove(ct);
            }
        }
    }

    private void updateMushrooms(){
        List<Missile> missiles = player.getMissiles();
        for(int ms = 0; ms < missiles.size(); ms++){
            Missile missile = missiles.get(ms);
            for(int ct = 0; ct < mushrooms.size(); ct++){
                Mushroom mushroom = mushrooms.get(ct);
                if(missile.getX() >= mushroom.getX() && missile.getX() <= mushroom.getX() + mushroom.getWidth() && missile.getY() >= mushroom.getY() && missile.getY() <= mushroom.getY() + mushroom.getHeight()){
                    mushroom.decLife();
                    missiles.remove(ms);
                    score++;
                }
                if(!mushroom.isVisible()){
                    //System.out.println(missile.getX() + " " + missile.getY() + " " + ct);
                    mushrooms.remove(ct);
                    score += 2;
                }
            }
        }
    }

    private void updateSpider(){
        List<Missile> missiles = player.getMissiles();
        Random rand = new Random();
        if(spider.isVisible()) {
            spider.move();
        }
        else if(!spider.isVisible()){
            spider = new Spider(BOARD_WIDTH - rand.nextInt(BOARD_WIDTH * 2) / BOARD_WIDTH, BOARD_HEIGHT - rand.nextInt(BOARD_HEIGHT));
            score += 600;
        }
        if(missiles.size() > 0) {
            for (int ms = 0; ms < missiles.size(); ms++) {
                Missile missile = missiles.get(ms);
                if (spider.isVisible()) {
                    if (missile.getX() >= spider.getX() && missile.getX() <= spider.getX() + spider.getWidth() && missile.getY() >= spider.getY() && missile.getY() <= spider.getY() + spider.getHeight()) {
                        spider.decLife();
                        missiles.remove(ms);
                        score += 100;
                    }
                }
            }
        }
    }

    private void updatePlayer(){
        if(spider.isVisible()){
            if (player.getX() >= spider.getX() && player.getX() <= spider.getX() + spider.getWidth() && player.getY() >= spider.getY() && player.getY() <= spider.getY() + spider.getHeight() ||
                player.getX() + player.getWidth() >= spider.getX() && player.getX() + player.getWidth() <= spider.getX() + spider.getWidth() && player.getY() >= spider.getY() && player.getY() <= spider.getY() + spider.getHeight() ||
                player.getX() >= spider.getX() && player.getX() <= spider.getX() + spider.getWidth() && player.getY() + player.getHeight() >= spider.getY() && player.getY() + player.getHeight() <= spider.getY() + spider.getHeight() ||
                player.getX() + player.getWidth()>= spider.getX() && player.getX() + player.getWidth() <= spider.getX() + spider.getWidth() && player.getY() + player.getHeight() >= spider.getY() && player.getY() + player.getHeight() <= spider.getY() + spider.getHeight()) {
                player.decLife();
                if(player.isVisible()) {
                    player = new Player(BOARD_WIDTH / 2, BOARD_HEIGHT - player.getImage().getHeight(null) * 2, player.life);
                }
            }
            for(int ct = 0; ct < centipedes.size(); ct++){
                Centipede centipede = centipedes.get(ct);
                if (player.getX() >= centipede.getX() && player.getX() <= centipede.getX() + centipede.getWidth() && player.getY() >= centipede.getY() && player.getY() <= centipede.getY() + centipede.getHeight() ||
                        player.getX() + player.getWidth() >= centipede.getX() && player.getX() + player.getWidth() <= centipede.getX() + centipede.getWidth() && player.getY() >= centipede.getY() && player.getY() <= centipede.getY() + centipede.getHeight() ||
                        player.getX() >= centipede.getX() && player.getX() <= centipede.getX() + centipede.getWidth() && player.getY() + player.getHeight() >= centipede.getY() && player.getY() + player.getHeight() <= centipede.getY() + centipede.getHeight() ||
                        player.getX() + player.getWidth()>= centipede.getX() && player.getX() + player.getWidth() <= centipede.getX() + centipede.getWidth() && player.getY() + player.getHeight() >= centipede.getY() && player.getY() + player.getHeight() <= centipede.getY() + centipede.getHeight()) {
                    player.decLife();
                    if(player.isVisible()) {
                        player = new Player(BOARD_WIDTH / 2, BOARD_HEIGHT - player.getImage().getHeight(null) * 2, player.life);
                    }
                }
            }
        }
    }

    private void updateCentipedes(){
        List<Missile> missiles = player.getMissiles();
        for(int ms = 0; ms < missiles.size(); ms++){
            Missile missile = missiles.get(ms);
            for(int ct = 0; ct < centipedes.size(); ct++){
                Centipede centipede = centipedes.get(ct);
                if(missile.getX() >= centipede.getX() && missile.getX() <= centipede.getX() + centipede.getWidth() && missile.getY() >= centipede.getY() && missile.getY() <= centipede.getY() + centipede.getHeight()){
                    centipede.decLife();
                    missiles.remove(ms);
                    score += 2;
                }
                if(!centipede.isVisible()){
                    //System.out.println(missile.getX() + " " + missile.getY() + " " + ct);
                    centipedes.remove(ct);
                    score += 5;
                    if(centipedes.size() == 0){
                        score += 600;
                        player.setVisible(false);
                    }
                }
            }
        }
        for(int ct = 0; ct < centipedes.size(); ct++){
            Centipede centipede = centipedes.get(ct);
            for(int ms = 0; ms < mushrooms.size(); ms++){
                Mushroom mushroom = mushrooms.get(ms);
                /*
                if (centipede.getX() >= mushroom.getX() && centipede.getX() <= mushroom.getX() + mushroom.getWidth() && centipede.getY() >= mushroom.getY() && centipede.getY() <= mushroom.getY() + mushroom.getHeight() ||
                        centipede.getX() + centipede.getWidth() >= mushroom.getX() && centipede.getX() + centipede.getWidth() <= mushroom.getX() + mushroom.getWidth() && centipede.getY() >= mushroom.getY() && centipede.getY() <= mushroom.getY() + mushroom.getHeight() ||
                        centipede.getX() >= mushroom.getX() && centipede.getX() <= mushroom.getX() + mushroom.getWidth() && centipede.getY() + centipede.getHeight() >= mushroom.getY() && centipede.getY() + centipede.getHeight() <= mushroom.getY() + mushroom.getHeight() ||
                        centipede.getX() + centipede.getWidth()>= mushroom.getX() && centipede.getX() + centipede.getWidth() <= mushroom.getX() + mushroom.getWidth() && centipede.getY() + centipede.getHeight() >= mushroom.getY() && centipede.getY() + centipede.getHeight() <= mushroom.getY() + mushroom.getHeight()) {
                       */
                if(centipede.getX() >= mushroom.getX() && centipede.getX() <= mushroom.getX() + mushroom.getWidth() && centipede.getY() / 2 >= mushroom.getY() && centipede.getY() <= mushroom.getY() + mushroom.getHeight()){
                    centipede.move();
                    if(centipede.getY() < BOARD_HEIGHT * 4 / 5) {
                        centipede.moveDown();
                    }
                    centipede.lr = -centipede.lr;
                }
                else if(centipede.getX() <=  centipede.getWidth()){
                    centipede.move();
                    if(centipede.getY() < BOARD_HEIGHT * 4 / 5) {
                        centipede.moveDown();
                    }
                    centipede.lr = 1;
                }
                else if(centipede.getX() >= BOARD_WIDTH - centipede.getWidth() && centipede.getY() != 0){
                    centipede.move();
                    if(centipede.getY() < BOARD_HEIGHT * 4 / 5) {
                        centipede.moveDown();
                    }
                    centipede.lr = -1;
                }
                else{
                    centipede.move();
                }
            }
        }
    }

    private List<Mushroom> genenrateMushrooms(int num){
        List<Mushroom> mushrooms = new ArrayList<>();
        Random rand = new Random();
        ImageIcon temp_ii = new ImageIcon("src/images/mushroom0.png");
        Image temp = temp_ii.getImage();
        int mushroom_width = temp.getWidth(null) + 1;
        int mushroom_height = temp.getHeight(null) + 1;
        for(int row = 0; row < BOARD_HEIGHT * 4 / 5 / mushroom_height; row++){
            int rand_x = rand.nextInt((BOARD_WIDTH - 2 * mushroom_width) / mushroom_width) * mushroom_width + mushroom_width;
        }
        for(int ct = 0; ct < num; ct ++){
            int rand_x = rand.nextInt((BOARD_WIDTH - 2 * mushroom_width) / mushroom_width) * mushroom_width + mushroom_width;
            int rand_y = rand.nextInt(BOARD_HEIGHT * 4 / 5 / mushroom_height) * mushroom_height + mushroom_height;
            System.out.println(rand_y);
            mushrooms.add(new Mushroom(rand_x, rand_y));
        }
        return mushrooms;
    }

    private List<Centipede> generateCentipedes(int num){
        List<Centipede> centipedes = new ArrayList<>();
        ImageIcon temp_ii = new ImageIcon("src/images/mushroom0.png");
        Image temp = temp_ii.getImage();
        int centipede_width = temp.getWidth(null);
        int centipede_height = temp.getHeight(null);
        for(int ct = 0; ct < num; ct++){
            if(ct == 0){
                centipedes.add(new Centipede(BOARD_WIDTH - centipede_width,0));
            }
            else{
                centipedes.add(new Centipede(BOARD_WIDTH - centipede_width + ct * centipede_width, 0));
            }
        }
        return centipedes;
    }

    public void gameOver() {

        Graphics g = this.getGraphics();

        g.setColor(Color.black);
        g.fillRect(0, 0, BOARD_WIDTH, BOARD_HEIGHT);

        g.setColor(new Color(0, 32, 48));
        g.fillRect(50, BOARD_WIDTH / 2 - 30, BOARD_WIDTH - 100, 50);
        g.setColor(Color.white);
        g.drawRect(50, BOARD_WIDTH / 2 - 30, BOARD_WIDTH - 100, 50);

        Font small = new Font("Helvetica", Font.BOLD, 14);
        FontMetrics metr = this.getFontMetrics(small);

        g.setColor(Color.white);
        g.setFont(small);
        g.drawString("GAME OVER Score: " + score, (BOARD_WIDTH - metr.stringWidth("GAME OVER Score: " + score)) / 2,
                BOARD_WIDTH / 2);
    }

    public void gameWon() {

        Graphics g = this.getGraphics();

        g.setColor(Color.black);
        g.fillRect(0, 0, BOARD_WIDTH, BOARD_HEIGHT);

        g.setColor(new Color(0, 32, 48));
        g.fillRect(50, BOARD_WIDTH / 2 - 30, BOARD_WIDTH - 100, 50);
        g.setColor(Color.white);
        g.drawRect(50, BOARD_WIDTH / 2 - 30, BOARD_WIDTH - 100, 50);

        Font small = new Font("Helvetica", Font.BOLD, 14);
        FontMetrics metr = this.getFontMetrics(small);

        g.setColor(Color.white);
        g.setFont(small);
        g.drawString("GAME WON Score: " + score, (BOARD_WIDTH - metr.stringWidth("GAME WON Score: " + score)) / 2,
                BOARD_WIDTH / 2);
    }

    public class MAdaptor extends MouseAdapter {
        @Override public void mouseMoved(MouseEvent e) {
            //System.out.println("x = " + e.getX() + "y = " + e.getY());
            player.mouseMoved(e);
        }

        @Override public void mouseDragged(MouseEvent e) {
            //System.out.println("x = " + e.getX() + "y = " + e.getY());
            player.mouseMoved(e);
        }

        @Override public void mousePressed(MouseEvent e){
            //System.out.println("Mouse Pressed");
            player.mousePressed(e);
        }
    }
}

