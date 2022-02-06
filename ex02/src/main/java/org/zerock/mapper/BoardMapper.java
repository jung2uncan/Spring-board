package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	//게시글 전체 조회
	//@Select("SELECT * FROM tbl_board WHERE bno > 0")
	public List<BoardVO> getList();
	
	//게시글의 페이지 번호와 읽어올 개수에 따라 게시글을 조회하는 함수
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	//게시글 삽입 : insert 처리 후 생성된 PK값을 알 필요 없는 경우
	public void insert(BoardVO board);
	
	//게시글 삽입 : insert 처리 후 생성된 PK값을 알아야 할 경우
	public void insertSelectKey(BoardVO board);
	
	//게시글 읽기 : 게시글 번호를 통해서 1개의 글 읽어오기
	public BoardVO get(Long bno);
	
	//게시글 삭제 : 특정 게시글을 삭제하기
	//삭제하고자하는 게시글이 있다면 1, 없으면 0 반환
	public int remove(Long bno);
	
	//게시글 수정 : 특정 게시글 수정하기
	//수정하고자하는 게시글이 있다면 1, 없으면 0 반환
	public int modify(BoardVO board);
	
	//게시글의 전체 개수 구하기
	public int getTotalCount(Criteria cri);
	
}
