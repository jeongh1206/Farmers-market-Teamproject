<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            text-align: center;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #333;
        }

        p {
            color: #666;
        }

        .confirmation-icon {
            font-size: 100px;
            color: #28a745; /* 성공 아이콘 색상 */
            margin-bottom: 20px;
        }

        .button-container {
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #28a745; /* 버튼 배경색 */
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #218838; /* 마우스 호버 시 배경색 변경 */
        }
    </style>
</head>
<body>
    <div class="container">
        <i class="fas fa-check-circle confirmation-icon"></i>
        <h1>주문이 성공적으로 완료되었습니다!</h1>
        <p>주문 번호: ${order_no }</p>
        <p>주문 내역을 확인하려면 아래 버튼을 클릭하세요.</p>
        <div class="button-container">
            <a href="orderList" class="btn">주문 내역 확인</a>
        </div>
    </div>
</body>
</html>