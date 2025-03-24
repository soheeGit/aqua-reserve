<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>스포츠 추가</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        .container { max-width: 400px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        label { display: block; margin: 10px 0 5px; }
        input, textarea { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 4px; }
        button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #218838; }
    </style>
</head>
<body>
<div class="container">
    <h2>스포츠 추가</h2>
    <form action="/admin/sport" method="post">
        <label for="name">스포츠 이름:</label>
        <input type="text" id="name" name="name" required>

        <label for="description">설명:</label>
        <textarea id="description" name="description" rows="3" required></textarea>

        <button type="submit">추가</button>
    </form>
</div>
</body>
</html>
