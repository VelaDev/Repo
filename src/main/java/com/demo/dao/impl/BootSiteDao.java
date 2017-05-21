package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.BootStockDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.model.BootStock;
import com.demo.model.OrderDetails;
import com.demo.model.Tickets;

@Repository("bootStockDao")
@Transactional(propagation = Propagation.REQUIRED)
public class BootSiteDao implements BootStockDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private TicketsDaoInt ticketsDaoInt;

	private BootStock bootStock;
	List<BootStock> bootStockList = null;
	List<BootStock> bootStocks = null;

	@Override
	public void saveBootStock(List<OrderDetails> detailsDaos) {
		try {

			for (OrderDetails stock : detailsDaos) {
				bootStock = new BootStock();
				bootStock.setItemDescription(stock.getItemDescription());
				bootStock.setItemType(stock.getItemType());
				bootStock.setPartNumber(stock.getPartNumber());
				bootStock.setQuantity(stock.getQuantity());
				bootStock.setRecordID(stock.getOrderDertailNumber());
				bootStock.setTechnicianEmail(stock.getTechnician());
				bootStock.setTechnicianName(stock.getTechnician());
				bootStock.setCompatibleDevice(stock.getCompatibleDevice());

				sessionFactory.getCurrentSession().saveOrUpdate(bootStock);
			}

		} catch (Exception exception) {
			exception.getMessage();
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BootStock> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				BootStock.class);
		return (List<BootStock>) criteria.list();
	}

	@Override
	public List<BootStock> getAllOrders(String technician, int ticketRecordID) {

		Tickets ticket = ticketsDaoInt
				.getLoggedTicketsByTicketNumber(ticketRecordID);
		String tempDeviceModelNumber = ticket.getDevice().getModelNumber();
		List<String> spare = null;
		bootStockList = new ArrayList<BootStock>();
		try {
			bootStocks = getAllOrders();
			for (BootStock boot : bootStocks) {
				String name = boot.getTechnicianName();
				if (name.equalsIgnoreCase(technician) && boot.getQuantity() > 0) {
					spare = new ArrayList<String>(Arrays.asList(boot
							.getCompatibleDevice().split(",")));
					for (int i = 0; i < spare.size(); i++) {
						if (spare.get(i)
								.equalsIgnoreCase(tempDeviceModelNumber)) {
							 bootStockList.add(boot);
						}
					}
				}
			}
		} catch (Exception e) {

		}
		return bootStockList;
	}

	@Override
	public void updateBootStock(BootStock bootStock) {
		try {
			sessionFactory.getCurrentSession().update(bootStock);
		} catch (Exception e) {
			e.getMessage();
		}

	}

	@Override
	public List<BootStock> getAllOrders(String technician) {
		
		bootStockList = new ArrayList<BootStock>();
		try {
			bootStocks = getAllOrders();
			for (BootStock boot : bootStocks) {
				String name = boot.getTechnicianName();
				if (name.equalsIgnoreCase(technician) && boot.getQuantity() > 0) {
					bootStockList.add(boot);

				}
			}
		} catch (Exception e) {

		}
		return bootStockList;
	}

}
