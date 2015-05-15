<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta  name="viewport" content="width=device­width, initial­scale=1.0">
        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">

        <title>User List</title>
        <style>
            tr:hover {
                cursor: pointer;
            }
            label {width: 100px;}
        </style>
    </head>
    <body>
        <!-- Navbar -->
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
                        <li><a href="../index.jsp">Home</a></li>
                        <li ><a href="studentList">Manage Students</a></li>
                        <li><a href="cohortList">Cohorts</a></li>
                        <li><a href="employerList">Employers</a></li>
                        <li class="active"><a href="#">Manage Accounts</a></li>
                        <li><a href="<c:url value="../j_spring_security_logout" />">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Header -->
        <div class="col-sm-10 col-sm-offset-1" style="margin-top: 50px">
            <h2>Users</h2>
        </div>

        <div class="col-sm-10 col-sm-offset-1" style="padding-bottom: 25px;">
            <button class="btn btn-danger " data-toggle="modal" data-target="#addUserModal">
                <span class="glyphicon glyphicon-plus"></span> Add User</button>

            <button class="btn btn-danger " data-toggle="modal" data-target="#searchModal">
                Search  
            </button> 
        </div>   

        <c:if test="${popupEditUser == 'true'}">
            <script>window.onload = function() {
                    $("#editUserModal").modal('show');
                }</script>
            </c:if>

        <!-- Modal for add user-->

        <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="POST" action="addUser">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add User</h4>
                        </div>
                        <div class="modal-body container-fluid" >
                            <div class="row-fluid style-form">
                                <div class="col-sm-6 no-margin">
                                    <label for="firstName">First Name:&nbsp;</label><input type="text" name="firstName" id="firstName" /><br/> 
                                    <label for="lastName">Last Name:&nbsp;</label><input type="text" name="lastName" id="street"/><br/>
                                    <label for="userName">User Name:&nbsp;</label><input type="text" name="userName" id="userName"/><br/>
                                    <label for="password">Password:&nbsp;</label><input type="text" name="password" id="password"/><br/>
                                    <label for="email">Email:&nbsp;</label><input type="text" name="email" id="email"/><br/>        
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="auth" value="ROLE_COHORTS_ADMIN">
                                            Cohorts Admin        
                                        </label> </br>
                                        <label>
                                            <input type="checkbox" name="auth" value="ROLE_EMPLOYERS_ADMIN">
                                            Employers Admin       
                                        </label></br>
                                        <label>
                                            <input type="checkbox" name="auth" value="ROLE_STUDENTS_ADMIN">
                                            Students Admin        
                                        </label><br/>
                                        <label>
                                            <input type="checkbox" name="auth" value="ROLE_USERS_ADMIN">
                                            Users Admin       
                                        </label><br/>
                                        <label>
                                            <input type="checkbox" name="auth" value="ROLE_VIEW">
                                            View Only       
                                        </label><br/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add User" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- create and populate table -->
        <div class="container col-sm-10 col-sm-offset-1">
            <table id="names-table" class="table table-striped ">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                        <th>User Name&#160&#160&#160&#160&#160</th>
                        <th>Password&#160&#160&#160&#160&#160</th>
                        <th>Edit</th>
                    </tr>
                </thead>

                <c:forEach var="user" items="${users}">
                    <tr class="clickableRow" data-toggle="modal" data-target="#modal_${user.userId}">
                        <td>${user.firstName} ${user.lastName}</td>
                        <td>${user.userName}</td>
                        <td>${user.email} </td>
                        <td>${user.userPassword}</td>

                        <td class="edit-column" ><a style="color:#333;" href="displayEditUser?userId=${user.userId}">&#160<span class="glyphicon glyphicon-pencil">&#160</span></a>
                            <a href="removeUser?userId=${user.userId}" style="color:#333;"><span class="glyphicon glyphicon-remove"></span></a></td>
                    </tr>

                    <!-- Modal for view user -->
                    <div class="modal fade" id="modal_${user.userId}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="POST" action="addUser">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h2 class="modal-title">Information for ${user.firstName} ${user.lastName} </h2>
                                    </div>
                                    <div class="modal-body container-fluid  ">
                                        <div class="col-sm-6 no-margin">
                                            First name: ${user.firstName}<br/> 
                                            Last name: ${user.lastName}<br/>
                                            User Name ${user.userName}<br/>
                                            Email: ${user.email}<br/>
                                            Password: ${user.userPassword}<br/><br/>
                                            <c:forEach var="auth" items="${user.authorities}">
                                                ${auth}<br/>
                                            </c:forEach>
                                            </div>
                                    </div>
                                            <div class="modal-footer">
                                                <input type="submit" value="Add User" class="btn btn-danger"/>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </table>
            </div>
            <!-- footer -->
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

            <script src="../js/jquery.js"></script>
            <script src="../js/bootstrap.js"></script>
            <script src="../js/jquery.tablesorter.min.js"></script>
            <script>
                    $(document).ready(function() {
                        $(function() {
                            var name;
                            $("#names-table").tablesorter();
                        });
                    });</script>
            <script>
                $(document).ready(function() {
                    $("body").on("click", ".removeclass", function(e) { //user click on remove text
                        $(this).parent('div').remove(); //remove text box
                    });
                });
            </script>
        </body>
    </html>

