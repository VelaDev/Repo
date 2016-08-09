package com.demo.dao.impl;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.demo.model.Tickets;



public class JavaMail {
	
	
 
  public static void sendFromGMail( Tickets ticket) {
	  String []to = {ticket.getEmployee().getEmail(),ticket.getProduct().getClient().getEmail()};
	  String from="cassino.happies@gmail.com";
      String pass="C@ss@no27";
      String body = "Hi "+ ticket.getEmployee().getFirstName()+","+ "\n\nTicket " + ticket.getTicketNumber() + " is assigned to you.\n\nProduct "+ ticket.getProduct().getSerialNumber()+" with description "+ ticket.getDescription() +"\n\nKind Regards\nVelaphanda Team";
      String subject ="Ticket No "+ ticket.getTicketNumber();

    Properties props = System.getProperties();
    String host = "smtp.gmail.com";
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.user", from);
    props.put("mail.smtp.password", pass);
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");

    Session session = Session.getDefaultInstance(props);
    MimeMessage message = new MimeMessage(session);

    try {
        message.setFrom(new InternetAddress(from));
        InternetAddress[] toAddress = new InternetAddress[to.length];

        // To get the array of addresses
        for( int i = 0; i < to.length; i++ ) {
            toAddress[i] = new InternetAddress(to[i]);
        }

        for( int i = 0; i < toAddress.length; i++) {
            message.addRecipient(Message.RecipientType.TO, toAddress[i]);
        }

        message.setSubject(subject);
        message.setText(body);
        Transport transport = session.getTransport("smtp");
        transport.connect(host, from, pass);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
    }
    catch (AddressException ae) {
        ae.printStackTrace();
    }
    catch (MessagingException me) {
        me.printStackTrace();
    }
}

}
