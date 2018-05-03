package com.haichaoaixuexi.util;

import java.util.Random;

public class Util {
	public static final String numberChar = "0123456789";
	 
    /**
     * ����ϵͳʱ����ָ��λ���������
     * 
     * @return ��õ������
     */
    public static String getRandom() {
 
        Long seed = System.currentTimeMillis();// ���ϵͳʱ�䣬��Ϊ���������������
 
        StringBuffer sb = new StringBuffer();// װ�����ɵ������
 
        Random random = new Random(seed);// �����������������
 
        for (int i = 0; i < 4; i++) {
 
            sb.append(numberChar.charAt(random.nextInt(numberChar.length())));
        }
 
        return sb.toString();
 
    }
	public static String ascllToString(String s) {// ASCIIת��Ϊ�ַ���   
       // String s = "24352 28023 36229";// ASCII��   
		String result="";
        String[] chars = s.split(" ");   
        for (int i = 0; i < chars.length; i++) {   
            result += (char) Integer.parseInt(chars[i]);
        }  
        return result;
    }   
  
    public static String stringToAscll(String s) {// �ַ���ת��ΪASCII��   
        //String s = "�ź���";// �ַ���   
        char[] chars = s.toCharArray(); // ���ַ���ת��Ϊ�ַ�����   
        String result = "";
        for (int i = 0; i < chars.length; i++) {// ������   
            result += (int) chars[i]+" ";
        }  
         
		return (String) result.subSequence(0,result.length()-1);
    }   
    
}
