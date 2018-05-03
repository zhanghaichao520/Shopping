package com.haichaoaixuexi.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.dao.UserDao;
import com.haichaoaixuexi.data.Const;
import com.haichaoaixuexi.util.DB;

public class User {
	private int id;
	private String status;
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Timestamp rdate;
	

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	public static void startUser(int id) {
		User user = UserDao.getUser(id);
		user.setStatus(Const.USER_SATATUS_START);
		UserDao.updateUser(user);
	}
	public static void stopUser(int id) {
		User user = UserDao.getUser(id);
		user.setStatus(Const.USER_SATATUS_STOP);
		UserDao.updateUser(user);
	}
	public static void delUser(int id) {
		User user = UserDao.getUser(id);
		user.setStatus(Const.USER_SATATUS_DELETE);
		UserDao.updateUser(user);
	}
	public static void delUserForever(int id) {
		UserDao.delUser(id);
	}
	public static void save(User u) {
		UserDao.add(u);
	}
	public static List<User> getUsers() {
		return UserDao.getUsers();
	}
	public static User getUser(int id) {
		return UserDao.getUser(id);
	}
	public static User getUserByUsername(String username) {
		return UserDao.getUser(username);
	}
	public static void updateUser(User user) {
		UserDao.updateUser(user);
	}
	public static void changePassword(int id,String password) {
		User user = UserDao.getUser(id);
		user.setPassword(password);
		UserDao.updateUser(user);
	}
	public static void changeUserInfo(int id,String username,String phone,String addr) {
		User user = UserDao.getUser(id);
		user.setUsername(username);
		user.setPhone(phone);
		user.setAddr(addr);
		UserDao.updateUser(user);
	}
	public static  User loginValidate(String username,String password) throws UserNotFindException, PasswordNotCorrectException, UserStopException, UserDeleteException {
		User user = UserDao.getUser(username);
		if (user.getId() == Const.USER_NOT_EXIST) {
			throw new UserNotFindException();
		}else if (!user.getPassword().equals(password)) {
			throw new PasswordNotCorrectException();
		}else if (user.getStatus().equals(Const.USER_SATATUS_STOP)) {
			throw new UserStopException();
		}else if (user.getStatus().equals(Const.USER_SATATUS_DELETE)) {
			throw new UserDeleteException();
		}
		return user;
	}
	public static boolean userExist(String username) {
		User user = UserDao.getUser(username);
		if (user.getId() != Const.USER_NOT_EXIST) {
			return true;
		}
		return false;
	}
	public static boolean passwordCorrect(String username,String password) {
		User user = UserDao.getUser(username);
		if (!user.getPassword().equals(password)) {
			return false;
		}
		return true;
	}
}
