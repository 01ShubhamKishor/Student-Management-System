package com.studentManagementSystem.model;

public class CourseBean {

	    private Long id;
	    private String course_code; 
	    private String course;
	    private String department;
	    private int duration_year;
	    private int total_semester;
	    private int fee;
	    private String description;
	    private boolean active;
	    
		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getCourse_code() {
			return course_code;
		}

		public void setCourse_code(String course_code) {
			this.course_code = course_code;
		}

		public String getCourse() {
			return course;
		}

		public void setCourse(String course) {
			this.course = course;
		}

		public String getDepartment() {
			return department;
		}

		public void setDepartment(String department) {
			this.department = department;
		}

		public int getDuration_year() {
			return duration_year;
		}

		public void setDuration_year(int duration_year) {
			this.duration_year = duration_year;
		}

		public int getTotal_semester() {
			return total_semester;
		}

		public void setTotal_semester(int total_semester) {
			this.total_semester = total_semester;
		}

		public int getFee() {
			return fee;
		}

		public void setFee(int fee) {
			this.fee = fee;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public boolean getActive() {
			return active;
		}

		public void setActive(boolean active) {
			this.active = active;
		}

		public CourseBean(Long id, String course_code, String course, String department, int duration_year,
				int total_semester, int fee, String description, boolean active) {
			super();
			this.id = id;
			this.course_code = course_code;
			this.course = course;
			this.department = department;
			this.duration_year = duration_year;
			this.total_semester = total_semester;
			this.fee= fee;
			this.description = description;
			this.active = active;
		}

		public CourseBean() {
			super();
			// TODO Auto-generated constructor stub
		}

	    

	}
