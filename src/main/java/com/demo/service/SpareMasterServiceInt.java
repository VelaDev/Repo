package com.demo.service;

import java.util.List;

import com.demo.model.SpareMaster;

public interface SpareMasterServiceInt {

	List<SpareMaster> getSparesFromMastaData();
	SpareMaster getSpareMaster(String partNumber);
	String[] getSerials();
}
