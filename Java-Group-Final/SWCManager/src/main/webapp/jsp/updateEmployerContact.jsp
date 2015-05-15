<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta  name="viewport" content="width=device­width, initial­scale=1.0">
        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link  href="../css/custom.css" rel="stylesheet" media="screen">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employer and Contacts</title>
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
                        <li><a href="cohortList">Cohorts</a></li>
                        <li class="active"><a href="employerList">Employers</a></li>
                        <li><a href="userList">Manage Accounts</a></li>
                        <li><a href="#">Logout</a></li>
                    </ul>

                </div>
            </div>
        </div> 
<!--Wrapper div begins-->
        <div id="wrapper">
            <h1>Employer and Contacts</h1> 
            <!--Left side, or "Employers," side of split screen   -->
            <div id="left-employer">
                <h3>Employer:</h3>

                <div class="col-sm-6 no-margin">
                    Company Name: ${employer.companyName}<br/> 
                    Tier: ${employer.tier}<br/>
                    Status: ${employer.status}<br/>
                    Company Phone: ${employer.companyPhone}<br/>
                    Company Email: ${employer.companyEmail}<br/>
                    Company Address: ${employer.companyAddress}<br/><br/>

                    <button  data-toggle="modal" data-target="#editEmployerModal">
                        <span class="glyphicon glyphicon-pencil"></span>&nbsp;Edit Employer</button>
                </div>

            </div>      



            <!--Right side, or "Contacts," side of split screen   -->   
            <div id="right-contacts">

                <!-- create and populate table -->
                <div class="container col-sm-6 col-sm-offset-1">
                    <table id="names-table" class="table table-striped ">
                        <caption><h3>${employer.companyName}'s Contacts</h3>  
                            <button  data-toggle="modal" data-target="#addContactModal">
                        <span class="glyphicon glyphicon-plus"></span>&nbsp;Add Contact</button></caption>
                        <thead>
                            <tr>
                                <th>Contact Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Note</th>
                                <th>Edit</th>
                            </tr>
                        </thead>

                        <c:forEach var="contact" items="${contacts}">
                            <tr class="clickableRow" data-toggle="modal" data-target="#modal_${contact.contactId}">
                                <td>${contact.firstName} ${contact.lastName}</td>
                                <td>${contact.phone}</td>
                                <td>${contact.email}</td>
                                <td>${contact.address}</td>
                                <td>${contact.note}</td>
                                <td class="edit-column" ><a style="color:#333;" href="editContactForm?employerId=${contact.contactId}">&#160<span class="glyphicon glyphicon-pencil">&#160</span></a>
                                    <a href="removeContact?contactId=${contact.contactId}" style="color:#333;"><span class="glyphicon glyphicon-remove"></span></a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <!-- Edit Employer Modal-->


        <div class="modal fade" id="editEmployerModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <sf:form method="POST" action="editEmployer" commandName="employer">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Edit Employer</h4>
                        </div>
                        <div class="modal-body container-fluid" >
                            <div class="row-fluid style-form">
                                <div class="col-sm-6 no-margin">
                                    <sf:label path="companyName">Company Name:&nbsp;</sf:label><sf:input type="text" path="companyName" id="companyname" /><br/> 
                                    <select name="tier" id="tier">
                                        <c:forEach var="tier" items="${tiers}">
                                            <option value="${tier}">${tier}</option>
                                        </c:forEach>
                                    </select>
                                    <br/>
                                    <select name="status" id="status">
                                        <c:forEach var="status" items="${statuses}">
                                            <option value="${status}">${status}</option>
                                        </c:forEach>
                                    </select>
                                    <br/>
                                    <sf:label path="companyPhone">Company Phone:&nbsp;</sf:label><sf:input type="text" path="companyPhone" id="companyphone"/><br/>
                                    <sf:label path="companyEmail">Company Email:&nbsp;</sf:label><sf:input type="text" path="companyEmail" id="companyemail"/><br/> 
                                    <sf:label path="companyAddress">Address:&nbsp;</sf:label><sf:input type="text" path="companyAddress" id="companyaddress"/><br/>
                                    <sf:hidden path="employerId"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Update Employer" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </sf:form>

                </div>
            </div>

        </div>

        
         <!-- Add Contact Modal-->


        <div class="modal fade" id="addContactModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 45%">
                <div class="modal-content">
                    <sf:form method="POST" action="addContact" commandName="contact">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add Contact</h4>
                        </div>
                        <div class="modal-body container-fluid" >
                            <div class="row-fluid style-form">
                                <div class="col-sm-6 no-margin">
                                    <label for="employerId"></label><input type="hidden" name="employerId" id="employerId" value="${employer.employerId}"/>
                                     <label for="firstName">First Name:&nbsp;</label><input type="text" name="firstName" id="firstName" /><br/> 
                                    <label for="lastName">Last Name:&nbsp;</label><input type="text" name="lastName" id="lastName"/><br/>
                                    <label for="phone">Phone:&nbsp;</label><input type="text" name="phone" id="phone"/><br/>
                                    <label for="email">Email:&nbsp;</label><input type="text" name="email" id="email"/><br/>
                                    <label for="address">Address:&nbsp;</label><input type="text" name="address" id="address"/><br/>
                                    <label for="note">Note:&nbsp;</label><input type="text" name="note" id="note"/><br/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Contact" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </sf:form>

                </div>
            </div>

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
    </body>
</html>
