package com.pcroom.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ReserveDTO {
	private int seat;
	private String userId;
	private LocalDateTime time;
	private String userName;
	private String userTel;
	private int hours;

	public int getSeat() {
		return seat;
	}

	public void setSeat(int seat) {
		this.seat = seat;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public LocalDateTime getTime() {
		return time;
	}

	public void setTime(LocalDateTime time) {
		this.time = time;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}

	public int getHours() {
		return hours;
	}

	public void setHours(int hours) {
		this.hours = hours;
	}

	// 시작 시간 포맷
	public String getFormattedStartTime() {
		if (time == null)
			return "";
		return time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}

	// 종료 시간 포맷
	public String getFormattedEndTime() {
		if (time == null)
			return "";
		return time.plusHours(hours).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}

	// 시간 범위 표시
	public String getTimeRange() {
		if (time == null)
			return "";
		return String.format("%s ~ %s", getFormattedStartTime(), getFormattedEndTime());
	}
}