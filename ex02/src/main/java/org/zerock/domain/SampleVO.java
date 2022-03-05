package org.zerock.domain;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SampleVO {
	
	private Integer mno;
	private String firstName;
	private String lastName;
}

/*
 * @NoArgsConstructor : 비어 있는 생성자를 만들기 위함.
 * @AllArgsConstructor : 모든 속성을 사용하는 생성자를 위함.
*/
