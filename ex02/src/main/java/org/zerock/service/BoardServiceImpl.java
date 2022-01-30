package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register ... : " + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get... : " + bno);
		return mapper.get(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		return mapper.modify(board) == 1; //수정이 정상적으로 이뤄지면 1 반환
	}

	@Override
	public boolean remove(Long bno) {
		log.info("delete...." + bno);
		return mapper.remove(bno) == 1;	//삭제가 정상적으로 이뤄지면 1 반환
	}

	/*
	@Override
	public List<BoardVO> getList() {
		log.info("getList...");
		
		return mapper.getList();
	}
	*/

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List With Criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}

}

/*
 * @AllArgsConstructor : 모든 파라미터를 이용하는 생성자를 만들어 줌
 */
