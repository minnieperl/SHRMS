<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Schedule Meeting — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Schedule Meeting" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-camera-video-fill text-primary me-2"></i>Schedule New Meeting</h5>
              <a href="${pageContext.request.contextPath}/meetings" class="btn btn-outline btn-sm"><i class="bi bi-arrow-left"></i> Back</a>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/meetings/schedule" method="post">
                <div class="row g-3">
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Meeting Title *</label>
                      <input type="text" name="title" class="form-control" placeholder="e.g. Q4 Planning, Sprint Review..." required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="form-label">Date & Time *</label>
                      <input type="datetime-local" name="scheduledAt" class="form-control" required>
                    </div>
                  </div>
                  <div class="col-12">
                    <div class="form-group">
                      <label class="form-label">Select Attendees *</label>
                      <div style="border:1.5px solid var(--border);border-radius:var(--radius-sm);padding:12px;max-height:220px;overflow-y:auto;background:#fafbff;">
                        <c:forEach var="emp" items="${employees}">
                          <label style="display:flex;align-items:center;gap:10px;padding:7px 8px;border-radius:6px;cursor:pointer;margin-bottom:2px;" onmouseover="this.style.background='#f1f5f9'" onmouseout="this.style.background='transparent'">
                            <input type="checkbox" name="attendeeIds" value="${emp.employeeId}" style="width:16px;height:16px;">
                            <div class="avatar" style="width:28px;height:28px;font-size:11px;">${emp.firstName.substring(0,1)}${emp.lastName.substring(0,1)}</div>
                            <span style="font-size:13px;">${emp.firstName} ${emp.lastName}</span>
                            <span class="badge badge-secondary" style="font-size:10px;margin-left:auto;">${emp.role.roleName}</span>
                          </label>
                        </c:forEach>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4">
                  <a href="${pageContext.request.contextPath}/meetings" class="btn btn-outline">Cancel</a>
                  <button type="submit" class="btn btn-primary"><i class="bi bi-calendar-plus"></i> Schedule</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
