<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.bean.Quizizz" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quizizz List</title>
    <link rel="stylesheet" type="text/css" href="/assets/css/reset.css">
    <link rel="stylesheet" href="./assets/css/reset.css">
	<link rel="stylesheet" href="./assets/css/nav.css">
	<link rel="stylesheet" href="./assets/css/modal.css">
	
	<script src="./assets/js/modal.js" defer></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            margin: 0; /* Remove default margin */
        }

        .header {
            background-color: #3498db; /* Update to match the navigation color */
            color: #fff;
            padding: 24px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            font-size: 21px;
            text-align: center; /* Center align the content */
        }

        .header a {
            text-decoration: none;
            color: #fff;
            padding: 10px 20px;
            margin: 0 5px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .header a:hover {
            background-color: #2980b9;
            transform: scale(1.05);
        }

        .header .active {
            background-color: #2ecc71;
            color: white;
        }

        h3 {
            color: #333;
            margin-top: 60px; /* Adjust margin-top to account for fixed header */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        form {
            margin-top: 20px;
        }

        input[type="submit"] {
            background-color: #dc3545;
            color: #fff;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="CRUD_quizizz?mod1=1">Thêm câu hỏi</a>
        <a href="CRUD_quizizz?mod4=1">Tìm kiếm câu hỏi</a>
        <a href="CR_test">Danh sách đề thi</a>
    </div>
	 <% 
        ArrayList<Quizizz> quizizzsArray = (ArrayList<Quizizz>) request.getAttribute("quizizzsArray"); 
        Object user_id = null;
        if (request.getAttribute("user_id") != null) {
            user_id = request.getAttribute("user_id");
        }        
        // Kiểm tra xem user_id có tồn tại không
        if (user_id != null) {
            // Lấy hoặc tạo một phiên
            HttpSession ss = request.getSession();
            
            // Đặt giá trị user_id vào phiên
            ss.setAttribute("user_id", user_id);
            
            // In ra thông báo hoặc thực hiện các hành động khác nếu cần thiết
            getServletContext().log("Đã đặt user_id vào phiên");
        } 
    %>
    <h3>1. Danh sách câu hỏi</h3>
    <form action="CRUD_quizizz?mod3=1" method="post">
        <table border="1">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Question</th>
                    <th>Answer</th>
                    <% if (user_id != null && user_id.equals(1)) { %>
                        <th>Update</th>
                    	<th>Select</th>
                    <% } %>

                </tr>
            </thead>
            <tbody>
                <% int index = 1; for (Quizizz quizizz : quizizzsArray) { %> 
                    <tr>
                        <td> <%= index++ %></td>
                        <td><a href="CRUD_quizizz?quizizz_id=<%= quizizz.getQuizizzId() %>"> <%= quizizz.getQuestion() %></a></td>
                        <td> <%= quizizz.getAnswer() %>></td>
                        <% if (user_id != null && user_id.equals(1)) { %>
                            <td><a href="CRUD_quizizz?mod2=1&&quizizz_id=<%= quizizz.getQuizizzId() %>">...</a></td>
                        	<td><input type="checkbox" name="quizizzId[]" value="<%= quizizz.getQuizizzId() %>"></td>
                        <% } %>
                    </tr>
                 <% } %> 
            </tbody>
        </table>
        <% if (user_id != null && user_id.equals(1)) { %>
        <input type="submit" value="Delete"/>
        <% } %>
    </form>
	<!-- Modal -->
	<div id="searchModal" class="modal">
	  <div class="modal-content">
	    <span class="close" onclick="closeModal()">&times;</span>
	    <form name="form1" action="CRUD_quizizz?mod4=1" id="searchForm" method="post" onsubmit="submitSearch()">
	      <label for="searchInput">Nhập câu hỏi cần tìm:</label>
	      <input type="text" id="infor" name="infor" required>
	      <input type="submit" value="Find">
	    </form>
	  </div>
	</div>
</body>
</html>