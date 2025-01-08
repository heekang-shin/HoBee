package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.InquiryVO;

public class InvenDAO {
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<CategoryVO> selectInven(int category){
		List<CategoryVO> list = sqlSession.selectList("i.big_list", category);
		return list;
	}
	
	public List<HobeeVO> selectHobee(int category){
		List<HobeeVO> list = sqlSession.selectList("i.hobee_list", category);
		return list;
	}
	
	
	public List<HobeeVO> selectHobee_best(int category){
		List<HobeeVO> list = sqlSession.selectList("i.hobee_list_best", category);
		return list;
	}
	
	public HobeeVO hobeeDetail(int hb_idx) {
		HobeeVO vo = sqlSession.selectOne("i.hobee_detail", hb_idx);
		return vo;
	}
	
	public List<InquiryVO> getAllInquiries(int hb_idx) {
		List<InquiryVO> list = sqlSession.selectList("i.hobee_inquiry", hb_idx);
		return list;
	}
	
}