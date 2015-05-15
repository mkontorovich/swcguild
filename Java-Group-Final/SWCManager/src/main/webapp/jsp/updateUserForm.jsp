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
        <link  href="../css/table.css" rel="stylesheet" media="screen">

        <title>Update User</title>
    </head>
    <body>
        <!-- Navbar -->
        <div class="navbar navbar-default  navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <h2>Update User Info</h2>
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                    </ul>
                </div>
            </div>
        </div>

        <!-- Header -->
        <div class="col-sm-10 col-sm-offset-1" style="margin-top: 50px">
            <h2>Information for ${user.firstName} ${user.lastName} </h2 >
        </div>

        <c:if test="${popupEditUser == 'true'}">
            <script>window.onload = function() {
                    $("#editUserModal").modal('show');
                }</script>
            </c:if>
        <!-- for the user form -->
        <div class="col-sm-10 col-sm-offset-1">
            <sf:form method="POST" action="updateUser" commandName="user">
                <div class="modal-body container-fluid ">
                    <div class="col-sm-6 no-margin">
                        <sf:hidden path="userId"/>
                        <sf:label path="firstName">First Name:&nbsp;</sf:label><sf:input type="text" path="firstName" id="firstName" /><br/> 
                        <sf:label path="lastName">Last Name:&nbsp;</sf:label><sf:input type="text" path="lastName" id="lastName"/><br/>
                        <sf:label path="email">Email: &nbsp;</sf:label><sf:input type="text" path="email" id="email"/><br/>
                        <sf:label path="userName">User Name:&nbsp;</sf:label><sf:input type="text" path="userName" id="userName"/><br/>
                        <sf:label path="userPassword">Password:&nbsp;</sf:label><sf:input type="text" path="userPassword" id="userPassword"/><br/>
                            <br/>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="ROLE_COHORTS_ADMIN" ${ROLE_COHORTS_ADMIN}>
                                    Cohorts Admin        
                                </label> </br>
                                <label>
                                    <input type="checkbox" name="auth" value="ROLE_EMPLOYERS_ADMIN"${ROLE_EMPLOYERS_ADMIN}>
                                    Employers Admin       
                                </label></br>
                                <label>
                                    <input type="checkbox" name="auth" value="ROLE_STUDENTS_ADMIN" ${ROLE_STUDENTS_ADMIN}>
                                    Students Admin        
                                </label><br/>
                                <label>
                                    <input type="checkbox" name="auth" value="ROLE_USERS_ADMIN" ${ROLE_USERS_ADMIN}>
                                    Users Admin       
                                </label><br/>
                                <label>
                                    <input type="checkbox" name="auth" value="ROLE_VIEW" ${ROLE_VIEW}>
                                    View Only       
                                </label><br/>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-danger " type="submit">
                        Update User 
                    </button>
            </sf:form>
        </div>

        <script src="../js/jquery.js"></script>
        <script src="../js/bootstrap.js"></script>
    </body>
</html>

