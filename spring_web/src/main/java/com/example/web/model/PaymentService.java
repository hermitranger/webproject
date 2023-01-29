package com.example.web.model;

import java.io.IOException;

public interface PaymentService {
	
	 String getToken() throws IOException; 
	 public void payMentCancle(String access_token, String imp_uid,	String reason) throws IOException;
	 

}
