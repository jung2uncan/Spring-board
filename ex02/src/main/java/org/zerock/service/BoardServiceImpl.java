package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register ... : " + board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get... : " + bno);
		return mapper.get(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		//기존 파일 다 지우고,
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.modify(board) == 1; //수정이 정상적으로 이뤄지면 1 반환
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0 ) {
			//bno를 얻어 수정하는 현재 갖고 있는 파일들을 새로 저장함.
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("delete...." + bno);
		
		attachMapper.deleteAll(bno);
		
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

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno : " + bno);
		return attachMapper.findByBno(bno);
	}
}

/*
 * @AllArgsConstructor : 모든 파라미터를 이용하는 생성자를 만들어 줌
 */
