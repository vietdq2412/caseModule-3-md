<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="apple-touch-icon" sizes="76x76" href="views/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="views/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>Admin</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <!--     Fonts and icons     -->
    <link href="views/assets/css/pe-icon-7-stroke.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>

    <!-- CSS Files -->
    <link href="views/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="views/assets/css/light-bootstrap-dashboard.css?v=1.4.0 " rel="stylesheet"/>
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="views/assets/css/demo.css" rel="stylesheet"/>
    <link href="views/assets/css/style.css" rel="stylesheet"/>

</head>

<body>
<div class="wrapper">
    <div class="sidebar" data-image="views/assets/img/sidebar-5.jpg">
        <div class="sidebar-wrapper">
            <ul class="nav">
                <li>
                    <a class="nav-link active" href="/accounts?action=edit">
                        <i class="nc-icon nc-circle-09"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <li >
                    <a class="nav-link" href="/books?action=shop">
                        <i class="nc-icon nc-notes"></i>
                        <p>Shop</p>
                    </a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="/accounts?page=1">
                        <i class="nc-icon nc-notes"></i>
                        <p>Accounts</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/books?page=1">
                        <i class="nc-icon nc-paper-2"></i>
                        <p>Books</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/category">
                        <i class="nc-icon nc-atom"></i>
                        <p>Category</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/authors">
                        <i class="nc-icon nc-album-2"></i>
                        <p>Author</p>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="#">
                        <i class="nc-icon nc-air-baloon"></i>
                        <p>Order</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="main-panel">

        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">EDIT PROFILE</h4>
                            </div>
                            <div class="content">
                                <form method="post" action="/accounts?action=profile&id=${accountEdit.id}">
                                    <c:if test="${accountEdit != null}">
                                        <input type="hidden" name="id" value="<c:out value='${accountEdit.id}' />"/>
                                    </c:if>
                                    <div class="row">
                                        <div class="col-md-6 pr-1">
                                            <div class="form-group">
                                                <label>Username</label>
                                                <input type="text" class="form-control" placeholder="Username"
                                                       name="editusername"
                                                       value="<c:out value="${accountEdit.username}"/>">
                                            </div>
                                        </div>
                                        <div class="col-md-6 pr-1">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input style="width: 290px;" type="email" class="form-control" placeholder="Email"
                                                       name="editemail"
                                                       value="<c:out value="${accountEdit.email}"/>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-8 pr-1">
                                            <div class="form-group">
                                                <label>Full Name</label>
                                                <input type="text" class="form-control" placeholder="Full Name"
                                                       name="editfullName"
                                                       value="<c:out value="${accountEdit.fullName}"/>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label>Password</label>
                                                <input type="text" class="form-control" placeholder="Password"
                                                       name="editpassword"
                                                       value="<c:out value="${accountEdit.password}"/>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" class="form-control" placeholder="Address"
                                                       name="editaddress"
                                                       value="<c:out value="${accountEdit.address}"/>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label>Phone Number</label>
                                                <input type="text" class="form-control" placeholder="Phone Number"
                                                       name="editphoneNumber"
                                                       value="<c:out value="${accountEdit.phoneNumber}"/>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label>Role</label>
                                                <select name="role" id="role" style="height:20px; width:150px;">
                                                    <c:if test="${accountEdit.role.id == 1}">
                                                        <option value="1">ROLE_ADMIN</option>
                                                        <option value="2">ROLE_USER</option>
                                                    </c:if>
                                                    <c:if test="${accountEdit.role.id == 2}">
                                                        <option value="2">ROLE_USER</option>
                                                        <option value="1">ROLE_ADMIN</option>
                                                    </c:if>

                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-info btn-fill pull-right">Update Profile
                                    </button>
                                    <div class="clearfix"></div>
                                </form>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card card-user">
                            <div class="image">
                                <img src="https://ununsplash.imgix.net/photo-1431578500526-4d9613015464?fit=crop&fm=jpg&h=300&q=75&w=400" alt="..."/>
                            </div>
                            <div class="content">
                                <div class="author">
                                    <a href="#">
                                        <img class="avatar border-gray" src="views/assets/img/faces/face-3.jpg"
                                             alt="..."/>

                                        <h4 class="title"><c:out value="${accountEdit.fullName}"/><br/>
                                            <small><c:out value="${accountEdit.username}"/></small>
                                        </h4>
                                    </a>
                                </div>
                                <p class="description text-center"><c:out value="${accountEdit.address}"/>
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <button href="#" class="btn btn-simple"><i class="fa fa-facebook-square"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-twitter"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-google-plus-square"></i></button>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
</body>
!--   Core JS Files   -->
<script src="views/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="views/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="views/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="views/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="views/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="views/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="views/assets/js/light-bootstrap-dashboard.js?v=1.4.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="views/assets/js/demo.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<style>
    .modal-backdrop {
        /* bug fix - no overlay */
        display: none;
    }

</style>
<script>
    $(document).ready(() => {
        $('#nav-mobile-menu').remove();
    })
</script>
</html>