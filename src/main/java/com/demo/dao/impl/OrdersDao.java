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
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.OrdersHeader;
import com.demo.model.OrderDetails;
import com.demo.model.Spare;
import com.demo.model.Device;

@Repository("ordersDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrdersDao implements OrdersDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	private Session session2;
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	@Autowired
	private SparePartsDaoInt sparePartsDaoInt;
	@Autowired
	private DeviceDaoInt deviceDaoInt;
	@Autowired
	private CustomerDaoInt customerDaoInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	
	private String orderNum ="VEL00";
	
	private String retMessage = null;
	private Customer cus;
	private Employee emp = null;
	private Spare part = null;
	private Device device=null;
	private OrdersHeader cusOrder = null;
	private DateFormat dateFormat = null;
	private Date date = null;
	private List<OrderDetails> orderDetailList = null;
	private OrderDetails orderDetails = null;
	private List<OrdersHeader> pendingOrders;
	
	
	@Override
	public String makeOrder(OrdersHeader ordersHeader) {
		
			try{
			     sessionFactory.getCurrentSession().save(ordersHeader);
			     retMessage = "OrdersHeader"+" "+ ordersHeader.getOrderNum()+ " "+"is created";
		}
		catch(Exception e){
			retMessage = "OrdersHeader"+" "+ ordersHeader.getOrderNum()+ " "+"is not created";
		}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean orders) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		String n = " ";
		cusOrder = new OrdersHeader();
		try{
			
			part= sparePartsDaoInt.getSparePartBySerial(orders.getPart());
			device = deviceDaoInt.getDeviceBySerialNumbuer(orders.getDevice());
			emp =employeeDaoInt.getEmployeeByEmpNum(orders.getEmployee());
			if(part != null){
				orders.setApproved(true);
				orders.setDateApproved(dateFormat.format(date));
				String approvedBy = (String) session.getAttribute("loggedInUser");
				orders.setOrderNum(orders.getOrderNum());
				cusOrder.setEmployee(emp);
				cusOrder.setDateOrdered(orders.getDateOrdered());
				
				sessionFactory.getCurrentSession().update(cusOrder);
				retMessage = "Order "+" "+ cusOrder.getOrderNum()+ " "+"is approved";
			}else{
				retMessage = "Order "+" "+n+ cusOrder.getOrderNum()+ " "+"is not approved because " + " is not available in store." ;
			}
		
		}catch (Exception e){
			retMessage = "Order "+" "+ orders.getOrderNum()+ " "+"is not updated " + e.getMessage();
		}
		return retMessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdersHeader> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(OrdersHeader.class);
		return (List<OrdersHeader>)criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdersHeader> getApprovedOrdersByTechnicianName(String userName) {
		
		ArrayList<OrdersHeader> aList = new ArrayList<OrdersHeader>();
		ArrayList<OrdersHeader> orderList = new ArrayList<OrdersHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(OrdersHeader.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof OrdersHeader){
				 if(((OrdersHeader) order).getEmployee().getEmail().equalsIgnoreCase(userName)&& ((OrdersHeader)order).isApproved()==true){
					 orderList.add((OrdersHeader) order);
				 }
			 }
		 }
		return orderList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdersHeader> getOpenOrders() {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<OrdersHeader> orderList = new ArrayList<OrdersHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(OrdersHeader.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof OrdersHeader){
				 if(((OrdersHeader) order).getStatus().equalsIgnoreCase("Approved")){
					 orderList.add((OrdersHeader) order);
				 }
			 }
		 }
		return orderList;
	}

	@Override
	public OrdersHeader getOrder(String orderNum) {
		
		return (OrdersHeader) sessionFactory.getCurrentSession().get(OrdersHeader.class, orderNum);
	}
	
	private String generateOrderNumber(){
		
		session2=sessionFactory.openSession();
		String result = "";
		Query query = session2.createQuery("from OrdersHeader order by orderNum DESC");
		query.setMaxResults(1);
		OrdersHeader orderNumber = (OrdersHeader) query.uniqueResult();
		
		if(orderNumber != null){
			result = orderNumber.getOrderNum();
		}
		else{
			result = null;
		}
		return result;
	}
	private String newOrderNumber(){
		String tempOrder = "";
		int tempOrderNum = 0;
		String newOrderNum = generateOrderNumber();
		
		if (newOrderNum != null){
			tempOrder = newOrderNum.substring(5);
			tempOrderNum = Integer.parseInt(tempOrder)+1;
			newOrderNum = orderNum+ tempOrderNum;
		}
		else{
			newOrderNum = "VEL001";
		}
		
		return newOrderNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdersHeader> getAllOrders(String orderedBy) {
		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<OrdersHeader> orderList = new ArrayList<OrdersHeader>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(OrdersHeader.class);
		 
		 aList.addAll(criteria.list());
		 for(Object order:aList)
		 {
			 if(order instanceof OrdersHeader){
				 if(((OrdersHeader) order).getEmployee().getEmail().equalsIgnoreCase(orderedBy)){
					 orderList.add((OrdersHeader) order);
				 }
			 }
		 }
		return orderList;
	}

	@Override
	public String prepareOrderMaking(OrdersBean orderBean) {
		orderDetailList = new ArrayList<OrderDetails>();
		
		cusOrder = new OrdersHeader();
		String orderNumber = null;
		 String[] split;
		 String partNumber,modelNumber,description,splitString = null;
		 int quatity = 0;
	
		 dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			date = new Date();
		String[] quantityArray = quantity(orderBean.getQuantity(),orderBean.getSelectedItem().length);
		
		try{
			
			Employee user = (Employee) session.getAttribute("loggedInUser");
			emp=employeeDaoInt.getEmployeeByEmpNum(user.getEmail());
			String customer = orderBean.getCustomer();
			cus = customerDaoInt.getClientByClientName(customer);
			cusOrder.setCustomer(cus);
			cusOrder.setStockType(orderBean.getStockType());
			cusOrder.setStatus("Pending");
			cusOrder.setApprover(orderBean.getApprover());
			
			orderNumber = newOrderNumber();
			cusOrder.setOrderNum(orderNumber);
			cusOrder.setEmployee(emp);
			cusOrder.setApproved(false);
			cusOrder.setDateOrdered(dateFormat.format(date));
				
			  for(int i=0; i<orderBean.getSelectedItem().length;i++){
				  orderDetails = new OrderDetails();
				  splitString = orderBean.getSelectedItem()[i];
				  split = splitString.split(",");
				  partNumber = split[0];
				  part = sparePartsDaoInt.getSparePartBySerial(partNumber);
				  quatity = Integer.parseInt(quantityArray[i]);
				  orderDetails.setPartNumber(partNumber);
				  orderDetails.setDescription(part.getDescription());
				  orderDetails.setModel(part.getCompitableDevice());
				  orderDetails.setQuantity(quatity);
				  orderDetails.setLocation(orderBean.getLocation());
				  orderDetails.setStockType(cusOrder.getStockType());
				  orderDetails.setTechnician(orderBean.getTechnician());
				  orderDetails.setOrdersHeader(cusOrder);
				  orderDetails.setDateTime(dateFormat.format(date));
				  
				  orderDetailList.add(orderDetails);
			  }
			   
			  
			  retMessage = makeOrder(cusOrder);
			  String retMsg = detailsDaoInt.saveOrderDetails(orderDetailList);
		}catch(Exception ex){
			retMessage = " Order cannot be proccessed "+ ex.getMessage();
		}
		return retMessage;
	}

	private String[] quantity(String[] arr, int length)
    {
    	String[] newQuantity =new String[length];
    	int x =0;
    	for(int i=0; i<arr.length; i++)
    	{
    		if(arr[i]!=""){
    			newQuantity[x] =arr[i];
    			x++;
    		}
    	}
	  return newQuantity;
	
    }

	@Override
	public List<OrdersHeader> pendingOrders() {
		ArrayList<OrdersHeader> pendingList = new ArrayList<OrdersHeader>();
		try{
			 pendingOrders = getAllOrders();
			 for(OrdersHeader ordersHeader:pendingOrders){
				 if(ordersHeader.getStatus().equalsIgnoreCase("Pending")){
					 pendingList.add(ordersHeader);
				 }
			 }
		}catch(Exception e){
			
		}
		return pendingList;
	}

	@Override
	public String approveOrder(String orderNum) {
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		try{
			cusOrder = getOrder(orderNum);
			cusOrder.setStatus("Approved");
			cusOrder.setApproved(true);
			cusOrder.setDateApproved(dateFormat.format(date));
			sessionFactory.getCurrentSession().update(cusOrder);
			
			orderDetailList = detailsDaoInt.getOrderDetailsByOrderNum(orderNum);
			retMessage = subtractOrderItems(orderDetailList);
			if(retMessage.equalsIgnoreCase("Ok")){
				retMessage = detailsDaoInt.incrementStockAvailability(orderDetailList);
				retMessage = "Order "+ cusOrder.getOrderNum() + " is approved";
			}
			else{
				retMessage = "Order cannot be approved because ordered items are more that available items";
			}
			
		}catch(Exception e){
			retMessage = "Order "+ cusOrder.getOrderNum() + " is not approved";
		}
		return retMessage;
	}
	
	private String subtractOrderItems(List<OrderDetails> orderDetails){
		int tempQuantity= 0;
		
		try{
			for(OrderDetails subtractQuatity:orderDetails){
				part = sparePartsDaoInt.getSparePartBySerial(subtractQuatity.getPartNumber());
				tempQuantity = part.getQuantity() - subtractQuatity.getQuantity();
				if(tempQuantity<=part.getQuantity()){
					
					part.setQuantity(tempQuantity);
					sessionFactory.getCurrentSession().update(part);
					retMessage = "Ok";
				}else{
					retMessage = "Ordered items are more than available items";
				}
			}
			
		}catch(Exception e){
			
		}
		return retMessage;
	}

	@Override
	public List<OrdersHeader> pendingOrders(String approveName) {
		List<OrdersHeader>pendingOrder = new ArrayList<OrdersHeader>();
		try{
			List<OrdersHeader> pendingForApprover = pendingOrders() ;
			
			for(OrdersHeader order:pendingForApprover){
				if(order.getApprover().equalsIgnoreCase(approveName)){
					
					pendingOrder.add(order);
				}
			}
		}catch(Exception e){
			retMessage = e.getMessage();
		}
		return pendingOrder;
	}
}
