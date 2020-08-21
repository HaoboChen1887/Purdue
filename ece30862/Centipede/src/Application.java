import java.awt.*;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import java.awt.EventQueue;
import java.awt.event.MouseListener;

public class Application extends JFrame{
	public Application(){
		initUI();
	}

	private void initUI(){
		add(new Board());

		setResizable(false);
		pack();

		setTitle("Centipede");
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setLocationRelativeTo(null);
	}

	public static void main(String[] args){
		EventQueue.invokeLater(() -> {
			Application app = new Application();
			app.setVisible(true);
		});
	}
}