package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
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
	public BoardVO select(Long bno) {
		log.info("select... : " + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		return mapper.update(board) == 1; //수정이 정상적으로 이뤄지면 1 반환
	}

	@Override
	public boolean delete(Long bno) {
		log.info("delete...." + bno);
		return mapper.delete(bno) == 1;	//삭제가 정상적으로 이뤄지면 1 반환
	}

	@Override
	public List<BoardVO> selectAllList() {
		log.info("selectAllList...");
		
		return mapper.getList();
	}

}

/*
 * @AllArgsConstructor : 모든 파라미터를 이용하는 생성자를 만들어 줌
 */
