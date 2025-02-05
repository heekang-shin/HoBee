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

	// 특정 hbidx로 리뷰만 조회
	public List<ReviewVO> get_reviewList(int hb_idx) {
		List<ReviewVO> list = sqlSession.selectList("review.selreview_list", hb_idx);
		return list;
	}

	// 특정 hbidx로 조회한 리뷰 최신순 정렬
	public List<ReviewVO> recentList(int hb_idx) {
		List<ReviewVO> list = sqlSession.selectList("review.recentList", hb_idx);
		return list;
	}

	// review_id로 조회된 게시글 삭제
	public int delete(int review_id) {
		int res = sqlSession.delete("review.review_del", review_id);
		return res;
	}

	// review_id로 특정 리뷰 조회 메서드
	public ReviewVO getReviewById(int review_id) {
	    return sqlSession.selectOne("review.getReviewById", review_id);
	}
	
	// userId로 리뷰를 조회하면서 hb_title도 함께 가져오도록 수정
	public List<ReviewVO> getReviewsByUserId(String userId) {
	    return sqlSession.selectList("review.getReviewsWithHobee", userId);
	}

	
	 //[신규 추가] 호스트가 삭제 요청을 DB에 저장하는 메서드
    public int insertDeleteRequest(ReviewVO vo) {
        return sqlSession.insert("review.insertDeleteRequest", vo);
    }

    //[신규 추가] 관리자 페이지에서 '대기' 상태의 삭제 요청 목록 조회
    public List<ReviewVO> getPendingDeleteRequests() {
        return sqlSession.selectList("review.getPendingDeleteRequests");
        
    }

    //[신규 추가] 관리자 승인 또는 거절 후 요청 상태 업데이트
    public int updateDeleteRequestStatus(int review_id, String status) {
        ReviewVO updateVO = new ReviewVO();
        updateVO.setReview_id(review_id);
        updateVO.setRequest_status(status);
        return sqlSession.update("review.updateDeleteRequestStatus", updateVO);
    }

    //[신규 추가] 특정 review_id에 대해 삭제 요청이 이미 존재하는지 확인
    public boolean isDeleteRequestExists(int review_id) {
        int count = sqlSession.selectOne("review.countDeleteRequest", review_id);
        return count > 0;  // 요청이 존재하면 true, 없으면 false
    }
    
 // ✅ 삭제 요청 테이블에서 해당 요청 제거
    public int deleteDeleteRequest(int review_id) {
        return sqlSession.delete("review.deleteDeleteRequest", review_id);
    }

    
 // ✅ 특정 모임(hbidx)을 생성한 호스트의 user_id 조회
    public String getHostUserIdByHbidx(int hbidx) {
        return sqlSession.selectOne("review.getHostUserIdByHbidx", hbidx);
    }

    
}


