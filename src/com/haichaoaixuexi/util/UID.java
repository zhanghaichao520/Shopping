package com.haichaoaixuexi.util;

/**
 * 生成唯一的UID类
 */
public class UID {

	//定义一个最大增长数
	private static final int MAX_COUNT = 99999;
    //定义用于递增的参数
	private static int generateCount = 0;

	/**
	 * 获取唯一的UID号		
	 * @return 14-18位的唯一UID号
     */
	public static synchronized String getUID() {

		if (generateCount > MAX_COUNT)
			generateCount = 0;
		String uniqueNumber = Long.toString(System.currentTimeMillis())
				+ Integer.toString(generateCount);
		generateCount++;

		//假如超过32位的话，只取后32位
		if (uniqueNumber.length() > 32) {
			uniqueNumber = uniqueNumber.substring(uniqueNumber.length() - 32);
		}

		return uniqueNumber;
		
	}


    public static void main(String arg[])
    {
    	//System.out.println(UID.getUID());
    	System.out.println(System.currentTimeMillis());
    	
    }
}
