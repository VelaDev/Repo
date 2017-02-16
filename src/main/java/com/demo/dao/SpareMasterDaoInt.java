package com.demo.dao;

import java.util.List;

import com.demo.model.SpareMaster;



public interface SpareMasterDaoInt {
	
	List<SpareMaster> getSparesFromMastaData();
	SpareMaster getSpareMaster(String partNumber);
	String[] getSerials();

}
