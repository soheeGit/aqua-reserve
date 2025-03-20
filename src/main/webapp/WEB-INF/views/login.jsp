<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-container {
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 300px;
      text-align: center;
    }

    h2 {
      font-size: 24px;
      margin-bottom: 20px;
    }

    .input-group {
      margin-bottom: 15px;
      text-align: left;
    }

    .input-group label {
      display: block;
      margin-bottom: 5px;
      font-size: 14px;
      color: #333;
    }

    .input-group input {
      width: 100%;
      padding: 10px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    .button-group {
      margin-top: 20px;
    }

    button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
    }

    button:hover {
      background-color: #45a049;
    }

    .signup-link {
      margin-top: 10px;
      font-size: 14px;
    }

    .signup-link a {
      color: #4CAF50;
      text-decoration: none;
    }

    .signup-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="login-container">
  <h2>로그인</h2>
  <form id="loginForm" method="POST" action="<%= request.getContextPath() %>/login">
    <div class="input-group">
      <label for="name">아이디</label>
      <input type="text" id="name" name="name" placeholder="아이디를 입력하세요" required>
    </div>
    <div class="input-group">
      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
    </div>
    <div class="button-group">
      <button type="submit">로그인</button>
    </div>
    <p class="signup-link">아직 계정이 없으신가요? <a href="<%= request.getContextPath() %>/join">회원가입</a></p>
  </form>
</div>

<script>
  document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const name = document.getElementById('name').value;
    const password = document.getElementById('password').value;

    // 로그인 요청을 서버에 전송 (예: Ajax 사용)
    fetch('<%= request.getContextPath() %>/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        name: name,
        password: password
      })
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                window.location.href = '<%= request.getContextPath() %>'; // 로그인 성공 후 대시보드로 이동
              } else {
                alert('아이디 또는 비밀번호가 틀렸습니다.');
              }
            })
            .catch(error => {
              console.error('로그인 실패:', error);
              alert('서버에 문제가 발생했습니다. 나중에 다시 시도해주세요.');
            });
  });
</script>
</body>
</html>
