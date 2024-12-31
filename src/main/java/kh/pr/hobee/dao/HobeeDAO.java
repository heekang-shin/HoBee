package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HobeeVO;

public class HobeeDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//best제품 조회
	public List<HobeeVO> bestSelect(){
		List<HobeeVO> best_list = sqlSession.selectList("h.hobee_best_list");
		return best_list;
	}
	
	//pick 제품 조회
	public List<HobeeVO> pickSelect(){
		List<HobeeVO> pick_list = sqlSession.selectList("h.hobee_pick_list");
		return pick_list;
	}
	
	
	//new 제품 조회
	public List<HobeeVO> newSelect(){
		List<HobeeVO> new_list = sqlSession.selectList("h.hobee_new_list");
		return new_list;
	}
	
	//검색어조회
	public List<HobeeVO> searchSelect(String search_text) {
	    // 검색어가 있으면 DB에서 조회
	    List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_list", search_text);
	    return search_list;
	}
	
	
	
	
}
