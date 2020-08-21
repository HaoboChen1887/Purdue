import java.awt.*;
import java.awt.geom.AffineTransform;
import javax.swing.ImageIcon;
import javax.swing.JFrame;

public class ImageSpeedTest2 extends JFrame {

    public static void main(String args[]) {

        DisplayMode displayMode;

        if (args.length == 3) {
            displayMode = new DisplayMode(
                Integer.parseInt(args[0]),
                Integer.parseInt(args[1]),
                Integer.parseInt(args[2]),
                DisplayMode.REFRESH_RATE_UNKNOWN);
        }
        else {
            displayMode = new DisplayMode(800, 600, 16,
                DisplayMode.REFRESH_RATE_UNKNOWN);
        }

        ImageSpeedTest2 test = new ImageSpeedTest2();
        test.run(displayMode);
    }

    private static final int FONT_SIZE = 24;
    private static final long TIME_PER_IMAGE = 1500;

    private SimpleScreenManager screen;
    private Image bgImage;
    private Image opaqueImage;
    private Image transparentImage;
    private Image translucentImage;
    private Image antiAliasedImage;
    private boolean imagesLoaded;

    public void run(DisplayMode displayMode) {
        setBackground(Color.blue);
        setForeground(Color.white);
        setFont(new Font("Dialog", Font.PLAIN, FONT_SIZE));
        imagesLoaded = false;

        screen = new SimpleScreenManager();
        try {
            screen.setFullScreen(displayMode, this);
            synchronized (this) {
                loadImages();
                // wait for test to complete
                try {
                    wait();
                }
                catch (InterruptedException ex) { }
            }
        }
        finally {
            screen.restoreScreen();
        }
    }


    public void loadImages() {
        bgImage = loadImage("images/background.jpg");
        opaqueImage = loadImage("images/opaque.png");
        transparentImage = loadImage("images/transparent.png");
        translucentImage = loadImage("images/translucent.png");
        antiAliasedImage = loadImage("images/antialiased.png");
        imagesLoaded = true;
        // signal to AWT to repaint this window
        repaint();
    }


    private final Image loadImage(String fileName) {
        return new ImageIcon(fileName).getImage();
    }


    public void paint(Graphics g) {
        // set text anti-aliasing
        if (g instanceof Graphics2D) {
            Graphics2D g2 = (Graphics2D)g;
            g2.setRenderingHint(
                RenderingHints.KEY_TEXT_ANTIALIASING,
                RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        }

        // draw images
        if (imagesLoaded) {
            drawImage(g, opaqueImage, "Opaque", false);
            drawImage(g, transparentImage, "Transparent", false);
            drawImage(g, translucentImage, "Translucent", false);
            drawImage(g, antiAliasedImage,
              "Translucent (Anti-Aliased)", false);

            drawImage(g, opaqueImage, "Opaque (Flipped)", true);
            drawImage(g, transparentImage,
                "Transparent (Flipped)", true);
            drawImage(g, translucentImage,
                "Translucent (Flipped)", true);
            drawImage(g, antiAliasedImage,
              "Translucent (Anti-Aliased, Flipped)", true);

            // notify that the test is complete
            synchronized (this) {
                notify();
            }
        }
        else {
            g.drawString("Loading Images...", 5, FONT_SIZE);
        }
    }


    public void drawImage(Graphics g1, Image image, String name,
        boolean flip)
    {
        Graphics2D g = (Graphics2D)g1;
        AffineTransform transform = new AffineTransform();
        int width = screen.getFullScreenWindow().getWidth() -
            image.getWidth(null);
        int height = screen.getFullScreenWindow().getHeight() -
            image.getHeight(null);
        int numImages = 0;

        g.drawImage(bgImage, 0, 0, null);

        long startTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - startTime
            < TIME_PER_IMAGE)
        {
            int x = Math.round((float)Math.random() * width);
            int y = Math.round((float)Math.random() * height);
            transform.setToTranslation(x, y);

            // if the sprite is moving left, flip the image
            if (flip) {
                transform.scale(-1, 1);
                transform.translate(-image.getWidth(null), 0);
            }

            // draw it
            g.drawImage(image, transform, null);
            numImages++;
        }
        long time = System.currentTimeMillis() - startTime;
        float speed = numImages * 1000f / time;
        System.out.println(name + ": " + speed + " images/sec");

    }

}
