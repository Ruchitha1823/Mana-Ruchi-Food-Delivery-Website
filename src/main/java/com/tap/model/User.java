package com.tap.model;
import java.sql.Timestamp;
public class User {
	private int userid;
	private String name;
	private String password;
	private String email;
	private String phone;
	private String address;
	private String role;
	private Timestamp createdDate;
	private Timestamp lastLoginDate;
	public User() {
		
	}
	public User(String name, String password, String email, String phone, String address, String role, Timestamp createdDate,
			Timestamp lastLoginDate) {
		super();
		this.name = name;
		this.password=password;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLoginDate = lastLoginDate;
	}
	public int getId() {
		return userid;
	}
	public void setId(int userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	@Override
	public String toString() {
		return "User [id=" + userid + ", name=" + name + ", email=" + email + ", phone=" + phone + ", address=" + address
				+ ", role=" + role + ", createdDate=" + createdDate + ", lastLoginDate=" + lastLoginDate + "]";
	}
	
	
}
