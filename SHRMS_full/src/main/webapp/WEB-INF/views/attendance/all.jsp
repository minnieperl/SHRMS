<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>All Attendance — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="All Attendance" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">

      <div class="card mb-4">
        <div class="card-body" style="padding:16px 20px;">
          <form method="get" action="${pageContext.request.contextPath}/attendance/all" class="d-flex gap-3 align-items-end">
            <div class="form-group mb-0">
              <label class="form-label">Select Date</label>
              <input type="date" name="date" class="form-control" value="${date}" style="width:200px;">
            </div>
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> View</button>
          </form>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <h5><i class="bi bi-people-fill text-primary me-2"></i>Attendance on: <strong>${date}</strong></h5>
          <span class="badge badge-success">${attendanceList.size()} Present</span>
        </div>
        <div class="table-wrapper">
          <table class="hrms-table">
            <thead>
              <tr><th>Employee</th><th>Department</th><th>Check In</th><th>Check Out</th><th>Hours</th><th>Status</th></tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty attendanceList}">
                  <tr><td colspan="6" class="text-center text-muted" style="padding:50px;">No attendance records for this date.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="a" items="${attendanceList}">
                    <tr>
                      <td>
                        <div style="display:flex;align-items:center;gap:10px;">
                          <div class="avatar" style="font-size:12px;">${a.employee.firstName.substring(0,1)}${a.employee.lastName.substring(0,1)}</div>
                          <div>
                            <div class="fw-600 small">${a.employee.firstName} ${a.employee.lastName}</div>
                            <div class="text-muted" style="font-size:11px;">${a.employee.employeeCode}</div>
                          </div>
                        </div>
                      </td>
                      <td class="text-muted small">${a.employee.department.departmentName}</td>
                      <td>${a.checkInTime != null ? a.checkInTime : '—'}</td>
                      <td>${a.checkOutTime != null ? a.checkOutTime : '—'}</td>
                      <td class="text-muted small">${a.checkOutTime != null ? a.workingHours : '—'}</td>
                      <td>
                        <span class="badge ${a.status == 'PRESENT' ? 'badge-success' : a.status == 'LATE' ? 'badge-warning' : 'badge-danger'}">${a.status}</span>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
