package com.example.web.model;

import java.util.Arrays;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardDTO {

	private int idx;
	private String title;
	private String contents;
	private String writer;
	private Date regdate; // java.util.Date
	private int hit;
	private String user_id;
	private int cnt;
	private String file_name;
	// 첨부파일의 이름 배열
	private String[] files;
	private MultipartFile[] file;
	
	
	
	
	
	
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public MultipartFile[] getFile() {
		return file;
	}
	public void setFile(MultipartFile[] file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "BoardDTO [idx=" + idx + ", title=" + title + ", contents=" + contents + ", writer=" + writer
				+ ", regdate=" + regdate + ", hit=" + hit + ", user_id=" + user_id + ", cnt=" + cnt + ", file_name="
				+ file_name + ", files=" + Arrays.toString(files) + ", file=" + Arrays.toString(file) + "]";
	}
	
	
	
}
