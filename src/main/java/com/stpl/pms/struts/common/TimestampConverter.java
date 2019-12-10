package com.stpl.pms.struts.common;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

import com.opensymphony.xwork2.conversion.TypeConversionException;

public class TimestampConverter extends StrutsTypeConverter {

	@SuppressWarnings("unchecked")
	@Override
	public Object convertFromString(Map context, String[] strings, Class toClass) {
		DateFormat DATETIME_FORMAT = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		if (strings == null || strings.length == 0
				|| strings[0].trim().length() == 0) {
			return null;
		}
		try {
			return new Timestamp(DATETIME_FORMAT.parse(strings[0]).getTime());
		} catch (ParseException e) {
			throw new TypeConversionException(
					"Unable to convert given object to date: " + strings[0]);
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public String convertToString(Map context, Object date) {
		DateFormat DATETIME_FORMAT = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		if (date != null && date instanceof Timestamp) {
			return DATETIME_FORMAT.format(date);
		} else {
			return null;
		}
	}

}
