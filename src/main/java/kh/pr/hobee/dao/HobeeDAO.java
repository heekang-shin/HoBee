package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.pr.hobee.vo.HobeeVO;

public class HobeeDAO {

	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//hobee 목록 조회
	public List<HobeeVO> selectlist() {
		List<HobeeVO> list = sqlSession.selectList("h.hobee_list");
		return list;
	}
	
	
	//검색어조회
		public List<HobeeVO> searchSelect(String search_text) {
		 
		    // 검색어가 있으면 DB에서 조회
		    List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_list", search_text);
		    return search_list;
		}
	
}
