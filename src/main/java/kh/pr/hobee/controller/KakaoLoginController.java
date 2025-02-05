package kh.pr.hobee.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kh.pr.hobee.vo.UsersVO;

@Controller
public class KakaoLoginController {

    private static final Logger logger = LoggerFactory.getLogger(KakaoLoginController.class);

    private static final String CLIENT_ID = "2c355d1f1a5a45a18ddab64bba16fb9b";
    private static final String CLIENT_SECRET = "zzomntrqzZThmbD9pHnbawZLDUCGgVXE";
    private static final String REDIRECT_URI = "http://192.168.0.24:9090/hobee/oauth/kakao/callback";
    private static final String TOKEN_URL = "https://kauth.kakao.com/oauth/token";
    private static final String USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";

    @RequestMapping("/kakao/kakao_login.do")
    public String kakaoLogin(HttpServletResponse response, HttpSession session) throws Exception {
        logger.info("카카오 로그인 요청 시작");

        // 상태 토큰 생성
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString(32);
        session.setAttribute("state", state);
        logger.info("생성된 State 토큰: {}", state);

        // 카카오 로그인 URL 생성
        String redirectURI = URLEncoder.encode(REDIRECT_URI, "UTF-8");
        String apiURL = "https://kauth.kakao.com/oauth/authorize?response_type=code" 
                + "&client_id=" + CLIENT_ID
                + "&redirect_uri=" + redirectURI 
                + "&state=" + state;

        logger.info("카카오 로그인 URL: {}", apiURL);

        // 리다이렉트
        //response.sendRedirect(apiURL);
        return "redirect:"+apiURL;

    }

    @RequestMapping("/oauth/kakao/callback")
    public String callback(@RequestParam("code") String code, 
                           @RequestParam("state") String state, 
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        logger.info("Callback invoked");
        logger.info("Authorization code: {}", code);
        logger.info("State: {}", state);
        // 기존 로직 유지
        try {
            logger.info("카카오 콜백 호출됨. code: {}, state: {}", code, state);

            // 상태 토큰 검증
            String sessionState = (String) session.getAttribute("state");
            if (!state.equals(sessionState)) {
                logger.error("State 값 불일치. 세션 state: {}, 요청 state: {}", sessionState, state);
                throw new RuntimeException("State 값이 일치하지 않습니다.");
            }

            // Access Token 요청
            String tokenUrl = TOKEN_URL + "?grant_type=authorization_code" 
                    + "&client_id=" + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8") 
                    + "&code=" + code 
                    + "&client_secret=" + CLIENT_SECRET;
            logger.info("Access Token 요청 URL: {}", tokenUrl);

            String response = getAPIResponse(tokenUrl);
            logger.info("Access Token 응답: {}", response);

            String accessToken = extractAccessToken(response);
            logger.info("추출된 Access Token: {}", accessToken);

            // 사용자 정보 요청
            String userInfoResponse = getAPIResponseWithToken(accessToken, USER_INFO_URL);
            logger.info("사용자 정보 응답: {}", userInfoResponse);

            JSONObject userInfo = new JSONObject(userInfoResponse);

            // UsersVO 객체에 사용자 정보 매핑
            UsersVO user = new UsersVO();
            user.setSocial_Type("KAKAO");
            user.setSocial_Id(userInfo.optString("id"));
            user.setUser_name(userInfo.getJSONObject("kakao_account").getJSONObject("profile").optString("nickname", "카카오 사용자"));
            user.setUser_email(userInfo.getJSONObject("kakao_account").optString("email", ""));
            user.setLv("일반"); // 🔹 lv 값을 "일반"으로 설정
            // 세션에 사용자 정보 저장
            session.setAttribute("loggedInUser", user);
            logger.info("사용자 정보 저장 완료. 사용자 이름: {}", user.getUser_name());

            return "redirect:/main.do"; // 메인 페이지로 이동
        } catch (Exception e) {
            logger.error("콜백 처리 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/errorPage.do";
        }
    }

    private String getAPIResponse(String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();

        return response.toString();
    }

    private String extractAccessToken(String response) throws Exception {
        JSONObject json = new JSONObject(response);
        return json.getString("access_token");
    }

    private String getAPIResponseWithToken(String accessToken, String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();

        return response.toString();
    }
}