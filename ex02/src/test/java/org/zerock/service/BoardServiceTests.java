package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java Config
//@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	
	@Test //BoardService 객체가 제대로 주입이 가능한지 확인하는 메소드
	public void testExist() {
		
		log.info("Service 객체 주입 확인 : " + service);
		assertNotNull(service);
	}
	
	@Test //service를 이용한 게시글 등록 테스트
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새로운 글");
		board.setContent("새로운 내용");
		board.setWriter("newbie2");
		
		//service.register(board);
		
		//log.info("생성된 게시물의 번호 : " + board.getBno());
	}
	
	@Test //service를 이용한 전체 게시글 조회 테스트
	public void testSelectAllList() {
		service.selectAllList().forEach(board -> log.info(board));
	}
	
	@Test //service를 이용한 1개의 게시글 조회 테스트
	public void testSelect() {
		log.info(service.select(1L));
	}
	
	@Test //service를 이용한 1개의 게시글 삭제 테스트
	public void testDelete() {
		log.info("REMOVE RESULT : " + service.delete(34L));
	}
	
	@Test //service를 이용한 1개의 게시글 수정 테스트
	public void testUpdate() {
		BoardVO board = service.select(1L);
		
		//게시글이 없으면 종료
		if(board == null) {
			return;
		}
		
		board.setTitle("제목 수정 글입니다.");
		log.info("UPDATE RESULT : " + service.modify(board));
	}
}
