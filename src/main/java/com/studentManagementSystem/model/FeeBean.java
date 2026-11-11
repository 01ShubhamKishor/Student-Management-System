package com.studentManagementSystem.model;

public class FeeBean {

		    private int id;
		    private int studentId;
		    private String courseCode;
		    private int totalFee;
		    private int paidFee;
		    private int dueFee;
		    private String paymentDate; // ya Date use kar sakta hai
		    private String paymentMode;

		    // Getter Setter
		    public int getId() { return id; }
		    public void setId(int id) { this.id = id; }
		    public int getStudentId() { return studentId; }
		    public void setStudentId(int studentId) { this.studentId = studentId; }
		    public String getCourseCode() { return courseCode; }
		    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }
		    public int getTotalFee() { return totalFee; }
		    public void setTotalFee(int totalFee) { this.totalFee = totalFee; }
		    public int getPaidFee() { return paidFee; }
		    public void setPaidFee(int paidFee) { this.paidFee = paidFee; }
		    public int getDueFee() { return dueFee; }
		    public void setDueFee(int dueFee) { this.dueFee = dueFee; }
		    public String getPaymentDate() { return paymentDate; }
		    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
		    public String getPaymentMode() { return paymentMode; }
		    public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }
			public FeeBean() {
				super();
				// TODO Auto-generated constructor stub
			}
			public FeeBean(int id, int studentId, String courseCode, int totalFee, int paidFee, int dueFee,
					String paymentDate, String paymentMode) {
				super();
				this.id = id;
				this.studentId = studentId;
				this.courseCode = courseCode;
				this.totalFee = totalFee;
				this.paidFee = paidFee;
				this.dueFee = dueFee;
				this.paymentDate = paymentDate;
				this.paymentMode = paymentMode;
			}
		    
		    
	
	}


