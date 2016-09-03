package com.demo.model;

import java.io.Serializable;


import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="Products")
public class Product implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="SERIAL_NUMBER")
	private String serialNumber;
	@Column(name="PRODUCT_MODEL")
	private String productModel;
	@Column(name="START_DATE")
	private String startDate;
	@Column(name="END_DATE")
	private String endDate;
	private String clientName;
	
	@ManyToOne
	@JoinColumn(name="CLIENT")
	private Client client;
	private String credenza;
	private String bridgeUnitSerialType;
	private String faxUnitSerialType;
	private String OneBinTrayType;
	private String finisherType;
	private String ltcType;
	private String additionalPaperTrays;
	
	
	
	private String credenzaSerialNo;
	private String bridgeUnitSerialTypeSerialNo;
	private String faxUnitSerialTypeSerialNo;
	private String OneBinTrayTypeSerialNo;
	private String finisherTypeSerialNo;
	private String ltcTypeSerial;
	private String additionalPaperTraysTypeSerial;
	
	
	public String getLtcType() {
		return ltcType;
	}

	public void setLtcType(String ltcType) {
		this.ltcType = ltcType;
	}

	public String getAdditionalPaperTrays() {
		return additionalPaperTrays;
	}

	public void setAdditionalPaperTrays(String additionalPaperTrays) {
		this.additionalPaperTrays = additionalPaperTrays;
	}

	public String getLtcTypeSerial() {
		return ltcTypeSerial;
	}

	public void setLtcTypeSerial(String ltcTypeSerial) {
		this.ltcTypeSerial = ltcTypeSerial;
	}

	public String getAdditionalPaperTraysTypeSerial() {
		return additionalPaperTraysTypeSerial;
	}

	public void setAdditionalPaperTraysTypeSerial(
			String additionalPaperTraysTypeSerial) {
		this.additionalPaperTraysTypeSerial = additionalPaperTraysTypeSerial;
	}

	public String getCredenza() {
		return credenza;
	}

	public void setCredenza(String credenza) {
		this.credenza = credenza;
	}

	public String getBridgeUnitSerialType() {
		return bridgeUnitSerialType;
	}

	public void setBridgeUnitSerialType(String bridgeUnitSerialType) {
		this.bridgeUnitSerialType = bridgeUnitSerialType;
	}

	public String getFaxUnitSerialType() {
		return faxUnitSerialType;
	}

	public void setFaxUnitSerialType(String faxUnitSerialType) {
		this.faxUnitSerialType = faxUnitSerialType;
	}

	public String getOneBinTrayType() {
		return OneBinTrayType;
	}

	public void setOneBinTrayType(String oneBinTrayType) {
		OneBinTrayType = oneBinTrayType;
	}

	public String getFinisherType() {
		return finisherType;
	}

	public void setFinisherType(String finisherType) {
		this.finisherType = finisherType;
	}


	/*@OneToMany(mappedBy ="product", cascade= CascadeType.ALL,fetch=FetchType.EAGER)*/
	/*private Set<Accessories> accessories;*/
	

	/*public Set<Accessories> getAccessories() {
		return accessories;
	}

	public void setAccessories(Set<Accessories> accessories) {
		this.accessories = accessories;
	}*/

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}


	public String getProductModel() {
		return productModel;
	}

	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

    

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getCredenzaSerialNo() {
		return credenzaSerialNo;
	}

	public void setCredenzaSerialNo(String credenzaSerialNo) {
		this.credenzaSerialNo = credenzaSerialNo;
	}

	public String getBridgeUnitSerialTypeSerialNo() {
		return bridgeUnitSerialTypeSerialNo;
	}

	public void setBridgeUnitSerialTypeSerialNo(String bridgeUnitSerialTypeSerialNo) {
		this.bridgeUnitSerialTypeSerialNo = bridgeUnitSerialTypeSerialNo;
	}

	public String getFaxUnitSerialTypeSerialNo() {
		return faxUnitSerialTypeSerialNo;
	}

	public void setFaxUnitSerialTypeSerialNo(String faxUnitSerialTypeSerialNo) {
		this.faxUnitSerialTypeSerialNo = faxUnitSerialTypeSerialNo;
	}

	public String getOneBinTrayTypeSerialNo() {
		return OneBinTrayTypeSerialNo;
	}

	public void setOneBinTrayTypeSerialNo(String oneBinTrayTypeSerialNo) {
		OneBinTrayTypeSerialNo = oneBinTrayTypeSerialNo;
	}

	public String getFinisherTypeSerialNo() {
		return finisherTypeSerialNo;
	}

	public void setFinisherTypeSerialNo(String finisherTypeSerialNo) {
		this.finisherTypeSerialNo = finisherTypeSerialNo;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}
