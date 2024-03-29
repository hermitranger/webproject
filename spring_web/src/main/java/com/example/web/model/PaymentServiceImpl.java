package com.example.web.model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.catalina.connector.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Repository
public class PaymentServiceImpl implements PaymentService {

	@Value("${imp_key}")
	private String impKey;

	@Value("${imp_secret}")
	private String impSecret;

	
	
	@Override
	public String getToken() throws IOException {
		//HttpsURLConnection 객체 생성
		HttpsURLConnection conn = null;
		
		URL url = new URL("https://api.iamport.kr/users/getToken");
		//url 연결(웹페이지 url 연결)
		conn = (HttpsURLConnection) url.openConnection();
		//요청방식 선택(get, post)
		conn.setRequestMethod("POST");
		
		//requset header 값 세팅, (string key, string value)
		//서버 response data를 json 형식의 타입으로 요청
		conn.setRequestProperty("Content-type", "application/json");
		//서버 response data를 json 형식의 타입으로 요청
		conn.setRequestProperty("Accept", "application/json");
		//outputstream으로 post 데이터를 넘겨주겠다는 옵션.
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		//request body에 data를 담기위해 outputstream객체를 생성
		//OutputStreamWriter 클래스와 인코딩 형식을 파라미터로 전달
		//BufferedWriter OutputStreamWriter에서 만든 OutputStream을 파라미터로 넣는다.
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		//제이슨 형식 스트링으로
		bw.write(json.toString());
		bw.flush(); //값비워주고
		bw.close(); //닫고
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		
		//자바 오브젝트를 쉽게 JSON으로 변환시켜주는 gson 자바 라이브러리
		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		System.out.println(response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();
		return token;
		
	}


	@Override
	public void payMentCancle(String access_token, String imp_uid, String reason)  throws IOException {
		System.out.println("결제 취소");
		
		System.out.println("access_token"+access_token);
		
		System.out.println("access_token"+imp_uid);
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
		
		//POST 방식은 스트림 기반의 데이터 전송 방식이기 때문에 setDoOutput(true)
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("reason", reason);
		json.addProperty("imp_uid", imp_uid);

 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();
		
		
	}

		


	

}
