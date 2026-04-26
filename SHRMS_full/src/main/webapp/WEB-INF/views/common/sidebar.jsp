<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="sidebar">
  <div class="sidebar-brand">
    <div class="brand-logo">🏢</div>
    <div class="brand-text">
      <h6>Smart HRMS</h6>
      <small>HR Management System</small>
    </div>
  </div>

  <nav class="sidebar-nav">
    <div class="nav-section-label">Main</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
      <i class="bi bi-grid-fill"></i> Dashboard
    </a>

    <div class="nav-section-label">People</div>
    <a href="${pageContext.request.contextPath}/employees" class="nav-link">
      <i class="bi bi-people-fill"></i> Employees
    </a>

    <div class="nav-section-label">Attendance</div>
    <a href="${pageContext.request.contextPath}/attendance" class="nav-link">
      <i class="bi bi-clock-fill"></i> My Attendance
    </a>
    <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
    <a href="${pageContext.request.contextPath}/attendance/all" class="nav-link">
      <i class="bi bi-calendar-check-fill"></i> All Attendance
    </a>
    </c:if>

    <div class="nav-section-label">Leaves</div>
    <a href="${pageContext.request.contextPath}/leaves" class="nav-link">
      <i class="bi bi-calendar2-minus-fill"></i> My Leaves
    </a>
    <c:if test="${role == 'ADMIN' || role == 'HR' || role == 'MANAGER'}">
    <a href="${pageContext.request.contextPath}/leaves/manage" class="nav-link">
      <i class="bi bi-clipboard-check-fill"></i> Manage Leaves
    </a>
    </c:if>

    <div class="nav-section-label">Work</div>
    <a href="${pageContext.request.contextPath}/tasks" class="nav-link">
      <i class="bi bi-check2-square"></i> Tasks
    </a>
    <a href="${pageContext.request.contextPath}/meetings" class="nav-link">
      <i class="bi bi-camera-video-fill"></i> Meetings
    </a>

    <div class="nav-section-label">HR</div>
    <a href="${pageContext.request.contextPath}/performance" class="nav-link">
      <i class="bi bi-graph-up-arrow"></i> Performance
    </a>
    <c:if test="${role == 'ADMIN' || role == 'HR'}">
    <a href="${pageContext.request.contextPath}/payroll" class="nav-link">
      <i class="bi bi-currency-dollar"></i> Payroll
    </a>
    </c:if>
    <c:if test="${role == 'EMPLOYEE'}">
    <a href="${pageContext.request.contextPath}/payroll" class="nav-link">
      <i class="bi bi-receipt"></i> My Payslips
    </a>
    </c:if>
    <a href="${pageContext.request.contextPath}/holidays" class="nav-link">
      <i class="bi bi-star-fill"></i> Holidays
    </a>
  </nav>

  <div class="sidebar-footer">
    <div class="sidebar-user">
      <div class="user-avatar">
        <c:choose>
          <c:when test="${not empty employee.photoPath}">
            <img src="${pageContext.request.contextPath}/uploads/${employee.photoPath}" alt="">
          </c:when>
          <c:otherwise>
            ${employee.firstName.substring(0,1)}${employee.lastName.substring(0,1)}
          </c:otherwise>
        </c:choose>
      </div>
      <div class="user-info">
        <div class="user-name">${employee.firstName} ${employee.lastName}</div>
        <div class="user-role">${employee.role.roleName}</div>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost w-100 mt-2"
       style="color:#ef4444;justify-content:center;">
      <i class="bi bi-box-arrow-left"></i> Logout
    </a>
  </div>
</aside>
