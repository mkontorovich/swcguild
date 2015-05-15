<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link  href="../css/table.css" rel="stylesheet" media="screen">

        <title>Cohort List</title>
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
                        <li><a href="studentList">Manage Students</a></li>
                        <li class="active"><a href="#">Cohort</a></li>
                        <li><a href="employerList">Employers</a></li>
                        <li><a href="#">Manage Accounts</a></li>
                        <li><a href="#">Logout</a></li>
                    </ul>

                </div>
            </div>
        </div>
        <!-- Header -->
        <div class="col-sm-10 col-sm-offset-1" style="margin-top: 50px">
            <h2>Edit Cohort</h2>
        </div>
        <div class="container">
            <sf:form method="POST" commandName="cohort" action="editCohort">
                <sf:label path="track">Track:&nbsp;</sf:label>
                <sf:select path="track">
                    <sf:options items="${trackList}"/>
                </sf:select>
                <br/>
                <sf:label name="startDate" path="startDate">Start Date:&nbsp;</sf:label>
                <sf:input path="startDate" type="date" />&nbsp${validDate}
                <sf:errors path="startDate" cssclass="error"></sf:errors><br/>
                <br/><br/>
                <sf:hidden path="cohortId"/>
                <button type="submit" class="btn btn-danger">Save Changes</button>
                <a href="cohortList" class="btn btn-default" >Discard</a>
            </sf:form>
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
                        <li><a href="#">SWC Guild</a></li>
                        <li><a href="#">Contact Us</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../js/jquery.js" ></script>
        <!-- Include all compiled plugins, or include individual files as needed -->
        <script src="../js/bootstrap.js" ></script>
        <script src="../js/jquery.tablesorter.min.js" ></script>
        <script>
            $(document).ready(function() {
                $(function() {
                    var name;
                    $("#names-table").tablesorter();
                });
            });

        </script>

    </body>
</html>
