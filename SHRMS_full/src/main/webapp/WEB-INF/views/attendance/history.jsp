<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Attendance History — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Attendance History" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">

      <div class="card mb-4">
        <div class="card-body" style="padding:16px 20px;">
          <form method="get" action="${pageContext.request.contextPath}/attendance/history" class="d-flex gap-3 align-items-end flex-wrap">
            <div class="form-group mb-0">
              <label class="form-label">From</label>
              <input type="date" name="from" class="form-control" value="${param.from}" style="width:160px;">
            </div>
            <div class="form-group mb-0">
              <label class="form-label">To</label>
              <input type="date" name="to" class="form-control" value="${param.to}" style="width:160px;">
            </div>
            <button type="submit" class="btn btn-primary">
              <i class="bi bi-filter"></i> Filter
            </button>
            <a href="${pageContext.request.contextPath}/attendance/history" class="btn btn-outline">Reset</a>
          </form>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <h5><i class="bi bi-calendar3 text-primary me-2"></i>Attendance Records</h5>
          <span class="badge badge-secondary">${history.size()} records</span>
        </div>
        <div class="table-wrapper">
          <table class="hrms-table">
            <thead>
              <tr>
                <th>#</th><th>Date</th><th>Day</th><th>Check In</th><th>Check Out</th><th>Working Hours</th><th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty history}">
                  <tr><td colspan="7" class="text-center text-muted" style="padding:50px;">No records found for selected range.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="a" items="${history}" varStatus="s">
                    <tr>
                      <td class="text-muted small">${s.index + 1}</td>
                      <td class="fw-600">${a.attendanceDate}</td>
                      <td class="text-muted small">${a.attendanceDate.dayOfWeek}</td>
                      <td>${a.checkInTime != null ? a.checkInTime : '—'}</td>
                      <td>${a.checkOutTime != null ? a.checkOutTime : '—'}</td>
                      <td class="text-muted small">${a.checkOutTime != null ? a.workingHours : '—'}</td>
                      <td>
                        <span class="badge
                          <c:choose>
                            <c:when test="${a.status == 'PRESENT'}">badge-success</c:when>
                            <c:when test="${a.status == 'LATE'}">badge-warning</c:when>
                            <c:when test="${a.status == 'ABSENT'}">badge-danger</c:when>
                            <c:otherwise>badge-secondary</c:otherwise>
                          </c:choose>">${a.status}</span>
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
