package com.wy.handler;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 自定义类型转换器. 时间格式转换器
 *
 */
public class SimpleDateConverter implements Converter<String,Date> {
    //定义四种时间格式
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat format3 = new SimpleDateFormat("yyyy/MM/dd");
    SimpleDateFormat format4 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    @Override
    public Date convert(String s) {
        Date date = null;
        try {
            int i = s.indexOf("-");
            int i1 = s.indexOf("/");
            if(i>0){ // 时间格式为 2020-10-10
                if(s.length() == 10){ //2020-10-10
                    date = format1.parse(s);
                }else if(s.length() == 19){ //2020-10-10 20:10:30
                    date = format2.parse(s);
                }
            }else if(i1 >0){ //时间格式为 2020/10/20
                if(s.length() == 10){ //2020-10-10
                    date = format3.parse(s);
                }else if(s.length() == 19){ //2020-10-10 20:10:30
                    date = format4.parse(s);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }
}
