<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Manage Leaves — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Leave Approvals" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h5 class="fw-bold mb-0">Pending Leave Requests</h5>
          <p class="text-muted small mb-0">${leaves.size()} requests awaiting action</p>
        </div>
      </div>

      <c:choose>
        <c:when test="${empty leaves}">
          <div class="card">
            <div class="card-body text-center" style="padding:60px;">
              <div style="font-size:56px;margin-bottom:12px;">🎉</div>
              <h6 class="fw-bold">All caught up!</h6>
              <p class="text-muted">No pending leave requests at this time.</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <div class="row g-3">
            <c:forEach var="l" items="${leaves}">
            <div class="col-lg-6">
              <div class="card">
                <div class="card-body" style="padding:20px;">
                  <div style="display:flex;gap:14px;align-items:flex-start;">
                    <div class="avatar" style="font-size:14px;width:44px;height:44px;">
                      ${l.employee.firstName.substring(0,1)}${l.employee.lastName.substring(0,1)}
                    </div>
                    <div style="flex:1;">
                      <div class="fw-bold" style="font-size:14px;">${l.employee.firstName} ${l.employee.lastName}</div>
                      <div class="text-muted small">${l.employee.department.departmentName} &bull; ${l.employee.employeeCode}</div>
                      <div style="margin-top:10px;display:flex;gap:8px;flex-wrap:wrap;">
                        <span class="badge badge-info">${l.leaveType}</span>
                        <span class="badge badge-secondary">
                          <i class="bi bi-calendar3"></i> ${l.startDate} → ${l.endDate}
                        </span>
                      </div>
                      <div class="text-muted small mt-2" style="font-style:italic;">"${l.reason}"</div>
                    </div>
                  </div>
                  <div class="d-flex gap-2 mt-3 justify-content-end">
                    <form action="${pageContext.request.contextPath}/leaves/action/${l.leaveId}" method="post">
                      <input type="hidden" name="action" value="REJECTED">
                      <button class="btn btn-danger btn-sm">
                        <i class="bi bi-x-lg"></i> Reject
                      </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/leaves/action/${l.leaveId}" method="post">
                      <input type="hidden" name="action" value="APPROVED">
                      <button class="btn btn-success btn-sm">
                        <i class="bi bi-check-lg"></i> Approve
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
