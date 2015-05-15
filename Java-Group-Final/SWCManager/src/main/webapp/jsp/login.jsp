<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="../assets/ico/favicon.ico">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SWC Login</title>

        <!-- Bootstrap core CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
    </head>
    <body>
        <div class="navbar navbar-default  navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
            </div>
        </div>

        <div class="container-fluid" style="padding-top: 175px;" align="center">
            <span class="manageswap"><img src="../pics/swclogo200x202.png" class="img-responsive" alt="SWC Guild" /></span>
        </div>
        <div class="container-fluid" style="padding-top: 55px">
            <form method="post" class="signin form-horizontal" role="form" action="../j_spring_security_check">
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-4">
                        <input type="text" class="form-control" id="username" name="j_username" placeholder="User name">
                        <input type="password" class="form-control" id="password" name="j_password" placeholder="Password">
                    </div>
                </div>
                <div class="col-sm-offset-5 col-sm-3">
                    <button name="commit" type="submit" class="btn btn-default btn-danger col-sm-7">Login</button>
                </div>
            </form>
            <br/>
            <div class="text-center">
                <c:if test="${param.login_error == 1}">
                    <h3>Wrong User name or password!</h3>
                </c:if>
            </div>
            <div>
                <div class="navbar navbar-inverse navbar-fixed-bottom" role="navigation">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="navbar-collapse collapse">
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#">SWC Guild</a></li>
                                <li><a href="#">Contact Us</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bootstrap core JavaScript
            ================================================== -->
            <!-- Placed at the end of the document so the pages load faster -->
            <script src="../js/jquery.js"></script>
            <script src="../js/bootstrap.js"></script>
            
            <script type="text/javascript">
                document.getElementById('username').focus();
            </script>
    </body>
</html>
