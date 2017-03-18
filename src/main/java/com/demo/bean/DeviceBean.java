package com.demo.bean;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class DeviceBean {

	
	private String serialNumber;
	private String modelNumber;
	private String startDate;
	private String endDate;
	private String installationDate;
	
	private String colourReading;
	
	private String monoReadingOnly;
	private String monoReadingAndColour;
	
	private String customerName;
	private String accessoryName;
	private String accessorySerial;
	
	
	
	
	//input checkbox
	private String bridgeUnitSerialType;
	private String finisherType;
	private String ltcType;																			
	private String faxUnitSerialType;
	private String oneBinSerialType;
	private String OneBinTrayType;
	private String creType;
	private String addType;
	
	//input textbox
	private String bridgeUnitSerialTypeSerialNo;
	private String finisherTypeSerialNo;
	private String ltcTypeSerial;									
	private String OneBinTrayTypeSerialNo;											
	private String faxUnitSerialTypeSerialNo;
	private String creTypeserial;
	private String addTypeserial;
	
	
	
	
	/*private String bridgeUnitSerialType;
	private String faxUnitSerialType;*/
	
	/*private String finisherType;		
	private String ltcType;
	private String creType;	*/
	
	/*private String creTypeserial;	
	private String bridgeUnitSerialTypeSerialNo;
	private String faxUnitSerialTypeSerialNo;
	private String OneBinTrayTypeSerialNo;
	private String finisherTypeSerialNo;*/
	/*private String LtcTypeSerial;
	private String addType;
*/
	private String streetName;
	private String city_town;
	private String province;
	private String zipcode;
	private String streetNumber;
	private String email;
	private String firstName;
	private String lastName;
	private String cellphone;
	private String telephone;
	private String tellphoneNumber;
	
}
