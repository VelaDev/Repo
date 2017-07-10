package com.demo.service;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.OrderHeader;

public interface OrdersServiceInt {
	public String makeOrder(OrderHeader orderHeader);
	public String updateOrder(OrdersBean order);
	public List<OrderHeader> getAllOrders();
	public List<OrderHeader> getApprovedOrdersByTechnicianName(String userName);
	public List<OrderHeader> getOpenOrders();
	public OrderHeader getOrder(Integer recordID);
	public List<OrderHeader> getAllOrders(String orderedBy);
	public String prepareOrderMaking(OrdersBean order);
	public List<OrderHeader> pendingOrders();
	public String approveOrder(Integer recordID);
	public List<OrderHeader> pendingOrders(String approveName);
	public String approveShipment(Integer recordID);
	public List<OrderHeader> shippedOrders();
	public List<OrderHeader> shippedOrders(String technicianEmail);
	public String declineOrder(String orderNum,String reasonForeclined);
	public int pendingOrdersCount(String approveName);
	public int technicianOrdersCount(String technicianName);
	public List<OrderHeader> getAllOrders(String startDate, String endDate);
	public List<OrderHeader> getAllOrders(String startDate, String endDate, String technicianEmail);
	public List<OrderHeader> getAllOrdersByDate();
	public List<OrderHeader> getAllOrdersByDate(String technicianName);
	public int countOrdersReceive(String lastFourteenDays);
	public int countNewOrders(String lastFourteenDays);
	public int countApprovedOrders(String lastFourteenDays);
	public int countShippedOrders(String lastFourteenDays);
	public List<OrderHeader> getLastFourteenDaysOrders();
	public List<OrderHeader> approvedOrders();
	public List<OrderHeader> getLastFourteenDaysApprovedOrders();
	public List<OrderHeader> getLastFourteenDaysPendingOrders();
	public List<OrderHeader> getLastFourteenDaysShippedOrders();
	public int countClosedOrder(String lastFourteenDays);
	public int countRejectedOrders(String lastFourteenDays);
	
	public List<OrderHeader> getLastFourteenDaysOrders(String technicianName);
	public List<OrderHeader> getLastFourteenDaysClosedOrders();
	public List<OrderHeader> getLastFourteenDaysRejectedOrders();
	
	
	public List<OrderHeader> getLastFourteenDaysOrdersForCustomer(String customerName); 
	
	public int countNewOrders(String lastFourteenDays, String technicianName);
	public int countClosedOrder(String lastFourteenDays ,String technicianName);
	public int countApprovedOrders(String lastFourteenDays,String technicianName);
	public int countShippedOrders(String lastFourteenDays,String technicianName);
	public int countOrdersReceive(String lastFourteenDays,String technicianName);
	public int countRejectedOrder(String lastFourteenDays,String technicianName);
		
	
	public int countNewOrders(String lastFourteenDays, String technicianName,String customerName);
	public int countClosedOrder(String lastFourteenDays ,String technicianName,String customerName);
	public int countApprovedOrders(String lastFourteenDays,String technicianName,String customerName);
	public int countShippedOrders(String lastFourteenDays,String technicianName,String customerName);
	public int countOrdersReceive(String lastFourteenDays,String technicianName,String customerName);
	

	public List<OrderHeader> getLastFourteenDaysOrdersToReceive(String technicianName);
	public List<OrderHeader> getLastFourteenDaysClosedOrders(String technicianName );
	public List<OrderHeader> getLastFourteenDaysRejectedOrders(String technicianName );
	
	public List<OrderHeader> getLastFourteenRejectedOrders(String lastFourteenDays);
	
	public List<OrderHeader> getLastFourteenDaysApprovedOrders(String lastFourteenDays,String technicianName,String customerName );
	public List<OrderHeader> getLastFourteenDaysPendingOrders(String lastFourteenDays,String technicianName,String customerName);
	public List<OrderHeader> getLastFourteenDaysShippedOrders(String lastFourteenDays,String technicianName,String customerName);
	public List<OrderHeader> getLastFourteenDaysClosedOrders(String lastFourteenDays,String technicianName,String customerName);
	public List<OrderHeader> getLastFourteenDaysOrdersToReceive(String lastFourteenDays,String technicianName,String customerName);
	public List<OrderHeader> getLastFourteenDaysOrders(String lastFourteenDays,String technicianName,String customerName );
	public List<OrderHeader> getLastFourteenDaysRejectedOrders(String lastFourteenDays,String technicianName,String customerName);

	
	public int countNewOrdersForCustomer(String customerName);
	public int countClosedOrderForCustomer(String customerName);
	public int countApprovedOrdersForCustomer(String customerName);
	public int countShippedOrdersForCustomer(String customerName);
	public int countOrdersReceiveForCustomer(String customerName);
	public int countRejectedOrderForCustomer(String customerName);
	
	public int countClosedOrderForTechnician(String customerName);
	
	public List<OrderHeader> getLastFourteenDaysApprovedOrdersForCustomer(String customerName );
	public List<OrderHeader> getLastFourteenDaysPendingOrdersForCustomer(String customerName);
	public List<OrderHeader> getLastFourteenDaysShippedOrdersForCustomer(String customerName);
	public List<OrderHeader> getLastFourteenDaysClosedOrdersForCustomer(String customerName);
	public List<OrderHeader> getLastFourteenDaysOrdersToReceiveForCustomer(String customerName);
	public List<OrderHeader> getLastFourteenDaysRejectedOrdersForCustomer(String customerName);
	
	
	
	public int countNewOrdersForTechnician_Customer(String technician,String customerName);
	public int countClosedOrderForTechnician_Customer(String technician,String customerName);
	public int countApprovedOrdersForTechnician_Customer(String technician,String customerName);
	public int countShippedOrdersForTechnicianCustomer(String technician,String customerName);
	public int countOrdersReceiveForTechnician_Customer(String technician,String customerName);
	public int countRejectedOrderForTechnicianCustomer(String technician,String customerName);
	
	
	
	public List<OrderHeader> getLastFourteenDaysOrdersForTechnicianCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysApprovedOrdersForTechnicianCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysPendingOrdersForCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysShippedOrdersForTechnicianCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysClosedOrdersForTechnicianCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysOrdersToReceiveForTechnicianCustomer(String technician,String customerName);
	public List<OrderHeader> getLastFourteenDaysRejectedOrdersForTechnicianCustomer(String technician,String customerName);

}
