package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java 설정을 사용하는 경우
//@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class DataSourceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;
	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testMyBatis() {
		try (SqlSession session = sqlSessionFactory.openSession();
			 Connection conn = session.getConnection();) {
			log.info(session);
			log.info(conn);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	/*
	 * 스프링에 빈(Bean)으로 등록된 DataSource를 이용해서 Connection을 제대로 처리할 수 있는지를 확인해보는 용도
	 * testConnection()을 실행해보면 내부적으로 HikariCP가 시작되고, 종료되는 로그를 확인할 수 있음.
	 */
	
	/*
	 * @Test 
	 * public void testConnection() { 
	 * 		try(Connection conn = dataSource.getConnection()) { 
	 * 			log.info(conn); 
	 * 		}
	 * 		catch(Exception e) {
	 * 			e.printStackTrace(); 
	 * 		} 
	 * }
	 */
}
