package com.studentManagementSystem.model;

import java.time.LocalDate;

public class AdminBean {
	
	private Long id;
	private String user_name;
	private String email;
	private String password;
	private String role;
	private String address;
	private String contact;
	private LocalDate dob;
	private boolean active;
	
	public boolean getActive()
	{
		return active;
	}
	
	public void setActive(boolean active)
	{
		this.active=active;
	}
	
	
	
	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getRole() {
		return role;
	}



	public void setRole(String role) {
		this.role = role;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getContact() {
		return contact;
	}



	public void setContact(String contact) {
		this.contact = contact;
	}



	public LocalDate getDob() {
		return dob;
	}



	public void setDob(LocalDate dob) {
		this.dob = dob;
	}



	public AdminBean(Long id, String user_name, String email, String password, String role, String address,
			String contact, LocalDate dob, boolean active) {
		super();
		this.id = id;
		this.user_name = user_name;
		this.email = email;
		this.password = password;
		this.role = role;
		this.address = address;
		this.contact = contact;
		this.dob = dob;
		this.active=active;
	}



	public AdminBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}
