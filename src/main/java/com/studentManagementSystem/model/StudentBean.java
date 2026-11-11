package com.studentManagementSystem.model;

import java.time.LocalDate;

public class StudentBean {
	
	private Long id;
	private String full_name;
	private String roll_number;
	private String email;
	private String phone;
	private LocalDate dob;
	private String course_code; // this will hold course_code
	private String semester;
	private String address;
	private boolean active;
	private String password;
	private String role;
	private int admissionYear;
	private String status;
	
	private int dueAmount;  //for calculation purpose not stored in db

	// getter setter
	public int getDueAmount() { return dueAmount; }
	public void setDueAmount(int dueAmount) { this.dueAmount = dueAmount; }
	
	




	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getFull_name() {
		return full_name;
	}


	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}


	public String getRoll_number() {
		return roll_number;
	}


	public void setRoll_number(String roll_number) {
		this.roll_number = roll_number;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public LocalDate getDob() {
		return dob;
	}


	public void setDob(LocalDate dob) {
		this.dob = dob;
	}


	public String getCourse_code() {
		return course_code;
	}


	public void setCourse_code(String course_code) {
		this.course_code = course_code;
	}


	public String getSemester() {
		return semester;
	}


	public void setSemester(String semester) {
		this.semester = semester;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
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


	public int getAdmissionYear() {
		return admissionYear;
	}


	public void setAdmissionYear(int admissionYear) {
		this.admissionYear = admissionYear;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public StudentBean(Long id, String full_name, String roll_number, String email, String phone, LocalDate dob,
			String course_code, String semester, String address, boolean active, String password,
			String role, int admissionYear, String status) {
		super();
		this.id = id;
		this.full_name = full_name;
		this.roll_number = roll_number;
		this.email = email;
		this.phone = phone;
		this.dob = dob;
		this.course_code = course_code;
		this.semester = semester;
		this.address = address;
		this.active = active;
		this.password = password;
		
		this.role = role;
		this.admissionYear = admissionYear;
		this.status = status;
	}


	public StudentBean() {
		super();
		// TODO Auto-generated constructor stub
	}


	public boolean getActive() {
		return active;
	}


	public void setActive(boolean active) {
		this.active = active;
	}
	
	
	
	

	
	

	
	
	
	
	
	

}
