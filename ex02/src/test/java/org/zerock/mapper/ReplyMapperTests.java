package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	//테스트를 위해 존재하는 게시물의 번호를 가진 배열 생성
	private Long[] bnoArr = {1202124L, 1202123L, 1202122L, 1202121L, 1202106L};
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info("mapper....." + mapper);
	}
	
	/*
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			
			//게시물의 번호
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
			
		});
	}
	*/
	
	@Test
	public void testRead() {
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		log.info("testRead : " + vo);
	}
	
	@Test
	public void testDelete() {
		Long targetRno = 10L;
		
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		Long targetRno = 7L;
		ReplyVO vo = mapper.read(targetRno);
			
		//게시물의 번호
		vo.setReply("댓글 수정 테스트 입니다.");
			
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT : " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
			
		replies.forEach(reply -> log.info("********************testList " + reply));
	}
}


