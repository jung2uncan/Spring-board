package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	/*
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	*/
	
	/*
	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
	*/
	
	/*
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 테스트");
		board.setContent("새로 작성하는 내용 테스트");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 테스트 Select Key");
		board.setContent("새로 작성하는 내용 테스트 Select Key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}

	@Test
	public void testRead() {
		//존재하는 게시글 번호로 테스트 진행 필수
		BoardVO board = mapper.get(1L);
		
		log.info(board);
	}
	
	@Test 
	public void testDelete() {
		//존재하는 게시글 번호로 테스트 진행 필수
		//삭제하고자하는 게시글이 있다면 1, 없으면 0 반환
		log.info("DELETE COUNT: " + mapper.remove(22L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(29L);
		board.setTitle("수정한 글 입니다.");
		board.setContent("수정하는 내용 테스트");
		board.setWriter("user00");
		
		int count = mapper.modify(board);
		log.info("UPDATE COUNT: " + count);
	}
	*/
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("안녕");
		cri.setType("T");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}

}
