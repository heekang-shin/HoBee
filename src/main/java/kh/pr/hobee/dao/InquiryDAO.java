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

	
	
}
