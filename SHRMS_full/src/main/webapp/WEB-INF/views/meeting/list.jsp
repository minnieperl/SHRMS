<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Meetings — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Meetings" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">All Meetings</h5>
        <a href="${pageContext.request.contextPath}/meetings/schedule" class="btn btn-primary">
          <i class="bi bi-plus-lg"></i> Schedule Meeting
        </a>
      </div>

      <div class="row g-3">
        <c:choose>
          <c:when test="${empty meetings}">
            <div class="col-12">
              <div class="card">
                <div class="card-body text-center" style="padding:60px;">
                  <div style="font-size:52px;margin-bottom:12px;">📅</div>
                  <h6 class="fw-bold">No meetings scheduled</h6>
                  <a href="${pageContext.request.contextPath}/meetings/schedule" class="btn btn-primary mt-2">Schedule One</a>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="m" items="${meetings}">
            <div class="col-lg-6">
              <div class="card">
                <div class="card-body" style="padding:20px;">
                  <div style="display:flex;gap:14px;align-items:flex-start;">
                    <div style="width:50px;height:50px;background:var(--primary-light);border-radius:10px;display:flex;flex-direction:column;align-items:center;justify-content:center;flex-shrink:0;">
                      <span style="font-size:16px;font-weight:800;color:var(--primary);line-height:1;">${m.scheduledAt.dayOfMonth}</span>
                      <span style="font-size:9px;color:var(--primary);font-weight:600;">${m.scheduledAt.month.toString().substring(0,3)}</span>
                    </div>
                    <div style="flex:1;">
                      <div class="fw-bold" style="font-size:14px;margin-bottom:4px;">${m.title}</div>
                      <div class="text-muted small mb-2">
                        <i class="bi bi-clock"></i> ${m.scheduledAt}
                        &bull; <i class="bi bi-person-fill"></i> ${m.createdBy.firstName} ${m.createdBy.lastName}
                      </div>
                      <div style="display:flex;gap:4px;flex-wrap:wrap;">
                        <c:forEach var="att" items="${m.attendees}" varStatus="s">
                          <c:if test="${s.index < 4}">
                            <span class="badge badge-secondary" style="font-size:10px;">${att.firstName}</span>
                          </c:if>
                        </c:forEach>
                        <c:if test="${m.attendees.size() > 4}">
                          <span class="badge badge-info" style="font-size:10px;">+${m.attendees.size()-4} more</span>
                        </c:if>
                      </div>
                    </div>
                    <div class="d-flex flex-column gap-1">
                      <a href="${pageContext.request.contextPath}/meetings/view/${m.meetingId}" class="btn btn-outline btn-sm"><i class="bi bi-eye"></i></a>
                      <c:if test="${role == 'ADMIN' || role == 'HR' || m.createdBy.email == employee.email}">
                      <form action="${pageContext.request.contextPath}/meetings/delete/${m.meetingId}" method="post" data-confirm="Delete this meeting?">
                        <button class="btn btn-ghost btn-sm" style="color:var(--danger);"><i class="bi bi-trash"></i></button>
                      </form>
                      </c:if>
                    </div>
                  </div>
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
