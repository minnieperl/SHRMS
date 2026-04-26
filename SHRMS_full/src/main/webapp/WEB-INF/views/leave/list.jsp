<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>My Leaves — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Leave Management" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h5 class="fw-bold mb-0">My Leave Requests</h5>
          <p class="text-muted small mb-0">${leaves.size()} total requests</p>
        </div>
        <a href="${pageContext.request.contextPath}/leaves/apply" class="btn btn-primary">
          <i class="bi bi-plus-lg"></i> Apply Leave
        </a>
      </div>

      <!-- Stats row -->
      <div class="row g-3 mb-4">
        <div class="col-sm-4">
          <div class="stat-card">
            <div class="stat-icon bg-warning"><i class="bi bi-hourglass-split"></i></div>
            <div class="stat-info">
              <div class="stat-value">
                <c:set var="pendCount" value="0"/>
                <c:forEach var="l" items="${leaves}"><c:if test="${l.status == 'PENDING'}"><c:set var="pendCount" value="${pendCount + 1}"/></c:if></c:forEach>
                ${pendCount}
              </div>
              <div class="stat-label">Pending</div>
            </div>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="stat-card">
            <div class="stat-icon bg-success"><i class="bi bi-check-circle-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">
                <c:set var="apprCount" value="0"/>
                <c:forEach var="l" items="${leaves}"><c:if test="${l.status == 'APPROVED'}"><c:set var="apprCount" value="${apprCount + 1}"/></c:if></c:forEach>
                ${apprCount}
              </div>
              <div class="stat-label">Approved</div>
            </div>
          </div>
        </div>
        <div class="col-sm-4">
          <div class="stat-card">
            <div class="stat-icon bg-danger"><i class="bi bi-x-circle-fill"></i></div>
            <div class="stat-info">
              <div class="stat-value">
                <c:set var="rejCount" value="0"/>
                <c:forEach var="l" items="${leaves}"><c:if test="${l.status == 'REJECTED'}"><c:set var="rejCount" value="${rejCount + 1}"/></c:if></c:forEach>
                ${rejCount}
              </div>
              <div class="stat-label">Rejected</div>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="table-wrapper">
          <table class="hrms-table">
            <thead>
              <tr><th>#</th><th>Type</th><th>From</th><th>To</th><th>Reason</th><th>Status</th><th>Approved By</th></tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty leaves}">
                  <tr><td colspan="7" class="text-center text-muted" style="padding:50px;">No leave requests found. <a href="${pageContext.request.contextPath}/leaves/apply">Apply now</a></td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="l" items="${leaves}" varStatus="s">
                    <tr>
                      <td class="text-muted small">${s.index + 1}</td>
                      <td><span class="badge badge-info">${l.leaveType}</span></td>
                      <td>${l.startDate}</td>
                      <td>${l.endDate}</td>
                      <td style="max-width:180px;font-size:12px;color:#64748b;">${l.reason}</td>
                      <td>
                        <span class="badge
                          <c:choose>
                            <c:when test="${l.status == 'APPROVED'}">badge-success</c:when>
                            <c:when test="${l.status == 'REJECTED'}">badge-danger</c:when>
                            <c:otherwise>badge-warning</c:otherwise>
                          </c:choose>">${l.status}</span>
                      </td>
                      <td class="text-muted small">
                        ${l.approvedBy != null ? l.approvedBy.firstName : '—'}
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
