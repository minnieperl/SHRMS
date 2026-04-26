<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${viewEmployee.firstName} ${viewEmployee.lastName} — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Employee Profile" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">

      <div class="row g-4">
        <!-- Profile Card -->
        <div class="col-lg-4">
          <div class="card text-center">
            <div class="card-body" style="padding:36px 24px;">
              <c:choose>
                <c:when test="${not empty viewEmployee.photoPath}">
                  <img src="${pageContext.request.contextPath}/uploads/${viewEmployee.photoPath}"
                       style="width:100px;height:100px;border-radius:50%;object-fit:cover;border:4px solid var(--primary-light);margin-bottom:16px;">
                </c:when>
                <c:otherwise>
                  <div style="width:100px;height:100px;border-radius:50%;background:var(--primary-light);color:var(--primary);font-size:36px;font-weight:800;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;border:4px solid var(--primary-light);">
                    ${viewEmployee.firstName.substring(0,1)}${viewEmployee.lastName.substring(0,1)}
                  </div>
                </c:otherwise>
              </c:choose>
              <h5 class="fw-bold mb-1">${viewEmployee.firstName} ${viewEmployee.lastName}</h5>
              <div class="text-muted small mb-2">${viewEmployee.employeeCode}</div>
              <span class="badge
                <c:choose>
                  <c:when test="${viewEmployee.role.roleName == 'ADMIN'}">badge-purple</c:when>
                  <c:when test="${viewEmployee.role.roleName == 'HR'}">badge-info</c:when>
                  <c:when test="${viewEmployee.role.roleName == 'MANAGER'}">badge-warning</c:when>
                  <c:otherwise>badge-secondary</c:otherwise>
                </c:choose>">${viewEmployee.role.roleName}</span>
              <span class="badge ${viewEmployee.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'} ms-1">${viewEmployee.status}</span>

              <div style="margin-top:24px;display:flex;flex-direction:column;gap:8px;">
                <div style="display:flex;align-items:center;gap:10px;padding:8px 12px;background:#f8fafc;border-radius:8px;font-size:13px;">
                  <i class="bi bi-envelope-fill text-primary"></i>
                  <span style="word-break:break-all;">${viewEmployee.email}</span>
                </div>
                <c:if test="${not empty viewEmployee.phone}">
                <div style="display:flex;align-items:center;gap:10px;padding:8px 12px;background:#f8fafc;border-radius:8px;font-size:13px;">
                  <i class="bi bi-telephone-fill text-success"></i>
                  <span>${viewEmployee.phone}</span>
                </div>
                </c:if>
                <div style="display:flex;align-items:center;gap:10px;padding:8px 12px;background:#f8fafc;border-radius:8px;font-size:13px;">
                  <i class="bi bi-building-fill text-info"></i>
                  <span>${viewEmployee.department.departmentName}</span>
                </div>
                <c:if test="${viewEmployee.manager != null}">
                <div style="display:flex;align-items:center;gap:10px;padding:8px 12px;background:#f8fafc;border-radius:8px;font-size:13px;">
                  <i class="bi bi-person-lines-fill text-warning"></i>
                  <span>Reports to: ${viewEmployee.manager.firstName} ${viewEmployee.manager.lastName}</span>
                </div>
                </c:if>
              </div>

              <c:if test="${role == 'ADMIN'}">
              <div class="d-flex gap-2 mt-4 justify-content-center">
                <a href="${pageContext.request.contextPath}/employees/edit/${viewEmployee.employeeId}" class="btn btn-primary btn-sm">
                  <i class="bi bi-pencil"></i> Edit
                </a>
              </div>
              </c:if>
            </div>
          </div>
        </div>

        <!-- Details -->
        <div class="col-lg-8">
          <div class="card mb-4">
            <div class="card-header"><h5><i class="bi bi-info-circle-fill text-primary me-2"></i>Employment Details</h5></div>
            <div class="card-body">
              <div class="row g-3">
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Employee Code</div>
                  <div class="fw-600">${viewEmployee.employeeCode}</div>
                </div>
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Joining Date</div>
                  <div class="fw-600">${viewEmployee.joiningDate != null ? viewEmployee.joiningDate : '—'}</div>
                </div>
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Base Salary</div>
                  <div class="fw-600 text-success">
                    ₹ <c:choose>
                      <c:when test="${viewEmployee.baseSalary != null}">${viewEmployee.baseSalary}</c:when>
                      <c:otherwise>—</c:otherwise>
                    </c:choose>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="text-muted small mb-1">Member Since</div>
                  <div class="fw-600">${viewEmployee.createdAt}</div>
                </div>
              </div>
            </div>
          </div>

          <div class="d-flex gap-3">
            <a href="${pageContext.request.contextPath}/attendance/history?empId=${viewEmployee.employeeId}"
               class="card text-decoration-none" style="flex:1;padding:20px;text-align:center;">
              <i class="bi bi-clock-fill" style="font-size:28px;color:var(--primary);display:block;margin-bottom:8px;"></i>
              <div class="fw-600 small">Attendance History</div>
            </a>
            <a href="${pageContext.request.contextPath}/leaves?empId=${viewEmployee.employeeId}"
               class="card text-decoration-none" style="flex:1;padding:20px;text-align:center;">
              <i class="bi bi-calendar2-minus-fill" style="font-size:28px;color:var(--warning);display:block;margin-bottom:8px;"></i>
              <div class="fw-600 small">Leave History</div>
            </a>
            <a href="${pageContext.request.contextPath}/payroll"
               class="card text-decoration-none" style="flex:1;padding:20px;text-align:center;">
              <i class="bi bi-receipt" style="font-size:28px;color:var(--success);display:block;margin-bottom:8px;"></i>
              <div class="fw-600 small">Payroll</div>
            </a>
          </div>
        </div>
      </div>

      <div class="mt-3">
        <a href="${pageContext.request.contextPath}/employees" class="btn btn-outline btn-sm">
          <i class="bi bi-arrow-left"></i> Back to Directory
        </a>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
