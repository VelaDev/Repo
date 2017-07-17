package com.demo.dao.impl;



import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.xml.sax.SAXException;







import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrderReportsDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.CustomerContactDetails;
import com.demo.model.OrderDetails;
import com.demo.model.OrderHeader;
import com.demo.model.VelaphandaProfile;
import com.demo.service.VelaphandaInt;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ICC_Profile;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.zugferd.exceptions.DataIncompleteException;
import com.itextpdf.text.zugferd.exceptions.InvalidCodeException;
import com.itextpdf.xmp.XMPException;

@Repository("orderReportDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderReportsDao implements OrderReportsDaoInt {

	private Date currentDate;
	private SimpleDateFormat dateFormat;
	static Calendar cal = Calendar.getInstance();
	String home = System.getProperty("user.home");
	String folderName =home+"/Downloads/Velaphanda Reports";
	
	/*String dateTimeStamp =  dateFormat.format(cal.getTime());
	String reportName = "DeliveryNote"+dateTimeStamp+".pdf";*/
	
	
	public static final String DEST = "folderName";
	public static final String ICC = "C:/Users/Mohapi/git/Repo/src/main/java/resources/sRGB_CS_profile.icm";
	public static final String FONT = "/resources/OpenSans-Regular.ttf";
	public static final String FONTB = "/resources//OpenSans-Bold.ttf";

	protected Font font8;
	protected Font font8b;
	protected Font font10;
	protected Font font10b;
	protected Font font12;
	protected Font font12b;
	protected Font font14;
	protected Font font14b;
	protected Font font18;
	protected Font font18b;
	
	@Autowired
	private OrdersDaoInt ordersDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	@Autowired
	private CustomerContactDetailsDaoInt contactDetails;
	@Autowired
	private VelaphandaInt velaphandaInt;
	
	private OrderHeader orderHeader;
	private CustomerContactDetails customerContact;
	private VelaphandaProfile profile;
	
	
	@Override
	public void createPdf(Integer recordID)throws ParserConfigurationException, SAXException,
	TransformerException, IOException, DocumentException, XMPException,
	ParseException, DataIncompleteException, InvalidCodeException {

		// String dest = String.format(DEST, invoice.getId());
		Document document = new Document(PageSize.A4.rotate());
		
		orderHeader = ordersDaoInt.getOrder(recordID);
		profile = velaphandaInt.getVelaphandaAddress("Velaphanda Trading & Projects");
		// PdfAWriter writer = PdfAWriter.getInstance(document, new
		// FileOutputStream(DEST), PdfAConformanceLevel.ZUGFeRDBasic);
		
		
		PdfWriter writer ;
		
		boolean file = new File(folderName).mkdir(); 
		if(!file){
			writer = PdfWriter.getInstance(document,
					new FileOutputStream(folderName+"/"+orderHeader.getOrderNum()+".pdf"));
			writer.setPdfVersion(PdfWriter.VERSION_1_7);
		}else{  
			writer = PdfWriter.getInstance(document,
					new FileOutputStream(folderName+"/"+orderHeader.getOrderNum()+".pdf"));
			writer.setPdfVersion(PdfWriter.VERSION_1_7);
		}
		
		
		/*PdfWriter writer = PdfWriter.getInstance(document,
				new FileOutputStream(DEST+"/"+orderHeader.getOrderNum()+".pdf"));
		writer.setPdfVersion(PdfWriter.VERSION_1_7);*/

		//Get payment information from order table
		orderHeader = ordersDaoInt.getOrder(recordID);
		currentDate = new Date();
		dateFormat = new SimpleDateFormat();
	
		
		
		// writer.createXmpMetadata();
		// writer.getXmpWriter().setProperty(PdfAXmpWriter.zugferdSchemaNS,
		// PdfAXmpWriter.zugferdDocumentFileName, "ZUGFeRD-invoice.xml");
		document.open();

		ICC_Profile icc = ICC_Profile.getInstance(new FileInputStream(ICC));
		writer.setOutputIntents("Custom", "", "http://www.color.org",
				"sRGB IEC61966-2.1", icc);

		// Current Time Stamp
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		

		PdfPTable table = new PdfPTable(1);
		table.setWidthPercentage(30);
		Image img = Image
				.getInstance("C:/Users/Mohapi/git/Repo/src/main/webapp/WEB-INF/resources/images/mainlogo.jpg");
		img.setWidthPercentage(1);
		PdfPCell cell = new PdfPCell(img);
		cell.setBorder(PdfPCell.NO_BORDER);
		table.addCell(cell);
		document.add(table);
		//Rotate event = new Rotate();

		table = new PdfPTable(3);
		table.setWidthPercentage(100);
		
		if(orderHeader.getStockType().equalsIgnoreCase("Site"))
		{
			customerContact = contactDetails.getContactPerson(orderHeader.getCustomer().getCustomerName());
			// Customer Address
			PdfPCell customerAddress = getCustomerAddress("DELIVER TO:",
					orderHeader.getCustomer().getCustomerName(), orderHeader.getCustomer().getStreetNumber()+" "+orderHeader.getCustomer().getStreetName(),orderHeader.getCustomer().getCity_town(),
					"Contact Person: "+customerContact.getFirstName()+" "+customerContact.getLastName(), "Contact No: "+ customerContact.getContactCellNumber(),
					"E-Mail: "+ customerContact.getContactEmail());
			table.addCell(customerAddress);
		}else if(orderHeader.getStockType().equalsIgnoreCase("Boot")){
			// Customer Address
			PdfPCell customerAddress = getCustomerAddress("DELIVER TO:",
					"Contact Person: "+orderHeader.getEmployee().getFirstName()+" "+orderHeader.getEmployee().getLastName() , "Contact No: "+orderHeader.getEmployee().getCellNumber() ,
					"E-Mail: "+ orderHeader.getEmployee().getEmail(),"","","");
			table.addCell(customerAddress);
		}
		PdfPCell velaphandaAddress = getVelaphandaAddress("DELIVERY NOTE",profile.getCompanyName(), "REG NO:2008/164490/23",
				"POSTNET SUITE 357, PRIVATE BAG X1028", "LYTTLETON 0140",
				"TEL: "+profile.getTelephoneNumber()+" FAX: " + profile.getFaxNumber(),
				"E-MAIL: "+ profile.getEmailAdress());
		table.addCell(velaphandaAddress);

		PdfPCell paymentInformation = getPaymentInformation(
				"PAYMENT INFORMATION", "DATE OF DELIVERY: 10 OCTOBER 2016",
				"DELIVERY NOTE NO: Mad/OCT/01", "ORDER NO: "+orderHeader.getOrderNum(),
				"CUSTOMER VAT NO:", "CONTRACT NO:", "WAYBILL NO:",
				"PLEASE REMIT TO admin@velaphanda.co.za");

		table.addCell(paymentInformation);

		document.add(table);

		// Line Item
		table = new PdfPTable(4);
		table.setWidthPercentage(100);
		table.setSpacingBefore(10);
		table.setSpacingAfter(10);
		
		List<OrderDetails> listItems = detailsDaoInt.getOrderDetailsByOrderNum(recordID);

		table.setWidths(new int[] { 5, 7, 3, 3 });

		table.addCell(getCell("Part Number:", Element.ALIGN_LEFT, font10b));
		table.addCell(getCell("Description:", Element.ALIGN_LEFT, font10b));
		table.addCell(getCell("Qty Ordered:", Element.ALIGN_LEFT, font10b));
		table.addCell(getCell("Qty Delivered:", Element.ALIGN_LEFT, font10b));

		for(OrderDetails ordDetails:listItems){
			
			table.addCell(getlineItemCell(ordDetails.getPartNumber(), font8));
			table.addCell(getlineItemCell(ordDetails.getItemDescription(), font8));
			table.addCell(getlineItemCell(""+ordDetails.getQuantity(), font8));
			table.addCell(getlineItemCell(""+ordDetails.getQuantity(), font8));
			
		
		}
		document.add(table);
		// Signature
		table = new PdfPTable(2);
		cell.setBorder(PdfPCell.NO_BORDER);
		table.setWidthPercentage(100);
		table.setSpacingBefore(10);
		table.setSpacingAfter(10);
		table.setWidths(new int[] { 10, 10 });

		table.addCell(signature(
				"Received By:___________________________________", font8b));
		table.addCell(signature(
				"Print Name & Surname:_____________________________", font8b));

		table.addCell(signature(
				"Signature:_____________________________________", font8b));
		table.addCell(signature(
				"Date/Time Received:_______________________________", font8b));

		document.add(table);

		document.close();

	}

	public String convertDate(Date d, String newFormat) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(newFormat);
		return sdf.format(d);
	}

	public OrderReportsDao() throws DocumentException, IOException {
		BaseFont bf = BaseFont.createFont(FONT, BaseFont.WINANSI,
				BaseFont.EMBEDDED);
		BaseFont bfb = BaseFont.createFont(FONTB, BaseFont.WINANSI,
				BaseFont.EMBEDDED);
		font8 = new Font(bf, 8);
		font8b = new Font(bfb, 8);
		font10 = new Font(bf, 10);
		font10b = new Font(bfb, 10);
		font12 = new Font(bf, 12);
		font12b = new Font(bfb, 12);
		font14 = new Font(bf, 14);
		font14b = new Font(bfb, 14);
		font18 = new Font(bf, 18);
		font18b = new Font(bfb, 18);
	}

	public PdfPCell getCustomerAddress(String customer, String streetNumber,
			String streetName, String city, String contactPerson,
			String contactNumber, String email) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(PdfPCell.NO_BORDER);
		cell.addElement(new Paragraph(customer, font12b));
		cell.addElement(new Paragraph(streetNumber, font8));
		cell.addElement(new Paragraph(streetName, font8));
		cell.addElement(new Paragraph(city, font8));
		cell.addElement(new Paragraph(contactPerson, font8));
		cell.addElement(new Paragraph(contactNumber, font8));
		cell.addElement(new Paragraph(email, font8));
		return cell;
	}

	public PdfPCell getVelaphandaAddress(String heading, String companyName,
			String registration, String address, String address1,
			String telephone, String email) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(PdfPCell.NO_BORDER);
		cell.addElement(new Paragraph(heading, font12b));
		cell.addElement(new Paragraph(companyName, font8));
		cell.addElement(new Paragraph(registration, font8));
		cell.addElement(new Paragraph(address, font8));
		cell.addElement(new Paragraph(address1, font8));
		cell.addElement(new Paragraph(telephone, font8));
		cell.addElement(new Paragraph(email, font8));

		return cell;
	}

	public PdfPCell getPaymentInformation(String heading, String date,
			String noteNumber, String orderNumber, String customerVatNumber,
			String contractNumber, String wayToBill, String message) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(PdfPCell.NO_BORDER);
		cell.addElement(new Paragraph(heading, font12b));
		cell.addElement(new Paragraph(date, font8));
		cell.addElement(new Paragraph(noteNumber, font8));
		cell.addElement(new Paragraph(orderNumber, font8));
		cell.addElement(new Paragraph(customerVatNumber, font8));
		cell.addElement(new Paragraph(contractNumber, font8));
		cell.addElement(new Paragraph(wayToBill, font8));
		cell.addElement(new Paragraph(message, font8));

		return cell;
	}

	public PdfPCell getCustomerContacts(String contactPerson,
			String contactNumber, String email) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(PdfPCell.NO_BORDER);
		cell.addElement(new Paragraph(contactPerson, font8));
		cell.addElement(new Paragraph(contactNumber, font8));
		cell.addElement(new Paragraph(email, font8));

		return cell;
	}

	public PdfPCell getlineItemCell(String value, Font font) {
		PdfPCell cell = new PdfPCell();
		cell.setUseAscender(true);
		cell.setUseDescender(true);
		Paragraph p = new Paragraph(value, font);
		cell.addElement(p);
		return cell;
	}

	public PdfPCell signature(String value, Font font) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(PdfPCell.NO_BORDER);
		cell.setUseAscender(true);
		cell.setUseDescender(true);
		Paragraph p = new Paragraph(value, font);
		cell.addElement(p);
		return cell;
	}

	public PdfPCell getCell(String value, int alignment, Font font) {
		PdfPCell cell = new PdfPCell();
		cell.setUseAscender(true);
		cell.setUseDescender(true);
		Paragraph p = new Paragraph(value, font);
		p.setAlignment(alignment);
		cell.addElement(p);
		return cell;
	}

}
