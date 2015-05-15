<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta  name="viewport" content="width=device­width, initial­scale=1.0">
        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">


        <title>Student List</title>

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
                        <li class="active"><a href="#">Manage Students</a></li>
                        <li><a href="cohortList">Cohorts</a></li>
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
            <h2>Students</h2>
        </div>

        <div class="col-sm-10 col-sm-offset-1" style="padding-bottom: 25px;">
            <sec:authorize access="hasRole('ROLE_STUDENTS_ADMIN')">
                <button class="btn btn-danger " data-toggle="modal" data-target="#addStudentModal">
                    <span class="glyphicon glyphicon-plus"></span> Add Student</button>
            </sec:authorize>
            <button class="btn btn-danger " data-toggle="modal" data-target="#searchModal">
                Search  
            </button> 
        </div>   

        <c:if test="${popupEditStudent == 'true'}">
            <script>window.onload = function() {
                    $("#editStudentModal").modal('show');
                }</script>
            </c:if>

        <!-- Modal for add student-->

        <div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <form method="POST" action="addStudent">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add Student</h4>
                        </div>
                        <div class="modal-body" >
                            <div class="row-fluid style-form">
                                <div class="col-sm-6 no-margin">
                                    <label for="firstName">First Name:&nbsp;</label><input type="text" name="firstName" id="firstName" /><br/> 
                                    <label for="street">Street:&nbsp;</label><input type="text" name="street" id="street"/><br/>
                                    <label for="state">State:&nbsp;</label><input type="text" name="state" id="state"/><br/>
                                    <label for="phone">Phone:&nbsp;</label><input type="text" name="phone" id="phone"/><br/>
                                    <label for="applicationDate">Application Date:&nbsp;</label>
                                    <input type="date" name="applicationDate" id="applicationDate"/><br/>
                                    <label for="status">Status:&nbsp;</label>
                                    <select name="status" id="status">
                                        <c:forEach var="status" items="${statuses}">
                                            <option value="${status}">${status}</option>
                                        </c:forEach>
                                    </select>
                                    <br/>
                                    <label for="bioLink">Bio Link:&nbsp;</label><input type="text" name="bioLink" id="bioLink"/> <br/>
                                </div>
                                <div class="col-sm-6 no-margin">
                                    <label for="lastName">Last Name:&nbsp;</label><input type="text" name="lastName" id="lastName"/><br/> 
                                    <label for="city">City:&nbsp;</label><input type="text" name="city" id="city"/><br/>
                                    <label for="zipCode">Zip Code:&nbsp;</label><input type="text" name="zipCode" id="zipCode"/><br/> 
                                    <label for="email">Email:&nbsp;</label><input type="text" name="email" id="email"/><br/> 
                                    <label for="testScore">Test Score:&nbsp;</label><input type="text" name="testScore" value="" id="testScore"/><br/> 
                                    <label for="housing">Housing:&nbsp;</label>
                                    <input type="radio" name="housing" value="TRUE">Yes</input>
                                    <input type="radio" name="housing" checked value="FALSE">No</input><br/>
                                    <label for="resumeLink">Resume Link:&nbsp;</label><input type="text" name="resumeLink" id="resumeLink"/><br/><br/>
                                </div>
                            </div>

                            <!-- cohort drop down -->
                            <label for="cohort">Cohort:&nbsp;</label>
                            <select name="cohort" id="cohort">
                                <c:forEach var="cohortName" items="${cohortList}">
                                    <option value="${cohortName.cohortId}">${cohortName.track} ${cohortName.startDate}</option>
                                </c:forEach>
                            </select><br/><br/>
                            <div id="insertPay">
                                <h4>Payments:</h4>
                                <label for="amount">Amount:&nbsp;</label><input type="text" name="amount[]" id="amount"/>
                                <label for="note">Note:&nbsp;</label><input type="text" name="payNote[]" id="note"/><br/>
                            </div>
                            <input type="button" id="addPay" value="Add another payment" /><br/><br/>

                            <div id="insertWork">
                                <h4>Work History:</h4>
                                <select name="employer[]">
                                    <c:forEach var="employer" items="${employerList}">
                                        <option value="">---Select Employer---</option>
                                        <option value="${employer.employerId}">${employer.companyName}</option>
                                    </c:forEach>
                                </select><br/>
                                <label for="startDate">Start Date:&nbsp;</label><input type="date" name="startDate[]" id="startDate"/><br/>
                                <label for="endDate">End Date:&nbsp;</label><input type="date" name="endDate[]" id="endDate"/><br/>
                                <label for="workNote">Note:&nbsp;</label><input type="text" name="workNote[]" id="workNote"/><br/>
                            </div>
                            <input type="button" id="addWork" value="Add another employer" />
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Student" class="btn btn-danger"/>
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
                        <th>Status&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                        <th>Cohort&#160&#160&#160&#160&#160</th>
                        <th>Resume&#160&#160&#160&#160&#160&#160</th>
                        <th>Bio&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                <sec:authorize access="hasRole('ROLE_STUDENTS_ADMIN')">
                    <th>Edit</th>
                </sec:authorize>
                </tr>
                </thead>

                <c:forEach var="student" items="${students}">
                    <tr class="clickableRow" data-toggle="modal" data-target="#modal_${student.studentId}">
                        <td>${student.firstName} ${student.lastName}</td>
                        <td>${student.status}</td>
                        <td>${student.cohort.track} ${student.cohort.startDate}</td>
                        <td>${student.resumeLink}</td>
                        <td>${student.bioLink}</td>
                    <sec:authorize access="hasRole('ROLE_STUDENTS_ADMIN')">
                        <td class="edit-column" ><a style="color:#333;" href="displayEditStudent?studentId=${student.studentId}">&#160<span class="glyphicon glyphicon-pencil">&#160</span></a>
                            <a href="removeStudent?studentId=${student.studentId}" style="color:#333;"><span class="glyphicon glyphicon-remove"></span></a></td>
                    </sec:authorize>
                    </tr>

                    <!-- Modal for view student -->
                    <div class="modal fade" id="modal_${student.studentId}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="POST" action="addStudent">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">View Student</h4>
                                    </div>
                                    <div class="modal-body container-fluid  ">
                                        <div class="col-sm-6 no-margin">
                                            <b>First name: </b>${student.firstName}<br/> 
                                            <b>Street: </b>${student.street}<br/>
                                            <b>State: </b>${student.state}<br/>
                                            <b>Phone: </b>${student.phone}<br/>
                                            <b>Application Date: </b>${student.applicationDate}<br/>
                                            <b>Status: </b>${student.status}<br/>
                                            <b>Bio: </b>${student.bioLink}<br/>
                                        </div>
                                        <div class="col-sm-6 no-margin">
                                            <b>Last name: </b>${student.lastName} <br/> 
                                            <b>City: </b>${student.city}<br/>
                                            <b>Zip Code: </b>${student.zipCode}<br/> 
                                            <b>Email: </b>${student.email}<br/> 
                                            <b>Test Score: </b>${student.testScore}<br/> 
                                            <b>Housing: </b> 
                                            <c:if test="${student.housing =='true'}">
                                                Yes<br/>
                                            </c:if>
                                            <c:if test="${student.housing =='false'}">
                                                No<br/>
                                            </c:if>
                                            <br/>
                                        </div>
                                        <div class="col-sm-6 no-margin">
                                            <c:forEach var="work" items="${student.workHistory}">
                                                <br/>
                                                <b>${work.companyName} </b><br/>
                                                Start Date: ${work.startDate} <br/>
                                                End Date: ${work.endDate}<br/>
                                                Note: ${work.note}<br/>
                                            </c:forEach>
                                        </div>
                                        <div class="col-sm-6 no-margin">
                                            <br/>
                                            <b>Payments:</b><br/>
                                            <c:forEach var="payment" items="${student.payments}">
                                                $${payment.amount} ${payment.note}<br/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
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
                var payCounter = 0;
                var workCounter = 0;
                var addPay = $("#addPay");
                var addWork = $("#addWork");
                var insertPay = $("#insertPay");
                var insertWork = $("#insertWork");

                $(addPay).click(function(e) {
                    payCounter++;
                    $(insertPay).append('<div><label for="amount">Amount:&nbsp;</label><input type="text" name="amount[]" id="pay' + payCounter + '"/><label for="note">&nbspNote:&nbsp;</label><input type="text" name="payNote[]" id="payNote' + payCounter + '"/><a href="#" class="removeclass"> Remove</a></div>');
                });
                $(addWork).click(function(e) {
                    workCounter++;
                    $(insertWork).append('<div> <select name="employer[]"><c:forEach var="employer" items="${employerList}"><option value="${employer.employerId}">${employer.companyName}</option></c:forEach></select><a href="#" class="removeclass"> Remove</a><br/><label for="startDate">Start Date:&nbsp;</label><input type="date" name="startDate[]" /><br/><label for="endDate">End Date:&nbsp;</label><input type="date" name="endDate[]" /><br/><label for="note">Note:&nbsp;</label><input type="text" name="workNote[]" /><br /><br/></div>');
                });
                $("body").on("click", ".removeclass", function(e) { //user click on remove text
                    $(this).parent('div').remove(); //remove text box
                });
            });
        </script>
    </body>
</html>
