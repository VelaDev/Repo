package com.demo.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.demo.model.Tickets;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ){
   
    	/*final int[] original = new int[]{1, 1, 2, 8, 9, 8, 4, 7, 4, 9, 1, 1000, 1000};
        System.out.println(Arrays.toString(original));
        final int[] buckets = new int[1001];
        for (final int i : original) {
            buckets[i]++;
        }
        final int[] unique = new int[original.length];
        int count = 0;
        for (int i = 0; i < buckets.length; ++i) {
            if (buckets[i] > 0) {
                unique[count++] = i;
            }
        }
        final int[] compressed = new int[count];
        System.arraycopy(unique, 0, compressed, 0, count);
        System.out.println(Arrays.toString(compressed));*/
    	
    	/*SimpleDateFormat myFormat = new SimpleDateFormat("dd MM yyyy");
    	String inputString1 = "14 12 2016";
    	String inputString2 = "18 02 2017";

    	try {
    	    Date date1 = myFormat.parse(inputString1);
    	    Date date2 = myFormat.parse(inputString2);
    	    long diff = date2.getTime() - date1.getTime();
    	    System.out.println ("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
    	} catch (ParseException e) {
    	    e.printStackTrace();
    	}
    }
*/
    	
    		/*String[] to = { "cassino.happies@gmail.com" };
    		String from = "helpdesk@velaphanda.co.za";
    		String pass = "@Vela1357";
    		String body = "Hi "  + ",";
    		String subject = "Ticket No ";
    		Properties props = System.getProperties();
    		String host = "smtp.mweb.co.za";
    		props.put("mail.smtp.starttls.enable", "true");
    		props.put("mail.smtp.host", host);
    		props.put("mail.smtp.user", from);
    		props.put("mail.smtp.password", pass);
    		props.put("mail.smtp.port", "25");
    		props.put("mail.smtp.auth", "true");

    		Session session = Session.getDefaultInstance(props);
    		MimeMessage message = new MimeMessage(session);

    		try {
    			message.setFrom(new InternetAddress(from));
    			InternetAddress[] toAddress = new InternetAddress[to.length];

    			// To get the array of addresses
    			for (int i = 0; i < to.length; i++) {
    				toAddress[i] = new InternetAddress(to[i]);
    			}

    			for (int i = 0; i < toAddress.length; i++) {
    				message.addRecipient(Message.RecipientType.TO, toAddress[i]);
    			}

    			message.setSubject(subject);
    			message.setText(body);
    			Transport transport = session.getTransport("smtp");
    			transport.connect(host, from, pass);
    			transport.sendMessage(message, message.getAllRecipients());
    			transport.close();
    		} catch (AddressException ae) {
    			ae.printStackTrace();
    		} catch (MessagingException me) {
    			me.printStackTrace();
    		}*/
    	String temID = "0001";
    	int recordID = 1;
    	
    	int newrecordID = Integer.valueOf(temID) + recordID;
    	
    	System.out.print(newrecordID);
    }}
		    

