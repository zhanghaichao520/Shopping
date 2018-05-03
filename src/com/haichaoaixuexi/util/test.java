package com.haichaoaixuexi.util;

import com.haichaoaixuexi.bean.User;

public class test {

	public static void main(String[] args)  {
		// TODO Auto-generated method stub
		User user =User.getUserByUsername("1232");
		String email = "961876295@qq.com";
		try {
			emailSend.sendEmail(user,email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
