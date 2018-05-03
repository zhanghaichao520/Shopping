package com.haichaoaixuexi.util;

import java.util.Random;

public class Util {
	public static final String numberChar = "0123456789";
	 
    /**
     * 根据系统时间获得指定位数的随机数
     * 
     * @return 获得的随机数
     */
    public static String getRandom() {
 
        Long seed = System.currentTimeMillis();// 获得系统时间，作为生成随机数的种子
 
        StringBuffer sb = new StringBuffer();// 装载生成的随机数
 
        Random random = new Random(seed);// 调用种子生成随机数
 
        for (int i = 0; i < 4; i++) {
 
            sb.append(numberChar.charAt(random.nextInt(numberChar.length())));
        }
 
        return sb.toString();
 
    }
	public static String ascllToString(String s) {// ASCII转换为字符串   
       // String s = "24352 28023 36229";// ASCII码   
		String result="";
        String[] chars = s.split(" ");   
        for (int i = 0; i < chars.length; i++) {   
            result += (char) Integer.parseInt(chars[i]);
        }  
        return result;
    }   
  
    public static String stringToAscll(String s) {// 字符串转换为ASCII码   
        //String s = "张海超";// 字符串   
        char[] chars = s.toCharArray(); // 把字符中转换为字符数组   
        String result = "";
        for (int i = 0; i < chars.length; i++) {// 输出结果   
            result += (int) chars[i]+" ";
        }  
         
		return (String) result.subSequence(0,result.length()-1);
    }   
    
}
