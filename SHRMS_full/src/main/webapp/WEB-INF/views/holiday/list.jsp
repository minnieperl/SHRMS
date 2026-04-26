<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Holidays — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Holiday Calendar" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h5 class="fw-bold mb-0">Company Holidays</h5>
          <p class="text-muted small mb-0">${holidays.size()} holidays listed</p>
        </div>
        <c:if test="${role == 'ADMIN' || role == 'HR'}">
          <a href="${pageContext.request.contextPath}/holidays/add" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Add Holiday
          </a>
        </c:if>
      </div>

      <div class="row g-3">
        <c:choose>
          <c:when test="${empty holidays}">
            <div class="col-12">
              <div class="card">
                <div class="card-body text-center" style="padding:60px;">
                  <div style="font-size:52px;margin-bottom:12px;">📅</div>
                  <h6 class="text-muted">No holidays added yet</h6>
                  <c:if test="${role == 'ADMIN' || role == 'HR'}">
                    <a href="${pageContext.request.contextPath}/holidays/add" class="btn btn-primary mt-2">Add First Holiday</a>
                  </c:if>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="h" items="${holidays}">
            <div class="col-sm-6 col-lg-4 col-xl-3">
              <div class="card" style="transition:all 0.2s;" onmouseover="this.style.transform='translateY(-3px)';this.style.boxShadow='var(--shadow-md)'" onmouseout="this.style.transform='';this.style.boxShadow=''">
                <div class="card-body" style="padding:20px;display:flex;gap:14px;align-items:center;">
                  <div style="width:52px;height:52px;border-radius:12px;display:flex;flex-direction:column;align-items:center;justify-content:center;flex-shrink:0;
                    background:${h.holidayType == 'NATIONAL' ? '#fee2e2' : h.holidayType == 'OPTIONAL' ? '#fef3c7' : '#dbeafe'};">
                    <span style="font-size:18px;font-weight:800;line-height:1;
                      color:${h.holidayType == 'NATIONAL' ? '#dc2626' : h.holidayType == 'OPTIONAL' ? '#d97706' : '#2563eb'};">
                      ${h.holidayDate.dayOfMonth}
                    </span>
                    <span style="font-size:9px;font-weight:600;
                      color:${h.holidayType == 'NATIONAL' ? '#dc2626' : h.holidayType == 'OPTIONAL' ? '#d97706' : '#2563eb'};">
                      ${h.holidayDate.month.toString().substring(0,3)}
                    </span>
                  </div>
                  <div style="flex:1;min-width:0;">
                    <div class="fw-bold small" style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${h.holidayName}</div>
                    <div class="text-muted" style="font-size:11px;margin-bottom:4px;">${h.holidayDate.dayOfWeek}</div>
                    <span class="badge
                      <c:choose>
                        <c:when test="${h.holidayType == 'NATIONAL'}">badge-danger</c:when>
                        <c:when test="${h.holidayType == 'OPTIONAL'}">badge-warning</c:when>
                        <c:otherwise>badge-info</c:otherwise>
                      </c:choose>" style="font-size:9px;">${h.holidayType}</span>
                  </div>
                  <c:if test="${role == 'ADMIN' || role == 'HR'}">
                  <form action="${pageContext.request.contextPath}/holidays/delete/${h.holidayId}" method="post"
                        data-confirm="Delete '${h.holidayName}'?">
                    <button class="btn btn-ghost btn-sm btn-icon" style="color:var(--danger);">
                      <i class="bi bi-trash"></i>
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
