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
	    // MyBatis를 통해 review_insert 쿼리 실행
	    int res = sqlSession.insert("review.review_insert", vo);
	    return res; // 결과 반환
	}


	// 모든 리뷰 조회 메서드
	public List<ReviewVO> reviewList() {
		List<ReviewVO> list = sqlSession.selectList("review.review_list");
		return list;
	}
	
	//특정 hbidx로 리뷰만 조회
	public List<ReviewVO> get_reviewList(int hb_idx){
		List<ReviewVO> list = sqlSession.selectList("review.selreview_list",hb_idx);
		return list;
	}
	
	//특정 hbidx로 조회한 리뷰 최신순 정렬 
	public List<ReviewVO>recentList(int hb_idx){
		List<ReviewVO> list = sqlSession.selectList("review.recentList",hb_idx);
		return list;
	}
}
