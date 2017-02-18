package com.demo.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.concurrent.TimeUnit;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
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
    	
    	SimpleDateFormat myFormat = new SimpleDateFormat("dd MM yyyy");
    	String inputString1 = "18 02 2017";
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
}
		    

