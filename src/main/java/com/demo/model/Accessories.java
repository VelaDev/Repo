package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name="ACCESSORIES")
public class Accessories implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Column(name="BRIDGE_UNIT_SERIAL")
	private String bridgeUnitSerial;
	@Column(name="FAX_UNIT_SERIAL")
	private String faxUnitSerial;
	@Column(name="ONE_BIN_TRAY_SERIAL")
	private String OneBinTray;
	@Column(name="FINISHER_SERIAL")
	private String finisher;
	@Column(name="LCT_SERIA:")
	private String lct;
	@Column(name="CREDENZA_SERIAL")
	private String credenza;
	@Column(name="ADDITIONAL_PAPER_TRAYS_SERIAL")
	@ManyToOne
	@JoinColumn(name="PRODUCT_SERIAL_NO")
	private Product product;
	public String getBridgeUnitSerial() {
		return bridgeUnitSerial;
	}
	public void setBridgeUnitSerial(String bridgeUnitSerial) {
		this.bridgeUnitSerial = bridgeUnitSerial;
	}
	public String getFaxUnitSerial() {
		return faxUnitSerial;
	}
	public void setFaxUnitSerial(String faxUnitSerial) {
		this.faxUnitSerial = faxUnitSerial;
	}
	public String getOneBinTray() {
		return OneBinTray;
	}
	public void setOneBinTray(String oneBinTray) {
		OneBinTray = oneBinTray;
	}
	public String getFinisher() {
		return finisher;
	}
	public void setFinisher(String finisher) {
		this.finisher = finisher;
	}
	public String getLct() {
		return lct;
	}
	public void setLct(String lct) {
		this.lct = lct;
	}
	public String getCredenza() {
		return credenza;
	}
	public void setCredenza(String credenza) {
		this.credenza = credenza;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	

}
