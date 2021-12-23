package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO select(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean delete(Long bno);
	
	public List<BoardVO> selectAllList();
}
