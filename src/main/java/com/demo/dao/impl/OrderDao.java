package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.OrdersBean;
import com.demo.dao.ApprovedOrderStockDaoInt;
import com.demo.dao.BootStockDaoInt;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrderHistoryDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.HOStockDaoInt;
import com.demo.dao.SiteStocDaoInt;
import com.demo.dao.TicketHistoryDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.OrderHeader;
import com.demo.model.OrderDetails;
import com.demo.model.HOStock;
import com.demo.model.Device;
import com.demo.model.Tickets;

@Repository("orderDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderDao implements OrdersDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	private Session session2;
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	@Autowired
	private HOStockDaoInt hOStockDaoInt;
	@Autowired
	private DeviceDaoInt deviceDaoInt;
	@Autowired
	private CustomerDaoInt customerDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	@Autowired
	private ApprovedOrderStockDaoInt approvedOrderStockDaoInt;
	@Autowired
	private SiteStocDaoInt siteStocDaoInt;
	@Autowired
	private BootStockDaoInt bootStockDaoInt;
	@Autowired
	private OrderHistoryDaoInt historyDaoInt;
	@Autowired
	private TicketsDaoInt ticketsDaoInt;
	@Autowired
	private TicketHistoryDaoInt ticketHistoryDaoInt;
	private OrderHeader orderHeader = null;
	

	private String retMessage = null;
	private Customer cus;
	private Employee emp = null;
	private HOStock part = null;
	private Device device = null;
	private OrderHeader cusOrder = null;
	private DateFormat dateFormat = null;
	private Date date = null;
	private List<OrderDetails> orderDetailList = null;
	private OrderDetails orderDetails = null;
	private List<OrderHeader> pendingOrders;
	private List<OrderDetails> listOrders;

	@Override
	public String makeOrder(OrderHeader orderHeader) {
		emp = employeeDaoInt.getEmployeeByEmpNum(orderHeader.getApprover());
		try {
			sessionFactory.getCurrentSession().save(orderHeader);
			JavaMail.sendEmail(orderHeader.getApprover(), orderHeader
					.getEmployee().getEmail(), emp.getFirstName(), orderHeader);
			
			
			historyDaoInt.insetOrderHistory(orderHeader);
			retMessage = "Order : " + " " + orderHeader.getOrderNum() + " "
					+ "successfuly placed.";
		} catch (Exception e) {
			retMessage = "Order : " + " " + orderHeader.getOrderNum() + " "
					+ "not placed " + e.getMessage()+".";
		}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean orders) {

		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String n = " ";
		cusOrder = new OrderHeader();
		try {

			part = hOStockDaoInt.getSparePartBySerial(orders.getPart());
			device = deviceDaoInt.getDeviceBySerialNumbuer(orders.getDevice());
			emp = employeeDaoInt.getEmployeeByEmpNum(orders.getEmployee());
			if (part != null) {
				orders.setApproved(true);
				orders.setDateApproved(dateFormat.format(date));
				String approvedBy = (String) session
						.getAttribute("loggedInUser");
				orders.setOrderNum(orders.getOrderNum());
				cusOrder.setEmployee(emp);
				cusOrder.setDateOrdered(orders.getDateOrdered());

				sessionFactory.getCurrentSession().update(cusOrder);
				historyDaoInt.insetOrderHistory(cusOrder);
				retMessage = "Order " + " " + cusOrder.getOrderNum() + " "
						+ "is approved.";
			} else {
				retMessage = "Order " + " " + n + cusOrder.getOrderNum() + " "
						+ "not approved because it"
						+ " is not available in store.";
			}

		} catch (Exception e) {
			retMessage = "Order " + " " + orders.getOrderNum() + " "
					+ "not updated " + e.getMessage()+".";
		}
		return retMessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderHeader> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				OrderHeader.class);
		return (List<OrderHeader>) criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderHeader> getApprovedOrdersByTechnicianName(String userName) {

		ArrayList<OrderHeader> aList = new ArrayList<OrderHeader>();
		ArrayList<OrderHeader> orderList = new ArrayList<OrderHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				OrderHeader.class);

		aList.addAll(criteria.list());
		for (Object order : aList) {
			if (order instanceof OrderHeader) {
				if (((OrderHeader) order).getEmployee().getEmail()
						.equalsIgnoreCase(userName)
						&& ((OrderHeader) order).isApproved() == true) {
					orderList.add((OrderHeader) order);
				}
			}
		}
		return orderList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderHeader> getOpenOrders() {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<OrderHeader> orderList = new ArrayList<OrderHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				OrderHeader.class);

		aList.addAll(criteria.list());
		for (Object order : aList) {
			if (order instanceof OrderHeader) {
				if (((OrderHeader) order).getStatus().equalsIgnoreCase(
						"Approved")) {
					orderList.add((OrderHeader) order);
				}
			}
		}
		return orderList;
	}

	@Override
	public OrderHeader getOrder(Integer recordID) {

		return (OrderHeader) sessionFactory.getCurrentSession().get(
				OrderHeader.class, recordID);
	}

	private Integer getRecordID() {

		session2 = sessionFactory.openSession();
		Integer result = (int) 1L;
		Query query = session2
				.createQuery("from OrderHeader order by recordID DESC");
		query.setMaxResults(1);
		OrderHeader orderNumber = (OrderHeader) query.uniqueResult();

		if (orderNumber != null) {
			result = orderNumber.getRecordID();
		} else {
			result = null;
		}
		return result;
	}

	private Integer newRecordID() {
		int tempOrderNum = 0;
		Integer newOrderNum = getRecordID();

		if (newOrderNum != null) {
			tempOrderNum = newOrderNum + 1;
		} else {
			tempOrderNum = 1;
		}

		return tempOrderNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderHeader> getAllOrders(String orderedBy) {
		List<OrderHeader> aList = getAllOrders();
		ArrayList<OrderHeader> orderList = new ArrayList<OrderHeader>();
		

		for (OrderHeader order : aList) {
			if(order.getEmployee().getEmail().equalsIgnoreCase(orderedBy)&& ((order.getStatus().equalsIgnoreCase("Pending"))||(order.getStatus().equalsIgnoreCase("Approved"))||(order.getStatus().equalsIgnoreCase("Shipped")))){
				orderList.add(order);
			}
		}
		return orderList;
	}

	@Override
	public String prepareOrderMaking(OrdersBean orderBean) {
		orderDetailList = new ArrayList<OrderDetails>();

		cusOrder = new OrderHeader();
		String orderNumber = null;
		Integer recordID = 1;
		String[] split;
		String partNumber,splitString = null;
		int quatity = 0;

		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String[] quantityArray = quantity(orderBean.getQuantity(),
				orderBean.getSelectedItem().length);

		try {

			Employee user = (Employee) session.getAttribute("loggedInUser");
			emp = employeeDaoInt.getEmployeeByEmpNum(user.getEmail());
			String customer = orderBean.getCustomer();
			if(customer !=null){
				cus = customerDaoInt.getClientByClientName(customer);
				cusOrder.setCustomer(cus);
			}
			if(emp.getRole().equalsIgnoreCase("Manager")){
				cusOrder.setApprover(emp.getEmail());
				
				emp = employeeDaoInt.getEmployeeByEmpNum(orderBean.getTechnicianUserName());
				cusOrder.setEmployee(emp);
				String tempTechnician = emp.getFirstName() + " " +emp.getLastName();
			}
			else{
				cusOrder.setEmployee(emp);
				cusOrder.setApprover(orderBean.getApprover());
			}
			cusOrder.setStockType(orderBean.getStockType());
			cusOrder.setStatus("Pending");
			
			recordID = newRecordID();
			orderNumber = "ORD00" + recordID;
			cusOrder.setRecordID(recordID);
			cusOrder.setOrderNum(orderNumber);
			
			cusOrder.setApproved(false);
			cusOrder.setDateOrdered(dateFormat.format(date));

			for (int i = 0; i < orderBean.getSelectedItem().length; i++) {
				orderDetails = new OrderDetails();
				splitString = orderBean.getSelectedItem()[i];
				split = splitString.split(",");
				partNumber = split[0];
				
				part = hOStockDaoInt.getSparePartBySerial(partNumber);
				if(part != null){
					quatity = Integer.parseInt(quantityArray[i]);
					orderDetails.setPartNumber(partNumber);
					orderDetails.setCompatibleDevice(part.getCompitableDevice());
					orderDetails.setItemDescription(part.getItemDescription());
					orderDetails.setModel(part.getCompitableDevice());
					orderDetails.setQuantity(quatity);
					orderDetails.setLocation(orderBean.getLocation());
					orderDetails.setStockType(cusOrder.getStockType());
					orderDetails.setItemType(part.getItemType());
					if(orderBean.getTechnician()!= null){
						orderDetails.setTechnician(orderBean.getTechnician());
					}
					else{
						orderDetails.setTechnician(emp.getFirstName()+" " +emp.getLastName());
					}
					orderDetails.setOrderHeader(cusOrder);
					orderDetails.setDateTime(dateFormat.format(date));

					orderDetailList.add(orderDetails);
				}
				
			}

			retMessage = makeOrder(cusOrder);
			String retMsg = detailsDaoInt.saveOrderDetails(orderDetailList);
		} catch (Exception ex) {
			retMessage = "Order cannot be proccessed.";
		}
		return retMessage;
	}

	private String[] quantity(String[] arr, int length) {
		String[] newQuantity = new String[length];
		int x = 0;
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] != "") {
				newQuantity[x] = arr[i];
				x++;
			}
		}
		return newQuantity;

	}

	@Override
	public List<OrderHeader> pendingOrders() {
		ArrayList<OrderHeader> pendingList = new ArrayList<OrderHeader>();
		try {
			pendingOrders = getAllOrders();
			for (OrderHeader orderHeader : pendingOrders) {
				if (orderHeader.getStatus().equalsIgnoreCase("Pending")) {
					pendingList.add(orderHeader);
				}
			}
		} catch (Exception e) {

		}
		return pendingList;
	}

	public List<OrderHeader> receivedOrders() {
		ArrayList<OrderHeader> pendingList = new ArrayList<OrderHeader>();
		try {
			pendingOrders = getAllOrders();
			for (OrderHeader orderHeader : pendingOrders) {
				if (orderHeader.getStatus().equalsIgnoreCase("Received")) {
					pendingList.add(orderHeader);
				}
			}
		} catch (Exception e) {

		}
		return pendingList;
	}

	@Override
	public String approveOrder(Integer recordID) {
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		
		try {
			cusOrder = getOrder(recordID);
			
			
			orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
			retMessage = subtractOrderItems(orderDetailList);
			if (retMessage.equalsIgnoreCase("Ok")) {

				cusOrder.setStatus("Approved");
				cusOrder.setApproved(true);
				cusOrder.setDateApproved(dateFormat.format(date));
				sessionFactory.getCurrentSession().update(cusOrder);
				listOrders = detailsDaoInt.getOrderDetailsByOrderNum(recordID);

				String addStockToApprovedTable = approvedOrderStockDaoInt
						.approveOrderStock(listOrders);
				
				emp = employeeDaoInt.getEmployeeByEmpNum(cusOrder.getApprover());
				JavaMail.sendEmailForOrderApproved(cusOrder.getEmployee().getEmail(), cusOrder.getApprover(), emp.getFirstName(), cusOrder.getEmployee().getFirstName(), cusOrder);
				historyDaoInt.insetOrderHistory(cusOrder);
				retMessage = "Order " + cusOrder.getOrderNum() + " approved.";
			} else {
				retMessage = "Order cannot be approved because ordered items are more that available items.";
			}

		} catch (Exception e) {
			retMessage = "Order " + cusOrder.getOrderNum() + " not approved.";
		}
		return retMessage;
	}

	private String subtractOrderItems(List<OrderDetails> orderDetails) {
		int tempQuantity = 0;

		try {
			for (OrderDetails subtractQuatity : orderDetails) {
				part = hOStockDaoInt.getSparePartBySerial(subtractQuatity
						.getPartNumber());
				tempQuantity = part.getQuantity()
						- subtractQuatity.getQuantity();
				if (tempQuantity >= 0) {

					part.setQuantity(tempQuantity);
					sessionFactory.getCurrentSession().update(part);
					retMessage = "Ok";
				} else {
					retMessage = "Error";
					break;
				}
			}

		} catch (Exception e) {

		}
		return retMessage;
	}

	@Override
	public List<OrderHeader> pendingOrders(String approveName) {
		List<OrderHeader> pendingOrder = new ArrayList<OrderHeader>();
		try {
			List<OrderHeader> pendingForApprover = pendingOrders();

			for (OrderHeader order : pendingForApprover) {
				if (order.getApprover().equalsIgnoreCase(approveName)) {

					pendingOrder.add(order);
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return pendingOrder;
	}

	@Override
	public String approveShipment(Integer recordID) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		orderHeader = getOrder(recordID);
		date = new Date();
		if(orderHeader!=null && orderHeader.getStatus().equalsIgnoreCase("Approved")){
			
			orderHeader.setStatus("Shipped");
			orderHeader.setShippingDate(dateFormat.format(date));
			sessionFactory.getCurrentSession().update(orderHeader);
			JavaMail.sendEmailForShipment(orderHeader.getApprover(),orderHeader);
			historyDaoInt.insetOrderHistory(orderHeader);
			retMessage = "Order Number "+ orderHeader.getOrderNum()+" shipped to "+ orderHeader.getEmployee().getFirstName()+ " "+orderHeader.getEmployee().getLastName()+".";
		}
		else if (orderHeader!=null && orderHeader.getStatus().equalsIgnoreCase("Shipped")){
			orderHeader.setStatus("Received");
			orderHeader.setOrderReceivedDateTime(dateFormat.format(date));
			
			sessionFactory.getCurrentSession().update(orderHeader);
			historyDaoInt.insetOrderHistory(orderHeader);
			List<Tickets> ticketList = ticketsDaoInt.getAwaitingSparesTickets();
			for(Tickets tick:ticketList){
				if(tick.getOrderHeader().getOrderNum().equalsIgnoreCase(orderHeader.getOrderNum())){
					tick.setStatus("Open");
					tick.setDateTime(dateFormat.format(date));
					sessionFactory.getCurrentSession().update(tick);
					ticketHistoryDaoInt.insertTicketHistory(tick);
				}
				
			}
			
			if(orderHeader.getStockType().equalsIgnoreCase("Site")){
				orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
				siteStocDaoInt.saveSiteStock(orderDetailList);
				retMessage = "Order Number "+ orderHeader.getOrderNum()+" now available for site "+ orderHeader.getCustomer().getCustomerName()+".";
			}
			else{
				orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
				 bootStockDaoInt.saveBootStock(orderDetailList);;
				 retMessage = "Order Number "+ orderHeader.getOrderNum()+" now available in boot stock for "+ orderHeader.getEmployee().getFirstName() +" "+ orderHeader.getEmployee().getLastName()+".";
			}
		}
		return retMessage;
	}

	@Override
	public List<OrderHeader> shippedOrders() {
		pendingOrders = getAllOrders();
		List<OrderHeader> pendingOrder = new ArrayList<OrderHeader>();
		try{
			for(OrderHeader orderHeader:pendingOrders){
				if(orderHeader.getStatus().equalsIgnoreCase("Shipped")){
					pendingOrder.add(orderHeader);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		return pendingOrder;
	}@Override
	public List<OrderHeader> shippedOrders(String technicianEmail){
		pendingOrders = getAllOrders();
		List<OrderHeader> pendingOrder = new ArrayList<OrderHeader>();
		try{
			for(OrderHeader orderHeader:pendingOrders){
				if(orderHeader.getStatus().equalsIgnoreCase("Shipped") && orderHeader.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					pendingOrder.add(orderHeader);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		return pendingOrder;
	}

	@Override
	public String declineOrder(String orderNum,String reasonForeclined) {
		try{
			cusOrder = declineOrder(orderNum);
			cusOrder.setComments(reasonForeclined);
			cusOrder.setStatus("Declined");
			sessionFactory.getCurrentSession().update(cusOrder);
			historyDaoInt.insetOrderHistory(cusOrder);
			retMessage = "Order " + cusOrder.getOrderNum()+ " declined";
		}catch(Exception e){
			retMessage = e.getMessage();
		}
		return retMessage;
	}
	private OrderHeader declineOrder(String orderNum){
		OrderHeader order = null;
		try{
			order = new OrderHeader();
			pendingOrders = getAllOrders();
			for(OrderHeader tempOrder:pendingOrders){
				if(tempOrder.getOrderNum().equalsIgnoreCase(orderNum)){
					order = tempOrder;
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		return order;
	}

	@Override
	public int pendingOrdersCount(String approveName) {
	
		int tempCount = 0;
		try {
			List<OrderHeader> pendingForApprover = pendingOrders();

			
			for (OrderHeader order : pendingForApprover) {
				if (order.getApprover().equalsIgnoreCase(approveName)) {

					tempCount ++;
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return tempCount;
	}
    @Override
	public int technicianOrdersCount(String technicianName) {
		int tempCount = 0;
		try {
			List<OrderHeader> shipperOrdersForTechnician = getShippedOrders();

			
			for (OrderHeader order : shipperOrdersForTechnician) {
				if (order.getEmployee().getEmail().equalsIgnoreCase(technicianName)) {

					tempCount ++;
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return tempCount;
	}
	private List<OrderHeader> getShippedOrders(){
		List<OrderHeader> shippedOrders = new ArrayList<OrderHeader>();
		try{
			pendingOrders = getAllOrders();
			for(OrderHeader orderHeader:pendingOrders){
				if(orderHeader.getStatus().equalsIgnoreCase("Shipped")){
					shippedOrders.add(orderHeader);
				}
			}
		}catch(Exception e)
		{
			e.getMessage();
		}
		return shippedOrders;
	}

	@Override
	public List<OrderHeader> getAllOrders(String startDate, String endDate) {
		List<Tickets> tempTickets = null;

		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		List<OrderHeader>orders = new ArrayList<OrderHeader>();
		try {
			

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<OrderHeader> tickets = getAllOrders();
			for (OrderHeader tic : tickets) {
				String convDate = tic.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					orders.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return orders;
	}

	@Override
	public List<OrderHeader> getAllOrders(String startDate, String endDate,
			String technicianEmail) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderHeader> getAllOrdersByDate() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<OrderHeader> getAllOrdersByDate(String technicianName) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0 && order.getEmployee().getEmail().equalsIgnoreCase(technicianName)) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public int countNewOrders(String lastFourteenDays) {
		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<OrderHeader> pendingOrders = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			pendingOrders = pendingOrders();
			for (OrderHeader order : pendingOrders) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
       System.out.println(tempCount);
		return tempCount;
	}

	@Override
	public int countApprovedOrders(String lastFourteenDays) {
		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<OrderHeader> pendingOrders = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			pendingOrders = approvedOrders();
			for (OrderHeader order : pendingOrders) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
       System.out.println(tempCount);
		return tempCount;
	}
    
	@Override
	public int countShippedOrders(String lastFourteenDays) {
		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<OrderHeader> pendingOrders = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			pendingOrders = shippedOrders();
			for (OrderHeader order : pendingOrders) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
       System.out.println(tempCount);
		return tempCount;
	}

	@Override
	public List<OrderHeader> getLastFourteenDaysOrders() {
		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<OrderHeader> approvedOrders() {
		ArrayList<OrderHeader> pendingList = new ArrayList<OrderHeader>();
		try {
			pendingOrders = getAllOrders();
			for (OrderHeader orderHeader : pendingOrders) {
				if (orderHeader.getStatus().equalsIgnoreCase("Approved")) {
					pendingList.add(orderHeader);
				}
			}
		} catch (Exception e) {

		}
		return pendingList;
	}
    
	@Override
	public List<OrderHeader> getLastFourteenDaysApprovedOrders() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList =approvedOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<OrderHeader> getLastFourteenDaysPendingOrders() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList =pendingOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<OrderHeader> getLastFourteenDaysShippedOrders() {
		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList =shippedOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public int countClosedOrder(String lastFourteenDays) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<OrderHeader> pendingOrders = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			pendingOrders = receivedOrders();
			for (OrderHeader order : pendingOrders) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
       System.out.println(tempCount);
		return tempCount;
	}

	@Override
	public List<OrderHeader> getLastFourteenDaysClosedOrders() {
	    SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List <OrderHeader> aList = new ArrayList<OrderHeader>();
	    List<OrderHeader>	ticketList =null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList =receivedOrders();
			for (OrderHeader order : ticketList) {
				String convDate = order.getDateOrdered().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(order);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}
}
