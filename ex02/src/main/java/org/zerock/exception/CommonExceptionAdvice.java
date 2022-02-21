package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	/*
	 * 500 에서는 Internal Server Error 이므로 @ExceptionHandler를 이용해서 처리되지만, 
	 * 400 에러는 잘못된 URL을 호출할 때 보이므로 다르게 처리해주어야 한다.
	 */
	
	@ExceptionHandler(Exception.class) 
	public String except(Exception ex, Model model) {
		log.error("Exception.........." + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		
		return "error_page";
	}

	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	//@ResponseStatus(HttpStatus.BAD_GATEWAY) 
	public String handler404(NoHandlerFoundException ex) {
		
		log.error("404.........." );
		log.error(ex);
		
		return "error_404";
	}
}

/*
 * @ControllerAdvice : 해당 객체가 스프링의 컨트롤러에서 발생하는 예외를 처리하는 존재임을 뜻함
 * @ExceptionHandler(Exception.class) : 해당 메소드가 ()에 들어가는 예외타입을 처리한다는 것을 뜻함.
 *  -> 이 경우, Exception.class을 지정하였으므로. 모든 예외에 대한 처리가 except()만을 이용해서 처리할 수 있음.
 */
