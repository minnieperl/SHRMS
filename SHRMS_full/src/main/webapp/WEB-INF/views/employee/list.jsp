<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Employees — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Employee Directory" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <!-- Header Row -->
      <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
          <h5 class="mb-0 fw-bold">All Employees</h5>
          <p class="text-muted small mb-0">${employees.size()} records found</p>
        </div>
        <div class="d-flex gap-2 align-items-center">
          <!-- Search -->
          <form method="get" action="${pageContext.request.contextPath}/employees">
            <div class="search-bar">
              <i class="bi bi-search"></i>
              <input type="text" name="search" value="${search}" placeholder="Search employees…">
            </div>
          </form>
          <c:if test="${role == 'ADMIN'}">
          <a href="${pageContext.request.contextPath}/employees/add" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Add Employee
          </a>
          </c:if>
        </div>
      </div>

      <!-- Employee Grid Cards -->
      <div class="row g-3">
        <c:choose>
          <c:when test="${empty employees}">
            <div class="col-12">
              <div class="card">
                <div class="card-body text-center" style="padding:60px;">
                  <i class="bi bi-people" style="font-size:48px;color:#cbd5e1;display:block;margin-bottom:12px;"></i>
                  <h6 class="text-muted">No employees found</h6>
                  <c:if test="${role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/employees/add" class="btn btn-primary mt-2">Add First Employee</a>
                  </c:if>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="emp" items="${employees}">
            <div class="col-sm-6 col-md-4 col-xl-3">
              <div class="emp-card">
                <c:choose>
                  <c:when test="${not empty emp.photoPath}">
                    <img src="${pageContext.request.contextPath}/uploads/${emp.photoPath}" class="emp-avatar" alt="">
                  </c:when>
                  <c:otherwise>
                    <div class="emp-avatar d-flex align-items-center justify-content-center"
                         style="background:var(--primary-light);color:var(--primary);font-weight:700;font-size:20px;margin:0 auto 12px;">
                      ${emp.firstName.substring(0,1)}${emp.lastName.substring(0,1)}
                    </div>
                  </c:otherwise>
                </c:choose>
                <div style="font-weight:700;font-size:14px;margin-bottom:2px;">${emp.firstName} ${emp.lastName}</div>
                <div class="text-muted small mb-1">${emp.employeeCode}</div>
                <div class="text-muted small mb-2">${emp.department.departmentName}</div>
                <span class="badge
                  <c:choose>
                    <c:when test="${emp.role.roleName == 'ADMIN'}">badge-purple</c:when>
                    <c:when test="${emp.role.roleName == 'HR'}">badge-info</c:when>
                    <c:when test="${emp.role.roleName == 'MANAGER'}">badge-warning</c:when>
                    <c:otherwise>badge-secondary</c:otherwise>
                  </c:choose>">${emp.role.roleName}</span>
                <span class="badge ${emp.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'} ms-1">${emp.status}</span>

                <div class="d-flex gap-2 justify-content-center mt-3">
                  <a href="${pageContext.request.contextPath}/employees/view/${emp.employeeId}"
                     class="btn btn-ghost btn-sm" title="View">
                    <i class="bi bi-eye"></i>
                  </a>
                  <c:if test="${role == 'ADMIN'}">
                  <a href="${pageContext.request.contextPath}/employees/edit/${emp.employeeId}"
                     class="btn btn-ghost btn-sm" title="Edit">
                    <i class="bi bi-pencil"></i>
                  </a>
                  <form action="${pageContext.request.contextPath}/employees/delete/${emp.employeeId}"
                        method="post" data-confirm="Deactivate ${emp.firstName}?">
                    <button class="btn btn-ghost btn-sm" title="Deactivate" style="color:var(--danger);">
                      <i class="bi bi-person-dash"></i>
                    </button>
                  </form>
                  </c:if>
                </div>
              </div>
            </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>

    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
