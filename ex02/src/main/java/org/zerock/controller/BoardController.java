package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor //생성자를 만들고 자동으로 주입하도록 함
public class BoardController {

	//@AllArgsConstructor를 안쓰려면, 아래와 같이 작성하여 처리
	//@Setter(onMethod_ = {@Autowired}) 
	private BoardService service;
	
	/*
	//전체 리스트 조회 메소드
	@GetMapping("/list")	
	public void list(Model model) {
		log.info("list..");
		
		model.addAttribute("list", service.getList());
	}
	*/
	
	//페이지 및 읽을 게시글 개수에 따른 조회 메소드
	@GetMapping("/list")	
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
				
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);		
		log.info("total : " + total);
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
		
	//글 등록 메소드
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("=================================");
		log.info("register : " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("=================================");
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list"; //'redirect:' : 스프링 MVC가 내부적으로 response.serdRedirect()를 처리함
	}
	
	//글 등록을 위해 화면에서 입력을 받기 위한 메소드. 입력 페이지를 보여주는 역할만 하기 때문에 별도의 처리는 불필요함
	@GetMapping("/register")
	public void register() {
		//아무것도 설정하지 않으면, 본인의 함수명과 동일한 jsp 파일을 자동으로 호출함.
	}
	
	//글 조회, 수정 메소드
	//@ModelAttribute : 자동으로 Model에 데이터를 지정한 이름으로 담아줌
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/get or /modify..");
		
		model.addAttribute("board", service.get(bno));
		
	}
	
	//글 수정 메소드
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify.." + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	//글 삭제 메소드
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Model model, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("/remove..");
		
		if( service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		
		return "redirect:/board/list"  + cri.getListLink();	
	}
	
	//특정한 게시물 번호의 첨부파일과 관련된 데이터를 JSON으로 반환하는 메소드
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

}
