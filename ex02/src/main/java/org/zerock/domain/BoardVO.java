package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date cdate;
	private Date udate;
	
	private int replyCnt;
	
	//게시글 등록시 한 번에 첨부파일도 처리하기 위함.
	private List<BoardAttachVO> attachList;
}
