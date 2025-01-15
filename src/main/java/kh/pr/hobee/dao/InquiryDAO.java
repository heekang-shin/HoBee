package kh.pr.hobee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pr.hobee.common.Common;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.InquiryVO;

public class InquiryDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 리스트 조회
	public List<InquiryVO> selectInq() {
		List<InquiryVO> inq_list = sqlSession.selectList("i.inq_list");
		return inq_list;
	}

	// inq 답변 상세 보기
	public InquiryVO inqOne(int id) {
		InquiryVO vo = sqlSession.selectOne("i.inq_one", id);
		return vo;
	}

	// inq 답변 제출
	public int inqFin(InquiryVO vo) {
		int res = sqlSession.update("i.inq_update", vo);
		return res;
	}

	// inq 답변 삭제
	public int inqDel(int id) {
		int res = sqlSession.delete("i.inq_del", id);
		return res;
	}

	// inq 답변 수정
	public int inqUpdate(int id) {
		int res = sqlSession.update("i.inq_write_update", id);
		return res;
	}

	// inq 제목에 따른 검색
	public List<InquiryVO> searchByTitle(String search_text) {
		System.out.println("검색어"+search_text);
		List<InquiryVO> search_list = sqlSession.selectList("i.inq_search_by_title", search_text);
		return search_list;
	}

	// inq 내용에 따른 검색
	public List<InquiryVO> searchByContent(String search_text) {
		System.out.println("검색어"+search_text);
		List<InquiryVO> search_list = sqlSession.selectList("i.inq_search_by_content", search_text);
		return search_list;
	}

	// inq 전체 검색
	public List<InquiryVO> searchByAll(String search_text) {
		System.out.println("검색어"+search_text);
		List<InquiryVO> search_list = sqlSession.selectList("i.inq_search_by_all", search_text);
		return search_list;
	}
	

}
