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
import kh.pr.hobee.vo.CategoryVO;
import kh.pr.hobee.vo.HobeeVO;
import kh.pr.hobee.vo.InquiryVO;
import kh.pr.hobee.vo.WishlistVO;

@Controller
public class InvenController {
	
	InvenDAO inven_dao;

	public void setInven_dao(InvenDAO inven_dao) {
		this.inven_dao = inven_dao;
	}
	
	@RequestMapping("/select_list.do")
	public String selectlist(Model model, int category, String arr) {
		String sel = "new"; // 정렬 방식 초기값 설정
		if (arr != null) {
			sel = arr;
		}
		
		List<CategoryVO> cate_list = inven_dao.selectInven(category);
		List<HobeeVO> hobee_list = null;
		
		if ("new".equals(sel)) {
			hobee_list = inven_dao.selectHobee(category);
		} else if ("best".equals(sel)) {
			hobee_list = inven_dao.selectHobee_best(category);
		}
		
		model.addAttribute("cate_list", cate_list);
		model.addAttribute("hobee_list", hobee_list);
		return "/WEB-INF/views/inventory/inven.jsp";
	}
	
	//상세페이지
	@RequestMapping("/hobee_detail.do")
	public String detail(Model model, int hbidx, Integer page) {
		if (page == null || page < 1) {
			page = 1;
		}
		
		int inquiriesPerPage = 3;

		HobeeVO hobee_vo = inven_dao.hobeeDetail(hbidx);
		List<InquiryVO> inquiries = inven_dao.getAllInquiries(hbidx);
		int totalInquiries = inquiries.size();
		int totalPages = (int) Math.ceil((double) totalInquiries / inquiriesPerPage);
		
		int start = (page - 1) * inquiriesPerPage;
		int end = Math.min(start + inquiriesPerPage, totalInquiries);

		List<InquiryVO> pagedInquiries = inquiries.subList(start, end);

		model.addAttribute("hobee", hobee_vo);
		model.addAttribute("inquiries", pagedInquiries);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

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