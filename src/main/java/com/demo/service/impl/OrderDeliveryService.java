package com.demo.service.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.xml.sax.SAXException;

import com.demo.dao.OrderReportsDaoInt;
import com.demo.service.OrderDeliveryServiceInt;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.zugferd.exceptions.DataIncompleteException;
import com.itextpdf.text.zugferd.exceptions.InvalidCodeException;
import com.itextpdf.xmp.XMPException;


@Service("orderDelivery")
@Transactional
public class OrderDeliveryService implements OrderDeliveryServiceInt{

	
	@Autowired
	private OrderReportsDaoInt reportsDaoInt;
	@Override
	public void printReports(Long recordID){
			reportsDaoInt.printReports(recordID);
	}


	
}
