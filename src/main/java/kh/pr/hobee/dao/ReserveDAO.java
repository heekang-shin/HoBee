package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReserveVO;

public class ReserveDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 신청내역 리스트 조회
	public List<ReserveVO> resList() {
		List<ReserveVO> res_list = sqlSession.selectList("r.res_list");
		return res_list;
	}

	// inq 제목에 따른 검색
	public List<ReserveVO> searchByTitle(String search_text) {
		System.out.println("검색어" + search_text);
		List<ReserveVO> search_list = sqlSession.selectList("r.inq_search_by_title", search_text);
		return search_list;
	}

	// inq 내용에 따른 검색
	public List<ReserveVO> searchByContent(String search_text) {
		System.out.println("검색어" + search_text);
		List<ReserveVO> search_list = sqlSession.selectList("r.inq_search_by_content", search_text);
		return search_list;
	}

	// inq 전체 검색
	public List<ReserveVO> searchByAll(String search_text) {
		System.out.println("검색어" + search_text);
		List<ReserveVO> search_list = sqlSession.selectList("r.inq_search_by_all", search_text);
		return search_list;
	}

}