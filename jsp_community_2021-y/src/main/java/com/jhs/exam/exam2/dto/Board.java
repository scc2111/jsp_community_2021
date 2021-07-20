package com.jhs.exam.exam2.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class Board {
	private int id;
	private String regDate;
	private String updateDate;
	private String code;
	private String name;
	private String delDate;
	private boolean delStatus;
	private String blindDate;
	private boolean blindStatus;
}