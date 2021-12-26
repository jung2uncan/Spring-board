package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
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
	
	//전체 리스트 조회 메소드
	@GetMapping("/list")	
	public void list(Model model) {
		log.info("list..");
		
		model.addAttribute("list", service.getList());
	}
	
	//글 등록 메소드
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : " + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list"; //'redirect:' : 스프링 MVC가 내부적으로 response.serdRedirect()를 처리함
	}
	
	//글 조회 메소드
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("/get..");
		model.addAttribute("get", service.get(bno));
	}
	
	//글 수정 메소드
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify.." + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list";
	}
	
	//글 삭제 메소드
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Model model, RedirectAttributes rttr) {
		log.info("/remove..");
		
		if( service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/board/list";	
	}
}
