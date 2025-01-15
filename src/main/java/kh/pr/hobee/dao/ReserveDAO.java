package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.ReserveVO;

public class ReserveDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/*
	// 신청내역 리스트 조회
	public List<ReserveVO> resList() {
		List<ReserveVO> res_list = sqlSession.selectList("r.res_list");
		return res_list;
	}*/

}