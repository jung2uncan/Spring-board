package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	//게시글 조회시, 게시글에 첨부된 첨부파일 조회용 메소드
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
}
