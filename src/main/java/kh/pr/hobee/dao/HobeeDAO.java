package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.HobeeVO;

public class HobeeDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// best제품 조회
	public List<HobeeVO> bestSelect() {
		List<HobeeVO> best_list = sqlSession.selectList("h.hobee_best_list");
		return best_list;
	}

	// pick 제품 조회
	public List<HobeeVO> pickSelect() {
		List<HobeeVO> pick_list = sqlSession.selectList("h.hobee_pick_list");
		return pick_list;
	}

	// new 제품 조회
	public List<HobeeVO> newSelect() {
		List<HobeeVO> new_list = sqlSession.selectList("h.hobee_new_list");
		return new_list;
	}

	// 검색어조회
	public List<HobeeVO> searchSelect(String search_text) {
		// 검색어가 있으면 DB에서 조회
		List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_list", search_text);
		return search_list;
	}

	// 프로그램 등록
	public int insertFin(HobeeVO vo) {
		int res = sqlSession.insert("h.hobee_insert", vo);
		return res;
	}

	// host 프로그램 조회
	public List<HobeeVO> applyList() {
		List<HobeeVO> apply_list = sqlSession.selectList("h.hobee_apply_list");
		return apply_list;
	}
	
	//host apply 한개 조회
	public HobeeVO applyOne(int hb_idx) {
		HobeeVO vo = sqlSession.selectOne("h.hobee_apply_one", hb_idx);
		return vo;
	}
	
	//host apply 수정
	public int modify(HobeeVO vo) {
		int res = sqlSession.insert("h.hobee_apply_update", vo);
		return res;
	}
	
	//host apply 삭제
	public int hostDel(int hb_idx) {
		int res = sqlSession.delete("h.hobee_apply_del", hb_idx);
		return res;
	}
	
	//host 제목에 따른 검색
	public List<HobeeVO> searchByTitle(String search_text) {
		List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_by_title", search_text);
		return search_list;
	}

	//host 내용에 따른 검색
	public List<HobeeVO> searchByContent(String search_text) {
		List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_by_content", search_text);
		return search_list;
	}

	//host 전체 검색
	public List<HobeeVO> searchByAll(String search_text) {
		List<HobeeVO> search_list = sqlSession.selectList("h.hobee_search_by_all", search_text);
		return search_list;
	}
	
		
}