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


        <title>Update Student</title>
        
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
                    <h2>Update Student Info</h2>
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
            <h3>Student</h3 >
        </div>

        <!-- older code
        <div class="col-sm-10 col-sm-offset-1" style="padding-bottom: 25px;">
            <button class="btn btn-danger " data-toggle="modal" data-target="#addStudentModal">
                <span class="glyphicon glyphicon-plus"></span> Add Student</button>

            <button class="btn btn-danger " data-toggle="modal" data-target="#searchModal">
                Search  
            </button> 
        </div>   
        -->
        
        <c:if test="${popupUpdatePayment == 'true'}">
        <script>window.onload=function(){
            $("#updatePaymentModal").modal('show');
        }</script>
        </c:if>
        <c:if test="${popupUpdateWork == 'true'}">
        <script>window.onload=function(){
            $("#updateWorkModal").modal('show');
        }</script>
        </c:if>
        
        <!-- for the student form -->
        <div class="col-sm-10 col-sm-offset-1">
            <form method="POST" action="updateStudent" >
                <div class="row-fluid style-form">
                    <div class="col-sm-6 no-margin">
                        <label for="firstName">First Name:&nbsp;</label><input type="text" name="firstName" id="firstName" value="${addStudent.firstName}"/><br/> 
                        <label for="street">Street:&nbsp;</label><input type="text" name="street" id="street" value="${addStudent.street}"/><br/>
                        <label for="state">State:&nbsp;</label><input type="text" name="state" id="state" value="${addStudent.state}"/><br/>
                        <label for="phone">Phone:&nbsp;</label><input type="text" name="phone" id="phone" value="${addStudent.phone}"/><br/>
                        <label for="applicationDate">Application Date:&nbsp;</label>
                        <input type="date" name="applicationDate" id="applicationDate" value="${addStudent.applicationDate}"/><br/>
                        <label for="status">Status:&nbsp;</label>
                        <select name="status" id="status" value="${addStudent.status}">
                            <c:forEach var="status" items="${statuses}">
                                <option value="${status}">${status}</option>
                            </c:forEach>
                        </select>
                        <br/>
                        <label for="bioLink">Bio Link:&nbsp;</label><input type="text" name="bioLink" id="bioLink" value="${addStudent.bioLink}"/> <br/>
                    </div>
                    <div class="col-sm-6 no-margin">
                        <label for="lastName">Last Name:&nbsp;</label><input type="text" name="lastName" id="lastName" value="${addStudent.lastName}"/><br/> 
                        <label for="city">City:&nbsp;</label><input type="text" name="city" id="city" value="${addStudent.city}"/><br/>
                        <label for="zipCode">Zip Code:&nbsp;</label><input type="text" name="zipCode" id="zipCode" value="${addStudent.zipCode}"/><br/> 
                        <label for="email">Email:&nbsp;</label><input type="text" name="email" id="email" value="${addStudent.email}"/><br/> 
                        <label for="testScore">Test Score:&nbsp;</label><input type="text" name="testScore" value="${addStudent.testScore}" id="testScore" /><br/> 
                        <label for="housing">Housing:&nbsp;</label>
                        <input type="radio" name="housing" value="TRUE">Yes</input>
                        <input type="radio" name="housing" checked value="FALSE">No</input><br/>
                        <label for="resumeLink">Resume Link:&nbsp;</label><input type="text" name="resumeLink" id="resumeLink" value="${addStudent.resumeLink}"/><br/>
                        <label for="cohort">Cohort:&nbsp;</label>
                        <select name="cohort"  id="cohort" value="${addStudent.cohort.cohortId}" >
                            <c:forEach var="cohort" items="${cohortList}">  
                                <option value="${cohort.cohortId}">${cohort.track} ${cohort.startDate}</option>
                            </c:forEach>
                                <input type="hidden" name="uPayStudentId" value="${addStudent.studentId}"/>
                        </select><br/>
                        <input type="hidden" name="uStudentId" value="${addStudent.studentId}"/>
                    </div>
                </div>
                <button class="btn btn-danger " type="submit">
                    Update Student 
                </button>
            </form>


        </div>
        <div class="col-sm-10 col-sm-offset-1" style="margin-top:25px;">
            <div class="col-sm-4">
                <div >
                    <button style="float:right;" class="btn btn-sm btn-danger " data-toggle ="modal" data-target="#addPaymentModal">
                        <span class="glyphicon glyphicon-plus"></span> Add Payment</button>
                    <h3 style="float:left;">Payment</h3>
                </div>
                <table  class="sortable-table table table-striped ">
                    <thead>
                        <tr>
                            <th>Amount&#160&#160&#160</th>
                            <th>Note&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                            <th class="edit-column">Edit&#160&#160&#160&#160</th>
                        </tr>
                    </thead>

                    <c:forEach var="payment" items="${payments}">
                        <tr>
                            <td>${payment.amount}</td> 
                            <td>${payment.note}</td> 
                            <td class="edit-column" ><a style="color:#333;" href="displayUpdatePayment?paymentId=${payment.paymentId}"><span class="glyphicon glyphicon-pencil"></span></a>
                                <a href="removePayment?paymentId=${payment.paymentId}" style="color:#333;"><span class="glyphicon glyphicon-remove"></span></a></td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
            <div class="col-sm-8">
                <div>
                    <button style="float:right;" class="btn btn-sm btn-danger " data-toggle="modal" data-target="#addWorkModal">
                        <span class="glyphicon glyphicon-plus"></span> Add Work History</button>
                    <h3 style="float:left;">Work History</h3>
                </div>
                <table  class="sortable-table table table-striped ">
                    <thead>
                        <tr>
                            <th>Name&#160&#160&#160</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Note &#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                            <th class="edit-column">Edit&#160&#160&#160&#160</th>
                        </tr>
                    </thead>

                    <c:forEach var="work" items="${works}">
                        <tr>
                            <td>${work.companyName}</td> 
                            <td>${work.startDate}</td> 
                            <td>${work.endDate}</td> 
                            <td>${work.note}</td> 
                            <td class="edit-column" ><a style="color:#333;" href="displayUpdateWork?workId=${work.workdId}"><span class="glyphicon glyphicon-pencil"></span></a>
                                <a href="removeWork?workId=${work.workdId}" style="color:#333;"><span class="glyphicon glyphicon-remove"></span></a></td>    
                        </tr>
                    </c:forEach>



                </table>

            </div>
        </div>

        <!-- Modal for update payment -->
        <div class="modal fade" id="updatePaymentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <form method="POST" action="updatePayment">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Update Payment</h4>
                        </div>
                        <div class="modal-body" >
                            <label for="uAmount">Amount:&nbsp;</label><input type="text" name="uAmount" value="${updatePayment.amount}"/><br/>
                            <label for="uPayNote">Note:&nbsp;</label><input type="text" name="uPayNote" value="${updatePayment.note}"/><br/>
                            <input type="hidden" name="uPayStudentId" value="${addStudent.studentId}"/>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Update Payment" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal for add Payment-->

        <div class="modal fade" id="addPaymentModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <form method="POST" action="addPayment">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add Payment</h4>
                        </div>
                        <div class="modal-body" >
                            <label for="amount">Amount:&nbsp;</label><input type="text" name="amount"/><br/>
                            <label for="note">Note:&nbsp;</label><input type="text" name="note"/><br/>
                            <input type="hidden" name="studentId" value="${addStudent.studentId}"/>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Payment" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Modal for update work -->
        <div class="modal fade" id="updateWorkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <form method="POST" action="updateWork">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Update Work History</h4>
                        </div>
                        <div class="modal-body" >
                            <select name="uEmployer">
                                <c:forEach var="employer" items="${employerList}">
                                    <option value="${employer.employerId}">${employer.companyName}</option>
                                </c:forEach>
                            </select><br/>
                            <label for="uStartDate">Start Date:&nbsp;</label><input value="${updateWork.startDate}" type="date" name="uStartDate" /><br/>
                            <label for="uEndDate">End Date:&nbsp;</label><input value="${updateWork.endDate}" type="date" name="uEndDate" /><br/>
                            <label for="uWorkNote">Note:&nbsp;</label><input value="${updateWork.note}" type="text" name="uWorkNote" /><br/>
                            <input type="hidden" name="uStudentId" value="${addStudent.studentId}"/>
                        </div>
                        <div class="modal-footer">  
                            <input type="submit" value="Update Work" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal for add work-->

        <div class="modal fade" id="addWorkModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <form method="POST" action="addWork">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add Work History</h4>
                        </div>
                        <div class="modal-body" >
                            <select name="employer">
                                <c:forEach var="employer" items="${employerList}">
                                    <option value="${employer.employerId}">${employer.companyName}</option>
                                </c:forEach>
                            </select><br/>
                            <label for="startDate">Start Date:&nbsp;</label><input type="date" name="startDate" /><br/>
                            <label for="endDate">End Date:&nbsp;</label><input type="date" name="endDate" /><br/>
                            <label for="note">Note:&nbsp;</label><input type="text" name="workNote" /><br/>
                            <input type="hidden" name="studentId" value="${addStudent.studentId}"/>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Work" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
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
                    $(".sortable-table").tablesorter();
                });
            });</script>

    </body>
</html>
