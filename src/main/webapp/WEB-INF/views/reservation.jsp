<%@ page import="org.example.aquareserve.model.dto.MemberDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  MemberDTO member = (MemberDTO) session.getAttribute("member");
  boolean isLoggedIn = (member != null);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>예약하기</title>
</head>
<body>
<h1>예약 페이지</h1>

<form id="reservationForm" method="post" action="/reservate">
  <% if (isLoggedIn) { %>
  <input type="hidden" id="reservationPlace" name="reservationPlace" value="${placeName}" >
  <input type="hidden" id="memberID" name="memberID" value="<%= member.memberId() %> " >

  <label for="timeslotID">시간 슬롯:</label>
  <select id="timeslotID" name="timeslotID" required>
    <option value="1">09:00 - 10:00</option>
    <option value="2">10:00 - 11:00</option>
    <option value="3">11:00 - 12:00</option>
    <option value="4">12:00 - 13:00</option>
    <option value="5">13:00 - 14:00</option>
    <option value="6">14:00 - 15:00</option>
    <option value="7">15:00 - 16:00</option>
    <option value="8">16:00 - 17:00</option>
    <option value="9">17:00 - 18:00</option>
    <option value="10">18:00 - 19:00</option>
    <option value="11">19:00 - 20:00</option>
    <option value="12">20:00 - 21:00</option>
    <option value="13">21:00 - 22:00</option>
  </select>
  <br>

  <label for="equipmentID">장비 대여:</label>
  <select id="equipmentID" name="equipmentID">
    <option value="">없음</option>
    <option value="1">스노클링 장비</option>
    <option value="2">수모</option>
    <option value="3">숏핀</option>
    <option value="4">롱핀</option>
    <option value="5">프리다이빙 핀</option>
  </select>
  <br>

  <label for="lessonID">강습 신청:</label>
  <select id="lessonID" name="lessonID">
    <option value="">없음</option>
    <option value="1">기초반</option>
    <option value="2">중급반</option>
    <option value="3">상급반</option>
    <option value="4">연수반</option>
  </select>
  <br>

  <label for="reservationDate">예약 날짜:</label>
  <input type="date" id="reservationDate" name="reservationDate" required>
  <br>

  <label for="paymentAmount">결제 금액:</label>
  <input type="number" id="paymentAmount" name="paymentAmount" >
  <br>

  <label for="paymentStatus">결제 상태:</label>
  <select id="paymentStatus" name="paymentStatus" required>
    <option value="PENDING">대기</option>
    <option value="PAID">결제 완료</option>
  </select>
  <br>

  <button type="submit">예약하기</button>
  <% } else { %>
  <h1>로그인이 필요합니다.</h1>
  <p>수중 스포츠 예약 시스템을 이용하려면 로그인하세요.</p>
  <div class="btn-group">
    <a href="login" class="btn btn-primary">로그인</a>
    <a href="join" class="btn btn-success">회원가입</a>
  </div>
  <% } %>
</form>

<script>
  document.getElementById("reservationForm").addEventListener("submit", function(event) {
    event.preventDefault();

    let formData = {
      reservationPlace: document.getElementById("reservationPlace").value,
      memberID: document.getElementById("memberID").value,
      timeslotID: document.getElementById("timeslotID").value,
      equipmentID: document.getElementById("equipmentID").value || "",
      lessonID: document.getElementById("lessonID").value || "",
      reservationDate: document.getElementById("reservationDate").value,
      paymentAmount: document.getElementById("paymentAmount").value || "",
      paymentStatus: document.getElementById("paymentStatus").value || ""
    };

    fetch("/reservate", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(formData)
    })
            .then(response => {
              if (response.redirected) {
                window.location.href = response.url;
              }
            })
            .catch(error => {
              console.error("예약 오류:", error);
              alert("서버에 문제가 발생했습니다.");
            });

  });
</script>
</body>
</html>
