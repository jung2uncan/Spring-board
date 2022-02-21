package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {

	@GetMapping(value="/getText", produces ="text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
	//http://localhost:8080/sample/getSample.json
	//XML과 JSON 방식의 데이토를 생성할 수 있는 getSample()
	@GetMapping(value="/getSample", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,
												MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		return new SampleVO(112,"스타","로드");	
	}
	
	//http://localhost:8080/sample/getSample2.json
	@GetMapping(value="/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113,"로켓","라쿤");	
	}
	
	//http://localhost:8080/sample/getList.json
	@GetMapping("/getList")
	public List<SampleVO> getList(){
		//Stream은 컬렉션, 배열등에 대해 저장되어있는 요소들을 하나씩 참조하며 반복적인 처리를 가능케하는 기능
		return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i+"First", i+"Last")).collect(Collectors.toList());
	}
	
	//http://localhost:8080/sample/getMap.json
	@GetMapping("getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111,"그루트","주니어"));
		
		return map;
	}
	
	//http://localhost:8080/sample/check?height=170&weight=60
	@GetMapping(value="/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo =  new SampleVO(0, ""+height, ""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if(height < 150.0) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	//http://localhost:8080/sample/product/bags/123
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
		return new String[] {"category : " + cat , "productId : " + pid};
	}
	
	//JSON 형태로 전달되는 데이터를 받아 Ticket 형태로 변환 후 Return하는 함수
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert.......ticket" + ticket);
		
		return ticket;
	}
	
}

/*
	1) GetMapping 내 produces
	 : produces 를 추가하고 data Type을 지정하면 해당 dataType으로만 사용자에게 응답하겠다는 의미
	   추가로, consumes도 추가할 수 있는데 수신 받고자하는 데이터 포맷을 정의(Request Body에 담는 타입을 제한)
	  
	2) MIME(Multipurpose Internet Mail Extensions) 이란?
	: 파일 변환을 위한 포맷. 웹을 통해 전달되는 다양한 형태의 파일을 텍스트 문자 형태로 변환해서 이메일과 함께 전송하기 위해 개발된 포맷
*/