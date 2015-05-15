<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link  href="../css/table.css" rel="stylesheet" media="screen">

        <title>Cohort List</title>
    </head>

    <body
        <!-- script to popup modal should it be filled erroneously-->
        <c:if test="${addCohortPopup == 'true'}">
        <script>window.onload=function(){
            $("#addCohort").modal('show');
        }</script>
        </c:if>
            
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
                        <li class="active"><a href="#">Cohorts</a></li>
                        <li><a href="employerList">Employers</a></li>
                            <sec:authorize access="hasRole('ROLE_USERS_ADMIN')">
                            <li><a href="userList">Manage Accounts</a></li>
                            </sec:authorize>
                        <li><a href="<c:url value="../j_spring_security_logout" />">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Header -->
        <div class="col-sm-10 col-sm-offset-1" style="margin-top: 50px">
            <h2>Cohorts</h2>
        </div>

        <div class="col-sm-10 col-sm-offset-1" style="padding-bottom: 25px;">
            <sec:authorize access="hasRole('ROLE_COHORTS_ADMIN')">
                <button class="btn btn-danger " data-toggle="modal" data-target="#addCohort">
                    <span class="glyphicon glyphicon-plus"></span> Add Cohort</button>
                </sec:authorize>
            <button class="btn btn-danger " data-toggle="modal" data-target="#searchModal">
                Search  
            </button> 
        </div>

        <!-- Modal for add cohort-->
        <div class="modal fade" id="addCohort" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="POST" action="addCohort">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Add an Order</h4>
                        </div>
                        <div class="modal-body" >

                            <div class="form-group">
                                <label for="atrack">Track:</label>
                                <select id="atrack" name="track" >
                                    <option value="Java">Java</option>
                                    <option value=".Net">.Net</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="startDate">Start Date:</label>
                                <input type="date" id="startDate" name="startDate" placeholder="yyyy-mm-dd"/>&nbsp${validDate}
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Cohort" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="container col-sm-10 col-sm-offset-1">
            <table id="names-table" class="table table-striped ">
                <thead>
                    <tr>
                        <th>Track</th>
                        <th>Start Date</th>
                            <sec:authorize access="hasRole('ROLE_COHORTS_ADMIN')">
                            <th>Edit&#160&#160&#160&#160&#160&#160</th>
                            </sec:authorize>
                    </tr>
                </thead>

                <c:forEach var="cohort" items="${cohortList}">

                    <tr class="clickableRow" data-toggle="modal" data-target="#modal_${cohort.cohortId}">
                        <td>${cohort.track}</td>    
                        <td>${cohort.startDate}</td>
                        <sec:authorize access="hasRole('ROLE_COHORTS_ADMIN')">
                            <td class="edit-column" ><a href="editCohortForm?cohortId=${cohort.cohortId}">&#160<span class="glyphicon glyphicon-pencil">&#160</span></a>
                                <a href="deleteCohort?cohortId=${cohort.cohortId}"><span class="glyphicon glyphicon-remove"></a></td>
                            </sec:authorize>
                    </tr>

                    <!-- Modal for view cohort -->
                    <div class="modal fade" id="modal_${cohort.cohortId}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">View Cohort</h4>
                                </div>
                                <div class="modal-body">
                                    Cohort Date: ${cohort.startDate}<br/> 
                                    Track: ${cohort.track}<br/> 
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div><!-- /.modal -->
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
