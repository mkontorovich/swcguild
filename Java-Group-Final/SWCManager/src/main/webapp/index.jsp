<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

        <title>Home Page</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <script language="javascript">
            function MouseRollover1(managestudents_red) {
                managestudents_red.src = "pics/managestudents_red.png";
            }
            function MouseOut1(managestudents_black) {
                managestudents_black.src = "pics/managestudents_black.png";
            }
            function MouseRollover2(cohorts_red) {
                cohorts_red.src = "pics/cohorts_red.png";
            }
            function MouseOut2(cohorts_black) {
                cohorts_black.src = "pics/cohorts_black.png";
            }
            function MouseRollover3(hiringpartners_red) {
                hiringpartners_red.src = "pics/hiringpartners_red.png";
            }
            function MouseOut3(hiringpartners_black) {
                hiringpartners_black.src = "pics/hiringpartners_black.png";
            }
            function MouseRollover4(todo_red) {
                todo_red.src = "pics/todo_red.png";
            }
            function MouseOut4(todo_black) {
                todo_black.src = "pics/todo_black.png";
            }
        </script>
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
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="spring/studentList">Manage Students</a></li>
                        <li><a href="spring/cohortList">Cohorts</a></li>
                        <li><a href="spring/employerList">Employers</a></li>
                            <sec:authorize access="hasRole('ROLE_USERS_ADMIN')">
                            <li><a href="spring/userList">Manage Accounts</a></li>
                            </sec:authorize>
                        <li><a href="<c:url value='/j_spring_security_logout'/>">Logout</a></li>
                    </ul>

                </div>
            </div>
        </div>

        <div>
            <div class="container-fluid" style="padding-top: 150px; padding-right: 350px">

                <div class="row col-xs-offset-5 col-xs-3">
                    <a href="spring/studentList" class="icons">
                        <img src="pics/managestudents_black.png" class="img-responsive floatleft" border="0px" 
                             data-toggle="tooltip" title="Manage Students" onMouseOver="MouseRollover1(this)" onMouseOut="MouseOut1(this)" />                   
                    </a>
                </div>
                <div class="row col-xs-offset-3">
                    <a href="spring/cohortList" class="icons">
                        <img src="pics/cohorts_black.png" class="img-responsive floatleft" border="0px" 
                             data-toggle="tooltip" title="Cohorts" onMouseOver="MouseRollover2(this)" onMouseOut="MouseOut2(this)" />           
                    </a>
                </div>
                <div class="row col-xs-offset-5 col-xs-3" style="padding-top: 30px">
                    <a href="spring/employerList" class="icons">
                        <img src="pics/hiringpartners_black.png" class="img-responsive floatleft" border="0px" 
                             data-toggle="tooltip" title="Employers" onMouseOver="MouseRollover3(this)" onMouseOut="MouseOut3(this)" />                   
                    </a>
                </div>

                <sec:authorize access="hasRole('ROLE_USERS_ADMIN')">
                    <div class="row col-xs-offset-3" style="padding-top: 30px">
                        <a href="spring/userList" class="icons">
                            <img src="pics/todo_black.png" class="img-responsive floatleft" border="0px" 
                                 data-toggle="tooltip" title="Manage Accounts" onMouseOver="MouseRollover4(this)" onMouseOut="MouseOut4(this)" />           
                        </a>
                    </div>
                </sec:authorize>
            </div>
        </div>
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
                        <li><a href="http://swcguild.com/">SWC Guild</a></li>
                        <li><a href="#">Contact Us</a></li>

                    </ul>

                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
