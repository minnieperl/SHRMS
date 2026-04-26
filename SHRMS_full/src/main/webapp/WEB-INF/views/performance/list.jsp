<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Performance — Smart HRMS</title>
  <%@ include file="/WEB-INF/views/common/head.jsp" %>
</head>
<body>
<div class="wrapper">
  <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
  <div class="main-content">
    <c:set var="pageTitle" value="Performance Reviews" />
    <%@ include file="/WEB-INF/views/common/topbar.jsp" %>
    <div class="page-body fade-in">
      <%@ include file="/WEB-INF/views/common/alerts.jsp" %>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">Performance Reviews</h5>
        <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
          <a href="${pageContext.request.contextPath}/performance/add" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Add Review
          </a>
        </c:if>
      </div>

      <div class="row g-3">
        <c:choose>
          <c:when test="${empty performances}">
            <div class="col-12">
              <div class="card">
                <div class="card-body text-center" style="padding:60px;">
                  <div style="font-size:52px;margin-bottom:12px;">📊</div>
                  <h6>No performance reviews found</h6>
                </div>
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="p" items="${performances}">
            <div class="col-lg-6">
              <div class="card">
                <div class="card-body" style="padding:20px;">
                  <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:14px;">
                    <div style="display:flex;gap:12px;align-items:center;">
                      <div class="avatar">${p.employee.firstName.substring(0,1)}${p.employee.lastName.substring(0,1)}</div>
                      <div>
                        <div class="fw-bold small">${p.employee.firstName} ${p.employee.lastName}</div>
                        <div class="text-muted" style="font-size:11px;">${p.employee.department.departmentName}</div>
                      </div>
                    </div>
                    <span class="badge badge-primary">${p.period}</span>
                  </div>

                  <!-- Rating Stars -->
                  <div style="margin-bottom:12px;">
                    <c:forEach begin="1" end="5" var="i">
                      <span style="font-size:20px;">${i <= p.rating ? '⭐' : '☆'}</span>
                    </c:forEach>
                    <span class="text-muted small ms-2">${p.rating}/5</span>
                  </div>

                  <div class="row g-2 mb-3">
                    <div class="col-6">
                      <div class="text-muted" style="font-size:11px;margin-bottom:2px;">Attendance Score</div>
                      <div class="progress">
                        <div class="progress-bar" style="width:${p.attendanceScore}%;background:var(--success);"></div>
                      </div>
                      <div class="fw-600 small mt-1">${p.attendanceScore}%</div>
                    </div>
                    <div class="col-6">
                      <div class="text-muted" style="font-size:11px;margin-bottom:2px;">Task Score</div>
                      <div class="progress">
                        <div class="progress-bar" style="width:${p.taskScore}%;background:var(--info);"></div>
                      </div>
                      <div class="fw-600 small mt-1">${p.taskScore}%</div>
                    </div>
                  </div>

                  <c:if test="${not empty p.remarks}">
                  <div style="background:#f8fafc;padding:10px 12px;border-radius:6px;font-size:12px;color:#64748b;font-style:italic;">
                    "${p.remarks}"
                  </div>
                  </c:if>

                  <c:if test="${role == 'ADMIN' || role == 'HR'}">
                  <div class="d-flex justify-content-end mt-2">
                    <form action="${pageContext.request.contextPath}/performance/delete/${p.performanceId}" method="post"
                          data-confirm="Delete this performance record?">
                      <button class="btn btn-ghost btn-sm" style="color:var(--danger);font-size:12px;">
                        <i class="bi bi-trash"></i> Delete
                      </button>
                    </form>
                  </div>
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
