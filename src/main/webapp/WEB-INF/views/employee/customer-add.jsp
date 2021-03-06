<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath }/">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="employee.customer.add" /></title>
</head>
<style type="text/css">
*[id$=errors] {
	color: red;
	font-style: italic;
	padding-left: 33px;
	background: url("images/hieuboy2.gif") no-repeat left center;
}
</style>
<body>

	<div id="main-wrapper">
		<jsp:include page="header.jsp"></jsp:include>
		<jsp:include page="menu.jsp"></jsp:include>
		<div class="page-wrapper">
			<!-- Container fluid  -->
			<div class="container-fluid">
				<!-- Bread crumb and right sidebar toggle -->
				<div class="row page-titles">
					<div class="col-md-5 col-8 align-self-center">
						<h3 class="text-themecolor m-b-0 m-t-0">
							<s:message code="employee.menu.customer" />
						</h3>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="javascript:void(0)"><s:message
										code="employee.menu.home" /></a></li>
							<li class="breadcrumb-item active"><s:message
									code="employee.customer.add" /></li>
						</ol>
					</div>
					<div class="col-md-7 col-4 align-self-center">
						<a href="http://facebook.com/HieuDTPH04388" target="blank"
							class="btn waves-effect waves-light btn-danger pull-right hidden-sm-down">
							<s:message code="employee.menu.contact" />
						</a>
					</div>
				</div>
				<!-- End Bread crumb and right sidebar toggle -->
				<!-- Start Page Content -->
				<div class="row">
					<!-- column -->
					<div class="col-lg-12">
						<div class="card">
							<div class="card-block">
								<h4 class="card-title">
									<s:message code="employee.customer.add" />
								</h4>
								<form:form action="employee/customer/save-customer.htm"
									method="POST" commandName="customer"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-6">
											<label> <s:message code="employee.customer.email" />:
												(<span style="color: red;">*</span>)<form:errors
													path="email" /></label>
											<form:input path="email" type="email"
												placeholder="Nh???p t??i kho???n email" size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
										<div class="col-md-6">
											<label><s:message code="employee.customer.password" />:
												(<span style="color: red;">*</span>)<form:errors
													path="password" /></label>
											<form:input path="password" placeholder="Nh???p m???t kh???u"
												size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-md-6">
											<label><s:message code="employee.customer.fullName" />:
												(<span style="color: red;">*</span>)<form:errors
													path="fullName" /></label>
											<form:input path="fullName" placeholder="Nh???p h??? v?? t??n"
												size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
										<div class="col-md-6">
											<label><i class="fa fa-calendar bigger-110"> </i> <s:message
													code="employee.customer.birthday" />: (<span
												style="color: red;">*</span>)<form:errors path="birthday" /></label>
											<form:input path="birthday" id="datepicker"
												placeholder="dd/MM/yyyy" size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
									</div>
									<br>

									<div class="row">
										<div class="col-md-6">
											<label><s:message code="employee.customer.address" />:
												(<span style="color: red;">*</span>)<form:errors
													path="address" /></label>
											<form:input path="address" placeholder="Nh???p ?????a ch???"
												size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
										<div class="col-md-6">
											<label><s:message
													code="employee.customer.numberPhone" />: (<span
												style="color: red;">*</span>)<form:errors path="numberPhone" /></label>
											<form:input path="numberPhone"
												placeholder="Nh???p s??? ??i???n tho???i" size="30" maxlength="30"
												class="form-control form-control-line" />
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-md-6">
											<label><s:message code="employee.customer.gender" />:
												(<span style="color: red;">*</span>)<form:errors
													path="gender" /> </label>
											<form:select path="gender"
												class="form-control form-control-line">
												<form:option value="0">
													<s:message code="employee.select" />
												</form:option>
												<form:option value="1">
													<s:message code="employee.gender.male" />
												</form:option>
												<form:option value="2">
													<s:message code="employee.gender.female" />
												</form:option>
											</form:select>
										</div>
										<div class="col-md-6">
											<label><s:message code="employee.customer.photo" />:
												(<span style="color: red;">*</span>)<form:errors
													path="photo" /></label> <input id="photo" type="file"
												name="file_image" class="form-control form-control-line" />
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-md-12">
											<div style="text-align: center;">
												<button class="btn btn-danger">
													<s:message code="employee.customer.add" />
												</button>
											</div>
										</div>
										<form:hidden path="activated" value="1" />
									</div>
									<br>
								</form:form>

							</div>
						</div>
					</div>
				</div>
				<!-- End PAge Content -->
			</div>
			<!-- End Container fluid  -->
			<!-- footer -->
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>



</body>
</html>