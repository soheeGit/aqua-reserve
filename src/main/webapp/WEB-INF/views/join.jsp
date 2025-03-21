<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
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
            max-width: 400px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #007bff;
        }
        .certification-options {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .certification-option {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>회원가입</h1>

    <p class="text-center text-muted">
        <%= request.getAttribute("members") != null ? request.getAttribute("members") : "" %>
    </p>

    <form id="registerForm" method="post" action="member">
        <input type="hidden" name="memberId" value="">

        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input name="id" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">이름</label>
            <input name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">이메일</label>
            <input name="email" type="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input name="password" type="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">핸드폰</label>
            <input name="phoneNumber" type="number" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">주소</label>
            <input name="address" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">생년월일</label>
            <input name="birthday" type="date" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">자격증 (선택 사항)</label>
            <div class="certification-options">
                <div class="certification-option">
                    <input type="checkbox" id="cert1" name="certifications" value="스쿠버 다이빙">
                    <label for="cert1">스쿠버 다이빙</label>
                </div>
                <div class="certification-option">
                    <input type="checkbox" id="cert2" name="certifications" value="응급처치">
                    <label for="cert2">응급처치</label>
                </div>
                <div class="certification-option">
                    <input type="checkbox" id="cert3" name="certifications" value="프리다이빙">
                    <label for="cert3">프리다이빙</label>
                </div>
                <div class="certification-option">
                    <input type="checkbox" id="cert4" name="certifications" value="라이프가드">
                    <label for="cert4">라이프가드</label>
                </div>
            </div>
        </div>
        <button type="submit" class="btn btn-primary w-100">회원가입</button>
    </form>
</div>

<script>
    document.getElementById("registerForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 기본 제출 방지

        // 체크된 자격증 값들을 배열로 수집
        const checkboxes = document.querySelectorAll('input[name="certifications"]:checked');
        const selectedCertifications = Array.from(checkboxes).map(checkbox => checkbox.value);

        // 폼 데이터를 객체로 수집
        const formData = new FormData(this);
        const formDataObj = {};

        // FormData를 객체로 변환
        for (let [key, value] of formData.entries()) {
            // certifications는 건너뛰기 (별도 처리)
            if (key !== 'certifications') {
                formDataObj[key] = value;
            }
        }

        // certifications 배열 추가 (이중 인코딩 방지)
        formDataObj.certifications = selectedCertifications;

        // 디버깅 출력
        console.log("전송할 데이터:", formDataObj);

        // JSON 문자열로 변환
        const jsonData = JSON.stringify(formDataObj);
        console.log("JSON 데이터:", jsonData);

        // 서버로 JSON 데이터 전송
        fetch(this.action, {
            method: this.method,
            headers: {
                "Content-Type": "application/json"
            },
            body: jsonData
        })
            .then(response => {
                if (response.ok) {
                    alert("회원가입이 완료되었습니다.");
                    window.location.href = "/";
                } else {
                    response.text().then(text => {
                        console.error("서버 응답 오류:", text);
                        alert("회원가입 중 오류가 발생했습니다.");
                    });
                }
            })
            .catch(error => {
                console.error("요청 오류:", error);
                alert("회원가입 요청 중 오류가 발생했습니다.");
            });
    });
</script>

</body>
</html>