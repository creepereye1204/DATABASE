package util;



import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	final String gmail="iostream1204@gmail.com";
	final String password="icenhzhdhqefzfnd";
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(gmail, password);
	}
	
	
}
