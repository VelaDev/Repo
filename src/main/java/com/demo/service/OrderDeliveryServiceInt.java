package com.demo.service;


import java.io.IOException;
import java.text.ParseException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.xml.sax.SAXException;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.zugferd.exceptions.DataIncompleteException;
import com.itextpdf.text.zugferd.exceptions.InvalidCodeException;
import com.itextpdf.xmp.XMPException;
public interface OrderDeliveryServiceInt {
	void createPdf(Long recordID)throws ParserConfigurationException, SAXException, TransformerException, IOException, DocumentException, XMPException, ParseException, DataIncompleteException, InvalidCodeException;
}
