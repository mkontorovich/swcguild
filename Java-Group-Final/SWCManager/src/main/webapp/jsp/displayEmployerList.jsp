<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta  name="viewport" content="width=device­width, initial­scale=1.0">
        <link  href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link  href="../css/custom.css" rel="stylesheet" media="screen">
        <title>Employer List</title>
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
            <h2>Employers</h2>
        </div>

        <div class="col-sm-10 col-sm-offset-1" style="padding-bottom: 25px;">
            <sec:authorize access="hasRole('ROLE_EMPLOYERS_ADMIN')">
                <button class="btn btn-danger " data-toggle="modal" data-target="#addEmployerModal">
                    <span class="glyphicon glyphicon-plus"></span> Add Employer</button>
                </sec:authorize>
            <button class="btn btn-danger " data-toggle="modal" data-target="#searchModal">
                Search  
            </button> 
        </div>

        <!-- Modal for add employer-->

        <div class="modal fade" id="addEmployerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="POST" action="addEmployer">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Add Employer</h4>
                        </div>
                        <div class="modal-body" >

                            <div class="form-group">
                                <div class="style-form"> 
                                    <label for="company">Company Name: </label><input type="text" name="companyName" /><br /><br/>
                                    <label for="tier">Tier: </label>

                                    <select name="tier" id="tier">
                                        <c:forEach var="tier" items="${tiers}">
                                            <option value="${tier}">${tier}</option>
                                        </c:forEach> 
                                    </select>

                                    <br/><br/>

                                    <label for="status">Status: </label>

                                    <select name="status" id="status">
                                        <c:forEach var="status" items="${statuses}">
                                            <option value="${status}">${status}</option>
                                        </c:forEach>
                                    </select>

                                    <br /><br/>
                                    <label for="phone">Company Phone: </label><input type="text" name="companyPhone" /><br />
                                    <label for="email">Company Email: </label><input type="text" name="companyEmail" /><br />
                                    <label for="address">Company Address: </label><input type="text" name="companyAddress" /><br /><br/>

                                    <!-- add Contact button -->

                                    <h4>Contacts</h4>
                                    <div id="insertContact">
                                        <label for="first_name">First name:&nbsp;</label><input type="text" name="first_name[]" id="first_name"/><br/>
                                        <label for="last_name">Last name:&nbsp;</label><input type="text" name="last_name[]" id="last_name"/><br/>
                                        <label for="phone">Phone #:&nbsp;</label><input type="text" name="phone[]" id="phone"/><br/>
                                        <label for="email">Email:&nbsp;</label><input type="text" name="email[]" id="email"/><br/>
                                        <label for="address">Address:&nbsp;</label><input type="text" name="address[]" id="address"/><br/>
                                        <label for="note">Note:&nbsp;</label><input type="text" name="note[]" id="note"/><br/>
                                    </div>

                                    <input type="button" id="addContact" value="Add contact" /><br/><br/>

                                </div>              
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" value="Add Employer" class="btn btn-danger"/>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>



        <!--<h1>Employer List</h1>
        <a href="../index.jsp">Home</a><br />
        <a href="displayNewEmployerForm">Add an Employer</a><br/>-->


        <div class="container col-sm-10 col-sm-offset-1">
            <table id="names-table" class="table table-striped ">
                <thead>
                    <tr>
                        <th>Company Name</th>
                        <th>Tier&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                        <th>Status&#160&#160&#160&#160&#160</th>
                        <th>Phone #&#160&#160&#160&#160&#160&#160</th>
                        <th>Email&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                        <th>Address&#160&#160&#160&#160&#160&#160&#160&#160&#160&#160</th>
                            <sec:authorize access="hasRole('ROLE_EMPLOYERS_ADMIN')">
                            <th>Edit</th>
                            </sec:authorize>
                    </tr>
                </thead>

                <c:forEach var="employer" items="${employerList}">
                    <tr>

                        <td>${employer.companyName}</td>    
                        <td>${employer.tier}</td>
                        <td>${employer.status}</td>
                        <td>${employer.companyPhone}</td>
                        <td>${employer.companyEmail}</td>
                        <td>${employer.companyAddress}</td>
                        <sec:authorize access="hasRole('ROLE_EMPLOYERS_ADMIN')">
                            <td class="edit-column" >
                                <a style="color:#333;" href="editEmployerForm?employerId=${employer.employerId}">&#160<span class="glyphicon glyphicon-pencil">&#160</span></a>
                                <a style="color:#333;" href="removeEmployer?employerId=${employer.employerId}"><span class="glyphicon glyphicon-remove"></span></a></td>
                                </sec:authorize>

                    </tr>


                    <!-- Modal for view employer -->
                    <div class="modal fade" id="modal_${employer.employerId}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="POST" action="addEmployer">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">View Employer</h4>
                                    </div>
                                    <div class="modal-body container-fluid  ">
                                        <div class="col-sm-6 no-margin">
                                            Company name: ${employer.companyName}<br/> 
                                            Tier: ${employer.tier}<br/>
                                            Status: ${employer.status}<br/>
                                            Phone: ${employer.companyPhone}<br/>
                                            Email: ${employer.companyEmail}<br/>
                                            Address: ${employer.companyAddress}<br/>
                                        </div>


                                    </div>
                                    <div class="modal-footer">
                                        <input type="submit" value="Add Employer" class="btn btn-danger"/>
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

        <script src="../js/jquery.js" ></script>
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


        <!-- adding a new contact field -->
        <script>
            $(document).ready(function() {
                var contactCounter = 0;
                var addContact = $("#addContact");
                var insertContact = $("#insertContact");

                $(addContact).click(function(e) {
                    contactCounter++;
                    $(insertContact).append('<div><br/><label for="first_name">First name:&nbsp;</label><input type="text" name="first_name[]" id="first_name' + contactCounter + '"/><br/><label for="last_name">Last name:&nbsp;</label><input type="text" name="last_name[]" id="last_name' + contactCounter + '"/><br/><label for="phone">Phone #:&nbsp;</label><input type="text" name="phone[]" id="phone' + contactCounter + '"/><br/><label for="email">Email:&nbsp;</label><input type="text" name="email[]" id="email' + contactCounter + '"/><br/><label for="address">Address:&nbsp;</label><input type="text" name="address[]" id="address' + contactCounter + '"/><br/><label for="note">Note:&nbsp;</label><input type="text" name="note[]" id="note' + contactCounter + '"/><a href="#" class="removeclass"> Remove</a></div>');
                });

                $("body").on("click", ".removeclass", function(e) { //user click on remove text
                    $(this).parent('div').remove(); //remove text box
                });
            });
        </script>
    </body>
</html>