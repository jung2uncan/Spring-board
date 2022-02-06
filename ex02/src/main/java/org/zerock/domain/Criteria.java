package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;
	private int amount;	//한 페이지에 보일 게시글의 개수
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 20);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		//검색조건이 T(Title), W(Writer), C(Content)로 구성되어 있으므로 검색 조건을 배열로 만들어서 한 번에 처리하기 위함
		return type == null ? new String[] {}: type.split("");
	}
	
	//여러 개의 파라미터들을 연결해서 URL의 형태로 만들어주는 기능을 가짐
	//URL을 만들어주면, 리다리렉트를 하거나, <form> 태그를 사용하는 상황을 많이 줄일 수 있는 장점이 있음
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
