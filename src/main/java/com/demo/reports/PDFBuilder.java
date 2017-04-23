package com.demo.reports;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.demo.dao.OrderDetailsDaoInt;
import com.demo.model.AbstractITextPdfView;
import com.demo.model.OrderDetails;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFBuilder extends AbstractITextPdfView{
	
	@Autowired
	private OrderDetailsDaoInt orderDetailsDao;

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc,
			PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// get data model which is passed by the Spring container
		List<OrderDetails> orderDetails = orderDetailsDao.getOrderDetailsByOrderNum(1);
		
		doc.add(new Paragraph("Orders"));
		
		PdfPTable table = new PdfPTable(5);
		table.setWidthPercentage(100.0f);
		table.setWidths(new float[] {3.0f, 2.0f, 2.0f, 2.0f, 1.0f});
		table.setSpacingBefore(10);
		
		// define font for table header row
		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setColor(BaseColor.WHITE);
		
		// define table header cell
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(BaseColor.BLUE);
		cell.setPadding(5);
		
		// write table header 
		cell.setPhrase(new Phrase("Part NUmber", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Description", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("QTY Ordered", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("QTY Delivered", font));
		table.addCell(cell);
		
		
		// write table row data
		for (OrderDetails ordDetails : orderDetails) {
			table.addCell(ordDetails.getPartNumber());
			table.addCell(ordDetails.getItemDescription());
			table.addCell(""+ordDetails.getQuantity());
			table.addCell(""+ordDetails.getQuantity());
		}
		
		doc.add(table);
		
	}


}
