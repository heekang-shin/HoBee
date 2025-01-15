package kh.pr.hobee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.ReviewVO;

public class ReviewDAO {

	SqlSession sqlSession;

	// setter 인젝션
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 리뷰 등록 메서드
	public int insertReview(ReviewVO vo) {
		int res = sqlSession.insert("review.review_insert", vo);
		return res;
	}

	// 모든 리뷰 조회 메서드
	public List<ReviewVO> reviewList() {
		List<ReviewVO> list = sqlSession.selectList("review.review_list");
		return list;
	}
}
