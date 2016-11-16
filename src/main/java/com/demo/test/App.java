package com.demo.test;

import java.util.Random;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
    	String text = "VeLaPhAnDa";
    	String text1 = "EmPlOYeEs";
    	String text2 = "PaSsWoRd";
    	String text3= "GeNeRaToRFroMAToZ";
    	String text4 = "CqXxHkB";
    	String text5 = "1234567890";
    	String specialCaractors ="!@#$%^&*";
    	
    	Random random = new Random();
    	String retPassword ="";
    	
    	int select = random.nextInt(text.length());
    	int select1 = random.nextInt(text1.length());
    	int select2 = random.nextInt(specialCaractors.length());
    	int select3 = random.nextInt(text3.length());
    	int select4 = random.nextInt(text5.length());
    	int select5 = random.nextInt(text5.length());
    	int select6 = random.nextInt(text2.length());
    	retPassword ="V"+text.charAt(select)+ text1.charAt(select1)+ specialCaractors.charAt(select2)+ text3.charAt(select3)+text5.charAt(select5)+text4.charAt(select4)+text2.charAt(select6);
		System.out.println(retPassword);
    }
}
		    

