package kh.pr.hobee.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.HostVO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReserveVO;
import kh.pr.hobee.vo.UsersVO;
import kh.pr.hobee.vo.WishlistVO;

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
	
	public int addReserve(ReserveVO res_vo) {
		int reserve = sqlSession.insert("i.hobee_reserve", res_vo);
		return reserve;
	}
	
	public int addWishlist(WishlistVO vo) {
		int res = sqlSession.insert("i.hobee_wishlist", vo);
		return res;
	}
	
	public int deleteWishlist(WishlistVO vo) {
		int res = sqlSession.delete("i.hobee_deleteWishlist", vo);
		return res;
	}
	
	public List<WishlistVO> allwish(int user_id){
		List<WishlistVO> list = sqlSession.selectList("i.hobee_allwish", user_id);
		return list;
	}
	
	public int saveInquiry(InquiryVO inquiryVO) {
	    return sqlSession.insert("i.saveInquiry", inquiryVO);
	}
	
	//찜목록에 이미 있는지 확인
	public boolean isInWishlist(int user_id, int hb_idx) {
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("user_id", user_id);
	    params.put("hb_idx", hb_idx);

	    Integer count = sqlSession.selectOne("i.checkWishlist", params);
	    return count != null && count > 0;
	}
	
	//hobee의 가격 가져오기
	public int hobPrice(int hbidx) {
		int res = sqlSession.selectOne("i.hobeePrice", hbidx);
		return res;
	}
	
	//hobee에 인원수 더하기
	public int plusHead(Map<String, Object> params) {
		int res = sqlSession.update("i.headPlus", params);
		return res;
	}
	
	public UsersVO selectUser(int userid) {
		UsersVO vo = sqlSession.selectOne("i.userselect", userid);
		return vo;
	}
	
	public HostVO hostinfo(int hostnum) {
		HostVO vo = sqlSession.selectOne("i.hostinfo", hostnum);
		return vo;
	}
}