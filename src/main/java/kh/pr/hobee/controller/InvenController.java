package kh.pr.hobee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pr.hobee.dao.InvenDAO;
import kh.pr.hobee.dao.ReviewDAO;
import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.HostVO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.ReviewVO;
import kh.pr.hobee.vo.WishlistVO;

@Controller
public class InvenController {

	InvenDAO inven_dao;

	public void setInven_dao(InvenDAO inven_dao) {
		this.inven_dao = inven_dao;
	}
	ReviewDAO review_dao;

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}
	
	@RequestMapping("/select_list.do")
	public String selectlist(Model model, int category, String arr) {
		
		// 모임 목록의 정렬 방식의 초기값을 최신순으로 설정
		String sel = "new";

		// 전달 받은 모임 목록 정렬 방식이 null이 아닐경우
		if (arr != null) {
			sel = arr;
		}

		List<CategoryVO> cate_list = inven_dao.selectInven(category); // 카테고리 하위의 세부 카테고리 받아오기
		List<HobeeVO> hobee_list = null;// 모임을 받아오고 전달하기 위한 list 생성
		
		// 정렬 방식에 따라 mapper의 쿼리문에 orderby를 다르게 주기 위한 if문
		if ("new".equals(sel)) {
			hobee_list = inven_dao.selectHobee(category);
		} else if ("best".equals(sel)) {
			hobee_list = inven_dao.selectHobee_best(category);
		}
		
		model.addAttribute("cate_list", cate_list);
		model.addAttribute("hobee_list", hobee_list);
		return "/WEB-INF/views/inventory/inven.jsp";
	}

	// 상세페이지
	@RequestMapping("/hobee_detail.do")

	public String detail(Model model, int hbidx, Integer page) {
		
		System.out.println("inven 컨트롤러[디버그] 전달받은 hbidx: " + hbidx); // 디버깅용 로그
		
		if (page == null || page < 1) {
			page = 1;
		}
		
		int inquiriesPerPage = 3;
		
		
		// 상세 정보 조회
		HobeeVO hobee_vo = inven_dao.hobeeDetail(hbidx);
		model.addAttribute("hobee", hobee_vo);
		model.addAttribute("hbidx", hbidx); // hbidx도 별도로 전달
		
		//호스트 정보
		int hostNum = hobee_vo.getUser_id();
		HostVO host_vo = inven_dao.hostinfo(hostNum);
		model.addAttribute("host",host_vo);
		
		 // 전체 리뷰 목록 조회
	    List<ReviewVO> reviews = review_dao.get_reviewList(hbidx);
	    System.out.println("[디버그] 조회된 전체 리뷰 개수: " + reviews.size());
		
	    // 최신 리뷰 3개 조회
	    List<ReviewVO> recentReviews = review_dao.recentList(hbidx);
	    System.out.println("[디버그] 조회된 최신 리뷰 개수: " + recentReviews.size());
	    
	    // 평균 평점 계산
	    double totalRating = 0;
	    for (ReviewVO r : reviews) {
	        totalRating += r.getRating();
	    }
	    double averageRating = (reviews.size() == 0) ? 0 : totalRating / reviews.size();

	    // 평균 평점 포맷팅 (소수점 한 자리로)
	    String formattedAverageRating = String.format("%.1f", averageRating);

	    System.out.println("[디버그] 평균 평점: " + formattedAverageRating);

	    
	    //문의
		List<InquiryVO> inquiries = inven_dao.getAllInquiries(hbidx);
		int totalInquiries = inquiries.size();
		int totalPages = (int) Math.ceil((double) totalInquiries / inquiriesPerPage);
		
		//페이징
		int start = (page - 1) * inquiriesPerPage;
		int end = Math.min(start + inquiriesPerPage, totalInquiries);

		List<InquiryVO> pagedInquiries = inquiries.subList(start, end);

		model.addAttribute("hobee", hobee_vo);
		model.addAttribute("inquiries", pagedInquiries);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		
	 // 모델에 저장
	    model.addAttribute("reviews", reviews); // 전체 리뷰 전달
	    model.addAttribute("recentReviews", recentReviews); // 최신 리뷰 3개 전달
	    model.addAttribute("formattedAverageRating", formattedAverageRating); // 포맷된 평균 평점 전달
	    model.addAttribute("reviewCount", reviews.size()); // 리뷰 개수 전달

		return "/WEB-INF/views/detail/detail.jsp";
	}
	
	
	@ResponseBody
	@RequestMapping("/addWishlist.do")
	public Map<String, Object> toggleWishlist(@RequestBody WishlistVO vo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			List<WishlistVO> allwish = inven_dao.allwish(vo.getUser_id());
			boolean isAlreadyWished = false;

			for (WishlistVO wishlist : allwish) {
				if (wishlist.getHb_idx() == vo.getHb_idx()) {
					isAlreadyWished = true;
					break;
				}
			}

			if (isAlreadyWished) {
				int deleteCount = inven_dao.deleteWishlist(vo);
				if (deleteCount > 0) {
					result.put("action", "removed");
					result.put("message", "찜목록에서 삭제되었습니다.");
				} else {
					result.put("success", false);
					result.put("message", "찜목록 삭제 중 오류가 발생했습니다.");
				}
			} else {
				int addCount = inven_dao.addWishlist(vo);
				if (addCount > 0) {
					result.put("action", "added");
					result.put("message", "찜목록에 추가되었습니다.");
				} else {
					result.put("success", false);
					result.put("message", "찜목록 추가 중 오류가 발생했습니다.");
				}
			}

			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "찜하기 처리 중 오류가 발생했습니다.");
			e.printStackTrace();
		}
		return result;
	}

    @RequestMapping(value = "/submitInquiry.do", method = RequestMethod.POST)
    public String submitInquiry(InquiryVO inquiryVO, Model model) {
        try {
            int result = inven_dao.saveInquiry(inquiryVO); // DAO 메서드를 호출해 저장
            if (result > 0) {
                model.addAttribute("message", "문의가 성공적으로 등록되었습니다.");
            } else {
                model.addAttribute("message", "문의 등록 중 문제가 발생했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return "redirect:/hobee_detail.do?hbidx=" + inquiryVO.getHb_idx(); // 상세 페이지로 리다이렉트
    }	
    
    @ResponseBody
    @RequestMapping(value = "/checkWishlist.do", method = RequestMethod.POST)
    public Map<String, Object> checkWishlist(@RequestBody WishlistVO vo) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            boolean inWishlist = inven_dao.isInWishlist(vo.getUser_id(), vo.getHb_idx());
            result.put("success", true);
            result.put("inWishlist", inWishlist);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "찜 상태 확인 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return result;
    }
}
