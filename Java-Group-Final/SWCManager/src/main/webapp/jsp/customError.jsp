<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap -->
        <link href="/SWCManager/css/bootstrap.min.css" rel="stylesheet" media="screen">

        <title>Error Page</title>
    </head>
    <body>
        <div class="container">
            <h1>An error has occurred...</h1>

            <h3>${errorMessage}</h3>
            <a href="/SWCManager/index.jsp" class="btn-primary btn">Home</a><br/>
        </div>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../js/jquery-1.11.0.min.js"></script>
        <script src="../js/bootstrap.js"></script>             
    </body>
</html>