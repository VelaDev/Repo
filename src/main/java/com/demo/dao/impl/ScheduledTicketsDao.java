package com.demo.dao.impl;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ScheduledTickets;
import com.demo.model.Tickets;


@Repository("scheduledTicketsDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class ScheduledTicketsDao implements ScheduledTickets{

	@Override
	public void calculateSLAHours() {
		
	}

	@Override
	public void resolveToClosedTicketUpdate() {

	}

	@Override
	public void updateSLA(Tickets tickets) {
		
	}

}
