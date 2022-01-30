package org.zerock.controller;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.queryParam;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//Test for Controller
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})

//Java 설정일 때,
// @ContextConfiguration(classes= {org.zerock.config.RootConfig.class, org.zerock.config.ServletConfig.class})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_= {@Autowired})
	private WebApplicationContext ctx;
	
	//가짜 MVC라고 생각하면 됨. 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것 처럼 만들어서 Contoroller를 실행해 볼 수 있음.
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	/*
	@Test
	public void testsList() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	*/
	
	@Test
	public void testsList() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "3")
				.param("amount", "10"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새 글 제목")
				.param("content", "테스트 새 글 내용")
				.param("writer", "user01"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testsGet() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/get").param("bno", "1")).
				andReturn().
				getModelAndView().
				getModelMap());
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage 
				= mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "3")
				.param("title", "테스트 수정 글 제목")
				.param("content", "테스트 수정 글 내용")
				.param("writer", "user02"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception{
		String resultPage = 
				mockMvc.perform(MockMvcRequestBuilders.get("/board/remove").param("bno", "25")).
				andReturn().
				getModelAndView().
				getViewName();
		
		log.info(resultPage);
	}
}

/*
 * @WebAppConfiguration : 스프링의 WebApplicationContext를 이용하기 위함.
 * @Before : 모든 테스트 전 매번 실행되는 메소드임을 명시
 * 
 */
