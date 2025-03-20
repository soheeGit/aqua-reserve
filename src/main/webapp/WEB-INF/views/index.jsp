<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
  String userName = (String) session.getAttribute("userName");
  boolean isLoggedIn = (userName != null);
%>
<html>
<head>
  <title>메인 페이지</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .container {
      max-width: 600px;
      padding: 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    h1 {
      color: #007bff;
    }
    .btn-group {
      margin-top: 15px;
    }
  </style>
</head>
<body>

<div class="container">
  <% if (isLoggedIn) { %>
  <h1>환영합니다, <%= userName %> 님!</h1>
  <p>수중 스포츠 종합 예약 시스템에 오신 것을 환영합니다.</p>
  <div class="btn-group">
    <a href="reservations" class="btn btn-primary">예약 확인</a>
    <a href="logout" class="btn btn-danger">로그아웃</a>
  </div>
  <% } else { %>
  <h1>로그인이 필요합니다.</h1>
  <p>수중 스포츠 예약 시스템을 이용하려면 로그인하세요.</p>
  <div class="btn-group">
    <a href="login" class="btn btn-primary">로그인</a>
    <a href="join" class="btn btn-success">회원가입</a>
  </div>
  <% } %>
</div>

</body>
</html>
