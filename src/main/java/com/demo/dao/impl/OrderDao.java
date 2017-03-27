package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.HOStockDaoInt;
import com.demo.dao.SiteStocDaoInt;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.OrderHeader;
import com.demo.model.OrderDetails;
import com.demo.model.HOStock;
import com.demo.model.Device;

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

			retMessage = "Order : " + " " + orderHeader.getOrderNum() + " "
					+ "is created";
		} catch (Exception e) {
			retMessage = "Order : " + " " + orderHeader.getOrderNum() + " "
					+ "is not created " + e.getMessage();
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
				retMessage = "Order " + " " + cusOrder.getOrderNum() + " "
						+ "is approved";
			} else {
				retMessage = "Order " + " " + n + cusOrder.getOrderNum() + " "
						+ "is not approved because "
						+ " is not available in store.";
			}

		} catch (Exception e) {
			retMessage = "Order " + " " + orders.getOrderNum() + " "
					+ "is not updated " + e.getMessage();
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
		String tempOrder = "";
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
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<OrderHeader> orderList = new ArrayList<OrderHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				OrderHeader.class);

		aList.addAll(criteria.list());
		for (Object order : aList) {
			if (order instanceof OrderHeader) {
				if (((OrderHeader) order).getEmployee().getEmail()
						.equalsIgnoreCase(orderedBy)) {
					orderList.add((OrderHeader) order);
				}
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
		String partNumber, modelNumber, description, splitString = null;
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
			cusOrder.setStockType(orderBean.getStockType());
			cusOrder.setStatus("Pending");
			cusOrder.setApprover(orderBean.getApprover());

			recordID = newRecordID();
			orderNumber = "ORD00" + recordID;
			cusOrder.setRecordID(recordID);
			cusOrder.setOrderNum(orderNumber);
			cusOrder.setEmployee(emp);
			cusOrder.setApproved(false);
			cusOrder.setDateOrdered(dateFormat.format(date));

			for (int i = 0; i < orderBean.getSelectedItem().length; i++) {
				orderDetails = new OrderDetails();
				splitString = orderBean.getSelectedItem()[i];
				split = splitString.split(",");
				partNumber = split[0];
				part = hOStockDaoInt.getSparePartBySerial(partNumber);
				quatity = Integer.parseInt(quantityArray[i]);
				orderDetails.setPartNumber(partNumber);
				orderDetails.setItemDescription(part.getItemDescription());
				orderDetails.setModel(part.getCompitableDevice());
				orderDetails.setQuantity(quatity);
				orderDetails.setLocation(orderBean.getLocation());
				orderDetails.setStockType(cusOrder.getStockType());
				orderDetails.setTechnician(orderBean.getTechnician());
				orderDetails.setOrderHeader(cusOrder);
				orderDetails.setDateTime(dateFormat.format(date));

				orderDetailList.add(orderDetails);
			}

			retMessage = makeOrder(cusOrder);
			String retMsg = detailsDaoInt.saveOrderDetails(orderDetailList);
		} catch (Exception ex) {
			retMessage = " Order cannot be proccessed " + ex.getMessage();
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

	@Override
	public String approveOrder(Integer recordID) {
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		
		try {
			cusOrder = getOrder(recordID);
			cusOrder.setStatus("Approved");
			cusOrder.setApproved(true);
			cusOrder.setDateApproved(dateFormat.format(date));
			sessionFactory.getCurrentSession().update(cusOrder);
			

			orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
			retMessage = subtractOrderItems(orderDetailList);
			if (retMessage.equalsIgnoreCase("Ok")) {

				listOrders = detailsDaoInt.getOrderDetailsByOrderNum(recordID);

				String addStockToApprovedTable = approvedOrderStockDaoInt
						.approveOrderStock(listOrders);
				
				emp = employeeDaoInt.getEmployeeByEmpNum(cusOrder.getApprover());
				JavaMail.sendEmailForOrderApproved(cusOrder.getEmployee().getEmail(), cusOrder.getApprover(), emp.getFirstName(), cusOrder.getEmployee().getFirstName(), cusOrder);

				retMessage = "Order " + cusOrder.getOrderNum() + " is approved";
			} else {
				retMessage = "Order cannot be approved because ordered items are more that available items";
			}

		} catch (Exception e) {
			retMessage = "Order " + cusOrder.getOrderNum() + " is not approved";
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
				if (tempQuantity <= part.getQuantity()) {

					part.setQuantity(tempQuantity);
					sessionFactory.getCurrentSession().update(part);
					retMessage = "Ok";
				} else {
					retMessage = "Ordered items are more than available items";
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
	public void approveShipment(Integer recordID) {
		orderHeader = getOrder(recordID);
		date = new Date();
		if(orderHeader!=null && orderHeader.getStatus().equalsIgnoreCase("Approved")){
			
			orderHeader.setStatus("Shipped");
			orderHeader.setShippingDate(date);
			sessionFactory.getCurrentSession().update(orderHeader);
			JavaMail.sendEmailForShipment(orderHeader.getApprover(),orderHeader);
		}
		else if (orderHeader!=null && orderHeader.getStatus().equalsIgnoreCase("Shipped")){
			orderHeader.setStatus("Received");
			sessionFactory.getCurrentSession().update(orderHeader);
			
			if(orderHeader.getStockType().equalsIgnoreCase("Site")){
				orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
				siteStocDaoInt.saveSiteStock(orderDetailList);
			}
			else{
				orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(recordID);
				 bootStockDaoInt.saveBootStock(orderDetailList);;
			}
		}
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
	}

	@Override
	public List<OrderHeader> shippedOrders(String technicianEmail) {
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
			System.out.println("Mic check ");
			cusOrder.setStatus("Declined");
			sessionFactory.getCurrentSession().update(cusOrder);
			retMessage = "Order " + cusOrder.getOrderNum()+ " is declined";
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
}
