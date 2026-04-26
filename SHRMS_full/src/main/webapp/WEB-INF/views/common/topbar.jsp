<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="topbar">
  <div class="topbar-left">
    <button id="sidebarToggle" class="topbar-btn d-lg-none">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${pageTitle}</div>
      <div class="breadcrumb-text text-muted">Smart HRMS &rsaquo; ${pageTitle}</div>
    </div>
  </div>
  <div class="topbar-right">
    <a href="${pageContext.request.contextPath}/holidays" class="topbar-btn" title="Holidays">
      <i class="bi bi-star"></i>
    </a>
    <a href="${pageContext.request.contextPath}/attendance" class="topbar-btn" title="Attendance">
      <i class="bi bi-clock"></i>
    </a>
    <div style="width:1px;height:24px;background:var(--border);"></div>
    <div style="display:flex;align-items:center;gap:8px;">
      <div class="avatar" style="font-size:12px;">
        <c:choose>
          <c:when test="${not empty employee.photoPath}">
            <img src="${pageContext.request.contextPath}/uploads/${employee.photoPath}" class="avatar" alt="">
          </c:when>
          <c:otherwise>
            ${employee.firstName.substring(0,1)}
          </c:otherwise>
        </c:choose>
      </div>
      <div>
        <div style="font-weight:600;font-size:13px;">${employee.firstName}</div>
        <div class="text-muted" style="font-size:11px;">${role}</div>
      </div>
    </div>
  </div>
</header>
