<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.aquareserve.model.dto.MemberDTO" %>
<%
  MemberDTO member = (MemberDTO) session.getAttribute("member");
  boolean isLoggedIn = (member != null);
  if (member == null || !member.id().equals("admin")) {
    response.sendRedirect("index.jsp"); // 관리자가 아니면 홈으로 리디렉트
    return;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 대시보드</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; }
    .container { max-width: 600px; margin: auto; padding: 20px; }
    a { display: block; margin: 10px 0; padding: 10px; background: #007BFF; color: white; text-decoration: none; }
    a:hover { background: #0056b3; }
  </style>
</head>
<body>
<div class="container">
  <h2>관리자 페이지</h2>
  <a href="addSport">스포츠 추가</a>
  <a href="addEquipment">스포츠 용품 추가</a>
  <a href="addLesson">레슨 추가</a>
  <a href="logout">로그아웃</a>
</div>
</body>
</html>
