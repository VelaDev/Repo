package com.demo.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
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
    public static void main( String[] args ) throws ParseException{
    	
    	String dateStart = "2017/08/08";
		String dateStop = "2017/08/13";

		//HH converts hour in 24 hours format (0-23), day calculation
		SimpleDateFormat format = new SimpleDateFormat("yyyy/mm/dd");

		Date d1 = null;
		Date d2 = null;

		try {
			d1 = format.parse(dateStart);
			d2 = format.parse(dateStop);

			//in milliseconds
			long diff = d2.getTime() - d1.getTime();
			System.out.println(diff);
			/*long diffSeconds = diff / 1000 % 60;
			long diffMinutes = diff / (60 * 1000) % 60;*/
			long diffHours = diff / (60 * 60 * 1000) % 24;
			long diffDays = diff / (24 * 60 * 60 * 1000);

			System.out.print(diffDays + " days, ");
			System.out.print(diffHours + " hours, ");
		/*	System.out.print(diffMinutes + " minutes, ");
			System.out.print(diffSeconds + " seconds.");*/

		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
