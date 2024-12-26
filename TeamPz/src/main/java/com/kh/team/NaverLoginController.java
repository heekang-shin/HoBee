package com.kh.team;

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vo.UsersVO;

@Controller
public class NaverLoginController {

    private static final String CLIENT_ID = "YlG3LTTSOlB1kXw9LGiO";
    private static final String CLIENT_SECRET = "6p62QCB4_U"; // 네이버 클라이언트 시크릿 값 입력
    private static final String CALLBACK_URL = "http://192.168.0.24:9090/team/callback";

    // 네이버 로그인 요청
    @RequestMapping("/naver_login.do")
    public void naverLogin(HttpServletResponse response, HttpSession session) throws Exception {
        // 상태 토큰 생성 및 세션 저장
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();
        session.setAttribute("state", state);

        // 네이버 로그인 요청 URL 생성
        String redirectURI = URLEncoder.encode(CALLBACK_URL, "UTF-8");
        String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                        + "&client_id=" + CLIENT_ID
                        + "&redirect_uri=" + redirectURI
                        + "&state=" + state;

        // 네이버 로그인 페이지로 리다이렉트
        response.sendRedirect(apiURL);
    }

    // 콜백 처리
    @RequestMapping("/callback")
    public String callback(@RequestParam("code") String code,
                           @RequestParam("state") String state,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            // 상태 토큰 검증
            String sessionState = (String) session.getAttribute("state");
            if (!state.equals(sessionState)) {
                throw new RuntimeException("State 값이 일치하지 않습니다.");
            }

            // Access Token 요청
            String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                    + "&client_id=" + CLIENT_ID
                    + "&client_secret=" + CLIENT_SECRET
                    + "&code=" + code
                    + "&state=" + state;

            String response = getAPIResponse(tokenUrl);
            String accessToken = extractAccessToken(response);

            // 사용자 정보 요청
            String userInfoResponse = getAPIResponseWithToken(accessToken, "https://openapi.naver.com/v1/nid/me");
            JSONObject userInfo = new JSONObject(userInfoResponse).getJSONObject("response");

            // UsersVO 객체에 네이버 사용자 정보 매핑
            UsersVO user = new UsersVO();
            user.setSocial_Type("NAVER");
            user.setSocial_Id(userInfo.getString("id"));
            user.setUser_name(userInfo.optString("name", "네이버 사용자"));
            user.setUser_email(userInfo.optString("email", ""));
            user.setPhone(userInfo.optString("mobile", ""));

            // 세션에 사용자 정보 저장
            session.setAttribute("loggedInUser", user);

            return "redirect:/main.do"; // 메인 페이지로 이동
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/errorPage.do";
        }
    }

    // API 응답 처리 메서드
    private String getAPIResponse(String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        return response.toString();
    }

    // Access Token 추출
    private String extractAccessToken(String response) {
        String[] tokens = response.split(",");
        for (String token : tokens) {
            if (token.contains("\"access_token\"")) {
                return token.split(":")[1].replaceAll("\"", "").trim();
            }
        }
        return null;
    }

    // API 요청 시 Access Token 사용
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
